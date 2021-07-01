import wollok.game.*
import utilidades.*
import nivel_bloques.*
import nivel_llaves.*

class Bloque {	// Cajas
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "caja.png"
	
	// agregar comportamiento
	method estaEnDeposito() = deposito.contiene(self.position())
	
	method sePuedeEmpujarA(posicion) = utilidadesParaJuego.sePuedeMover(posicion) and not nivelBloques.hayBloque(posicion)
	method empujar(posicion) {
		if (self.sePuedeEmpujarA(posicion)){
			self.position(posicion)
		}
	}
}

class Llave {
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "llave.png"
}

object deposito {
	method contiene(unaPosicion) = unaPosicion.x().between(5,9) and unaPosicion.y().between(7,12)
}

object salida {
	const property position = game.at(14,0)
	const property image = "salida.png"
}

class Pollo {
	var property energia =  0.randomUpTo(30).truncate(0)
    var property position = utilidadesParaJuego.posicionArbitraria() //game.at(10,8)
	const property image = "pollo.png"	
}

	
class Modificador {
	var property position = utilidadesParaJuego.posicionArbitraria() //game.at(10,8)
	const property image = "modificador.png"
	const property nombre = "sin Modificador"
	method energiaOtorgada(personaje,pollo) = pollo.energia()
}

class ModificadorDuplicador inherits Modificador  {
	override method nombre() = "Duplicador"
	override method energiaOtorgada(personaje,pollo) = super(personaje,pollo) * 2
}

class ModificadorReforzador inherits ModificadorDuplicador {
	override method nombre() = "Reforzador"
	override method energiaOtorgada(personaje,pollo) =  super(personaje,pollo) + self.energiaExtra(personaje)
	method energiaExtra(personaje) = if(personaje.energia() < 10 ) 20 else 0
}

class ModificadorTripleONada inherits Modificador {
	override method nombre() = "Triple O Nada"
	override method energiaOtorgada(personaje,pollo) =  super(personaje,pollo) + self.multiplicador(personaje)
	method multiplicador(personaje) = if(personaje.energia().even() ) 0 else 3
}