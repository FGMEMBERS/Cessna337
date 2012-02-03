# MODEL INFO

print(''); 
print('MODEL INFO: Cessna 337G Skymaster');
print(''); 
print('Type: Two-engine aircraft (civilian version)');
print('Powerplant: 2 Continental IO-360-C piston engines in a push-pull line configuration, 210HP each one');
print('Capacity: 1 pilot and 5 passengers');
print(''); 
print('Tipo: Avioneta bimotor (version civil)');
print('Planta motriz: 2 motores a piston Continental IO-360-C de 210HP cada uno, de configuracion tira-empuje en linea');
print('Capacidad: 1 piloto y 5 pasajeros');
print('');
print('Authors/Autores: Fernando Espinosa y Pavel Cueto');
print('February/Febrero 2012');



# AIRCRAFT DIALOGS

var dlg = {
	lights: gui.Dialog.new("/sim/gui/dialogs/lights/dialog","Aircraft/Cessna337/Dialogs/Cessna337-lights.xml"),
	systems: gui.Dialog.new("/sim/gui/dialogs/systems/dialog","Aircraft/Cessna337/Dialogs/Cessna337-systems.xml")
	};