notify <- function() {
  e <- get("e", parent.frame())
  if(e$val == "No") return(TRUE)
  
  good <- FALSE
  while(!good) {
    # Get info
    name <- readline_clean("What is your full name? ")
    numberST <- readline_clean("What is your SU student number? ")
    codeST <- paste(substr(name, 2,3),substr(numberST, 3,6),sep="")
    address <-  "theuns@sun.ac.za"
    
    # Repeat back to them
    message("\nDoes everything look good?\n")
    message("Ref: ", codeST, ". Your name: ", name, " and number: ",numberST, "\n", "Send to: ", address)
    
    yn <- select.list(c("Yes", "No"), graphics = FALSE)
    if(yn == "Yes") good <- TRUE
  }
  
  # Get course and lesson names
  course_name <- attr(e$les, "course_name")
  lesson_name <- attr(e$les, "lesson_name")
  
  subject <- paste("|| EE212 complete: ", course_name, "-", lesson_name, "-", numberST)
  body = ""
  
  # Send email
  swirl:::email(address, subject, body)
  
  hrule()
  message("I just tried to create a new email with the following info:\n")
  message("To: ", address)
  message("Subject: ", subject)
  message("Body: <empty>")
  
  message("\nIf it didn't work, you can send the same email manually.")
  hrule()
  
  # Return TRUE to satisfy swirl and return to course menu
  TRUE
}

readline_clean <- function(prompt = "") {
  wrapped <- strwrap(prompt, width = getOption("width") - 2)
  mes <- stringr::str_c("| ", wrapped, collapse = "\n")
  message(mes)
  readline()
}

hrule <- function() {
  message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
}