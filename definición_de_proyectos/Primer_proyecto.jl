### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 63b9e832-3b3b-11eb-0d45-b54bff3a4c10
using Pkg; Pkg.activate("."); using Plots

# ╔═╡ a79e42e0-3a31-11eb-3791-2dde6b25172b
md"
# Proyecto 1

## Descripción
Se escribirá un código para visualizar diferentes familias del conjunto de Julia y Mandelbrot, en el proceso se modelarán diversas formas biológicas. Ambos conjuntos se forman a partir del estudio de ciertas funciones, $f_c$, sobre las cuales se iteran los números complejos. La notación para la función, $f_c$, denota que ésta depende de un parámetro $c \in C$.

El conjunto de Julia $J_{f_c}$, para una constante $c$ particular, está formado por todos aquellos puntos del plano complejo en el cual la sucesión siguiente es acotada:

$$z_0=z$$
$$z_{n+1}=f_c(z_n)$$


El conjunto de Mandelbrot $M_{f_c}$, de forma similar, está formado por el conjunto de puntos del plano complejo, en el cual $c$ pertenece al conjunto si la siguiente sucesión es acotada:

$$z_0=0$$
$$z_{n+1}=f_c(z_n)$$

El conjunto de puntos que resulta de la sucesión, para cada $z$ implicado, se conoce como la órbita de $z$ por $f_c$. Para determinar los elementos de una familia del conjunto de $J_{f_c}$ y $M_{f_c}$, se utiliza un método iterativo, verificando el criterio convergencia siguiente, en cada paso de la iteración donde se obtiene un elemento de la órbita:

$$|z_n|<2$$

Si en algún punto de la iteración no se cumple el criterio, el punto del plano complejo analizado no pertenece al conjunto. 

El conjunto de Julia y Mandelbrot están dados por una familia muy popular de sistemas dinámicos complejos, esto es la familia de polinomios cuadráticos complejos:

$$f_c=z^2+c$$

Formas biológicas han sido representadas mediante procesos iterativos, como el descrito anteriormente. Pero, empleando un conjunto de funciones $(f_c)$ más complejas que las estudiadas en los conjuntos de Julia y Mandelbrot. A continuación, se listan algunas de las funciones usadas para reproducir formas biológicas:

$$f_1(z,c)=\sin(z)+z^2+c$$
$$f_2(z,c)=z^z+z^6+c$$
$$f_3(z,c)=z^z+z^6+c$$
$$f_4(z,c)=z^5+c$$
$$f_5(z,c)=z^3+c$$

La iteración es realizada hasta que la magnitud de la componente real e imaginaria de los elementos de la órbita sobrepasa un determinado valor $\tau$ (un valor puede ser $\tau=100$), esto significa que el proceso iterativo se mentiene mientras se cumpla que la parte real o imaginaria satisfacen la condición:

$$|Re(z_n)|<\tau$$ 

$$|Im(z_n)|<\tau$$

Una manera de graficar los conjuntos de Julia, Mandelbrot y las formas biológicas, es graficar solamente los puntos que pertenecen al conjunto con un color determinado (monocromático). 

Para agregar colores a los gráficos, generalmente se utiliza el algoritmo de: Tiempo de Escape, aunque no es el único. El algoritmo consiste en asignar un color dependiendo del número de iteraciones realizadas antes que el elemento de la órbita no satisfaga el criterio de convergencia. De esta manera se visualiza aquellos elementos que pertenecen al conjunto y los que no, además, revela la velocidad de divergencia de la órbita en cada punto. 

## Requisitos
Para el desarrollo del proyecto deberá utilizar solamente los elementos abarcados en la primera semana del workshop, esto es, el uso de: estructuras de datos y control, tipos de datos primitivos del lenguaje. Por lo que **no utilizará** ningún paquete adicional, creado o desarrollado por la comunidad de Julia, a excepción del paquete Plots.

Para completar este proyecto deberá realizar los siguientes items:
1. Graficar un conjunto de Julia, para un $c$ arbitrario (monocromático). 
2. Graficar el conjunto de Mandelbrot (monocromático).
3. Graficar una forma biológica, par un c arbitrario (monocromático).
4. Hacer una gráfica a color del conjunto de Mandelbrot usando el algoritmo de Tiempo de Escape.
5. Realizar una gráfica a color para un conjunto de Julia, para un $c$ arbitrario .
6. Realizar una gráfica a color para una forma biológica.

Para realizar las gráficas, deberá tomar en cuenta el uso de 'structs' para representar estructuras de datos particulares y también el uso de 'multiple dispatch'. 

## Criterios de Evaluación
Durante la evaluación del proyecto se tomarán en cuenta los siguientes aspectos:
- Cumplimiento de los requerimientos mencionados.
- Claridad y orden el código presentado.
- Completitud del proyecto, haciendo todas las partes que lo componen.
- Analizar y comentar el trabajo de otros grupos (Mediante el peer review).
"

# ╔═╡ 231273f6-3b3b-11eb-2b3b-2308e244a358
md"
---------
### AYUDA
---------
#### Gráficas
Para realizar las gráficas se utilizará el paquete Plots, por lo tanto el paquete debe ser importado:
"

# ╔═╡ 16040e00-539c-11eb-0f12-db5ae4d9970f
Plots.default(size = (650,450))

# ╔═╡ cd1023fa-3b3b-11eb-22ec-2724be9b2af8
md"
A continuación se mostrarán ejemplos para realizar gráficas con el paquete, los cuales pueden usarse para mostrar las formas biológicas y los conjuntos de Julia y Mandelbrot, una vez se hayan obtenido los datos necesarios.

Gráfico de números complejos:
"

# ╔═╡ 4070b426-3b3d-11eb-1ef2-73f2f10c9ce6
begin
	r = 2	
	zcomplejo = [r*cos(θ)+r*sin(θ)*im for θ in 0:0.3:2*pi]
	scatter(zcomplejo, seriescolor=:white,
		    markerstrokecolor=:blue,
		    aspectratio=1,
		    title="Gráfica de ejemplo")
end

# ╔═╡ 5a70e2f4-3b3f-11eb-1dfe-a777db142c6b
md"
Para colorear los gráficos del conjunto de Julia, Mandelbrot y las formas biológicas, utilizando el algoritmo de Tiempo de Escape,  se pueden utilizar mapas de calor. 
"

# ╔═╡ 48238fda-3b3e-11eb-00c6-278430e8d319
begin
	x = -2:0.3:2  
	y = -2:0.3:2
	colores = [i₁*i₂ for i₁ in x, i₂ in y]
	heatmap(x, y, colores, color=cgrad([:black,:blue,:white]),
		    title="Ejemplo Mapa de Calor", xlabel="Re(z)", ylabel="Im(z)")
end

# ╔═╡ 0b52804a-3b41-11eb-3178-c5d7e9b3dca7
md"
Para el mapa de calor, se necesita hacer una malla (las listas 'x' y 'y' del ejemplo anterior) y una matriz donde se guardan los valores que definen el color para cada punto de la malla.

#### Pseudocódigo
Para clarificar los pasos a realizar, se muestra el siguiente algoritmo, cuando se desee obtener un gráfico con colores:

*NOTAS:* 
- Se utilizan algunas funciones que pertenecen al core y base de Julia, si no conoce o intuye su uso averigue sobre la función mediante `?<nombre_función>` o `methods(<nombre_función>)`.
- Usar `test_convergencia = b` para la creación de formas biológicas.
- Las variables rz, iz son las componentes real imaginaria del número complejo respectivamente, que define un punto de la región del plano complejo por analizar.
- La variable i es el contador del número de iteraciones.
- c y z representan números complejos.

~~~julia
1  Para rz = -2:0.3:2 Hacer #Elección del rango puede ser diferente	
2  	  Para iz = -2:0.3:2 Hacer #Elección del rango puede ser diferente	
3		z = complex(rz,iz)
4		#La precisión de la imagen es mejor si incrementa las iteraciones
5		Para i = 1:30 
6			z = f(z) + c
7			#Se verfica que z = complex(rz,iz) esté en el conjunto
8			#T depende del conjunto que se desea graficar
9			Si abs(z) > T Entonces break Fin 
10	   	Fin
11		color = i #Indica la velocidad de divergencia de la orbita
12		Si test_convergencia = a Entonces 
13			Graficar punto en (rz,iz,color) 
14		Fin
15		Si test_convergencia = b Entonces 
16			Si real(z) < T || imag(z) < T Entonces
17				Graficar punto en (rz,iz,color) 
18			Fin
19		Fin
20	  Fin
21  Fin
~~~
"

# ╔═╡ c647eeb2-3b44-11eb-2637-9197f59f6490
md"
# Solución
"

# ╔═╡ ce1cb762-4629-11eb-0598-15119d777749
md"
La solución del problema planteado puede seguir un camino diferente, pero siempre basado en el algoritmo proporcionado. Para completar la parte obligatoria de este proyecto rellene las partes que están incompletas de este documento, tome en cuenta la signatura de las funciones descritas y lo que esta debe hacer. A medida avance en el documento haga uso de las definiciones previas donde sea conveniente.
"

# ╔═╡ b667cda0-46e0-11eb-370d-41d8d7cdf7de
md"
## Definición de objetos y funciones
"

# ╔═╡ 56c3949c-462c-11eb-058f-ef53a7395810
md"
+ A continuación construya un struct `Grid` (Grilla), donde se defina la región del plano complejo que debe ser analizado (límites en las abcisas y ordenadas) y el espacio entre cada punto de la grilla.
"

# ╔═╡ f915f344-3a00-11eb-16a9-6be5b192810c
"""*
 Representa un objeto grilla 
"""
struct Grid{T<:Real}
	
end

# ╔═╡ f1207c62-4631-11eb-30cb-691cbcca8574
md"
+ Defina una función que cree una matriz de rangos para los ejes de las abcisas y ordenas. 
"

# ╔═╡ 1dc63efc-39d6-11eb-3b8d-15da426e82a1
"""
	makeGrid(g::Grid)
Crear una matriz de rangos [rango_abcisas,rango_ordenadas]
"""
function makeGrid(g::Grid)
	
end

# ╔═╡ 774af954-4635-11eb-31dd-17a273bf9b15
md"
+ Defina funciones de una línea para las formas biológicas y la familia de polinomios cuadráticos complejos 
"

# ╔═╡ acda722e-4636-11eb-0a76-29912beacb1c
begin #*
	
end

# ╔═╡ 36bed290-4633-11eb-26fe-d15d7d6f03f8
md"
+ Defina una función que retorne `true` si el criterio de convergencia para los conjuntos $J_{_c}$ y $M_{f_c}$ se cumple, `false` en caso contrario.
"

# ╔═╡ 60604b20-4637-11eb-1874-49e2756715ac
""" *
	testJM(z::Complex)
Comprobar el criterio de convergencia para los conjuntos de Julia y Mandelbrot
"""
function testJM(z::Complex)
	
end

# ╔═╡ 5466484a-4637-11eb-115f-ab417bd2b802
md"
+ Defina una función que `true` si el criterio de convergencia para las formas biológicas se cumple, `false` en caso contrario.
"

# ╔═╡ 6b6e04f0-4638-11eb-1401-6db76349254b
"""
	testbiomorph(z::Complex,τ::Real)
Comprobar el criterio de convergencia para los conjuntos de Julia y Mandelbrot
"""
function testbiomorph(z::Complex,τ::Real)
	
end

# ╔═╡ 71f98b8a-4641-11eb-2c9c-7f49f8577365
md"
+ Defina una función que itere un número sobre una función $f_c$ y devuelva true si se cumple el criterio de divergencia para $J_{f_c}$, $M_{f_c}$ y formas biológicas
"

# ╔═╡ c84bee02-4640-11eb-0dc2-57337e999b50
"""
	iterate(test::Function,f::Function,z::Complex,iter::Integer)
Interar z sobre una funcion f
"""
function iterate(test::Function,f::Function,z::Complex,iter::Integer)
	
end

# ╔═╡ fb3a891a-4634-11eb-2228-67741e0f82e2
md"
+ Defina un función que devuelva el número de iteraciones realizadas para un dado z (número complejo), hasta que se no se cumple el criterio de divergencia.
"

# ╔═╡ 828790ba-39d9-11eb-03bf-cbf806cba31a
"""*
	colormap(f::Function,test::Function,z::Complex,c::Complex,iter::Integer)
Retornar el número de iteraciones para un valor dado de z minetras un criterio de convergencia sea válido
"""
function colormap(f::Function,test::Function,z::Complex,c::Complex,iter::Integer)
	
end

# ╔═╡ 393b931a-46a0-11eb-361d-8da678672d65
md"+ Usando multiple dispatch, defina nuevamente la función colormap agregando un nuevo parámetro de entrada $\tau$, de modo que se pueda usar el test de convergencia para la forma biológica"

# ╔═╡ 1c510af2-46a0-11eb-08ac-a1d54104fd11
function colormap(f::Function,test::Function,z::Complex,c::Complex,iter::Integer,τ::Integer)
	
end

# ╔═╡ 24bba08a-46e2-11eb-0e42-412ca935f3e7
md"
## Solución a los incisos
"

# ╔═╡ 94d3f144-46e2-11eb-1f3b-7f0ba366c99a
md"
Usando las definiciones anteriores realice lo indicado.
"

# ╔═╡ c7030f70-469e-11eb-1fc0-03060512aa15
md"
##### 1) Graficar un conjunto de Julia, para un $c$ arbitrario (monocromático).
"

# ╔═╡ 3f322d18-463b-11eb-1560-0dfa38f7f644
md"
+ Defina una funcion que retorne el conjunto de puntos que pertenecen al conjunto de Julia.
"

# ╔═╡ 73644592-463b-11eb-09c0-952848e159e3
"""
	setjulia()
Construir un array con los puntos del plano complejo que pertenecen al conjunto, dada la región de análisis del plano complejo
Entradas:
- f::Function
- test::Function
- grid::Array{T,2} where T
- c::Complex
- iter::Integer
"""
function setjulia(
		f::Function,
		test::Function,
		grid::Array{T,2} where T,
		c::Complex,
		iter::Integer)
	
end

# ╔═╡ 553b382e-469e-11eb-3b55-3d189b08538c
begin
	
end

# ╔═╡ 639f176a-46e3-11eb-0d26-21e096ca0863
md"
##### 2) Graficar el conjunto de Mandelbrot (monocromático).
"

# ╔═╡ 687d2356-463b-11eb-33a6-53321e36f77a
md"
+ Defina una funcion que retorne el conjunto de puntos que pertenecen al conjunto de Mandelbrot
"

# ╔═╡ ce8536ce-469d-11eb-3f57-59b7ce9ac946
"""
	setmandelbrot()
Construir un array con los puntos del plano complejo que pertenecen al conjunto, dada la región de análisis del plano complejo
Entradas:
- f::Function
- test::Function
- grid::Array{T,2} where T
- iter::Integer
"""
function setmandelbrot(
		f::Function,
		test::Function,
		grid::Array{T,2} where T,
		iter::Integer)
	
end

# ╔═╡ fc4feb92-3b5d-11eb-28ff-630169bd8fc2
begin
	
end

# ╔═╡ 847b1e16-46e3-11eb-1581-95c456a7482f
md"
##### 3) Graficar una forma biológica, par un c arbitrario (monocromático).
"

# ╔═╡ e270a720-469f-11eb-1608-57230535b389
md"
+ Defina una funcion que retorne el conjunto de puntos que pertenecen al conjunto de una forma biológica.
"

# ╔═╡ f4f08ecc-469f-11eb-0d11-91bbe2f63dc8
"""
	setbiomorph()
Construir un array con los puntos del plano complejo que pertenecen al conjunto, dada la región de análisis del plano complejo
Entradas:
- f::Function
- test::Function
- grid::Array{T,2} where T
- c::Complex
- iter::Integer
- τ::Integer
"""
function setbiomorph(
		f::Function,
		test::Function,
		grid::Array{T,2} where T,
		c::Complex,
		iter::Integer,
		τ::Integer)
	
end

# ╔═╡ 9772cb98-469f-11eb-00b0-312e5a3b75dd
begin
	
end

# ╔═╡ b27d4370-46e3-11eb-0b7d-fbe40c187c17
md"
##### 4) Hacer una gráfica a color del conjunto de Mandelbrot 

Usando el algoritmo de Tiempo de Escape y multiple dispatch, defina nuevamente la función setmandelbrot, para obtener los datos necesarios (matriz) que defina los colores para cada punto de una región arbitraria. 
"

# ╔═╡ 5af85e8e-46c8-11eb-3de2-cf62fcb0614f
"""
	setmandelbrot(f::Function,test::Function,grid::Array{T,1} where T,iter::Integer)
Crear una matriz de enteros correspondiente a los colores 
"""
function setmandelbrot(
		f::Function,
		test::Function,
		grid::Array{T,1} where T,
		iter::Integer
	)
	
end

# ╔═╡ e4797f76-40c9-11eb-02d6-35073745bec0
begin
	
end

# ╔═╡ e531a9be-46e3-11eb-0219-0bb7ff3871c2
md"
##### 5) Realizar una gráfica a color para un conjunto de Julia, para un $c$ arbitrario.

Usando el algoritmo de Tiempo de Escape y multiple dispatch, defina nuevamente la función setjulia, para obtener los datos necesarios (matriz) que defina los colores para cada punto de una región arbitraria. 
"

# ╔═╡ af6e5546-46d6-11eb-21cf-ef7281e43d44
begin
	
end

# ╔═╡ 27c6bc88-46e4-11eb-2f01-9531af826324
md"
##### 6) Realizar una gráfica a color para una forma biológica.

Usando el algoritmo de Tiempo de Escape y multiple dispatch, defina nuevamente la función setbiomorph, para obtener los datos necesarios (matriz) que defina los colores para cada punto de una región arbitraria.
"

# ╔═╡ 278afcae-46dd-11eb-2551-b7e85c38f1f2
begin
	
end

# ╔═╡ c05869d8-46e4-11eb-1a10-e71db604ca8c
md"
##### 7) Completar un ejercicio que forma parte de los  challenges problems.
"

# ╔═╡ 3ad65006-508d-11eb-0e27-b1bbeffc47aa


# ╔═╡ Cell order:
# ╟─a79e42e0-3a31-11eb-3791-2dde6b25172b
# ╟─231273f6-3b3b-11eb-2b3b-2308e244a358
# ╠═63b9e832-3b3b-11eb-0d45-b54bff3a4c10
# ╠═16040e00-539c-11eb-0f12-db5ae4d9970f
# ╟─cd1023fa-3b3b-11eb-22ec-2724be9b2af8
# ╠═4070b426-3b3d-11eb-1ef2-73f2f10c9ce6
# ╟─5a70e2f4-3b3f-11eb-1dfe-a777db142c6b
# ╠═48238fda-3b3e-11eb-00c6-278430e8d319
# ╟─0b52804a-3b41-11eb-3178-c5d7e9b3dca7
# ╟─c647eeb2-3b44-11eb-2637-9197f59f6490
# ╟─ce1cb762-4629-11eb-0598-15119d777749
# ╟─b667cda0-46e0-11eb-370d-41d8d7cdf7de
# ╟─56c3949c-462c-11eb-058f-ef53a7395810
# ╠═f915f344-3a00-11eb-16a9-6be5b192810c
# ╟─f1207c62-4631-11eb-30cb-691cbcca8574
# ╠═1dc63efc-39d6-11eb-3b8d-15da426e82a1
# ╟─774af954-4635-11eb-31dd-17a273bf9b15
# ╠═acda722e-4636-11eb-0a76-29912beacb1c
# ╟─36bed290-4633-11eb-26fe-d15d7d6f03f8
# ╠═60604b20-4637-11eb-1874-49e2756715ac
# ╟─5466484a-4637-11eb-115f-ab417bd2b802
# ╠═6b6e04f0-4638-11eb-1401-6db76349254b
# ╟─71f98b8a-4641-11eb-2c9c-7f49f8577365
# ╠═c84bee02-4640-11eb-0dc2-57337e999b50
# ╟─fb3a891a-4634-11eb-2228-67741e0f82e2
# ╠═828790ba-39d9-11eb-03bf-cbf806cba31a
# ╟─393b931a-46a0-11eb-361d-8da678672d65
# ╠═1c510af2-46a0-11eb-08ac-a1d54104fd11
# ╟─24bba08a-46e2-11eb-0e42-412ca935f3e7
# ╟─94d3f144-46e2-11eb-1f3b-7f0ba366c99a
# ╟─c7030f70-469e-11eb-1fc0-03060512aa15
# ╟─3f322d18-463b-11eb-1560-0dfa38f7f644
# ╠═73644592-463b-11eb-09c0-952848e159e3
# ╠═553b382e-469e-11eb-3b55-3d189b08538c
# ╟─639f176a-46e3-11eb-0d26-21e096ca0863
# ╟─687d2356-463b-11eb-33a6-53321e36f77a
# ╠═ce8536ce-469d-11eb-3f57-59b7ce9ac946
# ╠═fc4feb92-3b5d-11eb-28ff-630169bd8fc2
# ╟─847b1e16-46e3-11eb-1581-95c456a7482f
# ╟─e270a720-469f-11eb-1608-57230535b389
# ╠═f4f08ecc-469f-11eb-0d11-91bbe2f63dc8
# ╠═9772cb98-469f-11eb-00b0-312e5a3b75dd
# ╟─b27d4370-46e3-11eb-0b7d-fbe40c187c17
# ╠═5af85e8e-46c8-11eb-3de2-cf62fcb0614f
# ╠═e4797f76-40c9-11eb-02d6-35073745bec0
# ╟─e531a9be-46e3-11eb-0219-0bb7ff3871c2
# ╠═af6e5546-46d6-11eb-21cf-ef7281e43d44
# ╟─27c6bc88-46e4-11eb-2f01-9531af826324
# ╠═278afcae-46dd-11eb-2551-b7e85c38f1f2
# ╟─c05869d8-46e4-11eb-1a10-e71db604ca8c
# ╠═3ad65006-508d-11eb-0e27-b1bbeffc47aa
