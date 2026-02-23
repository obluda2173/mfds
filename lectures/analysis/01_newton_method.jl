### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d
begin
    using PlutoUI
    using Plots
    plotly()
end

# ╔═╡ 1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d
md"""
# Analysis I — Lecture 1: Newton's Method

**Course:** Analysis I  
**Topic:** Numerical Root Finding  
**Prerequisites:** Differentiation basics

[← Back to Index](../../index.html)

---
"""

# ╔═╡ 2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e
md"""
## 1. The Problem

We want to find $x^*$ such that $f(x^*) = 0$.

This is called **root finding** and appears constantly in mathematics:
- Solving equations
- Finding fixed points
- Optimization (finding where $f'(x) = 0$)

**Example:** Find $\sqrt{2}$ by solving $f(x) = x^2 - 2 = 0$
"""

# ╔═╡ 3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f
md"""
## 2. The Idea Behind Newton's Method

**Key insight:** If we can't solve $f(x) = 0$ directly, we can *approximate* $f$ with something simpler.

The simplest approximation? A **straight line** (the tangent).

At any point $x_n$, the tangent line to $f$ is:

$$L(x) = f(x_n) + f'(x_n)(x - x_n)$$

Setting $L(x) = 0$ and solving for $x$:

$$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}$$

This is **Newton's Method**!
"""

# ╔═╡ 4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a
md"""
## 3. Interactive Visualization

Use the sliders below to explore how Newton's method converges:
"""

# ╔═╡ 5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b
md"""
**Starting point $x_0$:**
"""

# ╔═╡ 6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c
@bind x0 Slider(-3.0:0.1:3.0, default=2.0, show_value=true)

# ╔═╡ 7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d
md"""
**Number of iterations:**
"""

# ╔═╡ 8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e
@bind max_iter Slider(1:10, default=5, show_value=true)

# ╔═╡ 9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f
begin
    # Define the function and its derivative
    f(x) = x^2 - 2
    f_prime(x) = 2x
    
    # Newton's method
    function newton(x0_val, n)
        xs = [x0_val]
        x = x0_val
        for _ in 1:n
            if abs(f_prime(x)) < 1e-10
                break
            end
            x = x - f(x) / f_prime(x)
            push!(xs, x)
        end
        return xs
    end
    
    history = newton(x0, max_iter)
end;

# ╔═╡ 0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a
begin
    # Create plot
    xrange = range(-3, 3, length=200)
    
    p = plot(xrange, f.(xrange), 
        label="f(x) = x² - 2", 
        lw=2.5, 
        color=:royalblue,
        xlabel="x",
        ylabel="y",
        title="Newton's Method: Finding √2",
        legend=:topleft,
        size=(750, 500),
        framestyle=:box,
        grid=true,
        gridalpha=0.3
    )
    
    # Draw iterations
    for i in 1:length(history)-1
        xi = history[i]
        yi = f(xi)
        slope = f_prime(xi)
        
        # Tangent line
        tangent(x) = yi + slope * (x - xi)
        t_range = range(xi - 1.2, xi + 1.2, length=50)
        plot!(p, t_range, tangent.(t_range), 
            color=:orange, alpha=0.6, lw=1.5, 
            label=(i==1 ? "Tangent lines" : ""))
        
        # Vertical drop
        xnext = history[i+1]
        plot!(p, [xnext, xnext], [0, f(xnext)],
            color=:gray, ls=:dash, alpha=0.5, lw=1, label="")
    end
    
    # Mark points
    scatter!(p, history, f.(history), 
        label="Iterations", ms=7, color=:red, 
        markerstrokecolor=:darkred, markerstrokewidth=1.5)
    
    # Reference lines
    hline!(p, [0], ls=:solid, color=:black, lw=0.5, label="")
    vline!(p, [sqrt(2), -sqrt(2)], color=:green, ls=:dot, 
        label="±√2", lw=2)
    
    p
end

# ╔═╡ 1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b
md"""
## 4. Convergence Analysis

The table below shows how quickly Newton's method converges:
"""

# ╔═╡ 2f3a4b5c-6d7e-8f9a-0b1c-2d3e4f5a6b7c
begin
    result_table = []
    for (i, x) in enumerate(history)
        err = abs(x - sqrt(2))
        push!(result_table, (
            n = i-1,
            xn = round(x, digits=12),
            error = err < 1e-15 ? "< 10⁻¹⁵" : string(round(err, sigdigits=3))
        ))
    end
    result_table
end

# ╔═╡ 3a4b5c6d-7e8f-9a0b-1c2d-3e4f5a6b7c8d
md"""
| Iteration | $x_n$ | Error $|x_n - \sqrt{2}|$ |
|:---------:|:------|:-------------------------|
$(join(["| $(r.n) | $(r.xn) | $(r.error) |" for r in result_table], "\n"))
"""

# ╔═╡ 4b5c6d7e-8f9a-0b1c-2d3e-4f5a6b7c8d9e
md"""
## 5. Quadratic Convergence

Notice how the error *squares* each iteration (once close to the root):

$$|x_{n+1} - x^*| \approx C |x_n - x^*|^2$$

This means:
- 1 correct digit → 2 correct digits
- 2 correct digits → 4 correct digits
- 4 correct digits → 8 correct digits

**Doubling precision with each step!** This is called **quadratic convergence**.
"""

# ╔═╡ 5c6d7e8f-9a0b-1c2d-3e4f-5a6b7c8d9e0f
md"""
## 6. When Does Newton's Method Fail?

Try these experiments with the sliders above:

1. **$x_0 = 0$**: What happens? Why?
2. **$x_0 = -0.1$**: Which root does it converge to?
3. **Large $|x_0|$**: Does it still converge?

### Failure Modes

- **Division by zero**: If $f'(x_n) = 0$, the method breaks
- **Cycling**: Some functions cause oscillation
- **Divergence**: Bad starting points can send iterates to infinity
- **Wrong root**: May converge to a different root than intended
"""

# ╔═╡ 6d7e8f9a-0b1c-2d3e-4f5a-6b7c8d9e0f1a
md"""
## 7. Self-Check Exercise

**Question:** Apply one step of Newton's method to $f(x) = x^2 - 2$ starting from $x_0 = 1$.

Calculate $x_1 = x_0 - \frac{f(x_0)}{f'(x_0)}$
"""

# ╔═╡ 7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0f1a2b
@bind answer TextField(default="")

# ╔═╡ 8f9a0b1c-2d3e-4f5a-6b7c-8d9e0f1a2b3c
begin
    correct = 1 - f(1) / f_prime(1)  # = 1 - (-1)/2 = 1.5
    
    if isempty(answer)
        md"*Enter your answer above (as a decimal)*"
    else
        try
            user_ans = parse(Float64, answer)
            if abs(user_ans - correct) < 0.01
                md"""
                ✅ **Correct!** 
                
                $x_1 = 1 - \frac{1^2 - 2}{2 \cdot 1} = 1 - \frac{-1}{2} = 1.5$
                """
            else
                md"""
                ❌ **Not quite.** 
                
                Remember: $x_1 = x_0 - \frac{f(x_0)}{f'(x_0)}$
                
                With $x_0 = 1$: What is $f(1)$? What is $f'(1)$?
                """
            end
        catch
            md"⚠️ Please enter a number"
        end
    end
end

# ╔═╡ 9a0b1c2d-3e4f-5a6b-7c8d-9e0f1a2b3c4d
md"""
## 8. Summary

### Newton's Method Formula
$$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}$$

### Key Properties
- **Quadratic convergence** near simple roots
- Requires **derivative** $f'(x)$
- Sensitive to **starting point**
- May fail if $f'(x_n) \approx 0$

### Applications
- Solving nonlinear equations
- Finding eigenvalues
- Optimization (via $f'(x) = 0$)
- Computer graphics (ray tracing)

---

[← Back to Index](../../index.html)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.40"
PlutoUI = "~0.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised
julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "0000000000000000000000000000000000000000"

[[deps.Plots]]
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.4"

[[deps.PlutoUI]]
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"
"""

# ╔═╡ Cell order:
# ╠═8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d
# ╟─1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d
# ╟─2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e
# ╟─3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f
# ╟─4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a
# ╟─5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b
# ╠═6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c
# ╟─7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d
# ╠═8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e
# ╟─9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f
# ╟─0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a
# ╟─1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b
# ╟─2f3a4b5c-6d7e-8f9a-0b1c-2d3e4f5a6b7c
# ╟─3a4b5c6d-7e8f-9a0b-1c2d-3e4f5a6b7c8d
# ╟─4b5c6d7e-8f9a-0b1c-2d3e-4f5a6b7c8d9e
# ╟─5c6d7e8f-9a0b-1c2d-3e4f-5a6b7c8d9e0f
# ╟─6d7e8f9a-0b1c-2d3e-4f5a-6b7c8d9e0f1a
# ╠═7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0f1a2b
# ╟─8f9a0b1c-2d3e-4f5a-6b7c-8d9e0f1a2b3c
# ╟─9a0b1c2d-3e4f-5a6b-7c8d-9e0f1a2b3c4d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
