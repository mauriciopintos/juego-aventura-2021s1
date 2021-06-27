import wollok.game.*
import utilidades.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = utilidadesParaJuego.posicionArbitraria() //game.at(10,8)
	const property image = "player.png"	
}
