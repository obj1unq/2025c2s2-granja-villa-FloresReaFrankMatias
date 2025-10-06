import wollok.game.*
import personaje.*
class Maiz {
	var property position = personaje.position()  
	var property image = "corn_baby.png" 
	//method position() {
		// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	//method image() {
		// TODO: hacer que devuelva la imagen que corresponde
	//	return "corn_baby.png"
	//}
	//method sembrar(){
	//	game.addVisual(self)
	//}
	method esRegada() {
	  if(self.esBebe()){
		image = "corn.adult.png"
	  }
	}
	method esBebe() {
	  return image == "corn_baby.png" 
	}
	
}

class Trigo {
	//method position() {
		// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(personaje.position().x(), personaje.position().y())
	//}
		var property position = personaje.position()  
		var property image = "wheat_0.png" 
	//method image() {
		// TODO: hacer que devuelva la imagen que corresponde
	//	return "wheat_0.png"
	//}
	
}

class Tomaco {
	//method position() {
		// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	var property position = personaje.position()  

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco_baby.png"
	}
}

