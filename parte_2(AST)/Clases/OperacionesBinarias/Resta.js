// Clases
const ArigOp = require("./ArigOp");

module.exports = class Resta extends ArigOp {
  constructor(left, right) {
    super(left, right, "-");
  }

  // Override
  accept(visitor) {
    return visitor.visit_resta(this);
  }

  // Override
  //   accept_transfomer(transformer) {
  //     return transformer.transform_suma(this);
  //   }
};
