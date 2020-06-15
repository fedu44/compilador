module.exports = class Nodo {
  constructor(nombre) {
    this.nombre = nombre;
  }

  getNombre() {
    return this.nombre;
  }

  setNombre(nombre) {
    this.nombre = nombre;
  }

  getEtiqueta() {
    if (this.nombre != null) {
      return this.getNombre();
    }
    name = this.getClass().getName();
    pos = name.lastIndexOf(".") + 1;
    return name.substring(pos);
  }

  accept(visitor) {}

  accept_transfomer(transformer) {
    transformer.transform(this);
  }
};
