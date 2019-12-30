#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

extern void nlinear_interp(double ** , double *, int *, int ,
                    double **, double *, int , int ,
                    double *, double *, int *, int *);

void interpn(double *x, double *val, int *dim, int *n, int *nn, double *xp,
                 double *yp, int *np, int *outmode)
{
   double **x_s, **xp_s, *u, *v;
   int *ad, *k, *dim_s;
   int n_s, np_s, nn_s, outmode_s;
   unsigned int i, j, nval;

   n_s = *n;  // number of dimensions
   nn_s = *nn;  // number of points for each dimension
   np_s = *np;  // number of points to interpolate
   nval = (int) pow(nn_s,  n_s);
   outmode_s = *outmode;  // extrapolation method
   // passage aux pointeurs double
   x_s = (double **) malloc(sizeof(double *) * n_s);
   xp_s = (double **) malloc(sizeof(double *) * n_s);
   j = 0;
   for(i = 0; i < n_s; i++){
     x_s[i] = (double *) malloc(sizeof(double) * nn_s);
     memcpy(x_s[i], x+j*nn_s, sizeof(double) * nn_s);
     xp_s[i] = (double *) malloc(sizeof(double) * np_s);
     memcpy(xp_s[i], xp+j*np_s, sizeof(double) * np_s);
     j++;
   }
   // tableaux de travail
   u = (double *) malloc(sizeof(double) * nval);
   v = (double *) malloc(sizeof(double) * nval);
   ad = (int *) malloc(sizeof(int) * nval);
   k = (int *) malloc(sizeof(int) * nval);
   // appel a l'interpolation
   nlinear_interp(x_s, val, dim, n_s, xp_s, yp, np_s, outmode_s, u, v, ad, k);

   return;
}
