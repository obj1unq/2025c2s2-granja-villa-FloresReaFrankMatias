
import wollok.game.*
import personaje.*

object aspersores {
    const    property aspersoresTotales = #{}

    method activarAspersores()    {   aspersoresTotales.forEach({asp => asp.regarLimitrofes()})                         }
    method hayAspersorEn(position){   return game.getObjectsIn(position).any({obj => aspersoresTotales.contains(obj)})  }

    method plantarAspersor() {
        const aspersor = aspersorFactory.crearAspersor()
        aspersoresTotales.add(aspersor)
        game.addVisual(aspersor)
    }
}

//----------------------------------------------------------------
object aspersorFactory {
    method crearAspersor() {      return  new Aspersor(position= personaje.position() )  }
}

//----------------------------------------------------------------

class Aspersor {
  var property position
  method image() {  return "aspersor.png"}


  method regarLimitrofes() {  
    const posLimitrofes= [
        //pos ortogonales
      position.up(1),
      position.right(1),
      position.down(1),
      position.left(1),
      // posiciones diagonales
      position.up(1).right(1),
      position.up(1).left(1),
      position.down(1).right(1),
      position.down(1).left(1)
    ]   
      posLimitrofes.forEach({ pos => self.regarPlantaEn2(pos) }) 
  }
  
  
    
    
  
method regarPlantaEn2(pos) {
    const plantas = personaje.plantaEn(pos)   // colección
    if (plantas.size() > 0) {                // si hay al menos una planta
        plantas.first().esRegada()           // llamamos al método solo sobre el objeto Maiz
    }
}
  method regarPlantaEn(pos) {
    if (  personaje.hayPlantaEn(pos)  )  {
      personaje.plantaEn(pos).esRegada()
    }
  }

  method puedeRegarse() {    return false }
  method esRegada()     {  }
}
