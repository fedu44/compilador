let TablaSimbolosInstancia = null;
const tiposVariables = { VAR: "var", CONST: "const" };
const tiposDatos = { INTEGER_TYPE: "number", STRING_TYPE: "string" };

function start() {
  if (TablaSimbolosInstancia) return TablaSimbolosInstancia;
  TablaSimbolosInstancia = new TablaSimbolos();
  return TablaSimbolosInstancia;
}

exports.instance = function () {
  return start();
};

class TablaSimbolos {
  constructor() {
    this.variables = {};
  }

  agregarVariable(tipo_var, tipo_dato, nombre, valor) {
    if (this.existeVariable(nombre))
      throw new Error("Ya existe variable con ese nombre");
    if (tiposVariables["VAR"] === tipo_var) {
      // Agregar variable
      this.variables[nombre] = {
        tipo_var: tiposVariables[tipo_var],
        tipo_dato: tiposDatos[tipo_dato],
        nombre,
      };
    } else {
      // Agregar constante
      if (valor !== null && tiposDatos[tipo_dato] !== typeof valor) {
        throw new Error("Valor a agregar tiene tipo equivocado");
      }
      this.variables[nombre] = {
        tipo_var: tiposVariables[tipo_var],
        tipo_dato: tiposDatos[tipo_dato],
        nombre,
        valor,
      };
    }
  }

  actualizarVariable(nombre, valor) {
    const { tipo_var, tipo_dato } = this.obtenerVariable(nombre);
    if (tipo_var === "const")
      throw new Error("Imposible actualizar constantes");
    if (tipo_dato !== typeof valor)
      throw new Error("Valor a actualizar tiene tipo equivocado");
  }

  existeVariable(nombre) {
    return this.variables.hasOwnProperty(nombre);
  }

  obtenerVariable(nombre) {
    if (this.existeVariable(nombre)) return this.variables[nombre];
    throw new Error("No hay variable con ese nombre");
  }

  imprimir(valor, estaCasteando, esVariable) {
    this.obtenerTodasLasVariables();
    if (esVariable) {
      const { tipo_dato } = obtenerVariable(valor);
      if (tipo_dato !== tiposDatos["STRING_TYPE"])
        throw new Error("Es necesario realizar conversion antes");
      console.log(`${valor}`);
    } else {
      console.log(`${valor}`);
    }
  }

  obtenerTodasLasVariables() {
    console.log("\n");
    Object.keys(this.variables).forEach((key) => {
      const { tipo_var, tipo_dato, nombre, valor } = this.variables[key];
      console.log(
        `${nombre} -> tipo_var: ${tipo_var} tipo_dato: ${tipo_dato} ${
          valor ? "valor:" + valor : ""
        }`
      );
    });
    console.log("\n");
  }
}
