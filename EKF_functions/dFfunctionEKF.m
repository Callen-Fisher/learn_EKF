function dF = dFfunctionEKF(in1,in2,in3)
%DFFUNCTIONEKF
%    DF = DFFUNCTIONEKF(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 7.0.
%    27-Jul-2017 10:22:37

dth1 = in1(1,:);
dth2 = in1(2,:);
g = in3(7,:);
l1 = in3(1,:);
l2 = in3(2,:);
l1_com = in3(3,:);
l2_com = in3(4,:);
m1 = in3(5,:);
m2 = in3(6,:);
th1 = in2(1,:);
th2 = in2(2,:);
t2 = th1-th2;
t3 = cos(t2);
t4 = sin(t2);
t5 = t3.^2;
t6 = l1_com.^2;
t7 = m1.*t6;
t11 = m2.*t5;
t8 = m2+t7-t11;
t9 = 1.0./t8;
t10 = 1.0./l1;
t12 = dth1.^2;
t13 = sin(th1);
t14 = cos(th2);
t15 = cos(th1);
t16 = dth2.^2;
t17 = l1.*m2.*t5.*t12;
t18 = t4.^2;
t19 = l2.*l2_com.*m2.*t3.*t16;
t20 = 1.0./t8.^2;
t21 = g.*m1.*t3.*t14;
t22 = l1.*m2.*t3.*t4.*t12;
t23 = l2.*l2_com.*m2.*t4.*t16;
t24 = t21+t22+t23-g.*m1.*t15-g.*l1_com.*m1.*t15;
t25 = m2.*t3.*t4.*t10.*t20.*t24.*2.0;
t26 = 1.0./l2;
t27 = 1.0./l2_com;
t28 = 1.0./m2;
t29 = m2.^2;
t30 = m1.^2;
t31 = sin(th2);
t32 = l1.*t3.*t12.*t29;
t33 = l2.*l2_com.*t5.*t16.*t29;
t34 = g.*m1.*m2.*t4.*t15;
t35 = l1.*m1.*m2.*t3.*t6.*t12;
t36 = g.*l1_com.*m1.*m2.*t4.*t15;
t37 = g.*t6.*t14.*t30;
t38 = l1.*t4.*t12.*t29;
t39 = g.*m1.*m2.*t14;
t40 = l1.*m1.*m2.*t4.*t6.*t12;
t41 = l2.*l2_com.*t3.*t4.*t16.*t29;
t42 = t37+t38+t39+t40+t41-g.*m1.*m2.*t3.*t15-g.*l1_com.*m1.*m2.*t3.*t15;
dF = reshape([dth1.*m2.*t3.*t4.*t9.*-2.0,t9.*t26.*t27.*t28.*(dth1.*l1.*t4.*t29.*2.0+dth1.*l1.*m1.*m2.*t4.*t6.*2.0),1.0,0.0,dth2.*l2.*l2_com.*m2.*t4.*t9.*t10.*-2.0,dth2.*m2.*t3.*t4.*t9.*2.0,0.0,1.0,t25-t9.*t10.*(t17+t19+g.*m1.*t13+g.*l1_com.*m1.*t13-g.*m1.*t4.*t14-l1.*m2.*t12.*t18),t9.*t26.*t27.*t28.*(t32+t33+t34+t35+t36+g.*m1.*m2.*t3.*t13-l2.*l2_com.*t16.*t18.*t29+g.*l1_com.*m1.*m2.*t3.*t13)-t3.*t4.*t20.*t26.*t27.*t42.*2.0,0.0,0.0,-t25+t9.*t10.*(t17+t19-g.*m1.*t4.*t14+g.*m1.*t3.*t31-l1.*m2.*t12.*t18),-t9.*t26.*t27.*t28.*(t32+t33+t34+t35+t36+g.*m1.*m2.*t31+g.*t6.*t30.*t31-l2.*l2_com.*t16.*t18.*t29)+t3.*t4.*t20.*t26.*t27.*t42.*2.0,0.0,0.0],[4,4]);
