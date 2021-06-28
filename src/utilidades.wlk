import wollok.game.*

object utilidadesParaJuego {
	method posicionArbitraria() {
		return game.at(
			1.randomUpTo(game.width()-1).truncate(0), 1.randomUpTo(game.height()-1).truncate(0)
		)
	}
	
	method defineRangoDeCeldas(objeto){ // Define recursivamente el rango de celdas del deposito
		objeto.y(objeto.y()+1)
		if (objeto.y() > objeto.yf()){
			if (objeto.x() <= objeto.xf()){
				objeto.y(objeto.yi())
				objeto.x(objeto.x() +1)
			}
		}
				
		if (objeto.x().between(objeto.xi(),objeto.xf()) and objeto.y().between(objeto.yi(),objeto.yf())) {
			objeto.celdas().add(game.at(objeto.x(),objeto.y()))
			self.defineRangoDeCeldas(objeto)
		}
	}
	
	method sePuedeMover(posicion) {
		return posicion.x().between(0,game.width()-1) and posicion.y().between(0,game.height()-1)	
	}
	
	/* DESARROLLAR IDEA
	 	method poner(cantidad,objeto,almacen) {
		if(cantidad > 0) {
			almacen.add(objeto)
			game.addVisual(objeto)
			self.poner(cantidad -1,objeto,almacen)
		}
	}
	 */
}