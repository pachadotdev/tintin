#' @keywords internal
"_PACKAGE"

#' Tintin Colours
#'
#' A list with 23 vectors (one per Tintin book) containing the five most
#' frequent colors per cover. White tones were removed to balance
#' the palettes. Alph-Art is Herge's unfinished book, it was published
#' posthumously, so we don't consider it in the list.
#'
#' @docType data
#' @keywords datasets
#' @name tintin_colours
#' @usage tintin_colours
#' @source Tintin covers obtained from Wikipedia and processed with ImageMagick.
#' @format A list with 23 vectors.
#' @examples head(tintin_colours)
NULL

#' Tintin Head Trauma
#'
#' Neurological traumas sustained by the subject (by book title)
#'
#' \describe{
#'   \item{\code{year}}{Release year of the comic, first occurrence was used
#'    for titles with a b&w and colour edition}
#'   \item{\code{book_title}}{English title of the books}
#'   \item{\code{page}}{Page number where the traumas happen}
#'   \item{\code{cause_of_injury}}{What causes the trauma (i.e., explosion)}
#'   \item{\code{loss_of_consciousness_length}}{Loss of consciousness length
#'    measured by the number of cartoon frames before subject returns to normal
#'    activity.}
#'   \item{\code{loss_of_consciousness_severity}}{Loss of consciousness severity
#'    measured by the number of objects revolving above Tintin's head}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name tintin_head_trauma
#' @usage tintin_head_trauma
#' @source Cyr, Antoine, Louis-Olivier Cyr, and Claude Cyr. "Acquired growth
#'  hormone deficiency and hypogonadotropic hypogonadism in a subject with
#'  repeated head trauma, or Tintin goes to the neurologist." CMAJ 171, no. 12
#'  (2004): 1433-1434. The book release year was obtained from Wikipedia.
#' @examples
#' tintin_head_trauma
#' @format A data frame with 50 rows and 4 variables
NULL
