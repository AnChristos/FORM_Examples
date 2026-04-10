# About FORM 

* **FORM**: J.A.M. Vermaseren, *"New features of FORM"* (math-ph/0010025)

- Repository https://github.com/form-dev/form
- Releases https://github.com/form-dev/form/releases
- Manual https://form-dev.github.io/form-docs/stable/manual/

#  This project

Simple textbook examples 

## Textbooks
* *Quarks & Leptons: An Introductory Course to Modern Particle Physics* by Halzen & Martin
* *Diagrammatica: The Path to Feynman Diagrams* by Martinus Veltman

## Structure
- `/Notebooks`: Interactive Jupyter environments.
- `/scripts`: Raw FORM 5.0 files generated from notebooks.

## Requirements
- We assume form is available (a command ``form'' exists)
- Python
    - jupyterlab
    - numpy
    - matplotlib 

## Description of pipeline
- We want to be able to run ``form``. Ideally from inside the notebook.
- Assume a notebook ``name.ipynb``
    - We import the utils in the first cell
    - At the start of second cell  we use ``%%pyForm name``.
    We then put the actual ``form`` code in the cell
    - When the cells runs we save and run``name.frm`` in the scripts folder.
    - We store the expressions using Format C in a file.
    - We then use python to parse the file and do further manipulations.

# Conventions for Amplitude Calculations

## Gamma Matrix and Identity Notation

See also Traces.ipynb 

| Term                     | FORM Notation        | Mathematical Equivalent    |
| :----------------------- | :------------------- | :------------------------- |
| **Identity Matrix**      | `g(i1, i2)`          | $\delta_{ab}$              |
| **Gamma Matrix**         | `g(i1, i2, mu)`      | $(\gamma^\mu)_{ab}$        |
| **Slash Momentum**       | `g(i1, i2, p1)`      | $(\not{p})_{ab}$           |
| **Gamma 5 ($\gamma^5$)** | `g(i1, i2, k5)`      | $(\gamma^5)_{ab}$          |
| **Closed Trace**         | `g(i1, i1, p1, ...)` | $\text{Tr}(\not{p} \dots)$ |

* **Chirality**: The indices `k5`, `k6`, and `k7` are reserved for special gamma structures.
* `k5` specifically represents $\gamma^5$ and receives a minus sign during the conjugation process.

---

## Spinors and External Lines

Spinors convention:
```
Spinor(index, momentum, mass)
```

* **Adjoint Lepton/Quark ($\bar{u}$)**: `UB(i1, p, m)` → $\bar{u}_a(p, m)$
* **Lepton/Quark ($u$)**: `U(i1, p, m)` → $u_a(p, m)$
* **Anti-Lepton ($v$)**: `V(i1, p, m)` → $v_a(p, m)$
* **Adjoint Anti-Lepton ($\bar{v}$)**: `VB(i1, p, m)` → $\bar{v}_a(p, m)$
* **Vector Polarization ($\epsilon$)**: `eps(mu1, p)` → $\epsilon_\mu(p)$

---

## Propagator Conventions

Propagators include both the numerator structure and the scalar denominator factor.

### Fermion Propagator

```
fprop(i1, i2, p, m) = (g(i1, i2, p) + g(i1, i2) * m) * prop(p.p - m^2)
```

### Photon Propagator

```
phprop(mu1, mu2, q) = -d_(mu1, mu2) * prop(q.q)
```

---

## Index and Momentum Mapping

To translate a handwritten Feynman rule:

1. **Index Direction**: Write indices in the direction of fermion flow (matrix multiplication order).
2. **Spinor Indices**: Use `i1, i2, i3...` for fermion lines (up to `i40`).
3. **Lorentz Indices**: Use `mu1, mu2, mu3...` for vector indices (up to `mu20`).


Then call
   ```
   squareamplitude(Amp, Mat)
   ```
