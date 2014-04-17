# MODEL INFO

print(''); 
print('MODEL INFO: Cessna 337G Skymaster');
print('---------------------------------'); 
print('Type: Two-engine aircraft (civilian version)');
print('Powerplant: 2 Continental IO-360-C piston engines in a push-pull line configuration, 210HP each one');
print('Capacity: 1 pilot and 5 passengers');
print('---'); 
print('Tipo: Avioneta bimotor (version civil)');
print('Planta motriz: 2 motores a piston Continental IO-360-C de 210HP cada uno, de configuracion tira-empuje en linea');
print('Capacidad: 1 piloto y 5 pasajeros');
print('');
print('Authors/Autores: Fernando Espinosa y Pavel Cueto');
print('February/Febrero 2012');



# AIRCRAFT DIALOGS

var dlg = {
	checklists: gui.Dialog.new("/sim/gui/dialogs/Cessna337/checklists/dialog","Aircraft/Cessna337/Dialogs/Cessna337-checklists.xml"),
	utility: gui.Dialog.new("/sim/gui/dialogs/Cessna337/utility/dialog","Aircraft/Cessna337/Dialogs/Cessna337-utility.xml"),
	autopilot: gui.Dialog.new("/sim/gui/dialogs/Cessna337/autopilot/dialog","Aircraft/Cessna337/Dialogs/Navomatic400A-autopilot.xml")
	};
fgcommand("loadxml", props.Node.new({filename: "Aircraft/Cessna337/Dialogs/Cessna337-checklists-text.xml", targetnode: "/sim/gui/dialogs/Cessna337/checklists-list"}));
	
	
#var checklists_dialog = gui.Dialog.new("/sim/gui/dialogs/dr400/checklists/dialog", getprop("/sim/aircraft-dir")~"/Dialogs/checklist/checklists.xml");
#fgcommand("loadxml", props.Node.new({filename: getprop("/sim/aircraft-dir")~"/Dialogs/checklist/checklists-text.xml", targetnode: #"/sim/gui/dialogs/dr400/checklists-list"}));
