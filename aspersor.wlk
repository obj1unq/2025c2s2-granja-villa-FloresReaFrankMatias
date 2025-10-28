
import wollok.game.*
import personaje.*

object aspersores {
    const    property aspersoresTotales = #{}

    method activarAspersores()    {   aspersoresTotales.forEach({aspersor=> aspersor.regarLimitrofes()})                         }
    
    // este metodo no lo uso en ningun lado
    //method hayAspersorEn(position){   return game.getObjectsIn(position).any({obj => aspersoresTotales.contains(obj)})  }

    method instalarAspersor(posicionAInstalar) {
        const aspersor = aspersorFactory.crearAspersor(posicionAInstalar)
        aspersoresTotales.add(aspersor)
        game.addVisual(aspersor)
    }
    method iniciarRiego(){
      game.onTick(1000, "regarLimitrofes", { self.activarAspersores()  } )
    }
}

//----------------------------------------------------------------
object aspersorFactory {
    method crearAspersor(posicionAInstalar) {  return  new Aspersor(position= posicionAInstalar )  }
}
//----------------------------------------------------------------
class Aspersor {
  var property position
  method image() {  return "aspersor.png"}


	method regarLimitrofes() {
		self.posicionesLimitrofes().forEach({ pos => personaje.regarPlantaEn(pos)  }) 
	} 
  
  // primero hice este metodo pero con este method despeus en regarLimitrofes tengo que hacer 
  //  self.cultivosLimitrofes().forEach( { cultivo => cultivo.esRegada() } ) y no le delegaria la repsonsabilidad
  // de regar al personaje como si lo hago usando posicionesLimitrofes()
  
  // aca retorno una collecion en donde filtro  los cultivs limirtrofes del aspersor
  method cultivosLimitrofes() {
    return  personaje.cultivos().filter( {planta => self.position().distance(planta.position()) < 2})
  }   

  // con este metodo retorno ls posciones de los cultivos limitrofes
  // me quedo con este method porque
  method posicionesLimitrofes() {
    const posicionesDeCultivos = personaje.cultivos().map({ cultivo => cultivo.position() }) 
    return posicionesDeCultivos.filter( { unaPosicion => 
        self.position().distance(unaPosicion) < 2 
    })
}
  
  method puedeRegarse() {    return false }
  method esRegada()     {  }
}
