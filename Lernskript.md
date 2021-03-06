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
        * Speicher $S: \mathit{ID} \to \mathit{ZAHL} \cup \{\underline{\mathit{frei}}\}$
        * Kontrollkeller $K$
        * Eingabe $E$
        * Ausgabe $A$
    (ii) $z_{P,E} = \langle \varepsilon | S_0 | P.\varepsilon | E | \varepsilon \rangle$
        * leerer Speicher $S_0$: $\forall I \in \mathit{ID}: S_0(I) = \underline{\mathit{frei}}$
    (iii) Induktive Definition von $\Delta$ über den Aufbau der 
          Programmkomponenten, die momentan auf der Programmspitze
          liegen
* Operationelle Semantik $\mathcal O : \mathit{PROG} \to [\overline{\mathit{KON}}^* \to \overline{\mathit{KON}}^* \cup \{\underline{\mathit{Fehler}}\}]$:
    $$\mathcal O(P)(\overline E) := \begin{cases}
        \overline A, & \exists n \in \mathbb{N}: \Delta^n(z_{P,E}) = \Delta^{n+1}(z_{P,E}) \land \Pi_5(\Delta^n(z_{P,E})) = A \\
        \underline{\mathit{Fehler}}, & \exists n \in \mathbb{N}: \Delta^n(z_{P,E}) = \text{n. d.}\\
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
* Reduktionssemantik $\mathit{eval} : \mathit{PROG} \to [\overline{\mathit{KON}}^* \to \overline{\mathit{KON}}^* \cup \{\underline{\mathit{Fehler}}\}]$:
    $$\mathit{eval}(P)(\overline E) := \begin{cases}
        \overline A, & (C, (S_0, E, \varepsilon)) \Longrightarrow (\mathbf{skip}, (S, E', A)), \text{mit $S, E'$ bel.} \\
        \underline{\mathit{Fehler}}, & (C, (S_0, E, \varepsilon)) \Longrightarrow (C', (S, E', A)), \text{mit $C' \neq \mathbf{skip}$, $S, E'$ bel. und}\\
                            & (C', (S, E', A)) \Longrightarrow \text{n. d.} \\
        \text{n. d.},       & \text{sonst}
    \end{cases}
    $$
* $\mathcal O = \mathit{eval}$

Denotationelle Semantik
=======================
* Funktionale Definition der Semantik
* Definition *Zustandsbereich*:
    1. $\mathit{ZUSTAND} = \mathit{SPEICHER} \times \mathit{EINGABE} \times \mathit{AUSGABE}$
    2. $\mathit{SPEICHER}: \mathit{ID} \to (\mathbb Z \cup \{\underline{\mathit{frei}}\})$
    3. $\mathit{EINGABE} = \overline{\mathit{KON}}^*$
    4. $\mathit{AUSGABE} = \overline{\mathit{KON}}^*$
* Für WHILE: 4 Semantikfunktionen:
    1. $\mathcal T : \mathit{TERM} \to (\mathit{ZUSTAND} \to (\mathbb{Z} \times \mathit{ZUSTAND}) \cup \{\underline{\mathit{Fehler}}\})$,
    2. $\mathcal B : \mathit{BT} \to (\mathit{ZUSTAND} \to ((\overline{\mathit{BOOL}} \times \mathit{ZUSTAND}) \cup \{\underline{\mathit{Fehler}}\}))$,
    3. $\mathcal C : \mathit{COM} \to (\mathit{ZUSTAND} \to (\mathit{ZUSTAND} \cup \{\underline{\mathit{Fehler}}\}))$ und
    4. $\mathcal P : \mathit{PROG} \to (\overline{\mathit{KON}}^* \to (\overline{\mathit{KON}}^* \cup \{\underline{\mathit{Fehler}}\}))$
* Schreibweise z. B. $\mathcal T \llbracket n \rrbracket z = (n, z)$ für alle $n \in \mathit{ZAHL}$

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
\begin{align*}
\{Q\} & \mathbf{skip} \{Q\} \\
\{Q[t/I]\} & I := T \{Q\} \\
\{\neg \underline{\mathit{eof}} \land Q[\pi_1(\underline{\mathit{input}})/I]\} & I := T \{Q[I.\underline{\mathit{input}}/\underline{\mathit{input}}]\} \\
\{Q[\underline{\mathit{output}}.t/\underline{\mathit{output}}]\} & I := T \{Q\} 
\end{align*}
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
    3. $f$ ist strikt, wenn
        $$f(\bot_A) = \bot_B$$
    4. Die Menge aller stetigen Funktionen von $A$ nach $B$ wird wie folgt bezeichnet:
        $$[A \to B]$$

* **Lemma:** wenn $f \in [A \to B]$, dann ist $f$ auch monoton
* Klasse der stetigen Funktionen enthält:
    + Identitätsfunktionen:
        \begin{align*}
            \underline{\mathit{id}}_D : D &\to D\\
            x &\mapsto x
        \end{align*}
    + konstante Funktionen (für alle $d \in D_2$):
        \begin{align*}
            k_d : D_1 &\to D_2\\
            x &\mapsto d
        \end{align*}
    * uvm. (Komposition $f \circ g$, Substitution, Limesbildung $\bigsqcup F$)

Fixpunkte
---------
* **Fixpunktsatz:** 
    * Geg.: cpo $A$ und $f \in [A \to A]$
    * minimaler Fixpunkt von $f$, $\underline{\mathit{fix}}(f)$ existiert in $A$ und es gilt
        $$\underline{\mathit{fix}}(f) = \bigsqcup\limits_{v \in \mathbb N} f^v(\bot)$$


Elementare Bereiche
-------------------
### Flache cpos
* Geg.: $M$ bel. abzählbare Menge
* **flacher cpo:** 
    $$M_\bot = (M \cup \{\bot_M\}, \sqsubseteq_M)$$
  mit 
    1. $\forall m \in M \cup \{\bot_M\} : \bot_M \sqsubseteq_M m$ und
    2. $\forall m_1, m_2 \in M : m_1 \sqsubseteq m_2 \Leftrightarrow m_1 = m_2$
* z. B. semantischer Bereich $\mathbb N_\bot$), $\mathit{\overline{BOOL}} = \{\mathit{wahr}, \mathit{falsch}\}_\bot$

### Kartesische Produkte und Folgen
* Geg.: semantische Bereiche $D_1, ..., D_n, n \in \mathbb N$
* **kartesischer Produktbereich:**
    $$D = D_1 \times ... \times D_n = (\{\langle d_1, ..., d_n\rangle\ |\ d_i \in D_i\}, \sqsubseteq_D)$$
  mit
    $$\langle d_1, ..., d_n\rangle \sqsubseteq_D \langle d'_1, ..., d'_n\rangle \Leftrightarrow \forall 1 \leq i \leq n : d_i \sqsubseteq_D d'_i$$
* analog dazu **semantischer Bereich von endlichen Folgen über $D$:**
    $$D^* = (\{\langle d_i | d_i \in D, 1 \leq i \leq d_n\rangle\ |\ n \in \mathbb N\}, \sqsubseteq_{D^*})$$
  mit
    $$\langle d_i | 1 \leq i \leq n \rangle \sqsubseteq_{D^*} \langle d'_i | 1 \leq i \leq n\rangle \Leftrightarrow n \leq m \land \forall 1 \leq i \leq n : d_i \sqsubseteq_D d'_i$$
* analog dazu **semantischer Bereich von unendlichen Folgen über $D$:**
    $$D^\omega = (\{\langle d_i | d_i \in D, i \in \mathbb N\rangle\}, \sqsubseteq_{D^\omega})$$
  mit
    $$\langle d_i | i \in \mathbb N \rangle \sqsubseteq_{D^*} \langle d'_i | i \in \mathbb N\rangle \Leftrightarrow n \leq m \land \forall i \in \mathbb N : d_i \sqsubseteq_D d'_i$$

### Summen
* Geg.: semantische Bereiche $D_1, ..., D_n, n \in \mathbb N$
* **Summenbereich:**
    $$D = (D_1 + ... + D_n) = (\{(d,i)\ |\ d \in D_i, 1 \leq i \leq n\}, \sqsubseteq_D)$$
  mit
  $$\forall i, j \in \{1, ..., n\} : \bot_D = (\bot_{D_i}, i) \land (d,i) \sqsubseteq_D (d',j) \Leftrightarrow d = \bot_{D_i} \lor i = j \land d \sqsubseteq_{D_i} d'$$
* $(d,i)$ kann auch mit $d$ abgekürzt werden, wenn Zugehörigkeit zu $D_i$ ersichtlich

### Funktionen
* Geg.: semantische Bereiche $D_1$ und $D_2$
* **Funktionsbereich:**
    $$D = [D_1 \to D_2] = (\{f : D_1 \to D_2\ |\ \text{$f$ ist stetig}\}, \sqsubseteq_D)$$
  mit
  $$\forall f, g \in [D_1 \to D_2] \forall x \in D_1 : f \sqsubseteq_D g \Leftrightarrow f(x) \sqsubseteq_D g(x)$$

Getyptes Lambda Kalkül
----------------------
* Geg.: 
    - Menge von, unter $\times, *, \omega, +$ und $\to$, semantischen Bereichen $\mathcal D$
    - Familie getypter Variablen $\mathcal X = \{\mathcal X^D\ |\ D \in \mathcal D\}$
    - Familie getypter Konstanten $\mathcal K = \{\mathcal K^D\ |\ D \in \mathcal D\}$
    - $\mathcal X$ und $\mathcal K$ enthalten $\pi_i, \mathit{hd}, \mathit{tl}, \underline{\mathit{null}}, \underline{\mathit{cons}},
      \underline{\mathit{cons}}', \underline{\mathit{out}}_i, \underline{\mathit{in}}_i, \underline{\mathit{is}}_i, \underline{\mathit{curry}}$ (s. unten)
      und $\underline{\mathit{fix}}$ (s. oben)
* **Definition:** Menge der *getypten $\lambda$-Ausdrücke* über $\mathcal D, \mathcal X$ und $\mathcal K$ $\mathcal A_\lambda[\mathcal D, \mathcal X, \mathcal K]$
  ist definiert durch
    1. **Atome:**
        \begin{align*}
            \forall D \in \mathcal D, x \in \mathcal X^D : x : D \in \mathcal A_\lambda\ \text{und}\\
            \forall D \in \mathcal D, k \in \mathcal K^D : k : D \in \mathcal A_\lambda\ \text{und}\\
        \end{align*} 
    2. **Tupel:**
        $$\forall 1 \leq v \leq r, r \in \mathbb N: (t_v : D \in \mathcal A_\lambda \Rightarrow \langle t_1, ..., t_r \rangle : (D_1 \times ... \times D_r) \in \mathcal A_\lambda)$$
    3. **Applikationen:**
        $$t_1 : D' \to D \in \mathcal A_\lambda \land t_2 : D' \in \mathcal A_\lambda \Rightarrow (t_1t_2) : D \in \mathcal A_\lambda$$
    4. **Abstraktion:**
        (a) *monadisch:*
        $$(x \in \mathcal X^{D_1}) \land (t : D_2 \in \mathcal A_\lambda) \Rightarrow \lambda x.t : [D_1 \to D_2] \in \mathcal A_\lambda$$
        (b) *polyadisch:*
        $$(\forall 1 \leq v \leq r: x_v \in \mathcal X^{D_v}) \land (t : D \in \mathcal A_\lambda) \Rightarrow (\lambda (x_1, ..., x_r).t) : [(D_1 \times ... \times D_r) \to D] \in \mathcal A_\lambda$$
* **Definition:** Die Menge der *Umgebungen* $\mathcal U[\mathcal D, \mathcal X]$ ist die Menge aller typerhaltenden Abbildungen von $\bigcup \mathcal X$ nach $\bigcup \mathcal D$
* **Definition:** Eine Abbildung $\rho : \bigcup \mathcal X \to \bigcup \mathcal D$ heißt *typerhaltend*, wenn gilt
    $$\forall x \in \mathcal X^D, D \in \mathcal D : \rho(x)$$
* **Definition:** *modifizierte Umgebung* $\rho[d/x]$ entsteht aus Umgebung $\rho$: 
    $$\rho[d/x](y) = \begin{cases}
        d, & x = y\\
        \rho(y)
    \end{cases}$$
 * **Semantik der $\lambda$-Ausdrücke** implizit durch Funktion 
    $$\llbracket\ , \mathcal D \rrbracket : \mathcal U[ \mathcal D, \mathcal X ] \to \mathcal A_\lambda[\mathcal D, \mathcal X, \mathcal K] \to \bigcup \mathcal D$$
   bestimmt mit
    1. $\llbracket x, \mathcal D \rrbracket \rho = \rho(x)$ \
       $\llbracket k, \mathcal D \rrbracket \rho = k$
    2. $\llbracket \langle t_1, ..., t_r \rangle, \mathcal D \rrbracket \rho = \langle \llbracket t_1, \mathcal D \rrbracket \rho, ..., \llbracket t_r, \mathcal D \rrbracket \rho \rangle$
    3. $\llbracket (t_1t_2), D \rrbracket \rho = \llbracket t_1, \mathcal D \rrbracket \rho (\llbracket t_2, \mathcal D \rrbracket \rho)$
    4. $\llbracket \lambda x.t, \mathcal D \rrbracket \rho = d \mapsto \llbracket t, \mathcal D \rrbracket \rho[d/x]$\
       $\llbracket \lambda (x_1, ..., x_r).t, \mathcal D \rrbracket \rho = \langle d_1, ..., d_2 \rangle \mapsto \llbracket t, \mathcal D\rrbracket \rho[d_1, x_1]\cdots[d_r, x_r]$
 * wenn semantischer Bereich ersichtlich, wird $\llbracket\ , \mathcal D \rrbracket$ mit $\llbracket\ \rrbracket$ abgekürzt
 * **Lemma:** Sei $t \in \mathcal A_\lambda[\mathcal D, \mathcal X, \mathcal K]$, $D \in \mathcal D, x \in \mathcal X^D$ und $\rho \in \mathcal U[\mathcal D, \mathcal X]$ so gilt
    $$\llbracket t \rrbracket \rho \in D' \in \bigcup \mathcal D \Rightarrow \llbracket \lambda x.t \rrbracket \rho \in [ D \to D' ] \in \bigcup \mathcal D$$
   (Die Semantik der Abstraktion ist stetig)
 * **Lemma:** Sei $t \in \mathcal A_\lambda[\mathcal D, \mathcal X, \mathcal K]$, $D \in \mathcal D, \langle y_1, ..., y_r\rangle \in \mathcal X^r, r \in \mathcal{N}$ und $\rho \in \mathcal U[\mathcal D, \mathcal X]$ so ist die Funktion $\llbracket \lambda (y_1, ..., y_r).t \rrbracket \rho$ stetig.
 * **Satz:** $\llbracket\ \rrbracket$ ist typerhaltend und wohldefiniert.
 * **Definition** Die Menge der *freien Variablen* $\mathrm{Fr}(t)$ und *gebundenen Variablen* $\mathrm{Geb}(t)$, für $f \in \mathcal A_\lambda$ sind induktiv über den Aufbau von $t$ definiert:
    1. $\forall x \in \mathcal X^D, D \in \mathcal D : \mathrm{Fr}(t) = \{x\} \land \mathrm{Geb}(t) = \emptyset$ \
       $\forall k \in \mathcal K^D, D \in \mathcal D : \mathrm{Fr}(t) = \mathrm{Geb}(t) = \emptyset$
    2. $\mathrm{Fr}(\langle t_1, ..., t_r)\rangle) = \bigcup\limits_{1 \leq v \leq r} \mathrm{Fr}(t_v)$ \
       $\mathrm{Geb}(\langle t_1, ..., t_r)\rangle) = \bigcup\limits_{1 \leq v \leq r} \mathrm{Geb}(t_v)$
    3. $\mathrm{Fr}(t_1t_2) = \mathrm{Fr}(t_1) \cup \mathrm{Fr}(t_2)$ \
       $\mathrm{Geb}(t_1t_2) = \mathrm{Geb}(t_1) \cup \mathrm{Geb}(t_2)$ \
    3. $\mathrm{Fr}(\lambda x.t) = \mathrm{Fr}(t) \setminus \{x\}$ \
       $\mathrm{Geb}(\lambda x.t) = \mathrm{Geb}(t) \cup \{x\}$ \
       $\mathrm{Fr}(\lambda (x_1, ..., x_r).t) = \mathrm{Fr}(t) \setminus \{x_1, ..., x_r\}$ \
       $\mathrm{Geb}(\lambda (x_1, ..., x_r).t) = \mathrm{Geb}(t) \cup \{x_1, ..., x_r\}$
 * **Definition:** Die *Menge der Variablen* in $t$ ist $\mathrm{Var}(t) := \mathrm{Fr}(t) \cup \mathrm{Geb}(t)$ 
 * **Definition:** Der *Substitutionsoperator* $\$_s^x : \mathcal A_\lambda \to \mathcal A_\lambda$ ist induktiv definiert durch:  
    1. $\forall y \in \bigcup \mathcal X : \$_s^x y = \begin{cases}
            s, & x = y \\
            y
        \end{cases}$ \
       $\forall k \in \bigcup \mathcal K : \$_s^x k = k$
    2. $\$_s^x \langle t_1, ..., t_r\rangle = \langle \$_s^x t_1, ..., \$_s^x t_r\rangle$
    3. $\$_s^x (t_1t_2) = (\$_s^x t_1 \$_s^x t_2)$
    4. $\$_s^x \lambda y.t = \begin{cases}
            \lambda y.t, & x = y \\
            \lambda y.\$_s^x t
        \end{cases}$ \
       $\$_s^x \lambda (x_1, ..., x_r).t = \begin{cases}
            \lambda (x_1, ..., x_r).t, & x \in \{x_1, ..., x_r\} \\
            \lambda (x_1, ..., x_r).\$_s^x t
        \end{cases}$
 * **Definition:** Der *simultane Substitution* $\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} : \mathcal A_\lambda \to \mathcal A_\lambda$ ist induktiv definiert durch:  
    1. $\forall y \in \bigcup \mathcal X : \$_{s_1 \cdots s_r}^{x_1 \cdots x_r} y = \begin{cases}
            s_i, & \exists 1 \leq i \leq r : x_i = y \\
            y
        \end{cases}$ \
       $\forall k \in \bigcup \mathcal K : \$_{s_1 \cdots s_r}^{x_1 \cdots x_r} k = k$
    2. $\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} \langle t_1, ..., t_r\rangle = \langle \$_{s_1 \cdots s_r}^{x_1 \cdots x_r} t_1, ..., \$_{s_1 \cdots s_r}^{x_1 \cdots x_r} t_r\rangle$
    3. $\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} (t_1t_2) = (\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} t_1 \$_{s_1 \cdots s_r}^{x_1 \cdots x_r} t_2)$
    4. $\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} \lambda y.t = \begin{cases}
            \lambda y.\$_{s_1 \cdots s_{i-1} s_{i+1} \cdots s_r}^{x_1 \cdots x_{i-1} x_{i+1} \cdots x_r} t, & \exists 1 \leq i \leq r : x_i = y \\
            \lambda y.\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} t
        \end{cases}$ \
       $\$_{s_1 \cdots s_r}^{x_1 \cdots x_r} \lambda (z_1, ..., z_n).t = \begin{cases}
            \lambda (z_1, ..., z_n).t, & \{x_1, ..., x_r\} \subseteq \{z_1, ..., z_n\} \\
            \lambda (z_1, ..., z_n).\$_{s'_1 \cdots s'_q}^{x'_1 \cdots x'_q} t, & \{x_1, ..., x_r\} \setminus \{z_1, ..., z_n\} = \{x'_1, ..., x'_q\} \
        \end{cases}$
 * Geg.: $x, y, x_1, y_1, ..., x_r, y_r \in \bigcup \mathcal X, t,s \in \mathcal A_\lambda$ und $D, D^r \in \mathcal D$ 
    1. $\alpha$-Konversion (Variablenumbenennung):
        \begin{align*}
            y \notin \mathrm{Var}(t) &\Rightarrow & \lambda x.t &\xrightarrow{\alpha} \lambda y.\$_y^x t \\
            \{y_1, ..., y_r\} \cap \mathrm{Var}(t) = \emptyset &\Rightarrow & \lambda (x_1, ..., x_r).t &\xrightarrow{\alpha} \lambda (y_1, ..., y_r).\$_{y_1 \cdots y_r}^{x_1 \cdots x_r} t 
        \end{align*}
        wenn $x : D$ und $y : D$ bzw. $(x_1, ..., x_r) : D^r$ und $(y_1, ..., y_r) : D^r$
    2. $\beta$-Reduktion (Argumentsubstitution): 
        \begin{align*}
            \mathrm{Fr}(s) \cap \mathrm{Geb}(t) = \emptyset &\Rightarrow & (\lambda x.t)s &\xrightarrow{\beta} \$_y^x t \\
            \mathrm{Fr}(s_1 \cdots s_r) \cap \mathrm{Geb}(t) = \emptyset &\Rightarrow & (\lambda (x_1, ..., x_r).t)\langle s_1, ..., s_r\rangle &\xrightarrow{\beta} \$_{y_1 \cdots y_r}^{x_1 \cdots x_r} t 
        \end{align*}
    3. $\delta$-Reduktion (Konstantenreduktion)
         (a) Auswertung von Basisoperationen (z. B. $4 + 5 \xrightarrow{\delta} 9$)
         (b) Auswertungen von Kombinatoren (Konstanten höheren Typs) \
          (z. B. $\pi_3 \langle t, s, \underline{\mathit{mult}}\langle 2, 3\rangle, 1 \rangle \xrightarrow{\delta} \underline{\mathit{mult}}\langle 2, 3 \rangle$)
    4. $\eta$-Reduktion (Extensionalität)
        \begin{align*}
            \lambda x.(t x) \xrightarrow{\eta} t \\
            \lambda (x_1, ..., x_r).(t \langle x_1, ..., x_r \rangle) \xrightarrow{\eta} t
        \end{align*}
    5. $\lambda$-Reduktion (Vereinigung von $\xrightarrow{\alpha}$, $\xrightarrow{\beta}$, $\xrightarrow{\delta}$, $\xrightarrow{\eta}$)
        $$t \xrightarrow{\alpha} s \lor t \xrightarrow{\beta} s \lor t \xrightarrow{\delta} s \lor t \xrightarrow{\eta} s \Rightarrow t \rightarrow s$$
 * $\xrightarrow{*}$ ist die reflexive, transitive Hülle von $\rightarrow$
 * **Satz:** Seien $s, t \in \mathcal A_\lambda$: $t \xrightarrow{*} s \Rightarrow \llbracket t \rrbracket = \llbracket s \rrbracket$ ($\lambda$-Reduktionen sind semantikerhaltend) 
 * **Satz von Church/Rosser:** Seien $t, t_1, t_2 \in \mathcal A_\lambda$:
    $$t \xrightarrow{*} t_1 \land t \xrightarrow{*} t_2 \Rightarrow \exists s \in A_\lambda : t_1 \xrightarrow{*} s \land t_2 \xrightarrow{*} s$$

Direkte denotationelle Semantik
-------------------------------
* Problem beim Kompositionsoperator $f \circ g$: Semantik hat meist $\underline{\mathit{Fehler}}$ im Wertebereich, z. B.:
    $$f: D_1 \to (D_2 + \{\underline{\mathit{Fehler}}_\bot) \qquad g: D_2 \to (D_3 + \{\underline{\mathit{Fehler}}_\bot)$$
  $\Rightarrow$ $\star$-Operator
    1. Geg. $f: D_1 \to (D_2 + \{\underline{\mathit{Fehler}}\}_\bot)$ und $g : D_2 \to (D_3 + \{\underline{\mathit{Fehler}}\}_\bot)$
        $$f \star g = \lambda x . f\ x = \underline{\mathit{Fehler}} \longrightarrow \underline{\mathit{Fehler}}, f\ x = d \longrightarrow g\ d$$
    2. Geg. $f: D_1 \to ((D_2 \times ... \times D_n) + \{\underline{\mathit{Fehler}}\}_\bot)$ und $g : D_2 \to ... \to D_n \to (D_{n+1} + \{\underline{\mathit{Fehler}}\}_\bot)$
        $$f \star g = \lambda x . f\ x = \underline{\mathit{Fehler}} \longrightarrow \underline{\mathit{Fehler}}, f\ x = \langle d_2, ..., d_n \rangle \longrightarrow g\ d_2\ ...\ d_n$$

Fortsetzungssemantik
--------------------
* Nachteil an bisherigen Semantiktechniken: Umsetzung von 
  *Sprunganweisungen* und *gemeinsamen Speicherplätzen* schlecht bis gar 
  nicht möglich\
  $\Rightarrow$ für Verallgemeinerung von Sprunganweisungen: Fortsetzungsemantik
* Gemeinsame Speicherplätze: Aufspaltung der Bindung von Variablen an Werte: statt Bereich $\mathit{SPEICHER}$ zwei neue Bereiche:
    \begin{align*}
        \mathit{ENV} &= \mathit{ID} \to (\mathit{LOC} + \{\underline{\mathit{ungebunden}}\}_\bot)\ \text{und}\\
        \mathit{STORE} &= \mathit{LOC} \to (\mathbb Z_\bot + \{\underline{\mathit{frei}}\}_\bot)
    \end{align*}

Hilfsfunktionen
===============
* $\underline{\mathit{curry}}: (A \times B \to C) \to (A \to (B \to C))$, mit $\underline{\mathit{curry}}(f)(a)(b) := f\ a\ b$
* Projektion: 
\begin{align*}
\pi_i : (D_1 \times ... \times D_n)     & \to D_i \\
        \langle d_1, ..., d_n \rangle   & \mapsto d_i, \text{für $1 \leq i \leq n$}& \text{bzw.}\\\\
\pi_i : D^*                                     & \to D\\
        \langle d_v\ |\ 1 \leq v \leq n \rangle & \mapsto \begin{cases}
                d_i, & 1 < i < n \\
                \bot_D 
            \end{cases}& \text{und}\\\\
\pi_i : D^\omega                                & \to D\\
        \langle d_v\ |\ v \in \mathbb{N}\rangle & \mapsto d_i& \forall i \in \mathbb{N}\\
\end{align*}
* Listenoperationen:
    \begin{align*}
        \underline{\mathit{hd}} : D^* &\to D \\
        \langle d_v\ |\ 1 \leq v \leq n \rangle &\mapsto \begin{cases}
            d_1, & n \geq 1\\
            \bot_D, & n = 0
        \end{cases}\\\\
        \underline{\mathit{hd}} : D^\omega &\to D \\
        \langle d_v\ |\ v \in \mathbb N \rangle &\mapsto d_1\\\\
        \underline{\mathit{tl}} : D^* &\to D^* \\
        \langle d_v\ |\ 1 \leq v \leq n \rangle &\mapsto \begin{cases}
            \langle d_{v+1}\ |\ 1 \leq v \leq n-1\rangle, & n \geq 1\\
            \bot_{D^*}, & n = 0
        \end{cases}\\\\
        \underline{\mathit{tl}} : D^\omega &\to D^\omega \\
        \langle d_v\ |\ v \in \mathbb N \rangle &\mapsto \langle d_{v+1}\ |\ v \in \mathbb N \rangle\\\\
        \underline{\mathit{null}} : D^* &\to \overline{\mathit{BOOL}} \\
        \langle d_v\ |\ 1 \leq v \leq n \rangle &\mapsto \begin{cases}
            \mathit{wahr}, & n = 0\\
            \mathit{falsch}, & n > 0
        \end{cases}\\\\
        \underline{\mathit{length}} : D^* &\to \mathbb N_\bot \\
        \langle d_v\ |\ 1 \leq v \leq n \rangle &\mapsto n\\\\
        \underline{\mathit{cons}} : (D \times D^*) &\to D^* \\
        (d, \langle d_v\ |\ 1 \leq v \leq n \rangle) &\mapsto \langle d, d_1, ..., d_n \rangle\\\\
        \underline{\mathit{cons}} : (D \times D^\omega) &\to D^\omega \\
        (d, \langle d_v\ |\ v \in \mathbb N \rangle) &\mapsto \langle d, d_1, d_2, ... \rangle\\\\
        \underline{\mathit{cons'}} : (D^* \times D) &\to D^* \\
        (\langle d_v\ |\ 1 \leq v \leq n \rangle, d) &\mapsto \langle d_1, ..., d_n, d \rangle
    \end{align*}
* Abkürzung für $\underline{\mathit{cons}}(d, \langle d_1, ..., d_n\rangle)$: $d.\langle d_1, ..., d_n\rangle$
* Abkürzung für $\underline{\mathit{cons'}}(\langle d_1, ..., d_n\rangle,d)$: $\langle d_1, ..., d_n\rangle.d$
* All diese Funktionen erhalten die cpo-Struktur und sind stetig
* Selektionsfunktion:
    \begin{align*}
        \underline{\mathit{out}}_i (D_1 + ... + D_n) &\to D_i
        (d,j) &\mapsto \begin{cases}
            d, & i = j \\
            \bot_D
        \end{cases}
    \end{align*}
* Injektionsfunktion:
    \begin{align*}
        \underline{\mathit{out}}_i D_i &\to (D_1 + ... + D_n)
        d &\mapsto (d, i)
    \end{align*}
* Testfunktion:
    \begin{align*}
        \underline{\mathit{is}}_i (D_1 + ... + D_n) &\to \overline{\mathit{BOOL}}\\
        (d,j) &\mapsto \begin{cases}
            \mathit{wahr}, & i = j \land d \neq \bot \\
            \mathit{falsch}, & i \neq j \land d \neq \bot \\
            \bot_{\overline{\mathit{BOOL}}}, & d = \bot
        \end{cases} \text{bzw.}\\
        \underline{\mathit{is}}_{D_i} (D_1 + ... + D_n) &\to \overline{\mathit{BOOL}} \\
        (d,j) &\mapsto \begin{cases}
            \mathit{wahr}, & D_i = D_j \land d \neq \bot \\
            \mathit{falsch}, & D_i \neq D_j \land d \neq \bot \\
            \bot_{\overline{\mathit{BOOL}}}, & d = \bot
        \end{cases} \text{bzw.}
    \end{align*}
* Bedingte Verzeigung: $\forall D \in \mathcal D: \underline{\mathit{cond}} \in \mathcal K^{(D \times D) \to \overline{\mathit{BOOL}} \to D}$
    \begin{align*}
        \underline{\mathit{cond}} \langle d_1, d_2 \rangle b = \begin{cases}
            d_1, & b = \mathit{wahr} \\
            d_2, & b = \mathit{falsch} \\
            \bot
        \end{cases}
    \end{align*}
   Abkürzung: $b \longrightarrow d_1, d_2$
