import wollok.game.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method sembrar(semilla) {
		//const semillas= [new Maiz(), new Tobaco(), new Trigo()]
		//if( semilla.any({semilla =>  semilla.position() != position })  ){ 	
	  	game.addVisual(semilla)
		
	}
	
	method validarSembrar(semilla) {
	  
		return position !=  semilla.position()
	}
	method regar(semilla) {
	  semilla.esRegada()
	}

}