import wollok.mirror.*
import wollok.game.*
import direcciones.*
import aspersor.*
object personaje {
	var  property position = game.center()
	const property image = "fplayer.png"
	const  property cultivos =  #{}
	const property cosecha = #{}
	var monedasDeOro = 0
	
	method monedas() = monedasDeOro
	
	method mover(direccion){
        position = direccion.siguiente(position)
    }
	method sembrar(semilla) {
	  	self.validarSembrar(semilla)
		game.addVisual(semilla)
		cultivos.add(semilla)
		
	}

	method regar(planta) {
		self.validadRegar(self.plantaAca())	
	  	planta.esRegada()
	}
	method cosechar() {
		const cultivo = self.plantaAca()
	  	self.validadCosechaDe(cultivo)
		game.removeVisual(self.plantaAca())
		cosecha.add(cultivo )
		cultivos.remove(cultivo )
	}
	method vender() {
	  monedasDeOro = cosecha.sum{ planta => planta.precio() }
	  cosecha.clear()
	}
	method oroTotal() {
	  game.say(self,"Tengo"  + monedasDeOro + "mondeas de oro y" + cosecha.size()+" plantas para vender")
	}
		method colocarAspersor() {
			self.validarSembrar(self.position())
			
			aspersores.plantarAspersor()
			//aspersor.regarAspersor()
		}

	method puedeRegarse() {
	  return false
	}

	method esRegada() {
	}


//---------------      Validadores     -----------------------
	method validarSembrar(semilla) {
		if( self.hayPlantaAca() ){
			self.error("Hay una planta aca")
		}  
	}
	method validadRegar(semilla) {
	  if(not self.hayPlantaAca()){
		self.error("No hay planta para regar")
	  }
	}
	method validadCosechaDe(planta) {
	  if (planta == null) {
        self.error("No hay ninguna planta para cosechar")
    }
    if (not planta.puedeSerCosechada()) {
        self.error("La planta aún no  esta lista para cosechar")
    }
	}



//------------------------    consultas   -------
	method hayPlantaAca() {
		//consulta si en la poscicion del personaje hay una planta
	  return  cultivos.any({ planta => planta.position() == position })
	}
	method plantaAca() {
		//retorna la planta de la pos actual
	  return cultivos.find({ p => p.position() == position })
	}
	method hayPlantaEn(pos) {
		//retorna is hay una plnata en una pos por parametro
	  return  cultivos.any({ planta => planta.position() == pos })
	}
	method plantasEn(posicion){
        return game.getObjectsIn(posicion).filter({obj => cultivos.contains(obj)})
    }


}