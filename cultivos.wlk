import wollok.game.*
import personaje.*


object cultivoFactory {
    method crearMaiz(pos) {
        return new Maiz(position= pos)
    }
    method crearTrigo(pos) {
        return new Trigo(position=pos)
    }
    method crearTomaco(pos) {
        return new Tomaco(position=pos)
    }
}

class Maiz {
	var property position 
	var    estado = bebe
	const precio = 150 
	method precio() {
	  return precio
	}
	
	method esRegada() {
		estado = estado.siguienteEstadoAlRegar()
    }


	//-------------- estado   ---------
	method image() {
	  return "corn_" + estado.image()
	}
	

	method esAdulto() {
	  return   estado.esCosechable() //not esBebe
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
	
	method esCosechable() {
	  return false
	
	}
	method siguienteEstadoAlRegar() {
        return adult
    }
}

object adult {
	var  property image = "adult.png" 
	method esCosechable() {
	  return true
	}
	method siguienteEstadoAlRegar() {
        return self
    }
	
}

//-------------------------------------------------
class Trigo {
	var evolucion = 0
	const property precio = (evolucion - 1) * 100

	var property position 
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
	var property position 
	const property precio = 80
	method image() {
		return "tomaco_baby.png"
	}
	
	//method esRegada2() {
	//	if(position.up(1).y() != game.height() && game.getObjectsIn(position.up(1)).isEmpty() ){
	//			position = position.up(1)
	//	} else {
	//		position = game.at(position.x(), 0)
	//	}
	//}
	method esRegada() {
		
		self.validarMoverTomaco(position.up(1), position.down(game.height() - 1)  )
		if (not (position.y() == game.height() - 1)  ) {
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
	method validarMoverTomaco(pos1,pos2) {
	  if( not game.getObjectsIn(pos1).isEmpty() ){ //personaje.hayPlantaEn(pos1)   ){
			self.error("No puedo ser regada")	
	  }
	  if( not game.getObjectsIn(pos2).isEmpty()  ){ //personaje.hayPlantaEn(pos2)
		self.error("No puedo ser regada ")
	  }
	}
}


