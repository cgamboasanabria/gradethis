# Praise messages
.praise <- c(
  "¡Absolutamente fabuloso!",
  "¡Asombroso!",
  "¡Increíble!",
  "¡Hermoso!",
  "¡Bravo!",
  "¡Buen trabajo!",
  "¡Encantador!",
  "¡Excelente!",
  "¡Fantástico!",
  "¡Buen trabajo!",
  "No podría haberlo hecho mejor yo mismo",
  "¡Impresionante trabajo!",
  "¡Buen trabajo!",
  "¡Magnífico!",
  "¡Buen trabajo!",
  "¡Fuera de este mundo!",
  "¡Resplandeciente!",
  "¡Imponente!",
  "Alguien sabe lo que está haciendo :)",
  "¡Un trabajo espectacular!",
  "¡Espléndido!",
  "¡Éxito!",
  "¡Super trabajo!",
  "¡Excelente trabajo!",
  "¡Buen trabajo!",
  "¡Estupendo!",
  "¡Esa es una respuesta de primera clase!",
  "¡Eso es glorioso!",
  "¡Eso es maravilloso!",
  "¡Muy bien!",
  "¡Bien hecho!",
  "¡Qué trabajo de primer nivel!",
  "¡Sorprendente!",
  "¡Maravilloso!",
  "¡Lo lograste!",
  "¡Me atrae tu inteligencia!",
  "Llénate de orgullo",
  ":)"
)

# Encouragement messages
.encourage <- c(
  "Inténtalo de nuevo.",
  "Inténtalo de nuevo",
  "Vamos a intentarlo de nuevo.",
  "Inténtalo de nuevo; ¡la próxima es la vencida!",
  "No te rindas ahora, pruébalo una vez más",
  "No hay necesidad de preocuparse, inténtalo de nuevo",
  "Inténtalo de nuevo. Tengo un buen presentimiento sobre esto",
  "Inténtalo de nuevo. Mejoras cada vez",
  "Inténtalo de nuevo. La perseverancia es la clave del éxito",
  "Está bien, aprendes más de los errores que de los éxitos. Hagámoslo una vez más"
)

#' Random praise and encouragement
#'
#' Generate a random praise or encouragement phrase.
#' This can be used in conjunction with
#' `glue::[glue][glue::glue()]` to generate praise or encouragement within feedback to users.
#'
#' @examples
#' replicate(5, glue::glue("Random praise: {random_praise()}"))
#' replicate(5, glue::glue("Random encouragement: {random_encourage()}"))
#' @export
#' @describeIn praise Returns a random praise message
random_praise <- function() {
  sample(.praise, 1)
}

#' @export
#' @describeIn praise Returns a random encouragement message
random_encourage <- function() {
  sample(.encourage, 1)
}
