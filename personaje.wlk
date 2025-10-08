import wollok.mirror.*
import wollok.game.*

object personaje {
	var  property position = game.center()
	const property image = "fplayer.png"
	const  property cultivos =  #{}
	const property cosecha = #{}
	var monedasDeOro = 0
	
	method monedas() = monedasDeOro

	method sembrar(semilla) {
	  	self.validarSembrar(semilla)
		game.addVisual(semilla)
		cultivos.add(semilla)
		
	}
//-------

	

//-------
	method regar(planta) {
		self.validadRegar(self.plantaAca())	
	  	planta.esRegada()
	}
	method cosechar() {
	  	self.validadCosechaDe(self.plantaAca())
		game.removeVisual(self.plantaAca())
		cosecha.add(self.plantaAca() )
		cultivos.remove(self.plantaAca() )
	}
	method vender() {
	  monedasDeOro = cosecha.sum{ planta => planta.precio() }
	  cosecha.clear()
	}
	method oroTotal() {
	  game.say(self,"Tengo"  + monedasDeOro + "mondeas de oro y" + cosecha.size()+" plantas para vender")
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
	  if( not (self.hayPlantaAca() && planta.puedeSerCosechada())  ){
		self.error(" No tengo nada para cosechar ")
	  }
	}



//------------------------    Getters   -------
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

}