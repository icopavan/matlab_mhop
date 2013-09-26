%JOES_DATA.M
%This is Joseph Camp's data from 25 ft meshbox with baseball bat antenna to
%ethernet bridge.

distvec = [8.40808
97.85968
145.73388
226.42552
227.42552
238.7228
304.70956
328.69296
245.96412
187.2372
296.32
200.31232
101.61924
136.99244
234.68544
160.54988
196.07124
];

%Baseball Bat at 25 feet

bb_dbmvec1 = [-6
-13
-14
-21
-19
-24
-21
-inf
-22.5
-23
-19
-20
-14
-8.5
-16
-12
-12
];

bb_dbmvar1 = [1
2
2
3
2
1
1
0
0.5
1
2
1
2
0.5
2
1
1
];

bb_tcpvec1 = [6000
4340
4870
546
2060
200
150
0
280
0
496
737
3930
5070
3110
4790
5040
];

%Second set of baseball bat measurements

bb_dbmvec2 = [-7
-14
-18
-22
-22
-24
-22.5
-inf
-23
-24.5
-22
-22
-20
-10
-19
-13
-20
];

bb_dbmvar2 = [1
2
5
2
2
1
2.5
0
3
1.5
2
2
3
1
2
3
3
];

bb_tcpvec2 = [5490
3210
3260
250
350
250
150
0
446
137
298
2350
2200
4930
3950
4880
1420
];

% dbmmat = [(dbmvec1 - dbmvar1) dbmvec1 (dbmvec1 + dbmvar1) (dbmvec2 - dbmvar2) dbmvec2 (dbmvec2 + dbmvar2)];
bb_dbmmat = [bb_dbmvec1; bb_dbmvec2];
bb_distvec = [distvec; distvec];
bb_tcpvec = [bb_tcpvec1; bb_tcpvec2];
bb_mwmat = 10.^(bb_dbmmat./10);

%Light Saber at 28 feet

ls_dbmvec = [-8
-15
-12
-20
-24
-24
-27
-27
-24
-24
-25
-25
-18
-9
-24
-19
-20];

ls_dbmvarvec = [0
2
1
1
2
4
0
0
2
1
1
1
1
1
1
2
2
];

ls_tcpvec = [5380
2340
4400
125
3040
10
0
0
200
200
200
100
1760
5280
350
3270
2140
];

ls_mwvec = 10.^(ls_dbmvec./10); %light saber received signal power in mW

%Visualization section

figure
hold on
scatter(bb_distvec,bb_dbmmat,'r','filled')
scatter(distvec,ls_dbmvec,'b','filled')
line([0 350],[-20 -20]);
legend('Baseball Bat @ 25 ft','Light Saber @ 30 ft')
xlabel('Distance (m)')
ylabel('Signal Strength (dBm)')
title('Mesh Box to Bridge: Signal Strength vs. Distance')
print -depsc bridge_signal_vs_dist

figure
hold on
scatter(bb_distvec,bb_tcpvec,'r','filled')
scatter(distvec,ls_tcpvec,'b','filled')
line([0 350],[1000 1000])
legend('Baseball Bat @ 25 ft','Light Saber @ 30 ft')
xlabel('Distance (m)')
ylabel('TCP Throughput (kb/s)')
title('Mesh Box to Bridge: TCP Throughput vs. Distance')
print -depsc bridge_throughput_vs_dist

% interceptlow = 2.5;
% intercepthigh = 1;
% alphalow = 1.2;
% alphahigh = 0.5;
% sortdist = min(distvec):max(distvec);
% colorvec = ['b','g','r','c','m','y','k'];
% lowbound = interceptlow * (sortdist.^(-alphalow));
% upbound = intercepthigh * (sortdist.^(-alphahigh));

% plot(sortdist,lowbound,'b')
% plot(sortdist,upbound,'r')