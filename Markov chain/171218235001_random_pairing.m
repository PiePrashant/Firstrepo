function [prm_out,iteration_out,n_ops_out] = random_pairing(N,iteration__in);
% generates a random pairing for N elements ;
% test with: ;
%{
  
  N_ = transpose(round(2.^[3:0.125:13]));
  I_ = zeros(length(N_),1);
  T_ = zeros(length(N_),1);
  for nN=1:length(N_);
  N = N_(nN);
  [~,I_(nN),T_(nN)] = random_pairing(N);
  end;%for nN=1:length(N_);
  clf; 
  subplot(1,3,1); plot(log2(N_),I_,'b.-');
  subplot(1,3,2); plot(log2(N_),log2(T_),'b.-',log2(N_),log2(N_),'r.-');
  subplot(1,3,3); plot(log2(N_),T_./N_,'k.-');

  %}

if nargin<2; iteration__in = 0; end;

verbose=0;
prm = randperm(N);
if (verbose); disp(sprintf(' %% prm: ')); end;%verbose;
if (verbose); disp(num2str(prm)); end;%verbose;
z_ = zeros(1,N);
for n=1:N;
p=prm(n); zn=z_(n); zp=z_(p);
if (~zn & ~zp); z_(n)=1; prm(p)=n; z_(p)=1; end;
end;%for n=1:N;
iteration_sub=0; n_ops_sub=0;

unpaired_ = find(z_==0);

if (length(unpaired_)>0);
if (verbose); disp(sprintf(' %% prm: ')); end;%verbose;
if (verbose); disp(num2str(prm)); end;%verbose;
if (verbose); disp(sprintf(' %% z_: ')); end;%verbose;
if (verbose); disp(num2str(z_)); end;%verbose;
if (verbose); disp(sprintf(' %% unpaired_: ')); end;%verbose;
if (verbose); disp(num2str(unpaired_)); end;%verbose;
if (verbose); disp(sprintf(' %% prm(unpaired_): ')); end;%verbose;
if (verbose); disp(num2str(prm(unpaired_))); end;%verbose;
[prm_sub,iteration_sub,n_ops_sub] = random_pairing(length(unpaired_),iteration__in+1);
if (verbose); disp(sprintf(' %% prm_sub: ')); end;%verbose;
if (verbose); disp(num2str(prm_sub)); end;%verbose;
if (verbose); disp(sprintf(' %% unpaired(prm_sub): ')); end;%verbose;
if (verbose); disp(num2str(unpaired_(prm_sub))); end;%verbose;
prm(unpaired_) = unpaired_(prm_sub);
end;%if (length(unpaired_)>0);

prm_out = prm;
iteration_out = 1 + iteration_sub;
n_ops_out = N + n_ops_sub;

check_flag=0;
if check_flag;
if (iteration__in==0); disp(sprintf(' %% iteration %d n_ops %d n_error %d',iteration_out,n_ops_out,random_pairing_check(prm_out))); end;
end;%if check_flag;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ;

function n_error = random_pairing_check(prm__in);
if (length(unique(prm__in))~=length(prm__in));
disp(sprintf(' %% error! not a permutation: '));
disp(num2str(prm__in));
end;%if (length(unique(prm__in))==length(prm__in));
n_error=0;
for n=1:length(prm__in);
p = prm__in(n); q = prm__in(p);
if (q~=n); n_error = n_error+1; end;
end;%for n=1:length(prm__in);
