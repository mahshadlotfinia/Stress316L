# Mathematical-Simulation-Part-of-the-Master-thesis.

Numerical Analysis of Roll Deflection during Plate Rolling using Finite Element Methods &amp; Artificial

1-1 Introduction

In Mathematical Simulation Part of my Master thesis, the work-roll deflection during multi-pass rolling operations was predicted employing a combined model using finite element method, artificial neural network (ANN) and finite difference scheme. The ANN modeling was utilized for calculating the flow stress of the steel being rolled while the mean pressure was calculated based on cold rolling theories coupled with the finite difference approach. Finally, the work-roll deflection was determined by means of the predicted mean roll pressure and finite element formulation.  It was found that that an increase in the number of passes as well as reducing rolling temperature led to an increase in work-roll the deflection.

1-2 Cold Rolling of Strips

We shall investigate the process in which a metal sheet or strip is reduced in thickness by passing it between a pair of cylindrical rolls shaving their axes parallel to one another. In cold rolling, the radius R of the rolls is usually more than 50 times the initial strip thickness. If the width of the strip is at least ﬁve times the length of the arc of contact, the non-plastic material prevents the lateral spread, and the deformation takes place effectively under plane strain condition. Due to the pressure of the rolled stock, the rolls are themselves ﬂattened so as to increase the arc of contact by as much as 20 to 25 percent or even more. It will be assumed, for simplicity, that the part of the rolls in contact with the strip is deformed into a cylindrical surface of a larger radius R/.

https://github.com/mahshadlotfinia/Mathematical-Simulation-Part-of-the-Master-thesis./issues/1#issue-794019814
Since the volume of the material passing through each vertical plane per unit time is the same, the speed of the strip steadily increases as it moves through the roll gap. On the entry side, the peripheral speed of the rolls is higher than that of the strip, and consequently the frictional forces draw the strip into the roll gap. On the exit side, the strip moves faster than the rolls, and the frictional forces therefore oppose the delivery of the strip. It follows that there is a neutral point N somewhere on the arc of contact where the strip moves at the same speed as that of the rolls.
1-3 Equation of Equilibrium
It is assumed at the outset that each element of the strip is uniformly compressed between the rolls while passing through the roll gap. The vertical compression of the strip is accompanied by a horizontal force which is increasingly compressive as the neutral point is approached from either side. the equation of equilibrium may be written as:

d/dϕ (hp)=2qR^՛ (sinϕ∓µcosϕ)  

Where the upper sign applies to the exit side and the lower sign to the entry side of the neutral point. We now assume that the material is everywhere plastic between the planes of entry and exit, and the principal compressive stresses at each point on a vertical section are approximately equal to p and q. Then the yield criterion may be written in the form:

q-p =2k

Where the shear yield stress k generally varies along the arc of contact. The value of 2k at a generic point on the arc of contact is approximately equal to the ordinate of the compressive stress–strain curve, obtained under plane strain condition, corresponding to an abscissa equal to ln(h1/h). Alternatively, the variation of the yield stress can be estimated by rolling a length of the strip in a succession of passes and carrying out a tensile test at the end of each pass. This gives the tensile yield stress √3k as a function of the thickness ratio h/h1. since the angle of contact is small, we arrive at the governing equation:

d/dϕ (q-2k)∓2μR^՛ q=4kR^՛ ϕ

d/dϕ (q-2k)∓2μR^՛ q=4kR^՛ ϕ	1-3

Where:

h=h_2+2R^՛ (1-cos⁡〖ϕ)≃h_2 〗+R^՛ ϕ^2

1-4 Finite Difference Formulation

In order to solve 1-3 equation by Finite Difference method, 3-5 equation is obtained by Forward Difference approach for the exit side (when  p=0  then 2k=q_0). By using the initial and final strip thickness in 1-4 equation  ϕ_1 for first step is obtained.

(h_i (q_(i+1)-2k_(i+1)-q_i+2k_i))/(ϕ_(i+1)-ϕ_i )+2μRq_0=4kRϕ_i

Like the exist side the Forward Difference approach is used for entry side. The equation of entry side may be written as below:

(h_i (q_(i+1)-2k_(i+1)))/ϕ_(i+1) -2μRq_0=0

After that, in every thickness the amount of pressure update until the final thickness. When the amount of calculated pressure in tow mentioned side are equal, it can be assumed as Neutral point pressure at corresponded degree. 

1-5 Artificial Neural Network

In any stage of thickness reduction, the flow stress is different. Therefore, artificial neural network (ANN) is utilized for calculating the flow stress. By conducting mechanical tensile test in different strain rate and temperature, the needed data have been obtained. 

![](https://github.com/mahshadlotfinia/Mathematical-Simulation-Part-of-the-Master-thesis./issues/3#issue-794027014)

Back propagation method and linear function have been used for creating artificial neutral network while:

https://github.com/mahshadlotfinia/Mathematical-Simulation-Part-of-the-Master-thesis./issues/4#issue-794028300

Finally, the below equation can be used for calculating the mean pressure that is going to be used for the work-roll deflection during multi-pass rolling operations.

P ̅=(∫_α^0▒〖q dϕ〗)/Δϕ

Finally, the work-roll deflection was determined by means of the predicted mean roll pressure and finite element formulation (Galerkin) as below:

d^2/〖dx〗^2  (EI (d^2 w )/(dx^2 ))=p(x)

Where:

I=(πd^4)/64

1-6 Finite Element Formulation
Cantilevered Beam is used as Boundary condition. 

K^e a^e=f^e               

