import wollok.game.*
import personaje.*

object mercados{
  const mercadosTotales = #{}

  method nuevoMercado(pos) {
    const mercado = mercadoFactory.crear(pos)
    mercadosTotales.add(mercado)
    game.addVisual(mercado)
  }


}

object mercadoFactory {
    method crear(pos) {
      return new Mercado( position = pos)

    }    

}

class Mercado {
    var property position  
    const mercaderia = #{}
    var property monedas  = 0
    method image() {
      return "market.png"
    }

    method comprarMercaderia(valorCompra) {
      self.validarCompra()
      mercaderia.addAll(personaje.)
    }
  
  method validarCompra() {
    if( monedas < personaje.valorDeCosechaTotal()){
      self.error("No tengo dinero suficiente para comprar")
    }
  }

}



