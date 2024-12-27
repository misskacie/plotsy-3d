#import "@preview/cetz:0.3.1": canvas, draw, matrix

#let render_rear_axis(
  axis_low:(0,0,0),
  axis_high: (10,10,10),
  axis_step:(5,5,5),
  axis_dot_scale: (0.08,0.08),
  dot_thickness:0.05em,
  axis_text_size: 1em,
  axis_text_offset: 0.07,
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
    let text_offset = axis_text_offset * text.size.pt()

    for xoffset in range(xaxis_high - xaxis_low, step:xaxis_step) {
      let xcoord = xaxis_low + xoffset
      line(
        (xcoord,yaxis_low,zaxis_low),
        (xcoord,yaxis_high,zaxis_low),
        stroke: yaxis_stroke
      )
      content((xcoord,yaxis_high + text_offset, zaxis_low), text(size:axis_text_size)[#xcoord])
      line(
        (xcoord,yaxis_low,zaxis_low),
        (xcoord,yaxis_low,zaxis_high),
        stroke:zaxis_stroke
      )
    }
    content((xaxis_high,yaxis_high + text_offset,zaxis_low), text(size:axis_text_size)[#xaxis_high])

    for yoffset in range(yaxis_high - yaxis_low, step:yaxis_step) {
      let ycoord = yaxis_low + yoffset
      line(
        (xaxis_low,ycoord,zaxis_low),
        (xaxis_high,ycoord,zaxis_low),
        stroke: xaxis_stroke
      )
      content((xaxis_high + text_offset,ycoord,zaxis_low), text(size:axis_text_size)[#ycoord])
      line(
        (xaxis_low,ycoord,zaxis_low),
        (xaxis_low,ycoord,zaxis_high),
        stroke:zaxis_stroke
      )
    }
    content((xaxis_high + text_offset,yaxis_high,zaxis_low), text(size:axis_text_size)[#yaxis_high])

    for zoffset in range(zaxis_high - zaxis_low, step:zaxis_step) {
      let zcoord = zaxis_low + zoffset
      line(
        (xaxis_low,yaxis_low,zcoord),
        (xaxis_low,yaxis_high,zcoord),
        stroke:yaxis_stroke
      )
      content((xaxis_low - text_offset,yaxis_high,zcoord), text(size:axis_text_size)[#zcoord])
      line(
        (xaxis_low,yaxis_low,zcoord),
        (xaxis_high,yaxis_low,zcoord),
        stroke:xaxis_stroke
      )
    }
    content((xaxis_low - text_offset,yaxis_high,zaxis_high), text(size:axis_text_size)[#zaxis_high])


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
}

#let render_front_axis(
  axis_low:(0,0,0),
  axis_high: (10,10,10),
  front_axis_dot_scale: (0.05,0.05),
  front_axis_thickness: 0.04em,
  xyz-colors: (red,green,blue),
  axis_label_size:1.5em,
  axis_label_offset: (0.3,0.2,0.15),
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

    content((
      xaxis_low + (xaxis_high - xaxis_low)/2, 
      yaxis_high + axis_label_offset.at(0) * text.size.pt(),
      zaxis_low
      ), text(size:axis_label_size)[$x$]
    )

    content((
      xaxis_high + axis_label_offset.at(1) * text.size.pt(),
      yaxis_low + (yaxis_high - yaxis_low)/2, 
      zaxis_low
      ), text(size:axis_label_size)[$y$]
      )

    content((
      xaxis_low - axis_label_offset.at(2) * text.size.pt(),
      yaxis_high,
      zaxis_low + (zaxis_high - zaxis_low)/2
      ), text(size:axis_label_size)[$z$]
    )

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

    for xregion in range(xaxis_low * samples, xaxis_high * samples + render_step, step: render_step) {
      let zpoints_temp = ()
      for yregion in range(yaxis_low * samples, yaxis_high * samples + render_step, step: render_step) {
        let x = xregion * step
        let y = yregion * step
        zpoints_temp.push(func(x,y))
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
  zpoints: (),
  axis_step: (5,5,5),
  dot_thickness:0.05em,
  ) = {
    import draw: *


    let (xaxis_low,xaxis_high) = xdomain
    let (yaxis_low,yaxis_high) = ydomain
    let (zaxis_low,zaxis_high) = zdomain

    let step = 1/samples

    let i = 0
    let j = 0 
    for xregion in range(xaxis_low * samples, xaxis_high * samples, step:render_step) {
      for yregion in range(yaxis_low * samples, yaxis_high * samples, step: render_step) {
        let x = xregion * step
        let y = yregion * step
        let offset = step * render_step
        line(
          (x, y, zpoints.at(i).at(j)),
          (x, y + offset, zpoints.at(i).at(j+1)),
          (x + offset, y + offset, zpoints.at(i+1).at(j+1)), 
          (x + offset, y, zpoints.at(i+1).at(j)), 
          stroke:0.02em,
          fill: color_func(x, y, zpoints.at(i).at(j), xaxis_low, xaxis_high, yaxis_low, yaxis_high, zaxis_low,zaxis_high)
        )
        j += 1
      }
      j = 0
      i += 1
    }
}


#let get_parametric_curve_points(
  x_func,
  y_func,
  z_func, 
  subdivisions: 10,
  tdomain: (0,1),
  ) = {
    import draw: *
    
    let (t_low, t_high) = tdomain
    let xcurve_lo = 0
    let ycurve_lo = 0
    let zcurve_lo = 0
    let xcurve_hi = 0
    let ycurve_hi = 0
    let zcurve_hi = 0

    
    let curve_points = ()
    for tregion in range(t_low * subdivisions, t_high * subdivisions) {
      let t = tregion *1/subdivisions
      let point = (x_func(t), y_func(t), z_func(t))
      curve_points.push(point)

      if (point.at(0) > xcurve_hi) {
        xcurve_hi = calc.ceil(point.at(0))
      }
      if (point.at(0) < xcurve_lo) {
        xcurve_lo = calc.floor(point.at(0))
      }
      if (point.at(1) > ycurve_hi) {
        ycurve_hi = calc.ceil(point.at(1))
      }
      if (point.at(1) < ycurve_lo) {
        ycurve_lo = calc.floor(point.at(1))
      }
      if (point.at(2) > zcurve_hi) {
        zcurve_hi = calc.ceil(point.at(2))
      }
      if (point.at(2) < zcurve_lo) {
        zcurve_lo = calc.floor(point.at(2))
      }
    }

    return (curve_points, (xcurve_lo, xcurve_hi), (ycurve_lo, ycurve_hi), (zcurve_lo, zcurve_hi))
}

#let default_color_func(x, y, z, x_lo,x_hi,y_lo,y_hi,z_lo,z_hi) = {
  return oklab(60%,((x - x_lo)/(x_hi))*30%+10%,0%,80%)
}

#let plot_3d_surface(
  func,
  func2: none,
  color_func: default_color_func,
  subdivision_mode: "increase",
  subdivisions: 1,
  scale_dim: (1,1,0.5),
  xdomain:(0,10),
  ydomain: (0,10),
  pad_high: (0,0,0),
  pad_low: (0,0,0),
  axis_step: (5,5,5),
  dot_thickness: 0.05em,
  front_axis_thickness: 0.1em,
  front_axis_dot_scale: (0.5, 1),
  rear_axis_dot_scale: (0.08,0.08),
  rear_axis_text_size: 0.5em,
  axis_label_size: 1.5em,
  axis_label_offset: (0.3,0.2,0.15),
  axis_text_offset: 0.075,
  rotation_matrix: ((-2, 2, 4), (0, -1, 0))
  ) = {
    let samples = 1
    let render_step = 1

    if (subdivision_mode == "increase"){
      samples = subdivisions
    } else if (subdivision_mode == "decrease") {
      render_step = subdivisions
    }

    context[#canvas({
      import draw: *
      let (xscale, yscale, zscale) = scale_dim
      
      set-transform(matrix.transform-rotate-dir(rotation_matrix.at(0),rotation_matrix.at(1)))
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
        axis_text_size: rear_axis_text_size,
        axis_text_offset: axis_text_offset
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

      if (func2 != none) {
        let (zdomain, zpoints) = get_surface_zpoints(func, samples: samples,render_step:render_step, xdomain: xdomain, ydomain: ydomain, axis_step:axis_step)

        render_surface(
        func2, 
        color_func, 
        samples: samples,
        render_step:render_step, 
        xdomain: xdomain,
        ydomain: ydomain, 
        zdomain:zdomain, 
        axis_step:axis_step, 
        zpoints: zpoints,
      )

      }

      render_front_axis(
        axis_low: (xaxis_low - xpad_low,yaxis_low - ypad_low,zaxis_low - zpad_low), 
        axis_high: (xaxis_high + xpad_high,yaxis_high + ypad_high,zaxis_high + zpad_high),
        axis_label_size: axis_label_size,
        front_axis_dot_scale: front_axis_dot_scale,
        front_axis_thickness: front_axis_thickness,
        axis_label_offset: axis_label_offset
      )

      })
    ]
}

#let default_line_color_func(i,imax) = {
  return purple.transparentize(20%).darken((i/imax) * 100%)
}

#let plot_3d_parametric_curve(
  x_func,
  y_func,
  z_func,
  color_func: default_line_color_func,
  subdivisions:1,
  scale_dim: (1,1,0.5),
  tdomain:(0,1),
  xdomain:(0,10),
  ydomain:(0,10),
  zdomain:(0,10),
  axis_step: (5,5,5),
  dot_thickness: 0.05em,
  front_axis_thickness: 0.1em,
  front_axis_dot_scale: (0.05, 0.05),
  rear_axis_dot_scale: (0.08,0.08),
  rear_axis_text_size: 0.5em,
  axis_label_size: 1.5em,
  axis_label_offset: (0.3,0.2,0.15),
  axis_text_offset: 0.075,
  rotation_matrix: ((-2, 2, 4), (0, -1, 0))
  ) = {
    context[#canvas({
      import draw: *
      let (xscale, yscale, zscale) = scale_dim
      set-transform(matrix.transform-rotate-dir(rotation_matrix.at(0),rotation_matrix.at(1)))
      scale(x: xscale*text.size.pt(), y: yscale*text.size.pt(), z: zscale*text.size.pt())
      

      let (xaxis_low,xaxis_high) = xdomain
      let (yaxis_low,yaxis_high) = ydomain
      let (zaxis_low,zaxis_high) = zdomain


      let (curve_points, (xcurve_lo, xcurve_hi), (ycurve_lo, ycurve_hi), (zcurve_lo, zcurve_hi)) = get_parametric_curve_points(
        x_func,
        y_func,
        z_func, 
        subdivisions: subdivisions,
        tdomain: tdomain,
      )

      render_rear_axis(
        axis_low: (calc.min(xcurve_lo, xaxis_low),calc.min(ycurve_lo, yaxis_low), calc.min(zcurve_lo, zaxis_low)), 
        axis_high: (calc.max(xcurve_hi, xaxis_high),calc.max(ycurve_hi, yaxis_high), calc.max(zcurve_hi, zaxis_high)), 
        axis_step: axis_step, 
        dot_thickness: dot_thickness, 
        axis_dot_scale: rear_axis_dot_scale, 
        axis_text_size: rear_axis_text_size
      )
      let npoints = curve_points.len()
      for i in range(curve_points.len() - 1) {
        line(curve_points.at(i), curve_points.at(i+1), stroke: color_func(i,npoints) + 0.2em)
      }
      

      render_front_axis(
        axis_low: (calc.min(xcurve_lo, xaxis_low),calc.min(ycurve_lo, yaxis_low), calc.min(zcurve_lo, zaxis_low)), 
        axis_high: (calc.max(xcurve_hi, xaxis_high),calc.max(ycurve_hi, yaxis_high), calc.max(zcurve_hi, zaxis_high)), 
        axis_label_size: axis_label_size,
        front_axis_dot_scale: front_axis_dot_scale,
        front_axis_thickness: front_axis_thickness,
      )

      })
    ]
  }