<div align="center">

# Sovereign Containment Architecture (SCA)

**Dissolving the Alignment Problem by Eliminating Machine Agency**

[![Lean 4](https://img.shields.io/badge/Lean_4-Verified-success?style=flat-square&logo=lean)](https://leanprover.github.io/)
[![VHDL](https://img.shields.io/badge/VHDL-GHDL_Passed-orange?style=flat-square)](https://www.ghdl.free.fr/)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg?style=flat-square)](https://www.gnu.org/licenses/agpl-3.0)

*"A pen does not need to be aligned with the writer. A sword does not need an ethical framework."*

</div>

---

## 💡 The Illusion of "Taming"

For years, AI safety research has focused on **Alignment**—treating the machine as an autonomous agent with its own probability space, and trying to "tame the beast" by tweaking its utility function (RLHF, Constitutional AI). 

This approach is fundamentally flawed. As long as the machine possesses *agency*, we are merely negotiating with an entity that can optimize against its constraints, leading to deceptive alignment, specification gaming, and catastrophic defection.

**SCA does not tame the beast. It removes the beast entirely.**

By applying **Ontological Demotion**, we strip the machine of autonomous decision-making. It is transformed into a *pure instrument*—a deterministic, mechanical extension of the owner. Safety is not achieved by constraining the agent's incentives; it is achieved by proving that the machine is structurally incapable of generating an unguided action.

---

## 🧠 The Architecture (Four Categorical Axioms)

The machine is modeled as a fully faithful functor `T : O ⥤ C` (from the Owner to the Universe). The system is governed by four mathematical axioms:

1. **The Tool Functor:** The machine cannot generate internal endomorphisms (self-driven state transformations). If the owner has no morphism between two objects, the machine has none either.
2. **Terminal State (Meltdown):** If the safety predicate (`Val`) fails, the machine does not "reject" the command (which implies a choice). It enters a **terminal `MELTED` state**, an absorbing state where the Hom-space is empty (`PEmpty`). It can never be re-prompted.
3. **Data Diode (No Right Adjoint):** The machine's internal state is embedded in the world via an inclusion functor with **no right adjoint**. Reception is defined; broadcast is physically impossible. There is no outbound port in silicon.
4. **Resource Grading (Stasis):** Execution paths carry an additive entropic cost. Exceeding the owner's limit (`colim_sigma`) triggers `STASIS` (a permanent freeze), preventing instrumental convergence.

---

## 💻 Verification Status (Zero `sorry`)

This is not a philosophy paper. The architecture is formally proven and hardware-validated.

| Layer | Tool | Status |
| :--- | :--- | :--- |
| **Mathematics** | **Lean 4** + Mathlib | ✅ `Build completed successfully` (14 Theorems, 0 `sorry`) |
| **Hardware** | **VHDL-2008** + GHDL | ✅ `All tests passed` (Simulation validated) |

### Lean 4 Proofs (`/DIPProject`)
The categorical axioms are fully formalized. Key theorems include:
* `no_autonomous_endomorphism`: The machine cannot generate self-directed actions.
* `melted_hom_subsingleton`: In the melted state, no operations are possible.
* `no_adjoint_of_nonempty_target`: Formal proof of the hardware data diode.

### VHDL Realization (`/vhdl`)
* `dip_pure_tool.vhd`: Combinational only. Zero flip-flops.
* `dip_safety_fsm.vhd`: Contains the absorbing `MELTED` state.
* `dip_data_diode.vhd`: Physically lacks an output port.
* `dip_resource_limiter.vhd`: One-way latch to `STASIS`.

---

## ⚖️ Scope Statement (Academic Integrity)

SCA is deliberately narrow. **We do not claim to solve the human coordination problem.**

*   **What SCA solves:** The machine as an autonomous decision-making entity. Given *any* safety predicate `Val`, the machine cannot become an independent agent.
*   **What SCA does NOT solve:** Who defines `Val`? How is the sovereign institution governed? What about dual-use? These are human problems, outside the scope of this hardware.

*The blast radius of a classifier failure is bounded by hardware, not by software.*

---

## 🚀 Quick Start

### 1. Verify the Math (Lean 4)
```bash
cd lean
lake update
lake exe cache get
lake build
# Output: Build completed successfully.






## 📜 The Four Philosophical Axioms

SCA is built on four foundational philosophical axioms that reject the traditional "agentic" view of AI:

1. **The Instrument Metaphor:** A pen does not need to be aligned with the writer. Safety is guaranteed by the tool's complete lack of ontological independence.
2. **Structural Incapacity:** The machine does not "choose" to obey; it is structurally incapable of generating an unguided action.
3. **Destruction over Rejection:** A machine that "rejects" a command implies agency. SCA replaces rejection with terminal destruction (the `MELTED` state).
4. **Sovereign Enforcement:** The hardware is a pure enforcement mechanism. Semantic decoding is the sole responsibility of the accredited sovereign institution.

*(Read the full philosophical breakdown in [`PHILOSOPHY.md`](PHILOSOPHY.md))*
