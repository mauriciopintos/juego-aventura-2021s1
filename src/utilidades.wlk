import wollok.game.*

object utilidadesParaJuego {
	method posicionArbitraria() {  // Delimita el rango aleatorio dejando una celda de margen para que los bloques no aparzcan pegados a la pared
		return game.at(
			1.randomUpTo(game.width()-2).truncate(0), 1.randomUpTo(game.height()-2).truncate(0)
		)
	}
	
	method sePuedeMover(posicion) {
		return posicion.x().between(0,game.width()-1) and posicion.y().between(0,game.height()-1)
	}
}

object pizarra {
	var property position = game.at(0,game.height()-1)
}