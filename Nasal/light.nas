###############################################################################
##   Copyright (C) 2010  Fernando Espinosa
##
##This program is free software; you can redistribute it and/or modify 
##it under the terms of the GNU General Public License as published by 
##the Free Software Foundation; either version 2 of the License, or 
##(at your option) any later version. 
##
##This program is distributed in the hope that it will be useful, 
##but WITHOUT ANY WARRANTY; without even the implied warranty of 
##MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
##GNU General Public License for more details. 
##
##You should have received a copy of the GNU General Public License 
##along with this program; if not, write to the Free Software 
##Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
##
###############################################################################


# strobes ===========================================================
var strobe_switch = props.globals.getNode("controls/lighting/strobe", 1);
aircraft.light.new("sim/model/Cessna337/lighting/strobes", [0.015, 1.985], strobe_switch);


# beacons ===========================================================
var beacon_switch = props.globals.getNode("controls/lighting/beacon", 1);
aircraft.light.new("sim/model/Cessna337/lighting/beacon-top", [0.10, 0.90], beacon_switch);

var autoInstrumentDimmingListener = func {
    var panel = getprop('controls/lighting/panel-norm');
    var dimming = panel < 0.1 ? 0.0 : 0.7 - panel;
    if (dimming < 0) dimming = 0.0;
    setprop('instrumentation/comm[0]/dimming-norm', dimming);
    setprop('instrumentation/comm[1]/dimming-norm', dimming);
    setprop('instrumentation/dme[0]/dimming-norm', dimming);
    setprop('instrumentation/adf[0]/dimming-norm', dimming);
}

setlistener('controls/lighting/panel-norm', autoInstrumentDimmingListener);
