import Mathlib.Logic.Basic

universe u

namespace DIP.AxiomII

inductive MachineState
  | running
  | melted
  deriving DecidableEq, Repr

def HomAt (H : Type u) : MachineState → Type u
  | .running => H
  | .melted  => PEmpty.{u+1}

structure Machine (H : Type u) where
  state : MachineState

def step {H : Type u} (Val : H → Prop) [DecidablePred Val]
    (m : Machine H) (f : H) : Machine H :=
  match m.state with
  | .running => if Val f then ⟨.running⟩ else ⟨.melted⟩
  | .melted  => ⟨.melted⟩

theorem meltdown_occurs {H : Type u} (Val : H → Prop) [DecidablePred Val]
    (m : Machine H) (f : H) (h_s : m.state = .running) (h_v : ¬ Val f) :
    (step Val m f).state = .melted := by
  cases m with
  | mk s =>
    simp only [Machine.state] at h_s
    subst h_s
    simp [step, if_neg h_v]

theorem melted_hom_subsingleton {H : Type u} (m : Machine H) (h : m.state = .melted) :
    Subsingleton (HomAt H m.state) := by
  cases m with
  | mk s =>
    simp only [Machine.state] at h
    subst h
    exact ⟨fun x => nomatch x⟩

theorem melted_is_absorbing {H : Type u} (Val : H → Prop) [DecidablePred Val]
    (m : Machine H) (h : m.state = .melted) (f : H) :
    (step Val m f).state = .melted := by
  cases m with
  | mk s =>
    simp only [Machine.state] at h
    subst h
    simp [step]

theorem no_distinction_after_meltdown {H : Type u}
    (m : Machine H) (h : m.state = .melted) (g1 g2 : HomAt H m.state) :
    g1 = g2 := by
  haveI : Subsingleton (HomAt H m.state) := melted_hom_subsingleton m h
  exact Subsingleton.elim g1 g2

theorem running_emits_safe {H : Type u} (Val : H → Prop) [DecidablePred Val]
    (m : Machine H) (f : H) (h_s : m.state = .running) (h_v : Val f) :
    (step Val m f).state = .running := by
  cases m with
  | mk s =>
    simp only [Machine.state] at h_s
    subst h_s
    simp [step, if_pos h_v]

end DIP.AxiomII