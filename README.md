# stan_hierarchical

This program is written using Stan and is for multivariate hierarchical model using an ODE. 

model: $y_j  = f_j(theta_j) + e_j, e_j \sim multiNormal(0, var_e*I), I is identity matrix. j =1:J, f_j is solution of ODE

log(theta_j) = a +b_j,  log(theta_j) is used as some parameters take very large values and some take very small values.
 
hyper priors: $a ~ multiNormal(mu_a , Lambda)$, b ~ multiNormal( 0 , Sigma), Lambda is diagonal, Sigma is covariance matrix

 mu_a, Lambda, given. Sigma ~ diag(tau) Omega diag(tau).