# Each case should have a function that takes both strings and quotes, and hence
# is easy to drop into testthat. ("that" always refers to correct/solution code,
# because it is not at hand in the submission. "this" always refers to
# incorrect/user code, which is always at hand). Cases:

# bad argument name
bad_argument_name <- function(this_call, 
                              this, 
                              this_name,
                              enclosing_call = NULL,
                              enclosing_arg = NULL) { # only if the user supplied one (to match user code)
  
  # f(1, g(1, h(b = i(1))))
  # f(1, a = g(1, a = h(ba = i(1)), bb = i(2)))
  
  # In f(1, g(1, h(b = i(1)))), h() accepts more than one argument that begins with b.
  # As a result, R cannot figure out which argument you want to pass i(1) to.
  # Check how you spelled b, or write out the full argument name.
  
  # {intro}{this_call} accepts more than one argument that begins with {this_name}.
  # As a result, R cannot figure out which argument you want to pass {this} to.
  # Check how you spelled {this_name}, or write out the full argument name.

  intro <- build_intro(.call = enclosing_call, .arg = enclosing_arg)

  this <- prep(this)
  this_call <- prep(this_call)
  
  if (grepl("\\(\\)", this))
    this <- paste("", this)
  
  glue::glue_data(
    list(
      intro = intro,
      this_call = this_call,
      this_name = this_name,
      this = this
    ),
    "{intro}{this_call} acepta más de un argumento que inicia ",
    "con {this_name}. Como consecuencia, R no puede identificar cuál ", 
    "argumento es el que quieres utilizar en {this}. Revisa la forma en que escribiste ",
    "{this_name}, o escribe de nuevo el nombre completo del argumento."
  )
}

# duplicate_name
duplicate_name <- function(this_call, 
                           this_name,
                           enclosing_call = NULL,
                           enclosing_arg = NULL) {
  
  # f(a = 1, a = 2)
  # f(a = 1)
  
  # "You passed multiple arguments named a to f(), which will cause "
  # "an error. Check your spelling, or remove one of the arguments."
  
  # "You passed multiple arguments named {this_name} to {this_call}, which will cause "
  # "an error. Check your spelling, or remove one of the arguments."
  
  this_call <- prep(this_call)
  this_name <- prep(this_name)
  
  intro <- build_intro(.call = enclosing_call, .arg = enclosing_arg)
  
  glue::glue_data(
    list(
      intro = intro,
      this_call = this_call,
      this_name = this_name
    ),
    "Usaste múltiples argumentos llamados {this_name} ",
    "en {this_call}, lo cual causa un error. ",
    "Revisa la gramática, o bien remueve uno de los argumentos."
  )
}

# WHAT TO DO IF THE MISSING ARGUMENT DOESN"T HAVE A NAME IN THE SOLUTION?
# missing argument
missing_argument <- function(this_call, 
                             that_name = NULL,
                             enclosing_call = NULL,
                             enclosing_arg = NULL) {
  
  # f(1, g(1, h(i(1))))
  # f(1, a = g(1, a = h(a = i(1)), b = i(2)))
  
  # "In g(1, h(i(1))), Your call to h() should include b",
  # "as one of its arguments. You may have referred to it ",
  # "in a different way, or left out an important argument name."
  
  # "{intro}Your call to {this_call} should include {that_name} ",
  # "as one of its arguments. You may have referred to it ",
  # "in a different way, or left out an important argument name."
  
  intro <- build_intro(.call = enclosing_call, .arg = enclosing_arg)
  your_char <- ifelse(intro == "", "Y", "y")
  
  this_call <- prep(this_call)
  that_name <- prep(that_name)
  
  if (grepl("\\(\\)", that_name)) {
    that_name <- paste0("un argumento, posiblemente sin nombre, que ejecuta ", that_name, ".")
  } else {
    that_name <- paste(that_name, "como uno de sus sus argumentos.")
  }
  
  glue::glue_data(
    list(
      intro = intro,
      this_call = this_call,
      that_name = that_name
    ),
    "{intro}{your_char}al ejecutar {this_call} se debería incluir {that_name} ",
    "Quizás escribiste mal el nombre del argumento, ",
    "o dejaste sin incluir algún argumento importante."
  )
}

# surplus argument
surplus_argument <- function(this_call, 
                             this, 
                             this_name = NULL,
                             enclosing_call = NULL, 
                             enclosing_arg = NULL) {
  
  # f(1, g(1, h(1, b = i(1))))
  # f(1, a = g(1, a = h(a = 1)))

  # "In g(1, h(1, i(1))), I did not expect your call to h() to ",
  # "include b = i(1). You ",
  # "may have included an unnecessary argument, or you ",
  # "may have left out or misspelled an important ",
  # "argument name."
    
  # "{intro}I did not expect your call to {this_call} to ",
  # "include {this}. You ",
  # "may have included an unnecessary argument, or you ",
  # "may have left out or misspelled an important ",
  # "argument name."
  
  intro <- build_intro(.call = enclosing_call, .arg = enclosing_arg)
  
  this_call <- prep(this_call)
  this      <- prep(this)
  
  if (!is.null(this_name) && this_name != "")
    this <- paste(this_name, "=", this)
  
  glue::glue_data(
    list(
      this = this,
      this_call = this_call
    ),
    "{intro}No esperaba que al ejecutar {this_call} ",
    "incluyeras {this}. Puede ser que ",
    "incluyeras un argumento innecesario, o bien ",
    "que dejaras fuera o escribieras mal un argumento importante ",
    "en la syntaxis."
  )
}

# too_many_matches
too_many_matches <- function(this_call, 
                             that_name,
                             enclosing_call = NULL,
                             enclosing_arg = NULL) {
  
  # f(1, g(1, h(b = i(1), ba = 2)))
  # f(1, a = g(1, a = h(bab = 1)))
  
  # "Double check the argument names you are using. ",
  # "In g(1, h(b = i(1), ba = 2)), h() accepts an argument named bab. More than one of your argument names will ",
  # "be matched to bab, which will cause an error. Try ",
  # "writing out the full argument names."
  
  # "Double check the argument names you are using. ",
  # "{intro}{this_call} accepts an argument named {that} and it ", 
  # "looks like more than one of your argument names will ",
  # "be matched to {that}, which will cause an error. Try ",
  # "writing out the full argument names."
  
  this_call <- prep(this_call)
  that_name <- prep(that_name)
  
  intro <- build_intro(.call = enclosing_call, .arg = enclosing_arg)
  
  glue::glue_data(
    list(
      intro = intro,
      this_call = this_call,
      that_name = that_name
    ),
    "{intro}{this_call} acepta un argumento llamado {that_name}. ", 
    "Más de uno de los argumentos que usaste en {this_call} será ",
    "comparado con {that_name}, lo cual genera un error. Intenta ",
    "escribir de nuevo el nombre completo de los argumentos."
  )
}

# wrong call
wrong_call <- function(this, 
                       that, 
                       this_name = NULL,
                       enclosing_call = NULL) {
  
  # f(1, g(1, h(a = i(1))))
  # f(1, a = g(1, a = h(a = j(1))))
  
  # "g(1, h(i(1))), I expected you to call a = j() where you called a = i()."
  
  # "{intro}I expected you to call {that} where you called {this}."
  
  intro <- build_intro(.call = enclosing_call)
  
  this <- prep(this)
  that <- prep(that)
  
  if (!is.null(this_name) && this_name != "") {
    that <- paste(this_name, "=", that)
    this <- paste(this_name, "=", this)
  }
  
  glue::glue_data(
    list(
      intro = intro, 
      this = this, 
      that = that
    ),
    "{intro}Esperaba que escribieras {that} pero pusiste {this}."
  )
}

# wrong value for wrong value and wrong call, the enclosing argument is the
# argument that appears before the call or value. It should be passed to
# this_name
wrong_value <- function(this, 
                        that, 
                        this_name = NULL,
                        enclosing_call = NULL) {
  
  # f(1, g(1, h(1)))
  # f(1, a = g(1, a = h(2)))
  
  # "h(1), I expected 2 where you wrote 1."
  
  # "{intro}I expected {that} where you wrote {this}."
  
  intro <- build_intro(.call = enclosing_call)
  
  this <- prep(this)
  that <- prep(that)
  
  if (!is.null(this_name) && this_name != "") {
    that <- paste(this_name, "=", that)
    this <- paste(this_name, "=", this)
  }
  
  if (grepl("\\(\\)", that))
    that <- paste("", that)
  
  glue::glue_data(
    list(
      this = this, 
      that = that
    ),
    "{intro}Esperaba que escribieras {that} pero pusiste {this}."
  )
}

prep <- function(text) {
  if (is.call(text)) text <- text[1]
  if (!is.character(text)) text <- deparse_to_string(text)
  text
}

build_intro <- function(.call = NULL, .arg = NULL) {
  
  if(!is.null(.call)) {
    .call <- deparse_to_string(.call)
    if (!is.null(.arg) && !identical(.arg, "")) {
      .call <- paste(.arg, "=", .call)
    }
    intro <- glue::glue("En {.call}, ")
  } else {
    intro <- ""
  }
  intro
}