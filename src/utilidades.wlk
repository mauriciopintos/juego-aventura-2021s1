import wollok.game.*

object utilidadesParaJuego {
	method posicionArbitraria() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0)
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