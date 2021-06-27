import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*


object nivelBloques {
	const property bloquesEnTablero = []
	
	method ponerBloques(cantidad) {
		if(cantidad > 0) {
			const unBloque = new Bloque(position=utilidadesParaJuego.posicionArbitraria())
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
		
		// Define zona de deposito
		deposito.defineZona()
		
		// otros visuals, p.ej. bloques o llaves
		self.ponerBloques(5)
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })

		// en este no hacen falta colisiones
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

