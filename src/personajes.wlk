import wollok.game.*
import utilidades.*
import nivel_bloques.*
import nivel_llaves.*


// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición
object personajeNivelDos {
	var property position = utilidadesParaJuego.posicionArbitraria()
	//const property posicionesVisitadas = #{}
	const property image = "player.png"
	var property energia=0
		
	method siHayLlaveGuardar() {
		if (nivelLlaves.hayLlave(self.position())){
			const unaLlave = nivelLlaves.llavesEnTablero().find( { b => b.position() == self.position() } )
			nivelLlaves.recolectar(unaLlave)
		}
	}
	
	method cambiarPosicion(posicion) {
		if (utilidadesParaJuego.sePuedeMover(posicion) ) {
			self.position(posicion)
			self.siHayLlaveGuardar()
		}
	}
	
	method moverDerecha() {
		self.cambiarPosicion(self.position().right(1))
	}
	method moverIzquierda() {
		self.cambiarPosicion(self.position().left(1))
	}
	method moverArriba() {
		self.cambiarPosicion(self.position().up(1))
	}
	method moverAbajo() {
		self.cambiarPosicion(self.position().down(1))
	}
}

object personajeSimple {
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "player.png"
	var proximaPosicion
	

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
	method cambiarPosicion(posicion) {
		if (utilidadesParaJuego.sePuedeMover(posicion) ) {
			self.avanzarA(posicion)
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
