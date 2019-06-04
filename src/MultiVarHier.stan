
//This stan code can  generates fake data from priors or fit model
//Author: Aminath Shausan 
//Date created: 04/04/19
///////////////////////////


functions {
     real[] ode(real t,
     real[] y,
     real[] theta,
     real[] x_r, // x_r:real data, x_i: integer data
     int[] x_i) {

     real dydt[4];
// all parameters must be positive and d must be between 0 and 1
     real A       =  theta[1];
     real beta    = theta[2];
     real delta   = theta[3];
     real gamma   = theta [4];
     real omega   = theta[5];
     real alpha   = theta[6];
     real kappa   = theta[7];
     real eta     = theta[8];
     real d       = theta[9];

     dydt[1] =  A - gamma*y[1]-beta * y[3] * y[1];              
     dydt[2] = beta * y[1] * y[3] - delta * y[2];                  
     dydt[3] = (1-d)*omega * y[2]  - kappa * y[3] -alpha* y[4]*y[3] ;             dydt[4] = eta *y[3]* y[4];
  return dydt;
 }
}
 
  data {
      int<lower = 1> J;  //number of subjects
      int<lower =1> K; //number of parameters
      vector[K] mu_a;   //mean vector of a
}

 transformed data {
       real x_r[0];
       int x_i[0];
}

  parameters{ 

  matrix[J,K] a;
  vector<lower = 0>[K] tau; // sd of b
  cholesky_factor_corr[K] Omega;
  matrix[K,J] z;
 }
 
 transformed parameters {
 matrix[J,K] b;
 matrix[J,K] l_theta;
 matrix[J,K] theta;
 
  b = (diag_pre_multiply(tau, Omega)*z)';
  l_theta = a + b;
  theta = exp(l_theta);
 }

model {
      //priors
      tau ~ cauchy(0,2.5);
      Omega ~ lkj_corr_cholesky(2); 
      to_vector(z) ~ normal(0,1);//this implies for(k in 1:K) z[k]~normal(0,1)
      to_vector(a) ~ normal(mu_a, 5);
}
