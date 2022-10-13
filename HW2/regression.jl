using MAT
using LinearAlgebra
using PyPlot
using Statistics

function calculate_mean(v)
	n=size(v,1)
	#println(n)
	#println(mean(v))
	#println(sum(v)/n)
	return sum(v)/n
end

function calculate_std(v,m)
	n=size(v,1)
	#println(std(v,correct=false))
	return norm(v.-m)/sqrt(n)
end

function calculate_rho(a,m_a,s_a,b,m_b,s_b)
	n=size(a,1)
	#println("testing")
	#println(cov(a,b,corrected=false)/(s_a*s_b))
	#println(dot(a.-m_a,b.-m_b)/n)
	return (1/(s_a*s_b*n))*(transpose(a.-m_a)*(b.-m_b))
end

function ortho_c2(rho,s_a,s_b)
	if rho==0
		return 0
	else
		b=(s_a/s_b-s_b/s_a)
		c_21=(-b+sqrt(b^2+4*(rho^2)))/(2*rho)
		c_22=(-b-sqrt(b^2+4*(rho^2)))/(2*rho)
		if sign(c_21)==sign(rho)
			return c_21
		else
			return c_22
		end
	end
end


function main()
	include("orthregdata.m")
	#print(size(a))
	m_a=calculate_mean(a)
	m_b=calculate_mean(b)
	s_a=calculate_std(a,m_a)
	#println(s_a)
	#println("---")
	s_b=calculate_std(b,m_b)
	rho=calculate_rho(a,m_a,s_a,b,m_b,s_b)
	#println(rho)
	#println(cor(a,b))
	#plot out scatter
	#println("plotting")
	plot(a,b,"o",label="data")
	#least squares solution
	c_2=rho*s_b/s_a
	#println(c_2)
	c_1=m_b-m_a*c_2
	#println(c_1)
	x=LinRange(minimum(a),maximum(a)+1,4)
	plot(x,x.*c_2.+c_1,label="least squares regression")
	#orthogonal solution
	c_2=ortho_c2(rho,s_a,s_b)
	c_1=m_b-m_a*c_2
	#println(rho*(c_2^2)+(s_a/s_b-s_b/s_a)*c_2-rho)
	#println(c_2)
	#println(rho)
	plot(x,x.*c_2.+c_1,label="orthogonal regression")
	legend()
	xlabel("a")
	ylabel("b")
	savefig("test.png")
	
end

main()
