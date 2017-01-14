################################################################################
#
# Bendix-King KMA24 Audio Panel Configuration
#
# Copyright (c) 2017 Richard Senior, Jackie Reyes
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
################################################################################

var root = "instrumentation/kma24";
var rootNode = props.globals.getNode(root);

var Amplifier = {SPEAKER: 0, PHONE: 1};
var Knob = {OFF: 0, TEL: 1, COM1: 2, COM2: 3, INT: 4, EXT: 5};
var Cutoff = {TEST: 0.0, DEFAULT: 0.4, MUTE: 9999};

# Whether an audio output is switched by an audio panel path.
#
var switched = func(path)
{
    var channelNode = rootNode.getNode(path);

    # Phone output is independent of knob
    if (channelNode.getChild("switch", Amplifier.PHONE).getBoolValue())
        return 1;

    var knob = getprop(root, "knob");
    var spkr = channelNode.getChild("switch", Amplifier.SPEAKER).getBoolValue();

    return knob != Knob.OFF and spkr;
}

# Whether comm radio(n) is selected by the rotary knob.
#
var autoSelected = func(n)
{
    var knob = getprop(root, "knob");
    return (knob == Knob.COM1 and n == 0) or (knob == Knob.COM2 and n == 1);
}

# Switch audio of one or more comm radios.
#
# Comm radio audio is affected by the comm buttons but also the auto buttons
# used in conjunction with the select knob and the position of the test button
# on the comm radio itself.
#
var switchCOM = func(indexes...)
{
    foreach (var i; indexes) {
        var com = switched("com["~i~"]");
        var auto = switched("auto") and autoSelected(i);
        var cutoff = Cutoff.MUTE;
        if (com or auto) {
            var test = getprop("instrumentation/comm["~i~"]/test-btn");
            cutoff = test ? Cutoff.TEST : Cutoff.DEFAULT;
        }
        setprop("instrumentation/comm["~i~"]/cutoff-signal-quality", cutoff);
    }
}

# Switch audio of one or more nav radios.
#
var switchNAV = func(indexes...)
{
    foreach (var i; indexes)
        setprop("instrumentation/nav["~i~"]/audio-btn", switched("nav["~i~"]"));
}

# Switch the DME receiver audio.
#
var switchDME = func
{
    setprop("instrumentation/dme/ident", switched("dme"));
}

# Switch the marker beacon audio.
#
var switchMKR = func
{
    # Marker audio is always disabled if the marker beacon receiver is off.
    # The marker beacon receiver is switched by the knob.
    var knob = getprop(root, "knob");
    var rec = knob != Knob.OFF;

    setprop("instrumentation/marker-beacon/audio-btn", rec and switched("mkr"));
}

# Switch the ADF receiver audio.
#
var switchADF = func
{
    setprop("instrumentation/adf/ident-audible", switched("adf"));
}

# Scan all switches and switch corresponding audio.
#
var switchAll = func
{
    switchCOM(0, 1);
    switchNAV(0, 1);
    switchDME();
    switchMKR();
    switchADF();
}

# Listener function that dispatches invocations based on the changed node.
#
var dispatcher = func(node)
{
    if (node.getName() == "switch") {
        var parent = node.getParent();
        if (parent.getName() == "com") {
            switchCOM(parent.getIndex());
        } elsif (parent.getName() == "nav") {
            switchNAV(parent.getIndex());
        } elsif (parent.getName() == "dme") {
            switchDME();
        } elsif (parent.getName() == "mkr") {
            switchMKR();
        } elsif (parent.getName() == "adf") {
            switchADF();
        } elsif (parent.getName() == "auto") {
            switchCOM(0, 1);
        }
    } elsif (node.getName() == "knob") {
        switchAll();
    }
}

# Listener function that mutes or unmutes all audio.
#
var mute = func(node)
{
    if (node.getBoolValue()) {
        setprop("instrumentation/comm[0]/cutoff-signal-quality", Cutoff.MUTE);
        setprop("instrumentation/comm[1]/cutoff-signal-quality", Cutoff.MUTE);
        setprop("instrumentation/nav[0]/audio-btn", 0);
        setprop("instrumentation/nav[1]/audio-btn", 0);
        setprop("instrumentation/dme/ident", 0);
        setprop("instrumentation/marker-beacon/audio-btn", 0);
        setprop("instrumentation/adf/ident-audible", 0);
    } else {
        switchAll();
    }
}

# Listener function that re-switches comm radios after a comm radio test
#
var commtest = func(node)
{
    switchCOM(node.getParent().getIndex());
}

# Listen for changes to any descendent of the root node.
#
setlistener(root, dispatcher, startup=0, runtime=2);

# Push-to-talk muting.
#
setlistener("instrumentation/comm[0]/ptt", mute, startup=0, runtime=0);
setlistener("instrumentation/comm[1]/ptt", mute, startup=0, runtime=0);

# Comm radio test
#
setlistener("instrumentation/comm[0]/test-btn", commtest, startup=0, runtime=0);
setlistener("instrumentation/comm[1]/test-btn", commtest, startup=0, runtime=0);

# Ensure all audio matches the startup state of the switches
#
switchAll();

print("KMA24 AudioPanel loaded");
