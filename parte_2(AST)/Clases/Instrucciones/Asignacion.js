// Clases
const Sentencia = require("./Sentencia");

module.exports = class Asignacion extends Sentencia {
  constructor(id, expression) {
    super("No name");
    this.id = id;
    this.expression = expression;
  }

  getId() {
    return this.id;
  }

  setId(id) {
    this.id = id;
  }

  getExpression() {
    return this.expression;
  }

  setExpression(expression) {
    this.expression = expression;
  }

  // Override
  accept(visitor) {
    return visitor.visit_declaracion(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform(this);
  //   }
};
