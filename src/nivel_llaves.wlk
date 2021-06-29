import wollok.game.*
import fondo.*
import personajes.*
import utilidades.*
import elementos.*

object nivelLlaves {
	const property llavesEnTablero = #{}

	method todasLasLlavesConseguidas() = self.llavesEnTablero().isEmpty()
	method recolectar(unaLlave){
		self.llavesEnTablero().remove(unaLlave)
		game.removeVisual(unaLlave)
		if (self.todasLasLlavesConseguidas()){
			// Se agrega la salida al tablero
			game.addVisual(salida)
		}
	}
	method hayLlave(posicion) = self.llavesEnTablero().any( { b => b.position() == posicion } )
	
	method ponerLlaves(cantidad) {
		if(cantidad > 0) {
			const unaLlave = new Llave()
			self.llavesEnTablero().add(unaLlave)
			game.addVisual(unaLlave)
			self.ponerLlaves(cantidad -1)
		}
	}			

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="fondoCompleto.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		self.ponerLlaves(3)
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeNivelDos)
		
		// teclado
		keyboard.right().onPressDo{ personajeNivelDos.moverDerecha() }
		keyboard.left().onPressDo{ personajeNivelDos.moverIzquierda() } 
		keyboard.up().onPressDo{ personajeNivelDos.moverArriba() }
		keyboard.down().onPressDo{ personajeNivelDos.moverAbajo() }
		keyboard.n().onPressDo({
			if(self.todasLasLlavesConseguidas())
				// Se agrega la salida al tablero
				game.addVisual(salida)
				if( personajeNivelDos.position() == salida.position())
					self.ganar()
			else
				self.faltanRequisitos()
		})
		
		// este es para probar, no es necesario dejarlo
		keyboard.g().onPressDo({ self.ganar() })
		keyboard.p().onPressDo({ self.perder() })
		
		// colisiones, acá sí hacen falta
	}
	
	method ganar() {
		// es muy parecido al terminar() de nivelBloques
		// el perder() también va a ser parecido
		
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="ganamos.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
		})
	}
	
		method perder() {	
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="perdimos.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
		})
	}
	
}
