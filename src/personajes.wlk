import wollok.game.*
import utilidades.*
import nivel_bloques.*
import nivel_llaves.*
import elementos.*


// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

/* personaje generico */
class Personaje {
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "player.png"
	var proximaPosicion = self.position()
	
	/* MOVIMIENTOS */
	method cambiarPosicionHaciendo(posicion)
	method cambiarPosicion(posicion) {
		if (utilidadesParaJuego.sePuedeMover(posicion) ) {
			self.cambiarPosicionHaciendo(posicion)
		}
	}

	method moverDerecha() {
		proximaPosicion = game.at(self.position().x() + 2, self.position().y())
		self.cambiarPosicion(self.position().right(1))
	}
	method moverIzquierda() {
		proximaPosicion = game.at(self.position().x() - 2, self.position().y())
		self.cambiarPosicion(self.position().left(1))
	}
	method moverArriba() {
		proximaPosicion = game.at(self.position().x(), self.position().y() + 2)
		self.cambiarPosicion(self.position().up(1))
	}
	method moverAbajo() {
		proximaPosicion = game.at(self.position().x(), self.position().y() - 2)
		self.cambiarPosicion(self.position().down(1))
	}
}

/* CON personajes como Clases heredadas */
class PersonajeNivelLlaves inherits Personaje {
	var property energia=40
		
	method perderEnergia(){self.energia(self.energia()-1)}
	method ganarEnergia(cantidad){self.energia(self.energia()+cantidad)}
	method evaluarEstado(posicion) { if (self.energia() == 0) nivelLlaves.perder() else self.evaluarPosicion(posicion)}
	method puedeGanar() = nivelLlaves.todasLasLlavesConseguidas() and proximaPosicion == salida.position()
	method	evaluarPosicion(posicion) { if (self.puedeGanar()) nivelLlaves.ganar() else self.position(posicion) }
	override method cambiarPosicionHaciendo(posicion) {
			self.perderEnergia()
			self.evaluarEstado(posicion)
	}
}

class PersonajeNivelBloques inherits Personaje {
	method siHayBloqueEmpujar(posicion) {
		if (nivelBloques.hayBloque(posicion) and not nivelBloques.hayBloque(proximaPosicion) ){
			const unBloque = nivelBloques.bloquesEnTablero().find( { b => b.position() == posicion } )
			unBloque.empujar(proximaPosicion)
		}
	}
	method avanzarA(posicion) {
		self.siHayBloqueEmpujar(posicion)
		if(not nivelBloques.hayBloque(posicion)) {
			self.position(posicion)
		}
	}
	
	override method cambiarPosicionHaciendo(posicion) {self.avanzarA(posicion) }
	/*
	override method moverDerecha() {
		proximaPosicion = game.at(self.position().x() + 2, self.position().y())
		super()
	}
	override method moverIzquierda() {
		proximaPosicion = game.at(self.position().x() - 2, self.position().y())
		super()
	}
	override method moverArriba() {
		proximaPosicion = game.at(self.position().x(), self.position().y() + 2)
		super()
	}
	override method moverAbajo() {
		proximaPosicion = game.at(self.position().x(), self.position().y() - 2)
		super()
	}*/
}