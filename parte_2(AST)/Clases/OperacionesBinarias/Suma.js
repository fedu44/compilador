// Clases
const ArigOp = require("./ArigOp");

module.exports = class Suma extends ArigOp {
  constructor(left, right) {
    super(left, right, "+");
  }

  // Override
  accept(visitor) {
    return visitor.visit_suma(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform_suma(this);
  //   }
};
