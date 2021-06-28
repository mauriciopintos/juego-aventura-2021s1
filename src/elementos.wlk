import wollok.game.*
import utilidades.*
import nivel_bloques.*

class Bloque {	// Cajas
	var property position
	const property image = "caja.png"
	
	// agregar comportamiento
	method estaEnDeposito() = deposito.contiene(self.position())
	
	method puedeEmpujarA(posicion) = utilidadesParaJuego.sePuedeMover(posicion) and not nivelBloques.hayBloque(posicion)
	
	method empujar(posicion) {
		if (self.puedeEmpujarA(posicion)){
			self.position(posicion)
		}
	}
}


object deposito {
	method contiene(unaPosicion) = unaPosicion.x().between(5,9) and unaPosicion.y().between(7,12)
}


object salida {
	const property position = game.at(14,0) //utilidadesParaJuego.posicionArbitraria()
	const property image = "salida.png"
}