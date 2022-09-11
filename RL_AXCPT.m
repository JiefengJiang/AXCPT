%RL model for applying proactive control in an AX-CPT task
%input:
%p: 1x5 vector consisting of
%   p_A: probability of encountering A
%   p_X|A: probability of encountering X after A
%   p_X|B: probability of encountering X after B
%   p_R|C: probability of being rewarded if correct
%   p_R|I: probability of being rewarded in incorrect
%
%r: 1x3 vector conssiting of rewards:
%   r_c: reward of using control. Should be negative to reflect a cost
%   r_g: reward of getting a trial correct
%   r_m: additional reward
%
%c: 2 (hiControl and lowControl) x 4(AX, AY, BX and BY) matrix consisting
%of probability of meeting reward criteria (even for no-reward conditions)
%
%output:
%v:
%1 x 14 vector consisting of values of 
% hiS, loS, hiA, loA, hiB, loB, hiAX, hiAY, loAX, loAY, hiBX, hiBY, loBX, loBY,
% correct, incorrect
%
%example input:
%p = [0.8 7/8 0.5 1 0];
%r = [-1 2 5];
%c = [0.97 0.7 0.92 0.92; 0.92 0.9 0.9 0.9];

function v = RL_AXCPT(p, r, c)

v3 = [p(4) p(5)] * r(3) + [r(2) 0];
v2 = c * v3(1) + (1 - c) * v3(2);
v2 = [v2(1, 1:2) v2(2, 1:2) v2(1, 3:4) v2(2, 3:4)];
v1 = [p(2) * v2(1) + (1 - p(2)) * v2(2), p(2) * v2(3) + (1 - p(2)) * v2(4), ...
    p(3) * v2(5) + (1 - p(3)) * v2(6), p(3) * v2(7) + (1 - p(3)) * v2(8)];
v1 = v1 + [r(1) 0 r(1) 0];
v0 = [v1(1) * p(1) + v1(3) * (1 - p(1)) v1(2) * p(1) + v1(4) * (1 - p(1))];
v = [v0 v1 v2 v3];