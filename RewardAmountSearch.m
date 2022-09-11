function [s, v] = RewardAmountSearch(p, c)

s1 = 0;
s2 = 1000000;
v1 = RL_AXCPT(p, [-1 0 s1], c);
v2 = RL_AXCPT(p, [-1 0 s2], c);

dif = v2(1) - v2(2);
while dif > 1e-4
    s3 = (s1 + s2) / 2;
    v3 = RL_AXCPT(p, [-1 0 s3], c);
    if v3(1) > v3(2)
        s2 = s3;
    else
        s1 = s3;
    end
    dif = abs(v3(1) - v3(2));
end

s = s2;
v = RL_AXCPT(p, [-1 0 s], c);

%search for break-even point for A
s1 = 0;
s2 = 1000000;
v1 = RL_AXCPT(p, [-1 0 s1], c);
v2 = RL_AXCPT(p, [-1 0 s2], c);

dif = v2(3) - v2(4);
while dif > 1e-4
    s3 = (s1 + s2) / 2;
    v3 = RL_AXCPT(p, [-1 0 s3], c);
    if v3(3) > v3(4)
        s2 = s3;
    else
        s1 = s3;
    end
    dif = abs(v3(3) - v3(4));
end

s = [s s2];
v = [v; RL_AXCPT(p, [-1 0 s], c)];

%search for break-even point for B
s1 = 0;
s2 = 1000000;
v1 = RL_AXCPT(p, [-1 0 s1], c);
v2 = RL_AXCPT(p, [-1 0 s2], c);

dif = v2(5) - v2(6);
while dif > 1e-4
    s3 = (s1 + s2) / 2;
    v3 = RL_AXCPT(p, [-1 0 s3], c);
    if v3(5) > v3(6)
        s2 = s3;
    else
        s1 = s3;
    end
    dif = abs(v3(5) - v3(6));
end

s = [s s2];
v = [v; RL_AXCPT(p, [-1 0 s], c)];