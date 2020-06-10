gradethis_default_options <- list(
  gradethis_glue_correct = "{ random_praise() } { .message } { .correct }",
  gradethis_glue_incorrect = "{ .message } { .incorrect } { random_encourage() }",

  gradethis_glue_pipe = paste0(
    "Veo que estás utilizando el pipe (i.e. %>%), ",
    "así que quiero que sepas cómo estoy interpretando tu código ",
    "antes de verificarlo it:\n\n{deparse_to_string(unpipe_all(.user), 60)}\n\n{.message}"),

  gradethis_glue_correct_test = "{ .num_correct }/{ .num_total } ¡correcto! { random_praise() }",
  gradethis_glue_incorrect_test = "{ .num_correct }/{ .num_total } ¡correcto! { random_encourage() }"
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- !(names(gradethis_default_options) %in% names(op))
  if (any(toset)) options(gradethis_default_options[toset])

  invisible()
}
