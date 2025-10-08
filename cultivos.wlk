import wollok.game.*
import personaje.*
class Maiz {
	var property position = personaje.position()
	var estado = bebe
	const precio = 150 
	method precio() {
	  return precio
	}
	
	method esRegada() {
	  estado.regar()
	}
	


	//----  REGAR
	


	//-------------- estado   ---------
	method image() {
	  return "corn_" + estado.image()
	}
	var property esBebe = false
	method estado() {
	  return	if ( esBebe) estado = bebe
	  	     	else estado = adult	
	}

	method esAdulto() {
	  return !esBebe
	}
	method puedeSerCosechada() {
	  return self.esAdulto() 
	}
	method esCosechada() {
	  game.removeVisual(self)
	}	



}

object bebe {
	var  property image = "baby.png" 
	method regar() {
	  image = "adult.png"
	}
	method esCosechable() {
	  return false
	
	}
}

object adult {
	var  property image = "adult.png" 
	method esCosechable() {
	  return true
	}
	method regar() {
	  image = "baby.png"
	}
}

//-------------------------------------------------
class Trigo {
	var evolucion = 0
	const property precio = (evolucion - 1) * 100

	//method position() {
		// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(personaje.position().x(), personaje.position().y())
	//}
		var property position = personaje.position()  
		//var property image = "wheat_0.png" 
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_" + evolucion + ".png"
	}
	
	method esRegada() {
	  if( evolucion <3 ){
		evolucion += 1
	  }else{
		evolucion = 0
	  }
	  
	}
	method puedeSerCosechada() {
	  return evolucion > 1
	}
	method esCosechada() {
	  game.removeVisual(self)
	}
}




//---------------------------------------------
class Tomaco {
	//method position() {
		// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	var property position = personaje.position()  
	const property precio = 80
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco_baby.png"
	}
	
	method esRegada() {
	  //position = game.at(position.x(), (game.height()-1).min(position.y() +1))
		self.validarMoverArriba()
		if(position.y() != game.height()-1 ){
			position= game.at(position.x(), position.y()+1)	
		}else{
			position= game.at(position.x(), 0)
		}

	}
	method validarMoverArriba() {
		var posAlMover=  game.at(position.x(),position.y()+1)
	  if(personaje.hayPlantaEn(posAlMover)){
			self.error("No se puede mover mas arriba")
	  }
	}
	method puedeSerCosechada() {
	  return true
	}
	method esCosechada() {
	  game.removeVisual(self)
	}
}

