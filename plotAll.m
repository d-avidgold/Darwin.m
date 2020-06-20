function plotAll(v1, c1, v2, c2, v3, c3, v4, c4)
    
    p = polyfit(log(v1),log(c1),1);
    z = polyval(p,log(v1));
    loglog(v1,exp(z), 'DisplayName', "size = 8");
    
    p = polyfit(log(v2),log(c2),1);
    z = polyval(p,log(v2));
    hold on;
    loglog(v2,exp(z), 'DisplayName', "size = 16");
    legend;
    p = polyfit(log(v3),log(c3),1);
    z = polyval(p,log(v3));
    hold on;
    loglog(v3,exp(z), 'DisplayName', "size = 32");
    
    p = polyfit(log(v4),log(c4),1);
    z = polyval(p,log(v4));
    hold on;
    loglog(v4,exp(z), 'DisplayName', "size = 64");
    axis([0 1000 0 10000]);
end