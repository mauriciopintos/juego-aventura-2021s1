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