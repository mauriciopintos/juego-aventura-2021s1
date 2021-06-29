import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*


object nivelBloques {
	const property bloquesEnTablero = #{}
	
	method todosLosBloquesEnDeposito() = self.bloquesEnTablero().all( { b => b.estaEnDeposito() } )
	
	method faltanRequisitos() {
		if (self.todosLosBloquesEnDeposito())
			game.say(personajeSimple,"Debo ir a la salida")
		else
			game.say(personajeSimple,"Faltan bloques en el deposito")
	}
	
	method hayBloque(posicion) = self.bloquesEnTablero().any( { b => b.position() == posicion } )
	
	method ponerBloques(cantidad) {
		if(cantidad > 0) {
			const unBloque = new Bloque()
			self.bloquesEnTablero().add(unBloque)
			game.addVisual(unBloque)
			self.ponerBloques(cantidad -1)
		}
	}
	
	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo())
		
		// Se agrega la salida al tablero
		game.addVisual(salida)
						
		// otros visuals, p.ej. bloques o llaves
		self.ponerBloques(5)
	
		
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		// teclado
		
		/*Movimientos del personaje*/
		keyboard.right().onPressDo{ personajeSimple.moverDerecha() }
		keyboard.left().onPressDo{ personajeSimple.moverIzquierda() } 
		keyboard.up().onPressDo{ personajeSimple.moverArriba() }
		keyboard.down().onPressDo{ personajeSimple.moverAbajo() }
		keyboard.n().onPressDo({
			if(self.todosLosBloquesEnDeposito() and personajeSimple.position() == salida.position() )
				self.terminar()
			else
				self.faltanRequisitos()
		})
					
	}
	
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(personajeSimple)
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}

