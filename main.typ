#set page(paper:"a4")

#import "plotsy-3d.typ": *

#let size = 10
#let scale_factor = 0.17
#let (xscale,yscale,zscale) = (0.3,0.3,0.2)    
#let scale_dim = (xscale*scale_factor,yscale*scale_factor, zscale*scale_factor)
#let func(x,y) = calc.sin(x) +calc.cos(y) 

#figure(
  plot_3d_surface(
    func,
    samples: 1,
    render_step:1,
    scale_dim: scale_dim,
    xdomain: (-size,size),
    ydomain:  (-size,size),
    pad_high: (0,0,10),
    pad_low: (0,0,5),
    axis_step: (5,5,5),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.05,0.05),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 0.5em,
    axis_label_size: 1.5em,
  )
)

#let size = 10
#let scale_factor = 0.08
#let (xscale,yscale,zscale) = (0.3,0.3,0.05)
#let scale_dim = (xscale*scale_factor,yscale*scale_factor, zscale*scale_factor)  
#let func(x,y) = y*calc.sin(x) -x*calc.cos(y) 
#let color_func(x,y,x_max,y_max,zpoints) = {
  return oklab(10%,(x/x_max)*100%,150%,60%)
}
#figure(
  plot_3d_surface(
    func,
    color_func: color_func,
    samples: 2,
    render_step:1,
    scale_dim: scale_dim,
    xdomain: (-size,size),
    ydomain:  (-size,size),
    pad_high: (0,0,24),
    pad_low: (0,0,5),
    axis_step: (5,5,5),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.05,0.05),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 0.5em,
    axis_label_size: 1.5em,
  )
)




#let size = 5
#let scale_factor = 0.3
#let (xscale,yscale,zscale) = (0.3,0.3,0.05)
#let scale_dim = (xscale*scale_factor,yscale*scale_factor, zscale*scale_factor)  
#let func(x,y) = y*calc.sin(x) -x*calc.cos(y) 

#figure(
  plot_3d_surface(
    func,
    samples: 3,
    render_step:1,
    scale_dim: scale_dim,
    xdomain: (-size,size),
    ydomain:  (-size,size),
    pad_high: (0,0,24),
    pad_low: (0,0,5),
    axis_step: (3,3,3),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.05,0.05),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 0.5em,
    axis_label_size: 1.5em,
  )
)

#let size = 5
#let scale_factor = 0.3
#let (xscale,yscale,zscale) = (0.3,0.3,0.01)
#let scale_dim = (xscale*scale_factor,yscale*scale_factor, zscale*scale_factor)  
#let func(x,y) = -calc.exp(x) + 20*calc.cos(y)
#let color_func(x,y,x_max,y_max,zpoints) = {
  return oklab(10%,(x/x_max)*80%,120%,80%)
}
#figure(
  plot_3d_surface(
    func,
    samples: 3,
    render_step:1,
    scale_dim: scale_dim,
    xdomain: (1,size),
    ydomain:  (-size,size),
    pad_high: (0,0,24),
    pad_low: (0,0,5),
    axis_step: (3,3,20),
    dot_thickness: 0.05em,
    front_axis_thickness: 0.1em,
    front_axis_dot_scale: (0.05,0.05),
    rear_axis_dot_scale: (0.08,0.08),
    rear_axis_text_size: 0.5em,
    axis_label_size: 1.5em,
  )
)







