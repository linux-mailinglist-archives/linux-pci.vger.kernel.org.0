Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17D3F0CFB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHRUwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 16:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhHRUv6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Aug 2021 16:51:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8A356108E;
        Wed, 18 Aug 2021 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629319883;
        bh=Sl9oNcjdvaGC5ZCxO831r8XBsDC8b75aZ5QbNSNY50A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UEKPsb3+TuzUutteScIlS/g3HkvqLLME4lY3tflEKWT+eNCQ1aBeKV+M0VCyS25Sa
         DqTD69LaVHtusV4ejfWlUMdJAHCW6QZmyh4JzeWTi4VC3GCN1Sv/EitCYxTHepxobZ
         8WdZzzDPv/qDiPtkKhgPfi1DZ/ToaIjsk43hG8oRCwe2bGh0hFFv9zBE+cjJgk6M7B
         LCOCDvH8ZroQt/zirTDYKU5qZq58WTnIm8acfqf7gAtVkHyT7X+0six7mOnOyLy/f6
         mpvQeT/87kTfbdlH6xRBZqJT4aD2aOaZhrr0Nn6ZF0BEDoMM3Ijg5t9kPulaOKkJ5C
         rcjsNH2+k/pfQ==
Received: by mail-qk1-f169.google.com with SMTP id t66so4707807qkb.0;
        Wed, 18 Aug 2021 13:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM531wGprO9FNxNH8W5Q3zb7uR1+wQ2BxhPA8aNJCOSOEwuEzFMU4c
        GRVr9hE/nqU6+uEdjVySR7VltrLIzKFETB128Q==
X-Google-Smtp-Source: ABdhPJzsXFLufScm5OLqx9ioRWJkzHawuyclMN7aVm+IWMfgM/GIQtrjm10ePLURM6Ln31c3t6kL2mGya1Mafw+z4m8=
X-Received: by 2002:a37:b686:: with SMTP id g128mr231665qkf.68.1629319882796;
 Wed, 18 Aug 2021 13:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
 <20210726083204.93196-2-mark.kettenis@xs4all.nl> <20210726231848.GA1025245@robh.at.kernel.org>
 <87sfzt1pg9.wl-maz@kernel.org> <CAL_JsqLvqWiuib9s4PzX8pOQYJQ0eR7Gxz==J849eVJ5MDq4SA@mail.gmail.com>
 <8735ra1x8t.wl-maz@kernel.org> <CAL_JsqJ5M3soMT30ntSTbqqdrQP8TT26mHL-0xExsn10MWPofA@mail.gmail.com>
 <56140331bd735d61@bloch.sibelius.xs4all.nl>
In-Reply-To: <56140331bd735d61@bloch.sibelius.xs4all.nl>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Aug 2021 15:51:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ-YDNWOoo8TUupDox31YreUNQAPXHnMMtXakQs0S_BDA@mail.gmail.com>
Message-ID: <CAL_JsqJ-YDNWOoo8TUupDox31YreUNQAPXHnMMtXakQs0S_BDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

,

On Wed, Aug 18, 2021 at 2:56 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Rob Herring <robh@kernel.org>
> > Date: Sun, 15 Aug 2021 14:19:57 -0500
> >
> > On Sun, Aug 15, 2021 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > Apologies for the delay, I somehow misplaced this email...
> > >
> > > On Mon, 02 Aug 2021 17:10:39 +0100,
> > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 1, 2021 at 3:31 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 27 Jul 2021 00:18:48 +0100,
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Jul 26, 2021 at 10:32:00AM +0200, Mark Kettenis wrote:
> > > > > > > From: Mark Kettenis <kettenis@openbsd.org>
> > > > > > >
> > > > > > > The Apple PCIe host controller is a PCIe host controller with
> > > > > > > multiple root ports present in Apple ARM SoC platforms, including
> > > > > > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > > > > >
> > > > > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
> > > > > > >  MAINTAINERS                                   |   1 +
> > > > > > >  2 files changed, 167 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..bfcbdee79c64
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > > > > @@ -0,0 +1,166 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Apple PCIe host controller
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Mark Kettenis <kettenis@openbsd.org>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  The Apple PCIe host controller is a PCIe host controller with
> > > > > > > +  multiple root ports present in Apple ARM SoC platforms, including
> > > > > > > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > > > > > +  The controller incorporates Synopsys DesigWare PCIe logic to
> > > > > > > +  implements its root ports.  But the ATU found on most DesignWare
> > > > > > > +  PCIe host bridges is absent.
> > > > > >
> > > > > > blank line
> > > > > >
> > > > > > > +  All root ports share a single ECAM space, but separate GPIOs are
> > > > > > > +  used to take the PCI devices on those ports out of reset.  Therefore
> > > > > > > +  the standard "reset-gpio" and "max-link-speed" properties appear on
> > > > > >
> > > > > > reset-gpios
> > > > > >
> > > > > > > +  the child nodes that represent the PCI bridges that correspond to
> > > > > > > +  the individual root ports.
> > > > > >
> > > > > > blank line
> > > > > >
> > > > > > > +  MSIs are handled by the PCIe controller and translated into regular
> > > > > > > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > > > > > > +  distributed over the root ports as the OS sees fit by programming
> > > > > > > +  the PCIe controller's port registers.
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    items:
> > > > > > > +      - const: apple,t8103-pcie
> > > > > > > +      - const: apple,pcie
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    minItems: 3
> > > > > > > +    maxItems: 5
> > > > > > > +
> > > > > > > +  reg-names:
> > > > > > > +    minItems: 3
> > > > > > > +    maxItems: 5
> > > > > > > +    items:
> > > > > > > +      - const: config
> > > > > > > +      - const: rc
> > > > > > > +      - const: port0
> > > > > > > +      - const: port1
> > > > > > > +      - const: port2
> > > > > > > +
> > > > > > > +  ranges:
> > > > > > > +    minItems: 2
> > > > > > > +    maxItems: 2
> > > > > > > +
> > > > > > > +  interrupts:
> > > > > > > +    description:
> > > > > > > +      Interrupt specifiers, one for each root port.
> > > > > > > +    minItems: 1
> > > > > > > +    maxItems: 3
> > > > > > > +
> > > > > > > +  msi-controller: true
> > > > > > > +  msi-parent: true

BTW, I don't think msi-parent and msi-controller together is valid?

> > > > > > > +
> > > > > > > +  msi-ranges:
> > > > > > > +    description:
> > > > > > > +      A list of pairs <intid span>, where "intid" is the first
> > > > > > > +      interrupt number that can be used as an MSI, and "span" the size
> > > > > > > +      of that range.
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > > > > +    items:
> > > > > > > +      minItems: 2
> > > > > > > +      maxItems: 2
> > > > > >
> > > > > > I still have issues I raised on v1 with this property. It's genericish
> > > > > > looking, but not generic. 'intid' as a single cell can't specify any
> > > > > > parent interrupt such as a GIC which uses 3 cells. You could put in all
> > > > > > the cells, but you'd still be assuming which cell you can increment.
> > > > >
> > > > > The GIC bindings already use similar abstractions, see what we do for
> > > > > both GICv2m and GICv3 MBIs. Other MSI controllers use similar
> > > > > properties (alpine and loongson, for example).
> > > >
> > > > That's the problem. Everyone making up their own crap.
> > >
> > > And that crap gets approved:
> > >
> > > https://lore.kernel.org/lkml/20200512205704.GA10412@bogus/
> > >
> > > I'm not trying to be antagonistic here, but it seems that your
> > > position on this very subject has changed recently.
> >
> > Not really, I think it's not the first time we've discussed this. But
> > as I see things over and over, my tolerance for another instance
> > without solving the problem for everyone diminishes. And what other
> > leverage do I have?
> >
> > Additionally, how long we have to support something comes into play. I
> > have no idea for a Loongson MSI controller. I have a better idea on an
> > Apple product...
> >
> > > > > > I think you should just list all these under 'interrupts' using
> > > > > > interrupt-names to make your life easier:
> > > > > >
> > > > > > interrupt-names:
> > > > > >   items:
> > > > > >     - const: port0
> > > > > >     - const: port1
> > > > > >     - const: port2
> > > > > >     - const: msi0
> > > > > >     - const: msi1
> > > > > >     - const: msi2
> > > > > >     - const: msi3
> > > > > >     ...
> > > > > >
> > > > > > Yeah, it's kind of verbose, but if the h/w block handles N interrupts,
> > > > > > you should list N interrupts. The worst case for the above is N entries
> > > > > > too if not contiguous.
> > > > >
> > > > > And that's where I beg to differ, again.
> > > > >
> > > > > Specifying interrupts like this gives the false impression that these
> > > > > interrupts are generated by the device that owns them (the RC). Which
> > > > > for MSIs is not the case.
> > > >
> > > > It's no different than an interrupt controller node having an
> > > > interrupts property. The source is downstream and the interrupt
> > > > controller is combining/translating the interrupts.
> > > >
> > > > The physical interrupt signals are connected to and originating in
> > > > this block.
> > >
> > > Oh, I also object to this, for the same reasons. The only case where
> > > it makes sense IMHO is when the interrupt controller is a multiplexer.
> >
> > So we've had the same kind of property for interrupt multiplexers. I'm
> > fine if you think an 'MSI to interrupts mapping property' should be
> > named something else.
> >
> > > > That sounds like perfectly 'describing the h/w' to me.
> > >
> > > I guess we have a different view of about these things. At the end of
> > > the day, I don't care enough as long as we can expose a range of
> > > interrupts one way or another.
> >
> > I don't really either. I just don't want 10 ways AND another...
> >
> > > > > This is not only verbose, this is
> > > > > semantically dubious. And what should we do when the number of
> > > > > possible interrupt is ridiculously large, as it is for the GICv3 ITS?
> > > >
> > > > I don't disagree with the verbose part. But that's not really an issue
> > > > in this case.
> > > >
> > > > > I wish we had a standard way to express these constraints. Until we
> > > > > do, I don't think enumerating individual interrupts is a practical
> > > > > thing to do, nor that it actually represents the topology of the
> > > > > system.
> > > >
> > > > The only way a standard way will happen is to stop accepting the
> > > > custom properties.
> > > >
> > > > All the custom properties suffer from knowledge of what the parent
> > > > interrupt controller is. To fix that, I think we need something like
> > > > this:
> > > >
> > > > msi-ranges = <intspec base>, <intspec step>, <intspec end>;
> > > >
> > > > 'intspec' is defined by the parent interrupt-controller cells. step is
> > > > the value to add. And end is what to match on to stop aka the last
> > > > interrupt in the range. For example, if the GIC is the parent, we'd
> > > > have something like this:
> > > >
> > > > <GIC_SPI 123 0>, <0 1 0>, <GIC_SPI 124 0>
> > > >
> > > > Does this apply to cases other than MSI? I think so as don't we have
> > > > the same type of properties with the low power mode shadow interrupt
> > > > controllers?  So 'interrupt-ranges'?
> > >
> > > This would work, though the increment seems a bit over-engineered. You
> > > also may need this property to accept multiple ranges.
> >
> > Yes, certainly. Worst case is a map.
> >
> > > > It looks to me like there's an assumption in the kernel that an MSI
> > > > controller has a linear range of parent interrupts? Is that correct
> > > > and something that's guaranteed? That assumption leaks into the
> > > > existing bindings.
> > >
> > > Depends on how the controller works. In general, the range maps to the
> > > MultiMSI requirements where the message is an offset from the base of
> > > the interrupt range. So you generally end-up with ranges of at least
> > > 32 contiguous MSIs. Anything under that is sub-par and probably not
> > > worth supporting.
> >
> > Maybe just this is enough:
> > msi-ranges = <intspec base>, <length>, <intspec base>, <length>, ...
> >
> > While I say 'length' here, that's really up to the interrupt parent to
> > interpret the intspec cells.
>
> So for the Apple PCIe controller we'd have:
>
>    msi-ranges = <AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
>
> That would work just fine.
>
> Should this be documented in the apple,pcie binding, or somewhere more
> generic?

It doesn't have an 'apple,' prefix, so somewhere generic. Probably
bindings/interrupt-controller/msi.txt. Or start an msi-controller.yaml
schema as I'd rather not add things we can't validate, but I don't
want to gate this on converting all the MSI bindings. Someone that
understands MSI better than me should review too.

Another thing I thought of is the above is assuming the interrupt
parent is the same as any interrupts for the node and that all MSIs go
to 1 interrupt controller. Also, given Marc doesn't think using
'interrupts' is right, then using 'interrupt-parent' isn't either
(though many of the examples below do just that). So maybe we need the
phandle in there:

msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;

Other examples of this type of property include:
al,msi-base-spi/al,msi-base-spi
arm,msi-base-spi/arm,msi-num-spis
mbi-ranges
loongson,msi-base-vec/loongson,msi-num-vecs
marvell,spi-ranges
ti,interrupt-ranges?

We should make sure msi-ranges works for all of these cases at least
even if we can't change them.

Rob
