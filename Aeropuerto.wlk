class Aeropuerto{
	var property nombre = self
	var property terminal = #{}
	var property pista = #{}
	var property pistadisponibilidad
	
	method sumarpd(a){ pistadisponibilidad += a }	
	method restarpd(a){ pistadisponibilidad -= a }
}

object buenosaires inherits Aeropuerto(pistadisponibilidad = 2){}
object santafe inherits Aeropuerto(pistadisponibilidad = 1){}
object cordoba inherits Aeropuerto(pistadisponibilidad = 1){}
object misiones inherits Aeropuerto(pistadisponibilidad = 1){}
object corrientes inherits Aeropuerto(pistadisponibilidad = 1){}

class Planesdevuelo{
	const property destinos = []
}

object primero inherits Planesdevuelo(destinos = [santafe, cordoba, misiones]){}
object segundo inherits Planesdevuelo(destinos = [buenosaires, corrientes]){}
object tercero inherits Planesdevuelo(destinos = [misiones]){}

class Aeronave{
	var property nombre = self
	var property destino = null
	var property destinos = []
	var property aeropuerto = null
	var property ubicacion = null
	
	method asignaraeropuerto(puerto){
		aeropuerto = puerto
		ubicacion = "terminal"
		puerto.terminal().add(self)
		console.println("aeropuerto asignado")
	}

	method asignarplandevuelo(plandevuelo){
		if (plandevuelo.destinos().first() != aeropuerto){
		destinos = plandevuelo.destinos().asList()
		const a = {n => n.destinos().first()}.apply(self)
		destino = a
		console.println("plan asignado")
		} else{console.println("no puedo tener este plan de vuelo porque porque ya estoy en el aeropuerto del primer destino")}
	}	
	
	method moveraeronave(ubi){
		if(ubi == "pista" && ubicacion == "terminal"){
			if(aeropuerto.pistadisponibilidad() > 0){
				ubicacion = ubi
				aeropuerto.restarpd(1)
				aeropuerto.terminal().remove(self)
				aeropuerto.pista().add(self)
			}else{
				console.println("no hay disponibilidad en la pista")
				}
		}else{
			ubicacion = ubi
			aeropuerto.sumarpd(1)
			aeropuerto.pista().remove(self)
			aeropuerto.terminal().add(self)}
}
	
	method despegar(){
		if (ubicacion == "pista"){
			ubicacion = "en vuelo"
			aeropuerto.pista().remove(self)
			aeropuerto.sumarpd(1)
			aeropuerto = null
			espacioaereo.aeronaves().add(self)
			console.println("volando")
		}else{console.println("no estoy en pista no puedo despegar")}	
	}
	
	method aterrizar(){
		if (ubicacion == "en vuelo"){
			if(destino.pistadisponibilidad() > 0){
				aeropuerto = destino
				self.destinos().remove(destino)
				console.println("aterrizaje perfecto")
				ubicacion = "pista"
				aeropuerto.pista().add(self)
				aeropuerto.restarpd(1)
				espacioaereo.aeronaves().remove(self)
				espacioaereo.vuelosenemergencia().remove(self)
				if(destinos.size() != 0){
					const a = {n => n.destinos().first()}.apply(self)
					destino = a
					}else{
						console.println("plan de vuelo terminado")
						}
			}else{
				espacioaereo.vuelosenemergencia().add(self)
				console.println("vuelo en emergencia")
				}
		}else{
			console.println("no estoy en vuelo")
			}
	}
}
object privado inherits Aeronave{}
object privada inherits Aeronave{}
object publico inherits Aeronave{}

object espacioaereo{
	var property aeronaves = #{}
	var property vuelosenemergencia = #{}
	
	method chequearubicacionde(nave1, nave2){
		if(nave1.ubicacion() == nave2.ubicacion()){
			console.println("ambas estan en " + nave1.ubicacion())
		} else{
			console.println("no estan en la misma ubicacion, " + nave1 + " esta en " + nave1.ubicacion() + " y " + nave2 + " esta en " + nave2.ubicacion())
			}
	}
	
	method chequearaeropuertode(nave1, nave2){
		if(nave1.aeropuerto() == nave2.aeropuerto()){
			console.println("ambas estan en " + nave1.aeropuerto())
		} else{
			console.println("no estan en la misma ubicacion, " + nave1 + " esta en " + nave1.aeropuerto() + " y " + nave2 + " esta en " + nave2.aeropuerto())
			}
	}
}