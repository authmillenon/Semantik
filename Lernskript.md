% Semantik — Lernskript
% Martin Lenders

Operationelle Semantik
======================
* Definition einer abstrakten Maschine zur Ausführung von Programmen
    1. Definition *Zustandsmenge* $\mathcal Z$,
    2. für ein Programm $P$ und eine Eingabe $E$: 
       *Anfgangszustand* $z_{P,E} \in \mathcal Z$ und
    3. Definition determistischer *Zustandsüberführungsfunktion* 
        $\Delta : \mathcal Z \to \mathcal Z$
* Semantik definiert als Ausgabekomponente des Zustands $z \in \mathcal Z$
  für den gilt:
    1. $\exists n \in \mathbb N : z = \Delta^n(z_{P,E})$ (Endzustand = Folgezustand des Anfangszustand),
    2. $\Delta(z) = z$ (Programm terminiert) und
    3. $\forall k < n : \Delta^k(z_{P,E}) \neq \Delta^{k+1}(z_{P,E})$ (Eindeutigkeit der Semantikfunktion)

WSKEA-Maschine
--------------
* Abstrakte Maschine im obigen Sinne zur Ausführung von WHILE-Programmen
    (i) $\mathcal Z = \mathcal W \times \mathcal S \times \mathcal K \times \mathcal E \times \mathcal A$, 
        mit $\langle W | S | K | E | A \rangle \in \mathcal Z$
        * Wertekeller $W$
        * Speicher $S: ID \to ZAHL \cup \{\underline{frei}\}$
        * Kontrollkeller $K$
        * Eingabe $E$
        * Ausgabe $A$
    (ii) $z_{P,E} = \langle \varepsilon | S_0 | P.\varepsilon | E | \varepsilon \rangle$
        * leerer Speicher $S_0$: $\forall I \in ID: S_0(I) = \underline{frei}$
    (iii) Induktive Definition von $\Delta$ über den Aufbau der 
          Programmkomponenten, die momentan auf der Programmspitze
          liegen
* Operationelle Semantik $\mathcal O : PROG \to [\overline{KON}^* \to \overline{KON}^* \cup \{\underline{Fehler}\}]$:
    $$\mathcal O(P)(\overline E) := \begin{cases}
        \overline A, & \exists n \in \mathbb{N}: \Delta^n(z_{P,E}) = \Delta^{n+1}(z_{P,E}) \land \Pi_5(\Delta^n(z_{P,E})) = A \\
        \underline{Fehler}, & \exists n \in \mathbb{N}: \Delta^n(z_{P,E}) = \text{n. d.}\\
        \text{n. d.}, & \text{sonst}
    \end{cases}
    $$

Reduktionssemantik
------------------
* Kontrolle des globalen Verhaltens der WSKAE-Maschine
* Reduktionsrelation „$\Longrightarrow$“:
    * $(P, (S,E,A)) \Longrightarrow (P', (S',E',A'))$, wenn die Ausführung
      von $P$ mit Speicher $S$, Eingabe $E$ und Ausgabe $A$ den „Wert“
      $P'$ ergibt und den Speicher in $S'$, die Eingabe in $E'$ und 
      die Ausgabe in $A'$ transformiert. 
* Reduktionssemantik $eval : PROG \to [\overline{KON}^* \to \overline{KON}^* \cup \{\underline{Fehler}\}]$:
    $$eval(P)(\overline E) := \begin{cases}
        \overline A, & (C, (S_0, E, \varepsilon)) \Longrightarrow (\mathbf{skip}, (S, E', A)), \text{mit $S, E'$ bel.} \\
        \underline{Fehler}, & (C, (S_0, E, \varepsilon)) \Longrightarrow (C', (S, E', A)), \text{mit $C' \neq \mathbf{skip}$, $S, E'$ bel. und}\\
                            & (C', (S, E', A)) \Longrightarrow \text{n. d.} \\
        \text{n. d.},       & \text{sonst}
    \end{cases}
    $$
* $\mathcal O = eval$

Denotationelle Semantik
=======================
* Funktionale Definition der Semantik
* Definition *Zustandsbereich*:
    1. $ZUSTAND = SPEICHER \times EINGABE \times AUSGABE$
    2. $SPEICHER: ID \to (\mathbb Z \cup \{\underline{frei}\})$
    3. $EINGABE = \overline{KON}^*$
    4. $AUSGABE = \overline{KON}^*$
* Für WHILE: 4 Semantikfunktionen:
    1. $\mathcal T : TERM \to (ZUSTAND \to (\mathbb{Z} \times ZUSTAND) \cup \{\underline{Fehler}\})$,
    2. $\mathcal B : BT \to (ZUSTAND \to ((\overline{BOOL} \times ZUSTAND) \cup \{\underline{Fehler}\}))$,
    3. $\mathcal C : COM \to (ZUSTAND \to (ZUSTAND \cup \{\underline{Fehler}\}))$ und
    4. $\mathcal P : PROG \to (\overline{KON}^* \to (\overline{KON}^* \cup \{\underline{Fehler}\}))$
* Schreibweise z. B. $\mathcal T \llbracket n \rrbracket z = (n, z)$ für alle $n \in ZAHL$

Axiomatische Semantik
=====================
* Neben abstrakter Syntax gehören zu axiomatischer Semantik:
    1. über Zustandsraum interpretierbare *logische Ausdrücke oder 
       Prädikate* (*Bedingungen*). I. A. Ausdrücke der Prädikatenlogik
       erster Stufe
    2. *Axiom* bzw. *Axiomschema* zu jeder elementaren Anweisung $C$
        $$\{P\} C \{Q\}$$
    3. Zu jeder Zusammengesetzte Anweisung $C$ mit unmittelbaren Komponenten 
       $C_1, ..., C_n$ eine *Schlussregel*
        $$\frac{F_1, ..., F_n}{\{P\} C \{Q\}}$$
       mit Formeln $F_1, ..., F_n$
    4. Menge *allgemeiner Schlussregeln*

Axiome für WHILE
================
* logische Ausdrücke und Prädikate entsprechend Prädikatenlogik
\begin{align}
\{Q\} & \mathbf{skip} \{Q\} \\
\{Q[t/I]\} & I := T \{Q\} \\
\{\neg \underline{eof} \land Q[\pi_1(\underline{input})/I]\} & I := T \{Q[I.\underline{input}/\underline{input}]\} \\
\{Q[\underline{output}.t/\underline{output}]\} & I := T \{Q\} 
\end{align}
* $t$ ist der semantische Term, der aus $T$ gewonnen wird
* Schlussregeln und allgemeine Schlussregeln s. Hoare-Kalkül

Semantische Bereiche (CPOs)
===========================
* Definition *complete partial order* (cpo): Struktur $A = (\underline A, \sqsubseteq_A)$ ist ein *semantischer Bereich (cpo)*, wenn
    1. Die Relation $\sqsubseteq_A$ eine *Halbordnung* in $\underline A$ (Approximationsrelation), also reflexiv, antisymmetrisch und transitiv, ist
        (Abgekürzt durch $\sqsubseteq$)
    2. Es existiert in $\underline A$ bezüglich $\sqsubseteq$ ein *minimales Element* $\bot_A$, sodass $\forall a \in A : \bot_A \sqsubseteq a$
        (Abgekürzt durch $\bot$)
    3. Jede Kette $K \subseteq \underline{A}$ besitzt bzgl. $\sqsubseteq_A$ eine kleinste obere Schranke $\bigsqcup K$ in $A$, wobei $K$ Kette heißt
       wenn $\forall k_1 \in K \exists k_2 \in : k_1 \sqsubseteq k_2 \lor k_2 \sqsubseteq k_1$  
        (Abkürzung: $\bigsqcup_{v \in \mathbb{N}} a_v$ für $\bigsqcup \{a_v\ |\ v \in \mathbb{N}\}$)

Monotonie, Stetigkeit, Striktheit
---------------------------------
* Geg.: cpos $A$ und $B$ und Funktion $f: A \to B$
    1. $f$ ist monoton, wenn
        $$\forall a_1, a_2 \in A : a_1 \sqsubseteq a_2 \Rightarrow f(a_1) \sqsubseteq f(a_2)$$
    2. $f$ ist stetig, wenn für alle Ketten $K \subseteq A$ gilt: $f(K) := \{f(k)\ |\ k \in K\} \subseteq B$ ist eine Kette und
        $$f(\bigsqcup K) = \bigsqcup f(K)$$

Fixpunkte
---------

Denotationelle Semantik
-----------------------

Fortsetzungssemantik
--------------------

Hilfsfunktionen
===============
* $\underline{curry}: (A \times B \to C) \to (A \to (B \to C))$, mit $\underline{curry}(f)(a)(b) := f\ a\ b$
* Projektion: 
\begin{align*}
\pi_i : (D_1 \times ... \times D_n)     & \to D_i \\
        \langle d_1, ..., d_2 \rangle   & \mapsto d_i, \text{für $1 \leq i \leq n$}& \text{bzw.}\\\\
\pi_i : D^*                                     & \to D\\
        \langle d_v\ |\ 1 \leq v \leq n \rangle & \mapsto \begin{cases}
                d_i, & 1 < i < n \\
                \bot_D 
            \end{cases}& \text{und}\\\\
\pi_i : D^\omega                                & \to D\\
        \langle d_v\ |\ v \in \mathbb{N}\rangle & \mapsto d_i& \forall i \in \mathbb{N}\\
\end{align*}
