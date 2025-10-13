
import wollok.game.*
import personaje.*

object aspersores {
    const    property aspersoresTotales = #{}

    method activarAspersores() {
      aspersoresTotales.forEach({asp => asp.regarLimitrofes()})
    }

    method plantarAspersor() {
        const aspersor = aspersorFactory.crearAspersor()
        aspersoresTotales.add(aspersor)
        game.addVisual(aspersor)
      
    }

}
object aspersorFactory {
    method crearAspersor() {
        return  new Aspersor(position= personaje.position() )
        
    }
   
}


class Aspersor {
  var property position
  method image() {
    return "aspersor.png"
  }

  

  method regarLimitrofes() {
        const posicionesARegar = [
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
        posicionesARegar.forEach({pos =>
          game.getObjectsIn(pos).forEach({objeto => objeto.esRegada()})
        })
      //game.getObjectsIn(position.up(1)).forEach({objeto => objeto.esRegada()})
      //game.getObjectsIn(position.right(1)).forEach({objeto => objeto.esRegada()})
      //game.getObjectsIn(position.down(1)).forEach({objeto => objeto.esRegada()})
      //game.getObjectsIn(position.left(1)).forEach({objeto => objeto.esRegada()})
  }
  method planta() {
    return false
  }

  method puedeRegarse() {
    return false
  }

  method esRegada() {
    }
}
