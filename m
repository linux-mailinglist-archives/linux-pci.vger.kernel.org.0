Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7583F40B8
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHVRpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 13:45:06 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:54463 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhHVRpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 13:45:06 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id a8d0cc6e;
        Sun, 22 Aug 2021 19:44:22 +0200 (CEST)
Date:   Sun, 22 Aug 2021 19:44:22 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     maz@kernel.org, devicetree@vger.kernel.org, robin.murphy@arm.com,
        sven@svenpeter.dev, kettenis@openbsd.org, marcan@marcan.st,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAL_JsqJ-YDNWOoo8TUupDox31YreUNQAPXHnMMtXakQs0S_BDA@mail.gmail.com>
        (message from Rob Herring on Wed, 18 Aug 2021 15:51:11 -0500)
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
 <20210726083204.93196-2-mark.kettenis@xs4all.nl> <20210726231848.GA1025245@robh.at.kernel.org>
 <87sfzt1pg9.wl-maz@kernel.org> <CAL_JsqLvqWiuib9s4PzX8pOQYJQ0eR7Gxz==J849eVJ5MDq4SA@mail.gmail.com>
 <8735ra1x8t.wl-maz@kernel.org> <CAL_JsqJ5M3soMT30ntSTbqqdrQP8TT26mHL-0xExsn10MWPofA@mail.gmail.com>
 <56140331bd735d61@bloch.sibelius.xs4all.nl> <CAL_JsqJ-YDNWOoo8TUupDox31YreUNQAPXHnMMtXakQs0S_BDA@mail.gmail.com>
Message-ID: <56140c26d86f4733@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> Date: Wed, 18 Aug 2021 15:51:11 -0500

Hi Rob,

> On Wed, Aug 18, 2021 at 2:56 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Rob Herring <robh@kernel.org>
> > > Date: Sun, 15 Aug 2021 14:19:57 -0500
> > >
> > > On Sun, Aug 15, 2021 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > Apologies for the delay, I somehow misplaced this email...
> > > >
> > > > On Mon, 02 Aug 2021 17:10:39 +0100,
> > > > Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Sun, Aug 1, 2021 at 3:31 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 27 Jul 2021 00:18:48 +0100,
> > > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 26, 2021 at 10:32:00AM +0200, Mark Kettenis wrote:
> > > > > > > > From: Mark Kettenis <kettenis@openbsd.org>
> > > > > > > >
> > > > > > > > The Apple PCIe host controller is a PCIe host controller with
> > > > > > > > multiple root ports present in Apple ARM SoC platforms, including
> > > > > > > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > > > > > >
> > > > > > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > > > > > ---
> > > > > > > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
> > > > > > > >  MAINTAINERS                                   |   1 +
> > > > > > > >  2 files changed, 167 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..bfcbdee79c64
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > > > @@ -0,0 +1,166 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Apple PCIe host controller
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Mark Kettenis <kettenis@openbsd.org>
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > > > +  The Apple PCIe host controller is a PCIe host controller with
> > > > > > > > +  multiple root ports present in Apple ARM SoC platforms, including
> > > > > > > > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > > > > > > +  The controller incorporates Synopsys DesigWare PCIe logic to
> > > > > > > > +  implements its root ports.  But the ATU found on most DesignWare
> > > > > > > > +  PCIe host bridges is absent.
> > > > > > >
> > > > > > > blank line
> > > > > > >
> > > > > > > > +  All root ports share a single ECAM space, but separate GPIOs are
> > > > > > > > +  used to take the PCI devices on those ports out of reset.  Therefore
> > > > > > > > +  the standard "reset-gpio" and "max-link-speed" properties appear on
> > > > > > >
> > > > > > > reset-gpios
> > > > > > >
> > > > > > > > +  the child nodes that represent the PCI bridges that correspond to
> > > > > > > > +  the individual root ports.
> > > > > > >
> > > > > > > blank line
> > > > > > >
> > > > > > > > +  MSIs are handled by the PCIe controller and translated into regular
> > > > > > > > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > > > > > > > +  distributed over the root ports as the OS sees fit by programming
> > > > > > > > +  the PCIe controller's port registers.
> > > > > > > > +
> > > > > > > > +allOf:
> > > > > > > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    items:
> > > > > > > > +      - const: apple,t8103-pcie
> > > > > > > > +      - const: apple,pcie
> > > > > > > > +
> > > > > > > > +  reg:
> > > > > > > > +    minItems: 3
> > > > > > > > +    maxItems: 5
> > > > > > > > +
> > > > > > > > +  reg-names:
> > > > > > > > +    minItems: 3
> > > > > > > > +    maxItems: 5
> > > > > > > > +    items:
> > > > > > > > +      - const: config
> > > > > > > > +      - const: rc
> > > > > > > > +      - const: port0
> > > > > > > > +      - const: port1
> > > > > > > > +      - const: port2
> > > > > > > > +
> > > > > > > > +  ranges:
> > > > > > > > +    minItems: 2
> > > > > > > > +    maxItems: 2
> > > > > > > > +
> > > > > > > > +  interrupts:
> > > > > > > > +    description:
> > > > > > > > +      Interrupt specifiers, one for each root port.
> > > > > > > > +    minItems: 1
> > > > > > > > +    maxItems: 3
> > > > > > > > +
> > > > > > > > +  msi-controller: true
> > > > > > > > +  msi-parent: true
> 
> BTW, I don't think msi-parent and msi-controller together is valid?

There is an existing example in:

arm64/boot/dts/marvell/armada-37xx.dtsi

I think it makes sense as the pcie bridge itself serves as the MSI
controller.

> > > > > > > > +
> > > > > > > > +  msi-ranges:
> > > > > > > > +    description:
> > > > > > > > +      A list of pairs <intid span>, where "intid" is the first
> > > > > > > > +      interrupt number that can be used as an MSI, and "span" the size
> > > > > > > > +      of that range.
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > > > > > +    items:
> > > > > > > > +      minItems: 2
> > > > > > > > +      maxItems: 2
> > > > > > >
> > > > > > > I still have issues I raised on v1 with this property. It's genericish
> > > > > > > looking, but not generic. 'intid' as a single cell can't specify any
> > > > > > > parent interrupt such as a GIC which uses 3 cells. You could put in all
> > > > > > > the cells, but you'd still be assuming which cell you can increment.
> > > > > >
> > > > > > The GIC bindings already use similar abstractions, see what we do for
> > > > > > both GICv2m and GICv3 MBIs. Other MSI controllers use similar
> > > > > > properties (alpine and loongson, for example).
> > > > >
> > > > > That's the problem. Everyone making up their own crap.
> > > >
> > > > And that crap gets approved:
> > > >
> > > > https://lore.kernel.org/lkml/20200512205704.GA10412@bogus/
> > > >
> > > > I'm not trying to be antagonistic here, but it seems that your
> > > > position on this very subject has changed recently.
> > >
> > > Not really, I think it's not the first time we've discussed this. But
> > > as I see things over and over, my tolerance for another instance
> > > without solving the problem for everyone diminishes. And what other
> > > leverage do I have?
> > >
> > > Additionally, how long we have to support something comes into play. I
> > > have no idea for a Loongson MSI controller. I have a better idea on an
> > > Apple product...
> > >
> > > > > > > I think you should just list all these under 'interrupts' using
> > > > > > > interrupt-names to make your life easier:
> > > > > > >
> > > > > > > interrupt-names:
> > > > > > >   items:
> > > > > > >     - const: port0
> > > > > > >     - const: port1
> > > > > > >     - const: port2
> > > > > > >     - const: msi0
> > > > > > >     - const: msi1
> > > > > > >     - const: msi2
> > > > > > >     - const: msi3
> > > > > > >     ...
> > > > > > >
> > > > > > > Yeah, it's kind of verbose, but if the h/w block handles N interrupts,
> > > > > > > you should list N interrupts. The worst case for the above is N entries
> > > > > > > too if not contiguous.
> > > > > >
> > > > > > And that's where I beg to differ, again.
> > > > > >
> > > > > > Specifying interrupts like this gives the false impression that these
> > > > > > interrupts are generated by the device that owns them (the RC). Which
> > > > > > for MSIs is not the case.
> > > > >
> > > > > It's no different than an interrupt controller node having an
> > > > > interrupts property. The source is downstream and the interrupt
> > > > > controller is combining/translating the interrupts.
> > > > >
> > > > > The physical interrupt signals are connected to and originating in
> > > > > this block.
> > > >
> > > > Oh, I also object to this, for the same reasons. The only case where
> > > > it makes sense IMHO is when the interrupt controller is a multiplexer.
> > >
> > > So we've had the same kind of property for interrupt multiplexers. I'm
> > > fine if you think an 'MSI to interrupts mapping property' should be
> > > named something else.
> > >
> > > > > That sounds like perfectly 'describing the h/w' to me.
> > > >
> > > > I guess we have a different view of about these things. At the end of
> > > > the day, I don't care enough as long as we can expose a range of
> > > > interrupts one way or another.
> > >
> > > I don't really either. I just don't want 10 ways AND another...
> > >
> > > > > > This is not only verbose, this is
> > > > > > semantically dubious. And what should we do when the number of
> > > > > > possible interrupt is ridiculously large, as it is for the GICv3 ITS?
> > > > >
> > > > > I don't disagree with the verbose part. But that's not really an issue
> > > > > in this case.
> > > > >
> > > > > > I wish we had a standard way to express these constraints. Until we
> > > > > > do, I don't think enumerating individual interrupts is a practical
> > > > > > thing to do, nor that it actually represents the topology of the
> > > > > > system.
> > > > >
> > > > > The only way a standard way will happen is to stop accepting the
> > > > > custom properties.
> > > > >
> > > > > All the custom properties suffer from knowledge of what the parent
> > > > > interrupt controller is. To fix that, I think we need something like
> > > > > this:
> > > > >
> > > > > msi-ranges = <intspec base>, <intspec step>, <intspec end>;
> > > > >
> > > > > 'intspec' is defined by the parent interrupt-controller cells. step is
> > > > > the value to add. And end is what to match on to stop aka the last
> > > > > interrupt in the range. For example, if the GIC is the parent, we'd
> > > > > have something like this:
> > > > >
> > > > > <GIC_SPI 123 0>, <0 1 0>, <GIC_SPI 124 0>
> > > > >
> > > > > Does this apply to cases other than MSI? I think so as don't we have
> > > > > the same type of properties with the low power mode shadow interrupt
> > > > > controllers?  So 'interrupt-ranges'?
> > > >
> > > > This would work, though the increment seems a bit over-engineered. You
> > > > also may need this property to accept multiple ranges.
> > >
> > > Yes, certainly. Worst case is a map.
> > >
> > > > > It looks to me like there's an assumption in the kernel that an MSI
> > > > > controller has a linear range of parent interrupts? Is that correct
> > > > > and something that's guaranteed? That assumption leaks into the
> > > > > existing bindings.
> > > >
> > > > Depends on how the controller works. In general, the range maps to the
> > > > MultiMSI requirements where the message is an offset from the base of
> > > > the interrupt range. So you generally end-up with ranges of at least
> > > > 32 contiguous MSIs. Anything under that is sub-par and probably not
> > > > worth supporting.
> > >
> > > Maybe just this is enough:
> > > msi-ranges = <intspec base>, <length>, <intspec base>, <length>, ...
> > >
> > > While I say 'length' here, that's really up to the interrupt parent to
> > > interpret the intspec cells.
> >
> > So for the Apple PCIe controller we'd have:
> >
> >    msi-ranges = <AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
> >
> > That would work just fine.
> >
> > Should this be documented in the apple,pcie binding, or somewhere more
> > generic?
> 
> It doesn't have an 'apple,' prefix, so somewhere generic. Probably
> bindings/interrupt-controller/msi.txt. Or start an msi-controller.yaml
> schema as I'd rather not add things we can't validate, but I don't
> want to gate this on converting all the MSI bindings. Someone that
> understands MSI better than me should review too.

Yes, I'd like to avoid converting all the MSI bindings, but I could
add an msi-controller.yaml file and use it in the appropriate
interrupt controller and pci host bridge bindings that have been
converted to yaml.

> Another thing I thought of is the above is assuming the interrupt
> parent is the same as any interrupts for the node and that all MSIs go
> to 1 interrupt controller. Also, given Marc doesn't think using
> 'interrupts' is right, then using 'interrupt-parent' isn't either
> (though many of the examples below do just that). So maybe we need the
> phandle in there:
> 
> msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;

That makes sense.

> Other examples of this type of property include:
> al,msi-base-spi/al,msi-base-spi
> arm,msi-base-spi/arm,msi-num-spis
> mbi-ranges
> loongson,msi-base-vec/loongson,msi-num-vecs
> marvell,spi-ranges
> ti,interrupt-ranges?
> 
> We should make sure msi-ranges works for all of these cases at least
> even if we can't change them.

I think this scheme would work for all of these although it isn't
entirely clear to me whether ti,interrupt-ranges is about just MSIs or
if it also maps some other kind of interrupts.

marvell,spi-ranges is an interesting one since it typically specifies
two ranges of 64 MSIs.  But that's something your proposal addresses
just fine.  I suppose we will provide a phandle for the parent
interrupt controller for each individual range?

If Marc agrees, I'll get working on implementing the
msi-controller.yaml schema.

Thanks,

Mark
