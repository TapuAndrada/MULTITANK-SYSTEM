clc
clear all
close all

date=load('date.mat');
t=date.OpenLevels.time;
u=date.OpenLevels.signals(1).values;
y_Lv1=date.OpenLevels.signals(2).values;
figure
plot(t,y_Lv1)
grid
figure
plot(t,u)
grid
%% Nivelul 1
uss_p=0;
for i=5990:6000
    uss_p=uss_p+u(i);
end
uss=1/11*uss_p;

y_Lv1_st_p=0;
for i=5990:6000
    y_Lv1_st_p=y_Lv1_st_p+y_Lv1(i);
end
y_Lv1_st=1/11*y_Lv1_st_p;
y_Lv1_0=0.001;

K=(y_Lv1_st-y_Lv1_0)/(uss-u(1));
T=37;
Tm=10;

Hf1=tf(K,[T 1],'iodelay',Tm)
yBun1=lsim(Hf1, 0.000030 * ones(size(t)),t);

figure
plot(t, yBun1 + y_Lv1_0,'b'), grid on
hold on
plot(t,y_Lv1,'r')
%% Nivelul 2
y_Lv2=date.OpenLevels.signals(3).values;
figure
plot(t,y_Lv2)
grid
y_Lv2_st_p=0;
for i=5990:6000
    y_Lv2_st_p=y_Lv2_st_p+y_Lv2(i);
end
y_Lv2_st=1/11*y_Lv2_st_p;
y_Lv2_0=0.001;

K2=(y_Lv2_st-y_Lv2_0)/(uss-u(1));
T2=73;
Tm2=10;
Hf2=tf(K2,[T2 1],'iodelay',Tm)
yBun2=lsim(Hf2, 0.000030 * ones(size(t)),t);

figure
plot(t, yBun2 + y_Lv2_0,'b'), grid on
hold on
plot(t,y_Lv2,'r')

%% Nivel 3
y_Lv3=date.OpenLevels.signals(4).values;
figure
plot(t,y_Lv3)
grid

y_Lv3_st_p=0;
for i=5990:6000
    y_Lv3_st_p=y_Lv3_st_p+y_Lv3(i);
end
y_Lv3_st=1/11*y_Lv3_st_p;
y_Lv3_0=0.0016;

%K3=(y_Lv3_st-y_Lv3_0)/(uss-u(1));
K3=4350;
T3=128;
Tm3=11.6;
Hf3=tf(K3,[T3 1],'iodelay',Tm)
yBun3=lsim(Hf3, 0.000030 * ones(size(t)),t);

figure
plot(t, yBun3 + y_Lv3_0,'g'), grid on
hold on
plot(t,y_Lv3,'r')

%% Controlerul fuzzy
fuzzy('controlerMultitank.fis')








