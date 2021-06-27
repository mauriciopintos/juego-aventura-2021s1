import wollok.game.*
import utilidades.*

class Bloque {	// Cajas
	var property position
	const property image = "caja.png"
	
	// agregar comportamiento
	method estaEnDeposito() = deposito.celdas().contains(self.position())
}

object deposito {
	var property celdas = [] // Definir el rango de celdas game.at(5,7)..game.at(9,12)
	const property xi = 5
	const property yi = 7
	const property xf = 9
	const property yf = 12
	var property x = self.xi()
	var property y = self.yi()-1

	method defineZona(){ utilidadesParaJuego.defineRangoDeCeldas(self) }	
}

object salida {
	const property position = game.at(14,0) //utilidadesParaJuego.posicionArbitraria()
	const property image = "salida.png"
}