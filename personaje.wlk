import wollok.mirror.*
import wollok.game.*
import direcciones.*
import aspersor.*
import mercado.*

object personaje {
	var  property position = game.center()
	const property image = "fplayer.png"
	const  property cultivos =  #{}
	const property cosecha = #{}
	var monedasDeOro = 0
	
	method monedas()       {    return monedasDeOro                      } 
	method mover(direccion){    position = direccion.siguiente(position) }
	
	method sembrar(semilla) {
	  	self.validarPlantar()
		game.addVisual(semilla)
		cultivos.add(semilla)
		
	}

	method regarPlantaEn(pos) {
		self.validarRegarEn(pos)
    	const cultivo = self.plantaEn(pos)   
	    cultivo.first().esRegada()          
    
}

	method cosechar() {
	  	self.validarCosecha()
		const cultivo = self.plantaEn(position).first()
		game.removeVisual(cultivo)
		cosecha.add(cultivo )
		cultivos.remove(cultivo )
	}
	method vender() {
		self.validarVenta()	
		mercados.mercadoEn(position).comprarMercaderia(self.valorDeCosechaTotal())
		monedasDeOro += self.valorDeCosechaTotal()
	  	cosecha.clear()
	}
	method oroTotal() {
	  game.say(self,"Tengo "+ " "+ + monedasDeOro + " "+ "de oro y  " +" "+ cosecha.size()+  " "+" plantas ")
	}
	method colocarAspersor() {
		self.validarPlantar()
		aspersores.instalarAspersor(position)	
		}

	method valorDeCosechaTotal(){	return cosecha.sum{ planta => planta.precio() }}	
	method puedeRegarse()       {	return false                                   }
	method esRegada()           { }                                                
	method text()               {	return monedasDeOro.toString()                 }
	method textColor()          { return "FF0000FF"			                       }


//---------------      Validadores     -----------------------
	method validarPlantar() {
			//if(self.hayPlantaAca() || self.estaSobreUnMercado()  || self.estaSobreUnAspersor()  ){
		if(  not game.colliders(self).isEmpty() ){ 
			self.error("No se puede plantar aca")
		}  
	}
	method validarRegarEn(posicionARegar) {
		if(!self.hayPlantaEn(posicionARegar)) {
			self.error("No se puede regar aca")
		}
	}
	method validarCosecha() {
	  	if (  self.plantaEn(position).isEmpty() ) {
    		self.error("No hay ninguna planta para cosechar")
    	}
    	if (not self.plantaEn(position).first().puedeSerCosechada()) {
        	self.error("La planta aún no  esta lista para cosechar")
    	}
	}

	method validarVenta(){
		if( not self.estaSobreUnMercado()){
			self.error("No estoy sobre un mercado")
		}
	}


//------------------------       -------
	
		//lo unifico con hayPlantaEn
	//method hayPlantaAca() { 
	//	//consulta si en la poscicion del personaje hay una planta
	 // return  cultivos.any({ planta => planta.position() == position })
	//}
	method hayPlantaEn(pos) {
		//retorna is hay una plnata en una pos por parametro
	  return  cultivos.any({ planta => planta.position() == pos })
	}

		// lo unifico con plantaEn
	//method plantaAca() { 
	//  return cultivos.find({ p => p.position() == position })
	//}
	
	method plantaEn(posicion){
		// retorna  la  planta que esta en una posicion dad por parametro
        return game.getObjectsIn(posicion).filter({obj => cultivos.contains(obj)})
    }
	method estaSobreUnMercado() {
		return mercados.hayMercadoEn(position)
	
	}


}