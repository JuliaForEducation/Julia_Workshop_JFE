### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 110f6082-5a79-11eb-0171-4b4cac76878a
begin
	using Pkg; Pkg.activate("."); Pkg.instantiate()
	using Plots
end

# ╔═╡ 180063f2-59b9-11eb-3db5-f13fecb39675
md"### _Primer Proyecto:_  
# Fractales en Plano Complejo   
#### Conjunto Mandelbrot
"

# ╔═╡ 9bf3a5ac-59e6-11eb-37a6-9bc1a163545b
md" Para este conjunto, definiremos las siguientes variables y funciones:"

# ╔═╡ deba8218-59d2-11eb-0cc5-d3dcbafa9fa4
md" **Nₚ** es el número de puntos de la división de cada eje."

# ╔═╡ 824ae056-59e2-11eb-3b81-5b4d3d9fc2fd
Nₚ = 100

# ╔═╡ 9320fd5e-59d8-11eb-2ef0-ad2c9ed49227
md" **τ** es el número de iteraciones para la un c complejo dado"

# ╔═╡ 6e4b972a-59e3-11eb-0cc7-15081c7c86db
τ=100

# ╔═╡ 774b1198-59e3-11eb-3835-a35680b83703
md" **cᵣ** es el rango de la componente real y **cᵢ** es el rango de la componente imaginaria de un c complejo dado"

# ╔═╡ cc88c952-59e8-11eb-3b3b-2fb4847976be
begin
	cᵣ = -2:Nₚ
	cᵢ = -2:Nₚ
end

# ╔═╡ 71dab49c-59f1-11eb-32f0-d5b8c0895142
md" **M** es el arreglo que contiene los puntos del conjunto"

# ╔═╡ 4220f670-59f9-11eb-055e-7771df49359a
M = Array{ComplexF16,1}()

# ╔═╡ b9155372-59f2-11eb-2b15-c57f5b6ab79e
md" Ya que tenemos todos los elementos necesarios, procedemos a las iteraciones:"

# ╔═╡ e8566eaa-59f2-11eb-3cb9-f10355f567c7
begin
	for r ∈ 1:length(cᵣ)
		for i ∈ 1:length(cᵢ)
			z = 0 + 0im
			c = cᵣ[r] + cᵢ[i]*im
			if abs(c) <=2
				for l ∈ 1:τ
					z = z^2 + c
				end
				if abs(z) < 2
					push!(M,c)
				end
			end
		end
	end
end

# ╔═╡ 8ec5bd24-5a78-11eb-394e-7914453605d2
Q = length(M)/Nₚ

# ╔═╡ 11779698-5a7e-11eb-12ea-77838d29e592
scatter(M,'.')

# ╔═╡ 46fb5f6e-5a80-11eb-28fc-b1765124e891
gui(g)

# ╔═╡ 4a970942-5a72-11eb-31d0-577b9573fb1b
md"#### Conjunto Julia"

# ╔═╡ 49895abe-5a72-11eb-20c7-a1f54f69e9f8


# ╔═╡ Cell order:
# ╠═180063f2-59b9-11eb-3db5-f13fecb39675
# ╠═9bf3a5ac-59e6-11eb-37a6-9bc1a163545b
# ╠═deba8218-59d2-11eb-0cc5-d3dcbafa9fa4
# ╠═824ae056-59e2-11eb-3b81-5b4d3d9fc2fd
# ╠═9320fd5e-59d8-11eb-2ef0-ad2c9ed49227
# ╠═6e4b972a-59e3-11eb-0cc7-15081c7c86db
# ╠═774b1198-59e3-11eb-3835-a35680b83703
# ╠═cc88c952-59e8-11eb-3b3b-2fb4847976be
# ╠═71dab49c-59f1-11eb-32f0-d5b8c0895142
# ╠═4220f670-59f9-11eb-055e-7771df49359a
# ╠═b9155372-59f2-11eb-2b15-c57f5b6ab79e
# ╠═e8566eaa-59f2-11eb-3cb9-f10355f567c7
# ╠═8ec5bd24-5a78-11eb-394e-7914453605d2
# ╠═110f6082-5a79-11eb-0171-4b4cac76878a
# ╠═11779698-5a7e-11eb-12ea-77838d29e592
# ╠═46fb5f6e-5a80-11eb-28fc-b1765124e891
# ╠═4a970942-5a72-11eb-31d0-577b9573fb1b
# ╠═49895abe-5a72-11eb-20c7-a1f54f69e9f8
