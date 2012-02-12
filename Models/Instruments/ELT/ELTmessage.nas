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

var eltmsg = func {
    var lat = getprop("/position/latitude-string");
    var lon = getprop("/position/longitude-string");
    var aircraft = getprop("sim/description");
    var callsign = getprop("sim/multiplay/callsign");
	
	setlistener("sim/crashed", func(n) {
		if (getprop("ELT/armed")) {
			var help_string = "ELT AutoMessage: " ~ aircraft ~ " " ~ callsign ~ " crashed at " ~lat~" LAT "~lon~" LON, requesting SAR service";
			setprop("/sim/multiplay/chat", help_string);
		}
	});
}