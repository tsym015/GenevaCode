%Separating real and imaginary components of data frames

tr_real(:,1) = freq_vec;
tr_real(:,2) = real(cmpxl_tr);

tr_imag(:,1) = freq_vec;
tr_imag(:,2) = imag(cmpxl_tr);

save(sprintf('tr_real.dat'),'tr_real','-ascii');
save(sprintf('tr_imag.dat'),'tr_imag','-ascii');