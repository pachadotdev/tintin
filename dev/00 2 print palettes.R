showcol <- function (pal = rev(tintin_colours), n = NULL, type = "all", exact.n = TRUE) {
  gaplist <- ""

  maxnum <- 5

  palattr <- switch(type, qual = "qualitative", div = "divergent",
                    seq = "sequential", all = "qualitative+divergent+sequential")
  if (is.null(n))
    n <- maxnum

  if (length(n) == 1)
    n <- rep(n, length(pal))

  n[n < 3] <- 3
  n[n > maxnum] <- maxnum[n > maxnum]
  nr <- length(pal)
  nc <- max(n)
  ylim <- c(0, nr)
  oldpar <- par(mgp = c(2, 0.25, 0))
  on.exit(par(oldpar))
  plot(1, 1, xlim = c(-4, nc), ylim = ylim, type = "n", axes = FALSE,
       bty = "n", xlab = "", ylab = "")
  for (i in 1:nr) {
    nj <- n[i]
    if (pal[i] == "")
      next
    shadi <- pal[[i]]
    rect(xleft = 0:(nj - 1), ybottom = i - 1, xright = 1:nj,
         ytop = i - 0.2, col = shadi, border = "light grey")
  }
  text(rep(-0.1, nr), (1:nr) - 0.6, labels = names(pal), xpd = TRUE,
       adj = 1)
}

grDevices::png("man/figures/tintin-colours.png")
showcol()
dev.off()
