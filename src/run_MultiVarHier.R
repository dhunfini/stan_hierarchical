#' ---
#' title: "Nonlinear Multivariate Hierarchical Model"
#' author: "Aminath Shausan"
#' date: "04/04/2019"

#'  ---------------
#clear history 
rm(list=ls())

#save the packages in this library

#-----------------------------------
# install required packages 
library(deSolve)
library(dplyr)

library("rstan")
#options(width = 90)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
#Sys.setenv(LOCAL_CPPFLAGS = '-march=native')
#==========================================================

stan_data <- list(  J = 1, #numb. of subjects
                    K = 9, #numb. of parameters 
                    #mu_a = c(log(1.4e7), log(1.72e-10), log(0.14),log(0.14), log(1e4), log(0.001),log(3.48),log(1.29e-5), log(0.5))#mean vector of a (A, beta, delta, gamma,omega,alpha, kappa,eta, d)
                    mu_a  = c(rep(0, 9))
                    )
                     
fake_data <- stan("MultiVarHier.stan",         
                  data = stan_data,
                  chains = 1, iter = 1000,
                  seed=4838282)            
a <- extract(fake_data, pars =c("a", 'b', 'l_theta'))
#plot(density(a$a[,1,1]), xlim= c(0,1.5e-5))

plot(density(a$l_theta[,1,9]), xlim = c(-20, +20))

