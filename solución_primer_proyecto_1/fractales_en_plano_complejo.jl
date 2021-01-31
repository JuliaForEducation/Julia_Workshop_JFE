### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 63b9e832-3b3b-11eb-0d45-b54bff3a4c10
using Pkg; Pkg.activate("."); using Plots

# ╔═╡ a79e42e0-3a31-11eb-3791-2dde6b25172b
md"
### _Primer Proyecto:_  
# Fractales en Plano Complejo 
"

# ╔═╡ 231273f6-3b3b-11eb-2b3b-2308e244a358
md"
#### Paquete Plots
Utilizaremos el paquete Plots para realizar las gráficas, por eso debemos importarlo:
"

# ╔═╡ b667cda0-46e0-11eb-370d-41d8d7cdf7de
md"
## Definición de objetos y funciones
"

# ╔═╡ 56c3949c-462c-11eb-058f-ef53a7395810
md"
Primero construiremos un estructura (struct) llamado **Grid**, donde se definirá la región del plano complejo que debe ser analizado y el salto entre cada punto de la grilla.
"

# ╔═╡ f915f344-3a00-11eb-16a9-6be5b192810c
#Representa un objeto Grid 

struct Grid{T<:Real}
    limite_abs :: T
    limite_ord :: T
    salto :: T
end

# ╔═╡ f1207c62-4631-11eb-30cb-691cbcca8574
md"
Definimos una función que cree una matriz de rangos para los ejes de las abcisas y ordenas. 
"

# ╔═╡ 1dc63efc-39d6-11eb-3b8d-15da426e82a1
"""
	makeGrid(g::Grid)
Crear una matriz de rangos [l_abs,l_ord]
"""
function makeGrid(g::Grid)
	rango_abs = -g.limite_abs:g.salto:g.limite_abs
    rango_ord = -g.limite_ord:g.salto:g.limite_ord
	M = zeros(Complex, size(rango_ord,1),size(rango_abs,1))
	for i ∈ 1:size(M,2)
		for j ∈ 1:size(M,1)
			M[j,i] = rango_abs[i] + rango_ord[j]*im 
		end
	end
	return M	
	
end

# ╔═╡ 774af954-4635-11eb-31dd-17a273bf9b15
md"
Defina funciones de una línea para las formas biológicas y la familia de polinomios cuadráticos complejos 
"

# ╔═╡ acda722e-4636-11eb-0a76-29912beacb1c
begin #*
	# Funcion para conjunto de Julia y Mandelbrot
    fc(z,c)= z^2+c
    # Funciones de formas biológicas
    f₁(z,c)=sin(z)+z^2+c
    f₂(z,c)=z^z+z^6+c
    f₃(z,c)=z^z+z^5+c
    f₄(z,c)=z^5+c
    f₅(z,c)=z^3+c
end

# ╔═╡ 36bed290-4633-11eb-26fe-d15d7d6f03f8
md"
Definimos una función que retorne `true` si el criterio de convergencia para los conjuntos $J_{_c}$ y $M_{f_c}$ se cumple, `false` en caso contrario.
"

# ╔═╡ 60604b20-4637-11eb-1874-49e2756715ac
"""
Comprobamos el criterio de convergencia para los conjuntos de Julia y Mandelbrot
"""
function testJM(z::Complex)
	return abs(z) < 2
end

# ╔═╡ 5466484a-4637-11eb-115f-ab417bd2b802
md" Ahora definimos una función que retorne `true` si el criterio de convergencia para las formas biológicas se cumple, `false` en caso contrario.
"

# ╔═╡ 6b6e04f0-4638-11eb-1401-6db76349254b
"""
	testbiomorph(z::Complex,τ::Real)
Comprobar el criterio de convergencia para las formas biológicas.
"""
function testbiomorph(z::Complex,τ::Real)
	return (real(z)<τ) || (imag(z)<τ)
end

# ╔═╡ 71f98b8a-4641-11eb-2c9c-7f49f8577365
md"
Definimos una función que itere un número sobre una función $f_c$ y devuelva `true` si se cumple el criterio de divergencia para $J_{f_c}$, $M_{f_c}$ y formas biológicas
"

# ╔═╡ c84bee02-4640-11eb-0dc2-57337e999b50
"""
	iterate(test::Function,f::Function,z::Complex,iter::Integer)
Interar z sobre una funcion f
"""
function iterate(test::Function,f::Function,z::Complex,iter::Integer, c::Complex)
	respuesta = false
	for i ∈ iter:-1:1
        if test(z)==true
			z = f(z,c)
			respuesta = true
        end
    end
    return respuesta
end

# ╔═╡ 7848fe70-59e3-11eb-20e7-b38210af2e66
function iterate(test::Function,f::Function,z::Complex,iter::Integer,c::Complex,τ::Real)
	respuesta = false
	for i ∈ iter:-1:1
        if test(z,τ)==true
			z = f(z,c)
            respuesta = true
        end
    end
    return respuesta
end

# ╔═╡ fb3a891a-4634-11eb-2228-67741e0f82e2
md"
Definimos una función que devuelva el número de iteraciones realizadas para un z dado (número complejo), hasta que se no se cumpla el criterio de divergencia.
"

# ╔═╡ 828790ba-39d9-11eb-03bf-cbf806cba31a
"""
Retornar el número de iteraciones para un valor dado de z mientras un criterio de convergencia sea válido
"""
function colormap(f::Function,test::Function,z::Complex,c::Complex,iter::Integer)
	iter = 0
	z = f(z,c)
	while test(z)
		z = f(z,c)
		iter += 1
	end
	return iter
end

# ╔═╡ 393b931a-46a0-11eb-361d-8da678672d65
md" Usando multiple dispatch, definimos nuevamente la función colormap agregando un nuevo parámetro de entrada $\tau$, de modo que se pueda usar el test de convergencia para la forma biológica"

# ╔═╡ 1c510af2-46a0-11eb-08ac-a1d54104fd11
function colormap(f::Function,test::Function,z::Complex,c::Complex,iter::Integer,τ::Integer)
	iter = 0
	z = f(z,c)
	while test(z,τ)
		z = f(z,c)
		iter += 1
	end
	return iter
end

# ╔═╡ 24bba08a-46e2-11eb-0e42-412ca935f3e7
md"
## Gráfica
##### _1) Graficamos un conjunto de Julia, para un $c$ arbitrario (monocromático)._  


Definimos la función setJulia() que retorne el conjunto de puntos que pertenecen al conjunto de Julia.
"

# ╔═╡ 73644592-463b-11eb-09c0-952848e159e3
"""
Con setjulia() construimos un array con los puntos del plano complejo que pertenecen al conjunto Julia, dada la región de análisis del plano complejo
"""
function setjulia(
	f::Function,
	test::Function,
	grid::Array{T,2} where T,
	c::Complex,
	iter::Integer)
	a = size(grid,1)
	b = size(grid,2)
	grafica = zeros(a,b)
        for i ∈ a:-1:1
		for j ∈ b:-1:1
			if iterate(test,f,grid[i,j],iter,c)
				grafica[i,j] = 1.0
			end
		end
	end
	return grafica
end

# ╔═╡ 553b382e-469e-11eb-3b55-3d189b08538c
begin
	g = Grid(2.0,3.0,0.2)
	G = makeGrid(g)
	c = 2.0 +1.0*im
	sJ = setjulia(fc,testJM,G,c,10)
	Lₐ = -g.limite_abs:g.salto:g.limite_abs
	Lₒ = -g.limite_ord:g.salto:g.limite_ord
	plot(Lₐ,Lₒ,sJ)
end

# ╔═╡ Cell order:
# ╟─a79e42e0-3a31-11eb-3791-2dde6b25172b
# ╟─231273f6-3b3b-11eb-2b3b-2308e244a358
# ╠═63b9e832-3b3b-11eb-0d45-b54bff3a4c10
# ╟─b667cda0-46e0-11eb-370d-41d8d7cdf7de
# ╟─56c3949c-462c-11eb-058f-ef53a7395810
# ╟─f915f344-3a00-11eb-16a9-6be5b192810c
# ╟─f1207c62-4631-11eb-30cb-691cbcca8574
# ╠═1dc63efc-39d6-11eb-3b8d-15da426e82a1
# ╠═774af954-4635-11eb-31dd-17a273bf9b15
# ╠═acda722e-4636-11eb-0a76-29912beacb1c
# ╟─36bed290-4633-11eb-26fe-d15d7d6f03f8
# ╠═60604b20-4637-11eb-1874-49e2756715ac
# ╟─5466484a-4637-11eb-115f-ab417bd2b802
# ╟─6b6e04f0-4638-11eb-1401-6db76349254b
# ╠═71f98b8a-4641-11eb-2c9c-7f49f8577365
# ╠═c84bee02-4640-11eb-0dc2-57337e999b50
# ╠═7848fe70-59e3-11eb-20e7-b38210af2e66
# ╟─fb3a891a-4634-11eb-2228-67741e0f82e2
# ╠═828790ba-39d9-11eb-03bf-cbf806cba31a
# ╟─393b931a-46a0-11eb-361d-8da678672d65
# ╠═1c510af2-46a0-11eb-08ac-a1d54104fd11
# ╟─24bba08a-46e2-11eb-0e42-412ca935f3e7
# ╠═73644592-463b-11eb-09c0-952848e159e3
# ╠═553b382e-469e-11eb-3b55-3d189b08538c
