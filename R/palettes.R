# Bridgerton Color Palette Package
# These are color palettes for RStudio
# inspired by soil profiles.

# 1.Create the color palettes
# ::::::::::::::::::::::::::::::::::::::::::::::
#' Complete list of palettes
#'
#' Use \code{names(whistledown_palettes)} to view list of palette names.
#' Currently:  "alaquod" "durorthod"  "eutrostox" "natrudoll" "paleustalf" "podzol" "rendoll" "vitrizerand" "bangor" "pywell" "crait" "redox" "redox2" "gley"        
#'
#' @export
whistledown_palettes <- list(
  eloise = rbind(c('#E2F3E6', '#C8E8C4', '#B4D39C', '#9FBDD0', '#6CA5C6'),c(5,4,1,2,3)),
  kathani = rbind(c('#B35512', '#DC8B7F', '#CEB5E3', '#65317B', '#2A7879'),c(5,1,4,2,3)),
  daphne = rbind(c('#B6E2D9', '#96BDD9', '#9592DD', '#C18FCC', '#E6B2DD'),c(4,3,1,5,2)),
  penelope = rbind(c('#D75C33', '#E2A452', '#F7E7B6', '#C5D8C0', '#2C4531'),c(5,3,1,2,4)),
  queen = rbind(c('#F5B856', '#D34A68', '#E6C6DC', '#89C5D2', '#3F828D'),c(3,1,5,2,4)),
  sharmaji = rbind(c('#DFD3DD', '#D59AAE', '#9A3268', '#652D76', '#8EB2C4'),c(5,3,4,1,2)),
  danbury = rbind(c('#7A0016', '#D16159', '#C680B7', '#843873', '#4C032A'),c(1,4,3,2,5)),
  simon = rbind(c('#10110C', '#9F2919', '#BA436B', '#98A1AE', '#CEC0B7'),c(5,1,4,2,3)),
  rakes = rbind(c('#9B404D', '#9FA5B0', '#6F8FA7', '#00497A', '#16323D'),c(1,4,3,2,5)),
  featherington = rbind(c('#D8E0E9', '#7F989F', '#688844', '#E6AB47', '#D66F90'),c(5,4,3,1,2))
)



# 2. Palette builder function
# ::::::::::::::::::::::::::::::::::::::::::::::

#' Soil Palette Generator.
#'
#' This function builds palettes based on soil profiles.
#' View photos for each palette \href{https://github.com/kaizadp/soilpalettes}{On Github}.
#'
#' @param name Name of the color palette. Options are \code{durorthod}, \code{rendoll}, \code{paleustalf},
#' \code{natrudoll}, \code{alaquod2}, \code{alaquod}
#' @param n Number of colors in the palette. Palletes include 5 colors, which can be used discretely,
#' or if more are desired, used as a gradient. If omitted, n = length of palette.
#' @param type Usage of palette as "continuous" or "discrete". Continuous usage interpolates between colors to create
#' a scale of values. If omitted, function assumes continuous if n > length of palette, and discrete if n < length of palette.
#' @param direction (TODO)
#'
#' @return TODO
#' @export
#'
#' @examples
#' whistledown_palette("featherington", n = 100, type = "continuous")
#' whistledown_palette("featherington", 3)
#' whistledown_palette("featherington", 50)
whistledown_palette <- function(name, n, type = c("discrete", "continuous"), direction = 1) {
  stopifnot(is.character(name))
  stopifnot(is.numeric(n))
  stopifnot(is.character(name))

  pal <- whistledown_palettes[[name]]


  if (is.null(pal)) {
    stop("Palette not found.")
  }

  if (missing(n)) {
    n <- length(pal[1, ])
  }

  if (missing(type)) {
    if (n > length(pal[1, ])) {
      type <- "continuous"
    }
    else {
      type <- "discrete"
    }
  }
  type <- match.arg(type)

  if (type == "discrete" && n > length(pal[1, ])) {
    stop("Number of requested colors greater than what discrete palette can offer, \n  use as continuous instead.")
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  if (direction == -1) {
    pal[1, ] <- rev(pal[1, ])
  }

  out <- switch(type,
    continuous = grDevices::colorRampPalette(pal[1, ])(n),
    discrete = pal[1, ][pal[2, ] %in% c(1:n)],
  )
  structure(out, class = "palette", name = name)
}


#' Palette Print Function
#'
#' @param x TODO
#' @param ... TODO
#' @importFrom graphics image par text rect
#' @importFrom stats median
#' @importFrom grDevices rgb
#' @return TODO
#' @export
print.palette <- function(x, ...) {
  stopifnot(class(x) == "palette")

  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n),
    col = x,
    ylab = "", xaxt = "n", yaxt = "n", bty = "n"
  )

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text(median(1:n), 1, labels = attr(x, "name"), cex = 1, family = "sans")
}
