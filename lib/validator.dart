class Validator {
  // Función para validar que la entrada solo contenga texto
  static bool isValidText(String input) {
    // Expresión regular que permite solo letras y espacios
    final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ \s]+$');
    return regex.hasMatch(input);  // Devuelve true si solo contiene letras y espacios
  }
}