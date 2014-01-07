
cca=[3.0002,8.3416,11.9788,16.818];
bfsca=[9.2423,13.8290,14.9167,19.1912];
gsp=[11.0601,15.8455,18.7859,19.6311];
pen=[8.5029,30.9351,34.5374,36.5101]

figure
hold on
plot(cca)
plot(bfsca,'ro-')
plot(gsp,'+-')

plot(pen,'k*-')

title('Max Network Throughput over Channels')
legend('CCA','BFS-CA','GSP','BPS')
xlabel('Mesh Node Best Bands Combination')
ylabel('Max Throughput Mb/s')

t=1:4
set(gca,'XTick',t)
str={'1 Band','2 Bands','3 Bands','4 Bands'}
set(gca,'XTickLabel',str,'fontname','symbol')