import wollok.game.*
import utilidades.*
import nivel_bloques.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = utilidadesParaJuego.posicionArbitraria() //game.at(10,8)
	const property posicionesVisitadas = #{}
	const property image = "player.png"
	var property energia=0
	var proximaPosicion
	
	method hayBloqueEnDestino(){
		return true
	}
	
	method cambiarPosicion(posicion) {
		if (utilidadesParaJuego.sePuedeMover(posicion) ) {
			if (nivelBloques.hayBloque(posicion) and not nivelBloques.hayBloque(proximaPosicion) ){
				const unBloque = nivelBloques.bloquesEnTablero().find( { b => b.position() == posicion } )
				unBloque.empujar(proximaPosicion)
				self.position(posicion)
				posicionesVisitadas.add(posicion)
			}else if(not nivelBloques.hayBloque(posicion)) {
				self.position(posicion)
				posicionesVisitadas.add(posicion)
			}
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
