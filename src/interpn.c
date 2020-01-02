#include<stdio.h>
#include<stdlib.h>
#include<string.h>

extern void nlinear_interp(double ** , double *, int *, int ,
                    double **, double *, int , int ,
                    double *, double *, int *, int *);

void interpn(double *x, double *y, int *n, int *dimx,
             double *xq, double *yq, int *nq, int *outmode)
{
   double **x_s, **xq_s, *u, *v;
   int *ad, *k;
   unsigned int i, kx, kxq, nwork;

   // pointer to pointer
   x_s = (double **) malloc(sizeof(double *) * *n);
   xq_s = (double **) malloc(sizeof(double *) * *n);
   kx = 0;
   kxq = 0;
   for(i = 0; i < *n; i++){
     x_s[i] = (double *) malloc(sizeof(double) * dimx[i]);
     memcpy(x_s[i], x+kx, sizeof(double) * dimx[i]);
     kx += dimx[i];
     xq_s[i] = (double *) malloc(sizeof(double) * *nq);
     memcpy(xq_s[i], xq+kxq, sizeof(double) * *nq);
     kxq += *nq;
   }

   // work arrays
   nwork = kx + kxq;
   u = (double *) malloc(sizeof(double) * nwork);
   v = (double *) malloc(sizeof(double) * nwork);
   ad = (int *) malloc(sizeof(int) * nwork);
   k = (int *) malloc(sizeof(int) * nwork);

   // call interpolation function of Scilab
   nlinear_interp(x_s, y, dimx, *n, xq_s, yq, *nq, *outmode, u, v, ad, k);

   // free memory
   for(i = 0; i < *n; i++){
     free(x_s[i]);
     free(xq_s[i]);
   }
   free(x_s);
   free(xq_s);
   free(u);
   free(v);
   free(ad);
   free(k);

   return;
}
