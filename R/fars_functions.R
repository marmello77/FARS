#' Read data
#'
#' This function reads data in CSV format into R.
#' First, it checks whether the file already exists in the working directory.
#' If the file does not exist, you get an error message.
#' Second, if the CSV file exists, it is read into R.
#' Third, the data are converted to a tibble.
#'
#' @param filename A string with the full name of a file in CSV format. This
#' function returns an error, if the file does not exist in the directory.
#'
#' @return This function returns a data frame in tibble format.
#'
#' @examples
#' \dontrun{
#' fars_read("accident_2013.csv")
#' fars_read("accident_2014.csv")
#' fars_read("accident_2015.csv")
#'}
#' @importFrom readr read_csv
#'
#' @export
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}



#' Name file
#'
#' This function makes a file name.
#' First, the inputted year will be converted to an integer. The value must be
#' a simple year without quotes.
#' Second, the year will be added to the middle of a string that represents the
#' main pattern of the file name, in the placeholder for an integer.
#'
#' @param year A number representing the desired year.
#'
#' @return This function returns a character vector with a combination of the
#' main string and the year inputted.
#'
#' @examples
#' \dontrun{
#' make_filename(2013)
#' make_filename(2014)
#' make_filename(2015)
#'}
#' @export
make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}



#' Read years
#'
#' This function reads specific variables from the data.
#' It reads two specific columns, MONTH and year, from the input files, and
#' then stores them as data frames in a list. It works by calling the function
#' \code{make_filename} from within
#'
#' @param years A vector of numbers, which represents the years to be analyzed.
#' Can be also a sequence of numbers. This function returns an error, if an
#' year number if invalid.
#'
#' @return A list with the data frames in tibble format for the selected years.
#' The list has the length of the input vector and each data frame contains
#' only the selected columns.
#'
#' @examples
#' \dontrun{
#' fars_read_years(2013)
#' fars_read_years(c(2013,2014))
#' fars_read_years(2013:2015)
#'}
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @export
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(.data$MONTH, .data$year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}



#' Summarize years
#'
#' This function summarizes the accidents by year and month for the data frames
#' imported. It calls the function \code{fars_read_years} from within.
#'
#' @param years A vector of numbers, which represents the years to be analyzed.
#' Can be also a sequence of numbers.
#'
#' @return This function returns a data frame in tibble format with months as
#' rows and years as columns, in which the data are the counts of accidents.
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(2013)
#' fars_summarize_years(c(2013,2014))
#' fars_summarize_years(2013:2015)
#'}
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom tidyr spread
#'
#' @export
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(.data$year, .data$MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(.data$year, .data$n)
}



#' Plot map
#'
#' This function plots a map with the locations of accidents for the selected
#' state and year.It calls the functions \code{make_filename} and
#' \code{fars_read} from within. T
#'
#' @param state.num A number representing the FARS code of the desired state.
#' This function returns an error, if the state number if invalid.
#' @param year A number representing the desired year.
#'
#' @return This function returns a map with the locations of accidents for
#' the selected state and year.
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(2013)
#' fars_summarize_years(c(2013,2014))
#' fars_summarize_years(2013:2015)
#'}
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#' @importFrom rlang .data
#'
#' @export
fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, .data$STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
