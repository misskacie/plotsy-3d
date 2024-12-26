#import "@preview/cetz:0.3.1": canvas, draw, matrix

#let render_rear_axis(
  axis_low:(0,0,0),
  axis_high: (10,10,10),
  axis_step:(5,5,5),
  axis_dot_scale: (0.08,0.08),
  dot_thickness:0.05em,
  axis_text_size: 1em
  ) = {
    import draw: *
    let (xaxis_low,yaxis_low,zaxis_low) = axis_low
    let (xaxis_high,yaxis_high,zaxis_high) = axis_high
    let (xaxis_step,yaxis_step,zaxis_step) = axis_step

    let xaxis_stroke = (paint:black, dash: (axis_dot_scale.at(0) *1em, axis_dot_scale.at(1) *1em))
    let yaxis_stroke = (paint:black, dash: (axis_dot_scale.at(0) *1em, axis_dot_scale.at(1) *1em))
    let zaxis_stroke = (paint:black, dash: (axis_dot_scale.at(0) *1em, axis_dot_scale.at(1) *1em))

    set-style(
      stroke:(thickness: dot_thickness)
    )

    for xoffset in range(xaxis_high - xaxis_low, step:xaxis_step) {
      let xcoord = xaxis_low + xoffset
      line(
        (xaxis_low+xoffset,yaxis_low,zaxis_low),
        (xaxis_low+xoffset,yaxis_high,zaxis_low),
        stroke: yaxis_stroke
      )
      content((), text(size:axis_text_size)[#xcoord], anchor:"north",padding: 0.2em)
      line(
        (xaxis_low+xoffset,yaxis_low,zaxis_low),
        (xaxis_low+xoffset,yaxis_low,zaxis_high),
        stroke:zaxis_stroke
      )
    }

    for yoffset in range(yaxis_high - yaxis_low, step:yaxis_step) {
      let ycoord = yaxis_low + yoffset
      line(
        (xaxis_low,ycoord,zaxis_low),
        (xaxis_high,ycoord,zaxis_low),
        stroke: xaxis_stroke
      )
      content((), text(size:axis_text_size)[#ycoord], anchor: "west", padding: 0.2em)
      line(
        (xaxis_low,ycoord,zaxis_low),
        (xaxis_low,ycoord,zaxis_high),
        stroke:zaxis_stroke
      )
    }

    for zoffset in range(zaxis_high - zaxis_low, step:zaxis_step) {
      let zcoord = zaxis_low + zoffset
      line(
        (xaxis_low,yaxis_low,zcoord),
        (xaxis_low,yaxis_high,zcoord),
        stroke:yaxis_stroke
      )
      content((), text(size:axis_text_size)[#zcoord], anchor: "east", padding: 0.2em)
      line(
        (xaxis_low,yaxis_low,zcoord),
        (xaxis_high,yaxis_low,zcoord),
        stroke:xaxis_stroke
      )
    }


    line(
      (xaxis_high,yaxis_low,zaxis_low),
      (xaxis_high,yaxis_low,zaxis_high),
      stroke: zaxis_stroke
    )
   // content((), [], anchor: "east", padding: 2em)
    

    line(
      (xaxis_low,yaxis_low,zaxis_high),
      (xaxis_high,yaxis_low,zaxis_high),
      stroke: xaxis_stroke
    )
    content((), [], anchor: "west", padding: 2em)

    line(
      (xaxis_low,yaxis_low,zaxis_high),
      (xaxis_low,yaxis_high,zaxis_high),
      stroke: yaxis_stroke
    )
    content((), text(size:axis_text_size)[#zaxis_high], anchor: "east", padding: 0.2em)

    line(
      (xaxis_low,yaxis_high,zaxis_low),
      (xaxis_high,yaxis_high,zaxis_low),
      stroke:none
    ) //x
    content((), text(size:axis_text_size)[#xaxis_high], anchor: "north", padding: 0.2em)
    

    line(
      (xaxis_high,yaxis_low,zaxis_low),
      (xaxis_high,yaxis_high,zaxis_low),
      stroke:none
    ) //y
    content((), text(size:axis_text_size)[#yaxis_high], anchor: "west", padding: 0.2em)

    

}


#let get_surface_zpoints(
  func, render_step: 1,
  samples: 1,
  xdomain:(0,10),
  ydomain: (0,10),
  axis_step: (5,5,5)
  ) = {
    import draw: *
    let (xaxis_low,xaxis_high) = xdomain
    let (yaxis_low,yaxis_high) = ydomain
    let (zaxis_low, zaxis_high) = (0,0)
    let zpoints = ()
    let step = 1/samples
    let x_count = (xaxis_high - xaxis_low) * samples
    let y_count = (yaxis_high - yaxis_low) * samples

    for xregion in range(xaxis_low * samples, xaxis_high * samples + render_step) {
      let zpoints_temp = ()
      for yregion in range(yaxis_low * samples, yaxis_high * samples + render_step) {
        let x = xregion * step
        let y = yregion * step
        let z = func(x,y)

        zpoints_temp.push(z)
      }
      zpoints.push(zpoints_temp)
      let possible_min = calc.min(..zpoints_temp)
      let possible_max = calc.max(..zpoints_temp)
      if (possible_min < zaxis_low) {
        zaxis_low = calc.floor(possible_min)
      }
      if (possible_max > zaxis_high) {
        zaxis_high = calc.ceil(possible_max)
      }
    }
    return (zdomain: (zaxis_low,zaxis_high), zpoints: zpoints)
}

#let render_surface(
  func,
  color_func,
  samples: 1,
  render_step:1,
  xdomain:(0,10),
  ydomain: (0,10),
  zdomain: (0,10),
  zpoints: (()),
  axis_step: (5,5,5),
  dot_thickness:0.05em,
  ) = {
    import draw: *

    let step = 1/samples

    let (xaxis_low,xaxis_high) = xdomain
    let (yaxis_low,yaxis_high) = ydomain
    let (zaxis_low,zaxis_high) = zdomain
    let x_count = (xaxis_high - xaxis_low) * samples
    let y_count = (yaxis_high - yaxis_low) * samples

    for i in range(x_count, step:render_step) {
      for j in range(y_count,step: render_step) {
        line(
          (xaxis_low + i * step, yaxis_low + j * step, zpoints.at(i).at(j)),
          (xaxis_low + i * step, yaxis_low + (j + render_step) * step, zpoints.at(i).at(j+render_step)),
          (
            xaxis_low + (i + render_step) * step , 
            yaxis_low + (j + render_step) * step, 
            zpoints.at(i + render_step).at(j + render_step)
          ),
          (xaxis_low + (i + render_step) * step, yaxis_low + j * step, zpoints.at(i + render_step).at(j)),
          stroke:0.02em,fill: color_func(i,j,x_count,y_count, zpoints)
        )
      }
    }
}

#let render_front_axis(
  axis_low:(0,0,0),
  axis_high: (10,10,10),
  front_axis_dot_scale: (0.05,0.05),
  front_axis_thickness: 0.04em,
  xyz-colors: (red,green,blue),
  axis_label_size:1.5em,
  ) = {
    import draw: *

    let (xaxis_low, yaxis_low, zaxis_low) = axis_low
    let (xaxis_high, yaxis_high, zaxis_high) = axis_high
    let axis_stroke = (paint:black, dash: (front_axis_dot_scale.at(0) *1em, front_axis_dot_scale.at(1) *1em))
    set-style(
      stroke:(thickness: front_axis_thickness),
    )
    line(
      (xaxis_low, yaxis_high, zaxis_low),
      (xaxis_low, yaxis_high, zaxis_high),
      stroke: (paint:xyz-colors.at(0), cap: "square"), name: "zaxis"
    ) //z

    line(
      (xaxis_low, yaxis_high, zaxis_low),
      (xaxis_high, yaxis_high, zaxis_low),
      stroke:(paint:xyz-colors.at(1), cap: "square"), name: "xaxis"
    ) //x

    line(
      (xaxis_high, yaxis_low, zaxis_low),
      (xaxis_high, yaxis_high, zaxis_low),
      stroke:(paint:xyz-colors.at(2), cap: "square"), name: "yaxis"
    ) //y

    line(
      (xaxis_high, yaxis_high, zaxis_low),
      (xaxis_high, yaxis_high, zaxis_high),
      stroke: axis_stroke
    ) //z

    line(
      (xaxis_low, yaxis_high, zaxis_high),
      (xaxis_high, yaxis_high, zaxis_high),
      stroke: axis_stroke
    ) //x

    line(
      (xaxis_high,yaxis_low,zaxis_high),
      (xaxis_high,yaxis_high,zaxis_high),
      stroke:axis_stroke
    ) //y

    content((xaxis_low + 0.56*(xaxis_high - xaxis_low),yaxis_high+ 0.2*(xaxis_high - xaxis_low),zaxis_low), text(size:axis_label_size)[$x$], padding: 2*axis_label_size)

    content((xaxis_high + 0.15*(yaxis_high - yaxis_low),yaxis_low+ 0.5*(yaxis_high - yaxis_low),zaxis_low), text(size:axis_label_size)[$y$], padding: 2*axis_label_size)

    content((xaxis_low - 0.15*(yaxis_high - yaxis_low),yaxis_high,zaxis_low+ 0.5*(zaxis_high - zaxis_low)), text(size:axis_label_size)[$z$], padding: 2*axis_label_size)

}

#let default_color_func(x,y,x_max,y_max,zpoints) = {
  return oklab(60%,(x/x_max)*30%+10%,0%,80%)
}

#let plot_3d_surface(
  func,
  color_func: default_color_func,
  samples: 1,
  render_step:1,
  scale_dim: (1,1,0.5),
  xdomain:(0,10),
  ydomain: (0,10),
  pad_high: (0,0,0),
  pad_low: (0,0,0),
  axis_step: (5,5,5),
  dot_thickness: 0.05em,
  front_axis_thickness: 0.1em,
  front_axis_dot_scale: (0.5em, 1em),
  rear_axis_dot_scale: (0.08,0.08),
  rear_axis_text_size: 0.5em,
  axis_label_size: 1.5em,
  ) = {
    context[#canvas({
      import draw: *
      let (xscale, yscale, zscale) = scale_dim
      //set-transform(matrix.transform-rotate-dir((-1, 1, 3), (0, -2, 0)))
      set-transform(matrix.transform-rotate-dir((-2, 2, 4), (0, -2, 0)))
      scale(x: xscale*text.size.pt(), y: yscale*text.size.pt(), z: zscale*text.size.pt())
      

      let (xaxis_low,xaxis_high) = xdomain
      let (yaxis_low,yaxis_high) = ydomain
      let (xpad_low,ypad_low,zpad_low) = pad_low
      let (xpad_high,ypad_high,zpad_high) = pad_high
      let step = 1/samples

      let (zdomain, zpoints) = get_surface_zpoints(func, samples: samples,render_step:render_step, xdomain: xdomain, ydomain: ydomain, axis_step:axis_step)

      let (zaxis_low,zaxis_high) = zdomain

      render_rear_axis(
        axis_low: (xaxis_low - xpad_low,yaxis_low - ypad_low, zaxis_low - zpad_low), 
        axis_high: (xaxis_high + xpad_high,yaxis_high + ypad_high, zaxis_high +zpad_high), 
        axis_step: axis_step, 
        dot_thickness: dot_thickness, 
        axis_dot_scale: rear_axis_dot_scale, 
        axis_text_size: rear_axis_text_size
      )

      render_surface(
        func, 
        color_func, 
        samples: samples,
        render_step:render_step, 
        xdomain: xdomain,
        ydomain: ydomain, 
        zdomain:zdomain, 
        axis_step:axis_step, 
        zpoints: zpoints,
      )

      render_front_axis(
        axis_low: (xaxis_low - xpad_low,yaxis_low - ypad_low,zaxis_low - zpad_low), 
        axis_high: (xaxis_high + xpad_high,yaxis_high + ypad_high,zaxis_high + zpad_high),
        axis_label_size: axis_label_size,
        front_axis_dot_scale: front_axis_dot_scale,
        front_axis_thickness: front_axis_thickness,
      )

      })
    ]
  }