setlistener("/sim/model/autostart", func(idle){
    var run= idle.getBoolValue();
    if(run){
    Startup();
    }else{
    Shutdown();
    }
},0,0);

var Startup = func {
	setprop("controls/engines/engine[0]/master-bat",1);
	setprop("controls/engines/engine[0]/master-alt",1);
	setprop("controls/engines/engine[0]/magnetos",3);
	setprop("controls/engines/engine[0]/primer",1);
	setprop("controls/engines/engine[0]/mixture",1);
	setprop("controls/engines/engine[0]/propeller-pitch",1);
	setprop("controls/engines/engine[0]/cowl-flaps-norm",1);
	setprop("controls/engines/engine[1]/master-alt",1);
	setprop("controls/engines/engine[1]/magnetos",3);
	setprop("controls/engines/engine[1]/primer",1);
	setprop("controls/engines/engine[1]/mixture",1);
	setprop("controls/engines/engine[1]/propeller-pitch",1);
	setprop("controls/engines/engine[1]/cowl-flaps-norm",1);
	setprop("/controls/anti-ice/pitot-heat",1);
	setprop("/controls/lighting/nav-lights",1);
	setprop("/controls/lighting/beacon",1);
	setprop("/controls/lighting/strobe",1);
	setprop("/controls/lighting/landing-lights",1);
	setprop("/controls/switches/master-avionics",1);
	setprop("/systems/electrical/outputs/adf",1);
	setprop("/systems/electrical/outputs/audio-panel[0]",1);
	setprop("/systems/electrical/outputs/audio-panel[1]",1);
	setprop("/systems/electrical/outputs/autopilot",1);
	setprop("/systems/electrical/outputs/avionics-fan",1);
	setprop("/systems/electrical/outputs/dme",1);
	setprop("/systems/electrical/outputs/hsi",1);
	setprop("/systems/electrical/outputs/nav[0]",1);
	setprop("/systems/electrical/outputs/nav[1]",1);
	setprop("/systems/electrical/outputs/transponder",1);
	setprop("/controls/gear/brake-parking",1);
		screen.log.write("Now press S to start the engines!");
}

var Shutdown = func{
	setprop("controls/engines/engine[0]/master-bat",0);
	setprop("controls/engines/engine[0]/master-alt",0);
	setprop("controls/engines/engine[0]/magnetos",0);
	setprop("controls/engines/engine[0]/primer",0);
	setprop("controls/engines/engine[0]/mixture",1);
	setprop("controls/engines/engine[0]/propeller-pitch",1);
	setprop("controls/engines/engine[0]/cowl-flaps-norm",0);
	setprop("controls/engines/engine[1]/master-alt",0);
	setprop("controls/engines/engine[1]/magnetos",0);
	setprop("controls/engines/engine[1]/primer",0);
	setprop("controls/engines/engine[1]/mixture",1);
	setprop("controls/engines/engine[1]/propeller-pitch",1);
	setprop("controls/engines/engine[1]/cowl-flaps-norm",0);
	setprop("/controls/anti-ice/pitot-heat",0);
	setprop("/controls/lighting/nav-lights",0);
	setprop("/controls/lighting/beacon",0);
	setprop("/controls/lighting/strobe",0);
	setprop("/controls/lighting/landing-lights",0);
	setprop("/controls/switches/master-avionics",0);
	setprop("/systems/electrical/outputs/adf",0);
	setprop("/systems/electrical/outputs/audio-panel[0]",0);
	setprop("/systems/electrical/outputs/audio-panel[1]",0);
	setprop("/systems/electrical/outputs/autopilot",0);
	setprop("/systems/electrical/outputs/avionics-fan",0);
	setprop("/systems/electrical/outputs/dme",0);
	setprop("/systems/electrical/outputs/hsi",0);
	setprop("/systems/electrical/outputs/nav[0]",0);
	setprop("/systems/electrical/outputs/nav[1]",0);
	setprop("/systems/electrical/outputs/transponder",0);
	setprop("/controls/gear/brake-parking",0);
}

setprop("/systems/electrical/outputs/nav[0]",0);
setprop("/systems/electrical/outputs/nav[1]",0);
