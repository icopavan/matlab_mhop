%MEASUREMENT_RESULTS_7_18_05.M
%On 7-18 and 7-19 we used a baseball bat at TFA at 40' and on the mobile unit at 30' 
%We also took measurements from Miguel's house but this will be
%in a seperate m-file
%No traffic was generated across the link, only signal strength
%measurements were taken

function [sig, sigvar, N, W, Nstat, Wstat] = measurement_results_7_18_05(dummy)

sig = [-14.5
      -13.5
      -9
      -11.5
      -21.5
      -24
      -24
      -23
      -10.5
      -11.5
      -20
      -22.5
      -18.5
      -24
      -20
      -16
      -20
      -13.5
      -12.5
      -15
      -20
      -24
      -26
      -26.5
      -26.5
      -24.5
      -20
      -19
      -13.5
      -20
      -24
      -24
      -17
      -25.5
      -25
      -21
      -18];


sigvar = [1.5
        1.5
        1
        0.5
        1.5
        1
        1
        1
        0.5
        0.5
        2
        1.5
        1.5
        2
        3
        1
        2
        0.5
        0.5
        1
        1
        1
        0
        0.5
        0.5
        1.5
        2
        2
        1.5
        2
        2
        3
        0.5
        1
        1
        1];

N = [42.305
     42.306
     42.307
     42.305
     42.301
     42.302
     42.303
     42.269
     42.237
     42.219
     42.220
     42.385
     42.385
     42.387
     42.360
     42.482
     42.468
     42.467
     42.470
     42.467
     42.465
     42.468
     42.464
     42.457
     42.427
     42.431
     42.430
     42.433
     42.449
     42.510
     42.510
     42.550
     42.551
     42.551
     42.555
     42.527
     42.387];


W = [16.829
     16.819
     16.804
     16.854
     16.869
     16.875
     16.882
     16.855
     16.841
     16.869
     16.862
     17.015
     17.036
     17.043
     16.840
     16.831
     16.859
     16.869
     16.884
     16.893
     16.906
     16.925
     17.012
     17.011
     16.997
     16.917
     16.882
     16.860
     16.848
     16.860
     16.900
     16.900
     16.893
     16.871
     16.859
     16.833
     16.884];


Nstat = 42.408;


Wstat = 16.745;