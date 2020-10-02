Rink's unit definitions are currently stored in [`rink-core/definitions.units`](https://github.com/tiffany352/rink-rs/blob/master/core/definitions.units). They are in a special format that's a bit different from the normal query language. This is mainly for backwards compatibility with the original source of the file (GNU Units).

## Fundamentals

* Comments start with `#` and continue to the end of the line.
  ```
  # This line is a comment
  # And so is this
  ```
* Normal unit definitions are the name of the unit and the expression used to define it, separated by spaces. 
  ```
  foot                    12 inch
  ```
* Documentation comments are lines starting with `??`. They apply to the next definition following them. They are shown to end users in Rink when you query a definition.
  ```
  ?? International yard and pound, since July 1, 1959.
  foot                    12 inch
  ```

## Expression syntax

The expression syntax is similar to Rink's input language. Simple expressions like multiplication and division should work as expected. If there are any problems they should show up once you run Rink locally and try to use the units you've defined.

## Guidelines

### Documentation

New units should generally have a citation for where they come from, listed in the documentation comment. Ideally this should also include a date for when the unit was standardized.

If it's not obvious what the unit is for, then include an explanation in the doc comment. This can be left out if it's implied by the name or definition of the unit.

If there are multiple ways to interpret how a unit should be defined, then mention which interpretation is being used. Unless it's implied by the name (e.g. `siderealyear`). Examples where units have multiple interpretations include:

- Customary units may vary by country, and may even vary depending on which year in that country. Such as US, British, Australian, and International definitions of the foot.
- Units that are inherently fuzzy or represent multiple sources. This may include days (calendar, sidereal), years (calendar, sidereal, tropical), and others.

Doc comments should be written in US English. They should have sentence capitalization and full stops, like this guide is written in. Avoid run-on sentences.

External links should include the protocol part (`https://`, `http://`). They should be wrapped like `<https://example.com>`.

Dates should be written in a longhand format such as `July 5th, 1982`. Exact time of day should only be included if it's important.

### Naming Conventions

- English names that are lowercase without separators. Words may be separated by underscores when it adds clarity. Examples include `foot`, `olympiccubit`, `usgallon`.
- Units typically written in non-Latin script. Examples include `золотник`, `分地`. Include an alias that can be typed on a US keyboard layout.
- Units typically written with a symbol. Examples include `π` (Pi), `τ` (Tau). Include an alias that can be typed on a US keyboard layout.
- Uncommon symbols such as `㎒` (Unicode symbol for Megahertz). These should only be included as aliases.
- Shorthands. Examples include `ft` for `foot`, `B` for `byte`. These should be an alias pointing to the long form name. These help make Rink more intuitive when you're not sure what the exact name is.

If there are multiple names for a unit, then the one that's most typical should be the "canonical name". The canonical version should have the full definition, and the other names should be added as aliases pointing to the canonical version. Avoid making duplicates of the same unit.

Units should be defined in terms of other related units when possible. The expression you use to define the unit will be visible to the end user. For example, a foot is defined as `12 inch` rather than as `304.8 mm`. This is because there is already a separate entry for `inch` defined as `2.54 mm`. When displaying a unit's definition, Rink shows both the original definition as well as the absolute value. So for `foot` it shows that it's defined as `12 inch` which equals `304.8 millimeter`.

 Rink can represent arbitrary precision of a number. The only limitation is how much memory is available. Because of this:

- For mathematical constants that represent an infinite series, like Pi or Euler's constant. These should be defined to at least 20 digits.
- For universal constants that are measured experimentally, like the Planck length. These should have as many significant figures as are currently known (often around 10 digits).

Comments in the definitions file are written for the benefit of other maintainers. They can include explanations for why units are defined a certain way. They can also state that certain units are part of a group or set.

## Other constructs

Most of these don't need to be added often, but they are documented here for completeness.

### Substances

Substances can represent either a specific object (such as the Earth, or the Sun), a material such as water or concrete, a chemical molecule, and a few other things.

```
neutron {
    mass                const neutron_mass          1.00866491588 u
    wavelength          const neutron_wavelength    planck_constant / mass c
    magnetic_moment     const neutron_moment        -0.96623650e-26 J/T
}
```

Their syntax is a bit complex. Inside of the `{}` brackets are a set of properties that the substance has. These can be either constants (as in the case of properties of a single object such as a neutron) or ratios (such as the density of water).

The two syntax variants are:

```
[name] const [output name] [expression]
```

and:

```
[name] [input name] [input expression] / [output name] [output expression]
```

### Pragmas

The only significant ones are `!category` and `!endcategory`. All units that are between these two pragmas will be grouped together in the UI when doing searches and other operations.

```
!category us_survey "US Survey Measures"
```

When adding new units, it's recommended to search around for a fitting category to add them into. If adding multiple units from a common set, then making a new category might be appropriate.

The remaining pragma types are ignored by the parser.

### Base Units

```
?? Equal to the mass of the international prototype of the
?? kilogram. 3rd CGPM (1901, CR, 70).
kg        !kilogram
```

Base units are impossible to define in terms of another unit without creating a cycle. They represent fundamental physical quantities such as time, length, temperature, etc.

The name is a shorthand form which is used when showing dimensionality (for example, the dimensionality of `acceleration` is `m / s^2`), while the long form is used for display purposes.

These should not be added frequently, but in some cases it's useful to. Examples that have been added so far:
- Musical notes
- Information (bits)
- Radians (angles)

### Dimensions

These are closely related to base units. For example, meters (a base unit) are the base unit of length (a dimension), seconds are the base unit of time, etc.

```
length                  ? meter
```

### Prefixes

Prefixes allow input of units like "gigabytes", "megameters", "kiloseconds" without needing to explicitly define each one manually.

These should not be added frequently, only when it's relevant to some counting system. Examples include power of two byte prefixes (MiB, GiB, etc.) and Dozenal prefixes.

```
kilo-                   1e3
```

There's also a second type of prefix, called a "short prefix" or SPrefix.

```
k--                     kilo
```

These are a shorthand of a longer prefix which let you input units like `MB` to mean `megabytes`.
