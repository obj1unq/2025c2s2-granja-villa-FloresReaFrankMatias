import wollok.game.*
import personaje.*


object cultivoFactory {
    method crearMaiz() {
        return new Maiz()
    }
    method crearTrigo() {
        return new Trigo()
    }
    method crearTomaco() {
        return new Tomaco()
    }
}

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

	var property position = personaje.position()  
	method image() {
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
	var property position = personaje.position()  
	const property precio = 80
	method image() {
		return "tomaco_baby.png"
	}
	
	method esRegado() {
		if(position.up(1).y() != game.height() && game.getObjectsIn(position.up(1)).isEmpty() ){
				position = position.up(1)
		} else {
			position = game.at(position.x(), 0)
		}
	}
	method esRegada() {
		if (not (position.y() == game.height() - 1) && not personaje.hayPlantaEn(position.up(1)) ) {
			position = position.up(1)
		}
		else {
			position = position.down(game.height() - 1)
		}
	}
	
	method puedeSerCosechada() {
	  return true
	}
	method esCosechada() {
	  game.removeVisual(self)
	}
}


