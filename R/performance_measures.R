
## Functions to evaluate performance measures

#' objective function to minimize for standard method of moments MAIC
#'
Q <- function(beta, X) {
  sum(exp(X %*% beta))
}

#' bias estimate
#' 
bias <- function(theta.hat, theta) {
  nsim <- length(theta.hat)
  sum(theta.hat)/nsim - theta
}

#' Monte Carlo SE of bias estimate
#' 
bias.mcse <- function(theta.hat) {
  nsim <- length(theta.hat)
  tmp <- sum((theta.hat - mean(theta.hat))^2)
  sqrt(1/(nsim*(nsim-1))*tmp)
}

#' coverage estimate
#' 
coverage <- function(low, upp, theta) {
  nsim <- length(low)
  theta_inside_range <- theta >= low & theta <= upp
  in_range <- ifelse(theta_inside_range, 1, 0)
  sum(in_range)/nsim
}

#' Monte Carlo SE of coverage estimate
#' 
coverage.mcse <- function(coverage, nsim) {
  sqrt((coverage*(1 - coverage))/nsim)
}

#' MSE estimate
#'
mse <- function(theta.hat, theta) {
  nsim <- length(theta.hat)
  sum((theta.hat - theta)^2)/nsim
}

#' Monte Carlo SE of MSE estimate
#' 
mse.mcse <- function(theta.hat, theta) {
  nsim <- length(theta.hat)
  tmp <- (theta.hat - theta)^2
  mse.est <- sum(tmp)/nsim
  sqrt(sum((tmp - mse.est)^2)/(nsim*(nsim-1)))
}

#' MAE estimate
#' 
mae <- function(theta.hat, theta) {
  nsim <- length(theta.hat)
  sum(abs(theta.hat - theta))/nsim
}

#' Monte Carlo SE of any continuous performance metric
#' 
mcse.estimate <- function(pm) {
  nsim <- length(pm)
  pm_mean <- sum(pm)/nsim
  sqrt(sum((pm - pm_mean)^2)/(nsim*(nsim-1)))
}

#' Empirical standard error 
#' 
empse <- function(theta.hat) {
  nsim <- length(theta.hat)
  tmp <- sum((theta.hat - mean(theta.hat))^2)
  sqrt(tmp/(nsim-1))
}

#' EmpSE MCSE
#' 
empse.mcse <- function(empse, nsim) {
  empse/(sqrt(2*(nsim-1)))
} 

#' Variability ratio
#' 
var.ratio <- function(theta.hat, std.err) {
  nsim <- length(theta.hat)
  num <- sum(std.err)/nsim
  denom <- sqrt(sum((theta.hat - mean(theta.hat))^2)/(nsim-1))
  num/denom
}

#' Variability ratio MCSE
#' 
#' Approximation of ratio variance based on independence of avg. se and emp.se
#' see Wolter, K., 2007. Introduction to variance estimation. 
#'
var.ratio.mcse <- function(avg.se, emp.se, var.avg.se, var.emp.se) {

  sqrt((1/emp.se^2)*var.avg.se + (((avg.se^2)/(emp.se^4))*var.emp.se))
}
