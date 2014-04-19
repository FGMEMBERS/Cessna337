#Basic ELT (Emergency Locator Transmitter)
#Authors: Pavel Cueto, with A LOT of collaboration from Thorsten and AndersG

#Designed to work with the "ArtexELT" files provided in the instrument folder.
#Be sure to link this Nasal in your -set file, typing:
#<nasal>
#	<ELT>
#		<file>YOUR/INSTRUMENT/FOLDER/ROUTE/HERE/ELTmessage.nas</file>
#	</ELT>
#</nasal>

print('Emergency Locator Transmitter (ELT) loaded');

#Aircraft ID definition
var aircraft = getprop("sim/description");
var callsign = getprop("sim/multiplay/callsign");
var aircraft_id = aircraft ~ ", " ~ callsign;

var crashed = func() {
    var ground = getprop("position/altitude-agl-ft");
    if ((getprop("sim/crashed")) and (ground < 1)) {
        var lat = getprop("/position/latitude-string");
        var lon = getprop("/position/longitude-string");
        var help_string = "ELT AutoMessage: " ~ aircraft_id ~ ", CRASHED AT " ~lat~" LAT "~lon~" LON, REQUESTING SAR SERVICE";
        setprop("/sim/multiplay/chat", help_string);
        settimer(crashed, 60);
    }
}

#Print an emergency auto-message when aircraft crashes
setlistener("sim/crashed", crashed);

#Print an emergency message when pilot turns on the "armed" button
setlistener("ELT/armed", func(alrm) {
	if (getprop("ELT/armed")) {
		var lat = getprop("/position/latitude-string");
		var lon = getprop("/position/longitude-string");
		var help_string = "ELT Message: " ~ aircraft_id ~ ", DECLARING EMERGENCY AT " ~lat~" LAT, "~lon~" LON";
		setprop("/sim/multiplay/chat", help_string);
	}
});
