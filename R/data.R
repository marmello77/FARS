#' Car accidents in the US from 2013 to 2015
#'
#' @source US National Highway Traffic Safety Administration's Fatality 
#' Analysis Reporting System, which is a nationwide census providing the 
#' American public yearly data regarding fatal injuries suffered in motor 
#' vehicle traffic crashes. \url{https://www.nhtsa.gov}. The data used in this
#' package were directly downloaded from the course's website, as the FARS
#' website changed considerably since the course was last updated.
#' @format Three data frames, one for each year, with 50 columns, including:
#' \describe{
#'  \item{Year}{Each data file represents one year, from 2013 to 2015}
#'  \item{STATE}{Code of the respective US state.}
#'  \item{COUNTY}{Code of the respective US county.}
#'  \item{CITY}{Code of the respective US city.}
#' }
#' @examples
#' \dontrun{
#'  accident_2013.csv.bz2
#' }
