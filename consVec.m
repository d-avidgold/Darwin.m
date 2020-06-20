function v = consVec(lexVec)
    th = count(lexVec, "th");
   justt = count(lexVec, "t") - th;
   
   dh = count(lexVec, "dh");
   justd = count(lexVec, "d") - dh;
   
   v = [sum(th) sum(justt) sum(dh) sum(justd)];
end