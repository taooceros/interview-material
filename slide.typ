#import "@preview/touying:0.5.5": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#set text(font: "Source Code Pro")



#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Research Statement],
    author: [Hongtao Zhang],
    date: datetime.today(),
    institution: [University of Wisconsin-Madison],
    logo: emoji.school,
  ),
  config-methods(
  init: (self: none, body) => {
    set text(fill: self.colors.neutral-darkest, size: 25pt, font: "Source Sans 3")
    show footnote.entry: set text(size: .6em)
    show strong: self.methods.alert.with(self: self)
    show heading.where(level: self.slide-level + 1): set text(1.4em)

    body
  },
)
)


#set heading(numbering: numbly("{1}.", "{1}.{2}", none))

#show heading.where(level: 3) : set block(above: 2em, below: 1em)


#title-slide()

#outline(depth: 1)

= Introduction

== Basic Information

- B.S. in Computer Science (Honors), Math and Data Science
- Comprehensive Honors
- GPA: 3.94/4.0

= Flow Launcher

== #link("https://flowlauncher.com")[Flow Launcher]

- Core Member/Maintainer (2020.09 - Present)
- 8,000+#emoji.star
- 50,000+ downloads per release.
- Authored 200+ Pull Requests (more than 100,000 LOC)

= Usage Fair Delegation-Styled Locking

== Background

#grid(
  columns: (30%, 60%),
  gutter: 2em,
  text(size: 1.1em)[CPU Time is resource, but lock time is not.],
  figure(image("images/lock-time.png", height: 80%), caption: [Scheduler subversion with UpScaleDB. @patel2020avoiding])
)

== Scheduler-Cooperative Locks (SCL @patel2020avoiding)

Ban the threads that lock the CPU based on lock usage.

=== Problem

- Frequent switching of lock owners (massive cache invalidation).
- Not Work-Conserving

=== Mitigation

- Lock Slice: Dedicate a fixed amount of lock usage to one owner.

== Delegation-Styled Locks

- Wrap the critical section, and delegate to a single thread to execute it.

=== Benefits

- No cache invalidation when switching critical sections.

== Usage Fair Delegation-Styled Locks

+ Delegation-Styled Locks with Banning
+ Delegation-Styled Locks with a Fair Job Submission Queue
+ Delegator-Reordered Delegation-Styled Locks

== Result

#figure(image("images/throughput-1000-3000-0-1000.svg", height: 80%), caption: [Throughput comparison\ (critical section size: 1000, 3000; non-critical section size: 0, 1000).])

= DPU Offloading

== Background

- Container network stack is expensive.
- It is hard to offload the network stack.

#figure(image("images/container-motivation.png"), caption: [Microbenchmark of Host CPU Core Consumption.])

== Contribution Overview

- An offloading channel between the CPU and the DPU allowing in-sync execution.
- A framework for offloading the container network stack.
- X-GVMI #footnote[Cross-Global Virtual Machine Index] based Zero-Copy Offloading.

== Challenge 1: The CPU and DPU are not cache-coherent.

- Separate Signal Plane and Data Plane
  - Hardware FIFO for signaling
  - DMA for general data path
  - X-GVMI for Zero-Copy data path

== Challenge 2: X-GVMI relies on Hardware Support and is not open source

- The only open interface of X-GVMI lies in UCX.

=== Solution

- Implement a simple network stack based on UCT #footnote[Lower level Transport Layer of UCX].
- A RDMA bridge between UCX and the legacy ibverbs to support legacy applications.

== Result

#grid(
  columns: (45%, 45%),
  gutter: 2em, 
  figure(image("images/dpu-offloading-bw-lat.png"), caption: [Microbenchmark of Host CPU Core Consumption.]),
  figure(image("images/latency-quark.png"), caption: [Microbenchmark of Host CPU Core Consumption.]),
)



= Bibliography

== Bibliography

#bibliography("lit.bib", style: "association-for-computing-machinery", title: none)