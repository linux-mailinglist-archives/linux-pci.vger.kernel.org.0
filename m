Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF023DDD46
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhHBQLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 12:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhHBQLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 12:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD9B461107;
        Mon,  2 Aug 2021 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627920652;
        bh=rglWHlzS0hDB02auQNohIp4iijeWGQuf2Ja7Qb4hYUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=unCZl25uSNAUzvN7qGehQ9rQCneXxegVdslhG2QXGl0Q5ZOqSFALCnPRGxRuvhgP6
         DLkenKRkOntptdvXrk3AhtIrOBKknYu5YOap23EHL5/KX4EKqfdv3TEePLzT0yCRQc
         gi/9xNM0a984FHhLb939V90piXvxzsvKwySaMmeLQ6zjE05U9JYSJEDEstqMNojxDg
         Yg/eNvfehj0znMejm8C4yb5GInF4Iud/ZFqmOKWO0/e1JUcy/Xo8Zt4ybXDhj8t5sd
         /ZPyA63H4ACh53ampfTdyR62yHl7DHbSyQJES7sHBBW4OQ486PLYl2zCd+Dtdu9YOx
         ZI8y8Q904Tc8g==
Received: by mail-qv1-f54.google.com with SMTP id cg4so4081351qvb.5;
        Mon, 02 Aug 2021 09:10:52 -0700 (PDT)
X-Gm-Message-State: AOAM531kZ20GD9oIpUCgl0yaYkdzoJjQSvVuAodDvtch1CBvetSFGKs3
        qt8fCvRvoSwQikq/sErxrf0osWUjOTt4UWjVVA==
X-Google-Smtp-Source: ABdhPJzGQUjalfg03Ji3GXBsBmtGCSK/zTh5PrJJsVuj2U9Uk2JfYU1Debygp3dek7c3OE+8pMR8zpYBMxtmKWE4BYA=
X-Received: by 2002:a0c:ff4b:: with SMTP id y11mr3347079qvt.50.1627920651928;
 Mon, 02 Aug 2021 09:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
 <20210726083204.93196-2-mark.kettenis@xs4all.nl> <20210726231848.GA1025245@robh.at.kernel.org>
 <87sfzt1pg9.wl-maz@kernel.org>
In-Reply-To: <87sfzt1pg9.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Aug 2021 10:10:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvqWiuib9s4PzX8pOQYJQ0eR7Gxz==J849eVJ5MDq4SA@mail.gmail.com>
Message-ID: <CAL_JsqLvqWiuib9s4PzX8pOQYJQ0eR7Gxz==J849eVJ5MDq4SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Sun, Aug 1, 2021 at 3:31 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 27 Jul 2021 00:18:48 +0100,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 10:32:00AM +0200, Mark Kettenis wrote:
> > > From: Mark Kettenis <kettenis@openbsd.org>
> > >
> > > The Apple PCIe host controller is a PCIe host controller with
> > > multiple root ports present in Apple ARM SoC platforms, including
> > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > >
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > ---
> > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
> > >  MAINTAINERS                                   |   1 +
> > >  2 files changed, 167 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > new file mode 100644
> > > index 000000000000..bfcbdee79c64
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > @@ -0,0 +1,166 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Apple PCIe host controller
> > > +
> > > +maintainers:
> > > +  - Mark Kettenis <kettenis@openbsd.org>
> > > +
> > > +description: |
> > > +  The Apple PCIe host controller is a PCIe host controller with
> > > +  multiple root ports present in Apple ARM SoC platforms, including
> > > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > +  The controller incorporates Synopsys DesigWare PCIe logic to
> > > +  implements its root ports.  But the ATU found on most DesignWare
> > > +  PCIe host bridges is absent.
> >
> > blank line
> >
> > > +  All root ports share a single ECAM space, but separate GPIOs are
> > > +  used to take the PCI devices on those ports out of reset.  Therefore
> > > +  the standard "reset-gpio" and "max-link-speed" properties appear on
> >
> > reset-gpios
> >
> > > +  the child nodes that represent the PCI bridges that correspond to
> > > +  the individual root ports.
> >
> > blank line
> >
> > > +  MSIs are handled by the PCIe controller and translated into regular
> > > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > > +  distributed over the root ports as the OS sees fit by programming
> > > +  the PCIe controller's port registers.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: apple,t8103-pcie
> > > +      - const: apple,pcie
> > > +
> > > +  reg:
> > > +    minItems: 3
> > > +    maxItems: 5
> > > +
> > > +  reg-names:
> > > +    minItems: 3
> > > +    maxItems: 5
> > > +    items:
> > > +      - const: config
> > > +      - const: rc
> > > +      - const: port0
> > > +      - const: port1
> > > +      - const: port2
> > > +
> > > +  ranges:
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +
> > > +  interrupts:
> > > +    description:
> > > +      Interrupt specifiers, one for each root port.
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  msi-controller: true
> > > +  msi-parent: true
> > > +
> > > +  msi-ranges:
> > > +    description:
> > > +      A list of pairs <intid span>, where "intid" is the first
> > > +      interrupt number that can be used as an MSI, and "span" the size
> > > +      of that range.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    items:
> > > +      minItems: 2
> > > +      maxItems: 2
> >
> > I still have issues I raised on v1 with this property. It's genericish
> > looking, but not generic. 'intid' as a single cell can't specify any
> > parent interrupt such as a GIC which uses 3 cells. You could put in all
> > the cells, but you'd still be assuming which cell you can increment.
>
> The GIC bindings already use similar abstractions, see what we do for
> both GICv2m and GICv3 MBIs. Other MSI controllers use similar
> properties (alpine and loongson, for example).

That's the problem. Everyone making up their own crap.

> > I think you should just list all these under 'interrupts' using
> > interrupt-names to make your life easier:
> >
> > interrupt-names:
> >   items:
> >     - const: port0
> >     - const: port1
> >     - const: port2
> >     - const: msi0
> >     - const: msi1
> >     - const: msi2
> >     - const: msi3
> >     ...
> >
> > Yeah, it's kind of verbose, but if the h/w block handles N interrupts,
> > you should list N interrupts. The worst case for the above is N entries
> > too if not contiguous.
>
> And that's where I beg to differ, again.
>
> Specifying interrupts like this gives the false impression that these
> interrupts are generated by the device that owns them (the RC). Which
> for MSIs is not the case.

It's no different than an interrupt controller node having an
interrupts property. The source is downstream and the interrupt
controller is combining/translating the interrupts.

The physical interrupt signals are connected to and originating in
this block. That sounds like perfectly 'describing the h/w' to me.

> This is not only verbose, this is
> semantically dubious. And what should we do when the number of
> possible interrupt is ridiculously large, as it is for the GICv3 ITS?

I don't disagree with the verbose part. But that's not really an issue
in this case.

> I wish we had a standard way to express these constraints. Until we
> do, I don't think enumerating individual interrupts is a practical
> thing to do, nor that it actually represents the topology of the
> system.

The only way a standard way will happen is to stop accepting the
custom properties.

All the custom properties suffer from knowledge of what the parent
interrupt controller is. To fix that, I think we need something like
this:

msi-ranges = <intspec base>, <intspec step>, <intspec end>;

'intspec' is defined by the parent interrupt-controller cells. step is
the value to add. And end is what to match on to stop aka the last
interrupt in the range. For example, if the GIC is the parent, we'd
have something like this:

<GIC_SPI 123 0>, <0 1 0>, <GIC_SPI 124 0>

Does this apply to cases other than MSI? I think so as don't we have
the same type of properties with the low power mode shadow interrupt
controllers?  So 'interrupt-ranges'?


It looks to me like there's an assumption in the kernel that an MSI
controller has a linear range of parent interrupts? Is that correct
and something that's guaranteed? That assumption leaks into the
existing bindings. It's fine for the kernel to assume that until
there's a case that's not linear, but a common binding needs to be
able handle a non-linear case.

Rob
