#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

extern void nlinear_interp(double ** , double *, int *, int ,
                    double **, double *, int , int ,
                    double *, double *, int *, int *);

void interpn(double *, double *, int *, int *, int *, double *,
                 double *, int *, int *);

/*double randInRange(double min, double max)
{
  return min + (double) (rand() / (double) (RAND_MAX) * (max - min));
}*/

/*void interpn_api(double *x, double *val, int *dim, int *n, int *nn, double *xp,
                 double *yp, int *np, int *outmode, double *u, double *v, int *ad, int *k)
{
   double **x_s, **xp_s;
   int n_s, np_s, nn_s, outmode_s;
   unsigned int i, j;
   
   n_s = *n;  // number of dimensions
   nn_s = *nn;  // number of points
   np_s = *np;  // number of points to interpolate
   outmode_s = *outmode;  // extrapolation method
   x_s = (void *) malloc(sizeof(double *) * n_s);
   xp_s = (void *) malloc(sizeof(double *) * n_s);
   j = 0;
   for(i = 0; i < n_s; i++){
     x_s[i] = (double *) malloc(sizeof(double) * nn_s);
     memcpy(x_s[i], x+j*nn_s, sizeof(double) * nn_s);
     xp_s[i] = (double *) malloc(sizeof(double) * np_s);
     memcpy(xp_s[i], xp+j*np_s, sizeof(double) * np_s);
     j++;
   }

   nlinear_interp(x_s, val, dim, n_s, xp_s, yp, np_s, outmode_s, u, v, ad, k);
   
   return;
}*/

int main(void){

    double *x, *xp;
    double *val, *yp;
    //double *u, *v;
    double xmin, xmax, range, dx;
    int *dim; //, *ad, *k;
    int n, np, nn, nval, nwork, outmode, i,j,k;
    FILE *fp;
    
    /* Test en dimension 1
    
    n = 1;  // une dimension
    nn = 10;  // nombre de points
    np = 5;  // nombre de points a interpoler
    nwork = 1000;  // dim tableaux de travail
    outmode = 1;  // natural
    x = (void *) malloc(sizeof(double *) * n);
    x[0] = (double *) malloc(sizeof(double) * nn);
    val = (double *) malloc(sizeof(double) * nn);
    dim = (int *) malloc(sizeof(int) * n);
    xp = (void *) malloc(sizeof(double *) * n);
    xp[0] = (double *) malloc(sizeof(double) * np);
    yp = (double *) malloc(sizeof(double) * np);
    u = (double *) malloc(sizeof(double) * nwork);
    v = (double *) malloc(sizeof(double) * nwork);
    ad = (int *) malloc(sizeof(int) * nwork);
    k = (int *) malloc(sizeof(int) * nwork);
    
    x[0][0] = 0.; x[0][1] = 1.; x[0][2] = 2.; x[0][3] = 3.; x[0][4] = 4.; x[0][5] = 5.; x[0][6] = 6.; x[0][7] = 7.; x[0][8] = 8.; x[0][9] = 9.;
    val[0] = 0.; val[1] = 1.; val[2] = 4.; val[3] = 9.; val[4] = 16.; val[5] = 25.; val[6] = 36.; val[7] = 49.; val[8] = 64.; val[9] = 81.;
    dim[0] = 10;
    xp[0][0] = 0.5; xp[0][1] = 1.5; xp[0][2] = 3.5; xp[0][3] = 5.5; xp[0][4] = 8.5;
    
    nlinear_interp(x, val, dim, n, xp, yp, np, outmode, u, v, ad, k);
    
    for(i = 0; i < np; i++) printf("xp = %f\typ = %f\n", xp[0][i], yp[i]); 
    
    */
    
    /* Test en dimension 2 */
    
    /*n = 2;  // une dimension
    nn = 10;  // nombre de points
    np = 5;  // nombre de points a interpoler
    nwork = nn * n;  // dim tableaux de travail
    outmode = 2;  // natural
    x = (void *) malloc(sizeof(double *) * n);
    x[0] = (double *) malloc(sizeof(double) * nn);
    x[1] = (double *) malloc(sizeof(double) * nn);
    val = (double *) malloc(sizeof(double) * nn);
    dim = (int *) malloc(sizeof(int) * n);
    xp = (void *) malloc(sizeof(double *) * n);
    xp[0] = (double *) malloc(sizeof(double) * np);
    xp[1] = (double *) malloc(sizeof(double) * np);
    yp = (double *) malloc(sizeof(double) * np);
    u = (double *) malloc(sizeof(double) * nwork);
    v = (double *) malloc(sizeof(double) * nwork);
    ad = (int *) malloc(sizeof(int) * nwork);
    k = (int *) malloc(sizeof(int) * nwork);
    xmin = 0.;
    xmax = 10.;
    dim[0] = 10;
    dim[1] = 10;
    fp = fopen("xval.txt", "w");
    for(i = 0; i < nn; i++){
        x[0][i] = randInRange(xmin, xmax);
        x[1][i] = randInRange(xmin, xmax);
        val[i] = x[0][i]+x[1][i]; //sqrt(x[0][i]*x[0][i] + x[1][i]*x[1][i]);
        // printf("%f\t%f\n", x[0][i], x[1][i]);
        fprintf(fp, "%lf %lf %lf\n", x[0][i], x[1][i], val[i]);
    }
    fclose(fp);
    xp[0][0] =1.; xp[0][1] = 3.; xp[0][2] = 5.; xp[0][3] = 7.; xp[0][4] = 9.;
    xp[1][0] =1.; xp[1][1] = 3.; xp[1][2] = 5.; xp[1][3] = 7.; xp[1][4] = 9.;
    
    for(i = 0; i < nn; i++) printf("x = %f %f\tval = %f\n", x[0][i], x[1][i], val[i]);
   printf("n = %d\tnp = %d\tdim = %d %d\t outmode_s = %d\n", n,np,dim[0],dim[1],outmode);
    
    nlinear_interp(x, val, dim, n, xp, yp, np, outmode, u, v, ad, k);
    
    for(i = 0; i < np; i++) printf("xp = %f %f\typ = %f\t ytrue = %f\n", xp[0][i], xp[1][i], yp[i], xp[0][i]+xp[1][i]);*/
    
    /* Test en dimension 2 et pointeurs simples */
    
    n = 2;  // une dimension
    nn = 10;  // nombre de points de grille pour chaque dimension
    np = 5;  // nombre de points a interpoler
    nval = (int) pow(nn,  n);  // nombre de points sur la grille
    outmode = 1;  // methode d'extrapolation
    x = (double *) malloc(sizeof(double) * n * nn);
    val = (double *) malloc(sizeof(double) * nval);
    dim = (int *) malloc(sizeof(int) * n);
    xp = (double *) malloc(sizeof(double) * n * np);
    yp = (double *) malloc(sizeof(double) * np);
    xmin = 0.;
    xmax = 10.;
    range = xmax - xmin;
    dx = range / nn;
    dim[0] = 10;
    dim[1] = 10;
    for(i = 0; i < n; i++){
        for(j = 0; j < nn; j++){
           x[i*nn+j] = j*dx;
        }
    }
    //val(i,j,k) is stored in i + nx( j + ny k )
    k = 0;
    for(i = 0; i < dim[0]; i++){
        for(j = 0; j < dim[1]; j++){
           val[k] = x[i] + x[dim[0]+j];
           printf("x1 = %f\tx2 = %f\tval = %f\n", x[i], x[dim[0]+j],val[k]);
           k++;
        }
    }
    
    for(i = 0; i < np; i++){
        xp[i]  = 2*i+1+0.5;
        xp[np+i] = 2*i+1+0.5;
    }


    interpn(x, val, dim, &n, &nn, xp, yp, &np, &outmode);
    
    for(i = 0; i < np; i++) printf("xp = %f %f\typ = %f\t ytrue = %f\n", xp[i], xp[np+i], yp[i], xp[i]+xp[np+i]);
    
    return 0;
}
