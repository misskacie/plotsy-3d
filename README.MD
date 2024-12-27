# The `plotsy-3d` Package
<div align="center">Version 0.1.0</div>

**plotsy-3d** is a [Typst](https://github.com/typst/typst) package for rendering 3D objects built on top of [CeTZ](https://github.com/cetz-package/cetz). Similar functionality to pgfplots for LaTeX but currently less developed.

Will be released on typst universe at some point but is not yet* so need to use `#import "plotsy-3d.typ": *` and have the `plotsy-3d.typ` file in your project folder.


## Features:

* 3D surface plotting of the form `z = f(x,y)` over a square region
* 3D parametric curve plotting with inputs `x(t), y(t), z(t)`

## Future Plans (contributors welcome):
- [ ] Vector Field Plotting
- [ ] Surface plotting over non square regions
- [ ] User Manual
- [ ] Make the code nicer
<!-- 
## Getting Started

These instructions will get you a copy of the project up and running on the typst web app. Perhaps a short code example on importing the package and a very simple teaser usage.

```typ
#import "@preview/plotsy-3d:0.1.0": *

#show: my-show-rule.with()
#my-func()
```

### Installation

A step by step guide that will tell you how to get the development environment up and running. This should example how to clone the repo and where to (maybe a link to the typst documentation on it), along with any pre-requisite software and installation steps.

```
$ First step
$ Another step
$ Final step
``` -->

## Usage

A more in-depth description of usage. Any template arguments? A complicated example that showcases most if not all of the functions the package provides? This is also an excellent place to signpost the manual.
### Parametric Function Plotting
```typ
#import "plotsy-3d.typ": *

#let xfunc(t) = 15*calc.cos(t)
#let yfunc(t) = calc.sin(t)
#let zfunc(t) = t


#plot_3d_parametric_curve(
    xfunc,
    yfunc,
    zfunc,
    subdivisions:10,
    scale_dim: (0.03,0.05,0.05),
    tdomain:(0,10),
    axis_step: (5,5,5),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.04, 0.04),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 0.5em,
    axis_label_size: 1.5em,
    rotation_matrix: ((-2, 2, 4), (0, -1, 0)) 
  )
```

### 3D Surface Plotting
```typ
#import "plotsy-3d.typ": *
#let size = 5
#let scale_factor = 0.3
#let (xscale,yscale,zscale) = (0.3,0.3,0.05)
#let scale_dim = (xscale*scale_factor,yscale*scale_factor, zscale*scale_factor)  
#let func(x,y) = y*calc.sin(x) -x*calc.cos(y) 
#let color_func(x, y, z, x_lo,x_hi,y_lo,y_hi,z_lo,z_hi) = {
  return purple.transparentize(20%).darken((z/(z_hi - z_lo)) * 300%)
}

#plot_3d_surface(
    func,
    color_func: color_func,
    subdivisions: 5,
    subdivision_mode: "increase",
    scale_dim: scale_dim,
    xdomain: (-size,size),
    ydomain:  (-size,size),
    pad_high: (0,0,3),
    pad_low: (0,0,0),
    axis_step: (3,3,3),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.05,0.05),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 1em,
    axis_label_size: 1.5em,
    axis_label_offset: (0.2,0.1,0.1),
    axis_text_offset: 0.045,
  )
```


