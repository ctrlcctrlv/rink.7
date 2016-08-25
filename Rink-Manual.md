# Introduction

Rink is a unit conversion and calculation tool which can be used for both small and simple arithmetic and more complex dimensionality analysis and other tasks. In this manual, each section will have examples of the discussed material at the top.

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

# Expressions

## Multiplication
```
> 3 4 m 5 s
60 m s
> 3 * 4 m 5 s
60 m s
```

Multiplication can be either by juxtaposition (that is, without any symbol) or using an explicit * operator.

## Division
```
> 10 km / (5 m)
2000 (dimensionless)
```

Division currently has the same precedence as multiplication, and is evaluated left to right.

## Addition, Subtraction
```
> 1 * 2 + 1 * 2
4 (dimensionless)
> 12 meters + 5 feet
13.524 m (length)
```

These have lower precedence than multiplication and subtraction.

## Temperatures
```
> 12 °C
285.15 K (temperature)
```

Temperature scales are operators with higher precedence than addition, and lower than multiplication.

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

## Powers
```
> 12 ft^2
435483/390625, approx. 1.114836 m^2 (area)
```

Powers have higher precedence than multiplication.

## Inline unit definitions
```
> ton -> rock = 10kg
45359237/500000, approx. 90.71847 rock (mass)
```

Allows you to define new units, which is only really useful in the right-hand side of a conversion.

## Custom base units
```
> 12 'core' hour / (3 'core') -> minutes
240 minutes (time)
```

These can be used to introduce "types" of a sort into calculations, which can be useful for reasoning about them.

# Units and prefixes

Units can be prefixed with SI prefixes as well as a number of non-SI prefixes, such as: quarter, double, kibi, mebi, ⅞.

Rink will accept plural units.

# Top-level statements

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

## Unit finding
```
> units for power
Units for kg m^2 / s^3 (power): VA, airwatt, boilerhorsepower, brhorsepower,
donkeypower, electrichorsepower, horsepower, lusec, mbh, metrichorsepower,
poncelet, sccm, sccs, scfh, scfm, slph, slpm, solarluminosity,
tonrefrigeration, waterhorsepower, watt
```

The `units for`, `units of`, and `units` commands will find more units which match the dimensionality of the one specified.

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

# Index of Units

The full list of units is specified in the file [`definitions.units`](https://github.com/tiffany352/rink-rs/blob/master/definitions.units), but a small list of the most helpful ones will be listed here. It is intended that most units should be easy to guess the names of.

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
- Density of water `water`
- Density of mercury `Hg`
