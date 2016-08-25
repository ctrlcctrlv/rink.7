# Introduction

Rink is a unit conversion and calculation tool which can be used for both small and simple arithmetic and more complex dimensionality analysis and other tasks. In this manual, each section will have examples of the discussed material at the top.

# Table of Contents
1. [Working with units](#working_with_units)
2. [Expressions](#expressions)
    1. [Multiplication](#expressions.multiplication)
    2. [Division](#expressions.division)
    3. [Addition, Subtraction](#expressions.addition)
    4. [Temperatures](#expressions.temperatures)
    5. [Numbers](#expressions.numbers)
    6. [Powers](#expressions.powers)
    7. [Inline unit definitions](#expressions.inline)
    8. [Custom base units](#expressions.custom)
3. [Units and prefixes](#prefixes)
4. [Top-level statements](#toplevel)
    1. [Conversions (->)](#toplevel.conversions)
        1. [Unit lists](#toplevel.conversions.lists)
        2. [Temperature](#toplevel.conversions.temperature)
    2. [Unit finding](#toplevel.finding)
    3. [Factorization](#toplevel.fact)
5. [Dates](#dates)
6. [Index of Units](#index)
    1. [Official SI Derived Units](#index.derived)
    2. [Constants](#index.constants)


<a name="working_with_units" />
# Working with units

In order to understand Rink, an understanding of units themselves is required. Fundamentally, a *unit* is a way of assigning a concrete value to a specific *quantity* such as length, volume, energy, power, current, etc. Each *quantity* can be reduced into other quantities (for example, area is length x length), except for 7 *base units*.

The 7 *base units* (as well as their SI *units*):
- Length (meters)
- Time (seconds)
- Mass (kilograms)
- Current (amperes)
- Temperature (kelvin)
- Amount of Substance (mol)
- Human-subjective brightness of light (candela)

In addition, Rink defines a few non-SI base units:
- Money (US dollar)
- Information (bit)
- Radian
- Steradian
- Musical note length (wholenote)

Each of these quantities is treated as irreducible. The 7 base units are the foundations of SI, and customary systems as well. (Customary systems are defined in terms of SI.)

Every *unit* is composed of two parts: A numerical value, and its *dimensionality*. The dimensionality is how a unit relates itself to the *base units*. Each base unit is raised to a certain power to construct the dimensionality. For example, the dimensionality of the quantity of acceleration is length^1 * time^-2 and then the rest of the base units are to the 0th power, which is to say that they do not matter. Two units are considered *conformable* if they have matching dimensionalities, and they can then be used in conversions.

Because each unit has a numerical part, it is possible to do normal math on them. 

- Adding two units produces a new unit with matching dimensionality. 
- Multiplying two units produces a new unit with its dimensionality as each base unit multiplied together, e.g. velocity (length time^-1) * hertz (time^-1) = acceleration (length time^-2).
- Dividing two units is like multiplication, but taking away from the base units. A unit divided by itself is *dimensionless*, it has no quantity. Normal numbers are dimensionless.

Because of this, units are essentially just numbers. As such, Rink is essentially a calculator which takes dimensionality into account.

<a name="expressions" />
# Expressions

<a name="expressions.multiplication" />
## Multiplication
```
> 3 4 m 5 s
60 m s
> 3 * 4 m 5 s
60 m s
```

Multiplication can be either by juxtaposition (that is, without any symbol) or using an explicit * operator.

<a name="expressions.division" />
## Division
```
> 10 km / 5 m
2000 (dimensionless)
> 1|2 m
0.5 m (length)
```

There are two division operators, for separate purposes. `/` has lower precedence than multiplication, and is used mainly for separating two halves of an entire expression. `|` has higher precedence than multiplication, and is used mainly for fractions of integers.

<a name="expressions.addition" />
## Addition, Subtraction
```
> 1 * 2 + 1 * 2
4 (dimensionless)
> 12 meters + 5 feet
13.524 m (length)
```

These have lower precedence than multiplication and subtraction.

<a name="expressions.temperatures" />
## Temperatures
```
> 12 °C
285.15 K (temperature)
```

Temperature scales are operators with higher precedence than addition, and lower than multiplication. See the section on [temperature conversions](#toplevel.conversions.temperature) for more detailed syntax.

<a name="expressions.numbers" />
## Numbers
```
> 9999999999999
approx. 9.99999e12 (dimensionless)
> 1.001
1.001 (dimensionless)
> 1e100
1.0e100 (dimensionless)
```

Numbers can be written with a fraction, and can be written in scientific notation. `1e24` is short for `1 * 10^24`.

<a name="expressions.powers" />
## Powers
```
> 12 ft^2
435483/390625, approx. 1.114836 m^2 (area)
```

Powers have higher precedence than multiplication.

<a name="expressions.inline" />
## Inline unit definitions
```
> ton -> rock = 10kg
45359237/500000, approx. 90.71847 rock (mass)
```

An equals expression is one which simultaneously defines a new unit with the right-hand side, names it using the left-hand side, and then produces it as its result. This is useful for customizing the output of the right-hand side of a conversion or converting into things that don't currently have units such as the amount of calories in a potato.

<a name="expressions.custom" />
## Custom base units
```
> 12 'core' hour / 3 'core' -> minutes
240 minutes (time)
```

A unit name which is wrapped in quotation marks will not be checked for whether it exists when it is evaluated. This means you can wrap anything in quotes to in effect produce a new *base unit* for the purposes of a single calculation. This can be useful for doing calculations in terms of things which are otherwise dimensionless.

<a name="prefixes" />
# Units and prefixes

Units can be prefixed with SI prefixes as well as a number of non-SI prefixes, such as: quarter, double, kibi, mebi, ⅞.

Rink will accept plural units.

<a name="toplevel" />
# Top-level statements

<a name="toplevel.conversions" />
## Conversion (->)
```
> meter -> feet
3.280839 foot (length)
> 12 °C -> °F
53.6 °F (temperature)
```

The left hand side of the conversion is an arbitrary expression, and the right hand side is one of:

- An arbitrary expression
- A temperature scale (celsius, fahrenheit, and several historical scales)
- A unit list (e.g. hour;min;sec)

<a name="toplevel.conversions.lists" />
### Unit lists
```
> 2^17 seconds -> hour;min;sec
36 hour, 24 minute, 32 s (time)
> 2 km -> mi;ft
1 mile, 1281.679 foot (length)
> liter -> cup;tbsp;tsp
4 uscup, 3 ustablespoon, 1.884136 usteaspoon (volume)
```

A unit list is a comma- or semicolon- delimited list of units with the same dimensionality, which can be used for breaking down numbers into more familiar quantities.

<a name="toplevel.conversions.temperature" />
### Temperature
```
> 12 °C
285.15 K (temperature)
> 12 degC
285.15 K (temperature)
> 12 celsius
285.15 K (temperature)
```

Temperature scales in Rink are handled a little specially, because only Kelvin and Rankine (the absolute zero version of Fahrenheit) start at absolute zero. As such, they are *operators*, not units. These operators have looser binding precedence than multiplication, but tighter than addition.

Available temperature scales:
- `degC`, `°C`, `celsius`, `℃`: **Celsius**, the standard scale in most countries.
- `degF`, `°F`, `fahrenheit`, `℉`: **Fahrenheit**, the scale used in households across the United States.
- `degRé`, `°Ré`, `degRe`, `°Re`, `réaumur`, `reaumur`: **Réaumur**: A historical scale once used throughout Europe.
- `degRø`, `°Rø`, `degRo`, `°Ro`, `rømer`, `romer`: **Romer**: Yet another historical scale.
- `degN`, `°N`, `degnewton`: **Newton**: A historical scale created by Isaac Newton.
- `degDe`, `°De`, `delisle`: **Delisle**: A historical scale which, alongside the original Celsius scale, is reversed from the scales we are used to today. Its zero point is boiling water, and the freezing point of water is 150°De.

Note that these temperature scale measurements are *absolute* measurements, not *differences*. If you wish to say something like "a difference of 1°C", then you must use the absolute scale for the scale you're using. These are:
- For Celsius, kelvin `K`
- For Fahrenheit, Rankine `degR`
- For Réaumur, `reaumur_absolute` (absolute as in the zero point is absolute zero)
- For Rømer, `romer_absolute`
- For Newton, `newton_absolute`
- For Delisle, `delisle_absolute`

<a name="toplevel.finding" />
## Unit finding
```
> units for power
Units for kg m^2 / s^3 (power): VA, airwatt, boilerhorsepower, brhorsepower,
donkeypower, electrichorsepower, horsepower, lusec, mbh, metrichorsepower,
poncelet, sccm, sccs, scfh, scfm, slph, slpm, solarluminosity,
tonrefrigeration, waterhorsepower, watt
```

The `units for`, `units of`, and `units` commands will find more units which match the dimensionality of the one specified.

<a name="toplevel.fact" />
## Factorization
```
> factorize velocity
Factorizations: velocity;  frequency length;  area viscosity;
acceleration time;  length^2 viscosity
> factorize power
Factorizations: power;  force velocity;  radiant_intensity solid_angle;
area radiosity;  length spectral_flux_wavelength;  radiation_dose spectral_exposure_frequency;
spectral_irradiance_wavelength volume;  temperature thermal_conductance;
energy frequency;  current^2 resistance;  ...
```

Unit factorization is what Rink names the process of finding quantities which can be multiplied together to produce the original quantity. This can be useful for discovering new ways to construct a unit.

<a name="dates" />
# Dates
```
> #jan 01, 1970#
1970-01-01 00:00:00 +00:00 (46 years ago)
> now - #jan 01, 1970# -> gigaseconds
1.472083 gigas (time)
> #2016-08-24# + 500 weeks
2026-03-25 00:00:00 +00:00 (in 9 years)
```

In addition to handling units, Rink is also capable of doing some calculations with dates and times.

<a name="index" />
# Index of Units

The full list of units is specified in the file [`definitions.units`](https://github.com/tiffany352/rink-rs/blob/master/definitions.units), but a small list of the most helpful ones will be listed here. It is intended that most units should be easy to guess the names of.

<a name="index.derived" />
## Official SI Derived Units
- Newton `N` (force)
- Pascal `Pa` (pressure)
- Joule `J` (energy)
- Watt `W` (power)
- Coulomb `C` (charge)
- Volt `V` (electrical potential)
- Ohm (electrical resistance)
- Siemens `S` (electrical conductance)
- Farad `F` (capacitance)
- Weber `Wb` (magnetic flux)
- Henry `H` (inductance)
- Tesla `T` (magnetic flux density)
- Hertz `Hz` (frequency)

<a name="index.constants" />
## Constants
- Pi `pi`
- Speed of light `c`
- Electron Charge `electroncharge`
- Planck Constant `planck_constant`
- Gravitational Constant `G`
- Avogadro's number `avogadro`
- Gas Constant `gasconstant`
- Boltzmann Constant `boltzmann`
- Earth Gravity `gravity`, `force`
- Earth Atmosphere Density `atm`
- Pressure of a water column per length `water`
- Density of water `waterdensity`
- Pressure of a mercury column per length `Hg`
