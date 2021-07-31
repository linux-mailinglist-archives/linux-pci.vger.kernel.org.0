Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F753DC57E
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhGaJvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 05:51:47 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:53833 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhGaJvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 05:51:47 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 05:51:46 EDT
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id e3d389dd;
        Sat, 31 Jul 2021 11:44:59 +0200 (CEST)
Date:   Sat, 31 Jul 2021 11:44:59 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>, maz@kernel.org
Cc:     devicetree@vger.kernel.org, robin.murphy@arm.com,
        sven@svenpeter.dev, kettenis@openbsd.org, marcan@marcan.st,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210726231848.GA1025245@robh.at.kernel.org> (message from Rob
        Herring on Mon, 26 Jul 2021 17:18:48 -0600)
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
 <20210726083204.93196-2-mark.kettenis@xs4all.nl> <20210726231848.GA1025245@robh.at.kernel.org>
Message-ID: <5613e78e95a90b8e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Mon, 26 Jul 2021 17:18:48 -0600
> From: Rob Herring <robh@kernel.org>

Hi Rob,

> On Mon, Jul 26, 2021 at 10:32:00AM +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > The Apple PCIe host controller is a PCIe host controller with
> > multiple root ports present in Apple ARM SoC platforms, including
> > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 167 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > new file mode 100644
> > index 000000000000..bfcbdee79c64
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > @@ -0,0 +1,166 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Apple PCIe host controller
> > +
> > +maintainers:
> > +  - Mark Kettenis <kettenis@openbsd.org>
> > +
> > +description: |
> > +  The Apple PCIe host controller is a PCIe host controller with
> > +  multiple root ports present in Apple ARM SoC platforms, including
> > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > +  The controller incorporates Synopsys DesigWare PCIe logic to
> > +  implements its root ports.  But the ATU found on most DesignWare
> > +  PCIe host bridges is absent.
> 
> blank line
> 
> > +  All root ports share a single ECAM space, but separate GPIOs are
> > +  used to take the PCI devices on those ports out of reset.  Therefore
> > +  the standard "reset-gpio" and "max-link-speed" properties appear on
> 
> reset-gpios
> 
> > +  the child nodes that represent the PCI bridges that correspond to
> > +  the individual root ports.
> 
> blank line

Fixing these for v4.

> > +  MSIs are handled by the PCIe controller and translated into regular
> > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > +  distributed over the root ports as the OS sees fit by programming
> > +  the PCIe controller's port registers.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: apple,t8103-pcie
> > +      - const: apple,pcie
> > +
> > +  reg:
> > +    minItems: 3
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    minItems: 3
> > +    maxItems: 5
> > +    items:
> > +      - const: config
> > +      - const: rc
> > +      - const: port0
> > +      - const: port1
> > +      - const: port2
> > +
> > +  ranges:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt specifiers, one for each root port.
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  msi-controller: true
> > +  msi-parent: true
> > +
> > +  msi-ranges:
> > +    description:
> > +      A list of pairs <intid span>, where "intid" is the first
> > +      interrupt number that can be used as an MSI, and "span" the size
> > +      of that range.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      minItems: 2
> > +      maxItems: 2
> 
> I still have issues I raised on v1 with this property. It's genericish 
> looking, but not generic. 'intid' as a single cell can't specify any 
> parent interrupt such as a GIC which uses 3 cells. You could put in all 
> the cells, but you'd still be assuming which cell you can increment.

Not sure what you mean with "specify any parent interrupt" here.  For
the GIC and AIC the three cells encode the interrupt type, interrupt
number, and trigger level/polarity.  And for MSIs the interrupt type
and trigger level/polarity are pretty much implied.  It is genericish
in the sense that it follows the pattern of the "mbi-ranges" in the
arm,gic-v3.yaml binding.

> I think you should just list all these under 'interrupts' using 
> interrupt-names to make your life easier:
> 
> interrupt-names:
>   items:
>     - const: port0
>     - const: port1
>     - const: port2
>     - const: msi0
>     - const: msi1
>     - const: msi2
>     - const: msi3
>     ...
> 
> Yeah, it's kind of verbose, but if the h/w block handles N interrupts, 
> you should list N interrupts. The worst case for the above is N entries 
> too if not contiguous.

Hmm, "msi-ranges" was what Marc Zyngier came up with since he didn't
really like the approach you sketch above.  And he gave this version
of the binding his blessing.  Your approach would work fine as well,
although doing a string-based lookup for each MSI vector is a bit
ugly.
