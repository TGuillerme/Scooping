#' @title Creating the citation table for a list of DOIs.
#'
#' @description Creating the citation table for a list of DOIs.
#'
#' @param xml A \code{character} being the path to the xml file
#'
#' @author Thomas Guillerme

get.cite.table <- function(xml) {
    require(XML)

    # Get dois function (for lapply)
    get.dois <- function(xml_list) {
        if(xml_list$.attrs[[2]] != "resolved"){
            return(NA)
        } else {
            return(xml_list$doi$text)
        }
    }


    # Get created date (for lapply)
    get.date <- function(xml_list) {
        if(xml_list$.attrs[[2]] != "resolved"){
            return(NA)
        } else {
            if(xml_list[[10]]$.attrs[[1]] != "created") {
                return(NA)
                message(paste(xml_list$.attrs[[1]], "has no creation date in position 10!"))
            } else {
                return(xml_list[[10]]$text)
            }
        }
    }

    # Get number of cites (for lapply)
    get.cites <- function(xml_list) {
        if(xml_list$.attrs[[2]] != "resolved"){
            return(NA)
        } else {
            if(xml_list[[11]]$.attrs[[1]] != "citedby-count") {
                return(NA)
                message(paste(xml_list$.attrs[[1]], "has no citations number in position 11!"))
            } else {
                return(xml_list[[11]]$text)
            }
        }
    }

    # Get the xml data
    data_xml <- xmlParse(xml)
    xml_data <- xmlToList(data_xml)

    # Get the dois
    DOIs <- unlist(lapply(xml_data$query_result$body, get.dois))
    dates <- unlist(lapply(xml_data$query_result$body, get.date))
    cites <- unlist(lapply(xml_data$query_result$body, get.cites))

    # Make a table
    data_out <- data.frame("DOis" = as.character(DOIs), "dates" = as.character(dates), "cites" = as.numeric(cites))

    return(data_out)
}