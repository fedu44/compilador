// Clases
const ArigOp = require("./ArigOp");

module.exports = class Division extends ArigOp {
  constructor(left, right) {
    super(left, right, "*");
  }

  // Override
  accept(visitor) {
    return visitor.visit_division(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform_suma(this);
  //   }
};
