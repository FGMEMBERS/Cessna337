# Variables

	# Cockpit power switches
var battMasterSwitch = ("sim/systems/electrical/switches/voltage/battery-master");
var avionicsMasterSwitch = ("sim/systems/electrical/switches/voltage/avionics-master");
var frontAltSwitch = ("sim/systems/electrical/switches/voltage/alternator-front");
var rearAltSwitch = ("sim/systems/electrical/switches/voltage/alternator-rear");

	# Internal electrical states
		# Volts
var battVolts = ("sim/systems/electrical/suppliers/battery/volts");
var frontAltVolts = ("sim/systems/electrical/suppliers/alternator-front/volts");
var rearAltVolts = ("sim/systems/electrical/suppliers/alternator-rear/volts");
var mainBusVolts = ("sim/systems/electrical/buses/main");
var avionicsBusVolts = ("sim/systems/electrical/buses/avionics");

		# Amps
var battAmps = ("sim/systems/electrical/suppliers/battery/amps");
var frontAltAmps = ("sim/systems/electrical/suppliers/alternator-front/amps");
var rearAltAmps = ("sim/systems/electrical/suppliers/alternator-rear/amps");
var sysAmps = ("sim/systems/electrical/amps");

	# Engine status
var frontRpm = ("engines/engine[0]/rpm");
var rearRpm = ("engines/engine[1]/rpm");

# Functions
	
var setMainBus = func()
{
	print("update reached.");

	if(getprop(battMasterSwitch)){setprop(mainBusVolts,getprop(battVolts));}
		else if((getprop(rearAltSwitch)) and (getprop(rearRpm) > 800))
			{setprop(mainBusVolts,getprop(rearAltVolts));}	
		else if((getprop(frontAltSwitch)) and (getprop(frontRpm) > 800))
			{setprop(mainBusVolts,getprop(frontAltVolts));}
		else {setprop(mainBusVolts,0.0);}

	setAvionicsBus();		
}

var setAvionicsBus = func()
{
	print("setAvionicsBus reached.");
	if(getprop(avionicsMasterSwitch))
	{
		setprop(avionicsBusVolts,getprop(mainBusVolts));
	}	else	{
					setprop(avionicsBusVolts,0.0);
				}
	setBreakerVolts();
}

var setBreakerVolts = func ()
{
	print("setBreakerVolts reached.");

	for(i=1;i<=34;i=i+1)
	{
		if(i == 34)
		{
			if(getprop("sim/systems/electrical/switches/breakers/breaker[34]/closed"))
			{
				setprop("sim/systems/electrical/switches/breakers/breaker[34]/volts",getprop(avionicsBusVolts));
			}	
			else
			{
				setprop("sim/systems/electrical/switches/breakers/breaker[34]/volts",0.0);	
			}
		lighting();
		}
		else
		{
			if(getprop("sim/systems/electrical/switches/breakers/breaker["~i~"]/closed"))
			{	
				setprop("sim/systems/electrical/switches/breakers/breaker["~i~"]/volts", getprop(mainBusVolts));
			} 	
			else
			{
				setprop("sim/systems/electrical/switches/breakers/breaker["~i~"]/volts",0.0);
			}
		}
	}
}

var engineStarters = func
{
	if((getprop("sim/systems/electrical/switches/engines/starter-front")) and (getprop("sim/systems/electrical/switches/breakers/breaker[15]/volts")))
	{
		setprop("controls/engines/engine[0]/starter",1);
	}	else
		{
			setprop("controls/engines/engine[0]/starter",0);
		}
	if((getprop("sim/systems/electrical/switches/engines/starter-rear")) and (getprop("sim/systems/electrical/switches/breakers/breaker[15]/volts")))
	{
		setprop("controls/engines/engine[1]/starter",1);
	}	else
		{
			setprop("controls/engines/engine[1]/starter",0);
		}
}

var lighting = func
{
	if((getprop("sim/systems/electrical/switches/lighting/strobes")) and 
  (getprop("sim/systems/electrical/switches/breakers/breaker[6]/volts")))
	{
		setprop("sim/model/Cessna337/lighting/strobes/state",1);
	} else 
		{
			setprop("sim/model/Cessna337/lighting/strobes/state",0);
		}
}

# Listeners
	
	# Cockpit power switches
setlistener("sim/systems/electrical/switches/voltage/battery-master",setMainBus);
setlistener("sim/systems/electrical/switches/voltage/alternator-front",setMainBus);
setlistener("sim/systems/electrical/switches/voltage/avionics-master",setAvionicsBus);

	# Engine states
setlistener("controls/engines/engine[0]/running",setMainBus);
setlistener("controls/engines/engine[1]/running",setMainBus);

	# Circuit breakers
setlistener("sim/systems/electrical/switches/breakers/breaker[1]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[2]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[3]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[4]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[5]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[6]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[7]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[8]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[9]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[10]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[11]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[12]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[13]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[14]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[15]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[16]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[17]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[18]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[19]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[20]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[21]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[22]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[23]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[24]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[25]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[26]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[27]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[28]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[29]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[30]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[31]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[32]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[33]/closed",setBreakerVolts);
setlistener("sim/systems/electrical/switches/breakers/breaker[34]/closed",setBreakerVolts);

	# Starters
setlistener("sim/systems/electrical/switches/engines/starter-front",engineStarters);
setlistener("sim/systems/electrical/switches/engines/starter-rear",engineStarters);

	# Strobes and beacon lights
setlistener("sim/systems/electrical/switches/lighting/strobes",lighting);
#setlistener("sim/systems/electrical/switches/lighting/beacon",lighting);

	# Gear
	# Flaps
	
# Init on startup

setMainBus();

print("Electrical system loaded.");