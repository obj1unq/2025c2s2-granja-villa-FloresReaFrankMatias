import wollok.game.*
import personaje.*


object cultivoFactory {
    method crearMaiz(pos)   { return new Maiz(position= pos)    }
    method crearTrigo(pos)  { return new Trigo(position=pos)    }
    method crearTomaco(pos) { return new Tomaco(position=pos)   }
}

class Maiz {
	var property position 
	var estado = bebe
	const precio = 150 

	method precio()            {	return precio								}
	method esRegada()          {	 estado= estado.siguienteEstadoAlRegar()    }
	method image()             {	return "corn_" + estado.image()				}
	method puedeSerCosechada() {	return estado.esCosechable()				}
	
	
	method esCosechada()       {	game.removeVisual(self)						}	
}

object bebe {
	var  property image = "baby.png" 
	method esCosechable()           { return false  }
	method siguienteEstadoAlRegar() { return adult  }
}

object adult {
	var  property image = "adult.png" 
	method esCosechable()           {  return true}
	method siguienteEstadoAlRegar() {    return self         } // no cambia de estado
	
}

//-------------------------------------------------
class Trigo {
	var evolucion = 0
	const property precio = (evolucion - 1) * 100
	var property position 
	
	method esRegada() {
	  if( evolucion <3 ){
		evolucion += 1
	  }else{
		evolucion = 0
	  }
	}
	method image()             {	return "wheat_" + evolucion + ".png"	}   
	method puedeSerCosechada() {  	return evolucion > 1	   				}
	method esCosechada()       {  	game.removeVisual(self)					}
}



//---------------------------------------------
class Tomaco {
	var property position 
	const property precio = 80
	method image() {
		return "tomaco_baby.png"
	}
	
//  version anterior, solo la comento no la borro por las dudas
//	method esRegada() { 
//		
//		self.validarMoverTomacoAlRegar(position.up(1), position.down(game.height() - 1)  )
//		if (not (position.y() == game.height() - 1)  ) {
//			position = position.up(1)
//		}
//		else {
//			position = position.down(game.height() - 1)
//		}
//		
//		
//		
//	}

	method esRegada() { 
		self.validarDestino(self.posicionAlRegar())
		position = self.posicionAlRegar() 
	}

    // el tomaco cuando se riega se mueve arriba si no esta en el borde superior
	 // o sino a la posicion abajo de todo
	method posicionAlRegar() {
	  return if (  not (position.y() == game.height() - 1)){           //position.y() == game.height() - 1) {
              position.up(1)    
        } else {
              position.down(game.height() - 1)                 
        }
	}
	// en esta subtarea valido si se puede mover el tomaco al ser regado, osea que  e nla pos
	//   que se mueve al ser regado no haya nada 
	method validarDestino(posicionAMoverse) {
        if (not game.getObjectsIn(posicionAMoverse).isEmpty()) {
            self.error("No puedo ser regada ")
		}
	}

	
	method puedeSerCosechada() {	return true            	}
	method esCosechada()       { 	game.removeVisual(self)	}
	
}


