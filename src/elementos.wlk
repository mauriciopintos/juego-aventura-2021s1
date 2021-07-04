import wollok.game.*
import utilidades.*
import nivel_bloques.*
import nivel_llaves.*

class Bloque {	// Cajas
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "caja.png"
	
	// agregar comportamiento
	method estaEnDeposito() = deposito.contiene(self.position())
	
	method sePuedeEmpujarA(posicion) = utilidadesParaJuego.sePuedeMover(posicion) and not nivelBloques.hayBloque(posicion)
	method empujar(posicion) {
		if (self.sePuedeEmpujarA(posicion)){
			self.position(posicion)
		}
	}
}
object deposito {
	method contiene(unaPosicion) = unaPosicion.x().between(5,9) and unaPosicion.y().between(7,12)
}

object salida {
	const property position = game.at(game.width()-1,0)
	const property image = "salida.png"
	method reaccionarA(unPersonaje){ }//nivelLlaves.ganar() }
}

class Elemento{
	var property position
	method reaccionarA(unPersonaje)
	method dejarPasar(unPersonaje) { unPersonaje.position(self.position()) }
}
class Llave inherits Elemento{
	const property image = "llave.png"
	override method reaccionarA(unPersonaje){
		self.dejarPasar(unPersonaje)
		unPersonaje.guardarLlave()
	}
}

class Pollo inherits Elemento{
	var property energia =  0.randomUpTo(30).truncate(0)
	const property image = "pollo.png"
	override method reaccionarA(unPersonaje){
		self.dejarPasar(unPersonaje)
		unPersonaje.ganarEnergia(self.energia())
	}
}

class Modificador inherits Elemento{
	const property image = "modificador.png"
	const property nombre = "sin Modificador"
	method energiaOtorgada(personaje,unPollo) = unPollo.energia()
	override method reaccionarA(unPersonaje){if(self.position() == unPersonaje.position()) unPersonaje.incorporaEfecto(self)}
}

class Duplicador inherits Modificador  {
	override method nombre() = "Duplicador"
	override method energiaOtorgada(personaje,unPollo) = super(personaje,unPollo) * 2
}

class Reforzador inherits Duplicador {
	override method nombre() = "Reforzador"
	override method energiaOtorgada(personaje,unPollo) =  super(personaje,unPollo) + self.energiaExtra(personaje)
	method energiaExtra(personaje) = if(personaje.energia() < 10 ) 20 else 0
}

class TripleOrNada inherits Modificador {
	override method nombre() = "Triple O Nada"
	override method energiaOtorgada(personaje,unPollo) =  super(personaje,unPollo) + self.multiplicador(personaje)
	method multiplicador(personaje) = if(personaje.energia().even() ) 0 else 3
}

class CeldaSorpresa inherits Elemento{
	var property image = "sorpresa.png"
	method cambiarDeIMagen(){image="kisspng.png"}
	override method reaccionarA(unPersonaje){ // DETERMINAR Y CODIFICAR ACCION
	}
}