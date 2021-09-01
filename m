Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3363FD8B9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbhIALaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 07:30:21 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:63913 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhIALaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 07:30:21 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ddf5f73a;
        Wed, 1 Sep 2021 13:29:22 +0200 (CEST)
Date:   Wed, 1 Sep 2021 13:29:22 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, maz@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, jim2101024@gmail.com,
        nsaenz@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <YS6dWI4wwg7XkuNA@robh.at.kernel.org> (message from Rob Herring
        on Tue, 31 Aug 2021 16:21:28 -0500)
Subject: Re: [PATCH v4 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-4-mark.kettenis@xs4all.nl> <YS6dWI4wwg7XkuNA@robh.at.kernel.org>
Message-ID: <561431b178447575@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 31 Aug 2021 16:21:28 -0500
> From: Rob Herring <robh@kernel.org>
> 
> On Fri, Aug 27, 2021 at 07:15:28PM +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > The Apple PCIe host controller is a PCIe host controller with
> > multiple root ports present in Apple ARM SoC platforms, including
> > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../devicetree/bindings/pci/apple,pcie.yaml   | 165 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 166 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > new file mode 100644
> > index 000000000000..97a126db935a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > @@ -0,0 +1,165 @@
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
> > +
> > +  All root ports share a single ECAM space, but separate GPIOs are
> > +  used to take the PCI devices on those ports out of reset.  Therefore
> > +  the standard "reset-gpios" and "max-link-speed" properties appear on
> > +  the child nodes that represent the PCI bridges that correspond to
> > +  the individual root ports.
> > +
> > +  MSIs are handled by the PCIe controller and translated into regular
> > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > +  distributed over the root ports as the OS sees fit by programming
> > +  the PCIe controller's port registers.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - $ref: ../interrupt-controller/msi-controller.yaml#
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
> > +  msi-parent: true
> 
> I still think this should be dropped as it is meaningless with 
> 'msi-controller' present.

Hmm.  As far as I can tell all current arm64 device trees that
describe hardware with an MSI controller integrated on the PCI host
bridge have both the 'msi-controller' and 'msi-parent' properties.
See arch/arm64/boot/dts/marvell/aramada-37xx.dtsi and
arch/arm64/boot/dts/xilinx/zynqmp.dtsi.

The current OpenBSD code will fail to map the MSIs if 'msi-parent'
isn't there, although Linux seems to fall back on an MSI domain that's
directly attached to the host bridge if the 'msi-parent' property is
missing.  I think it makes sense to be explicit here, but if both you
and Marc think it shouldn't be there, I probably can change the
OpenBSD to do a similar fallback.

> > +
> > +#  msi-ranges:
> > +#    description:
> > +#      A list of pairs <intid span>, where "intid" is the first
> > +#      interrupt number that can be used as an MSI, and "span" the size
> > +#      of that range.
> > +#    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Here, you'll want just 'maxItems: 1' as there's only 1 entry.

Right.  As far as I can tell the Apple hardware only supports a single
range.

> > +
> > +  iommu-map: true
> > +  iommu-map-mask: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - bus-range
> > +  - interrupts
> > +  - msi-controller
> > +  - msi-parent
> > +  - msi-ranges
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pcie0: pcie@690000000 {
> > +        compatible = "apple,t8103-pcie", "apple,pcie";
> > +        device_type = "pci";
> > +
> > +        reg = <0x6 0x90000000 0x0 0x1000000>,
> > +              <0x6 0x80000000 0x0 0x4000>,
> > +              <0x6 0x81000000 0x0 0x8000>,
> > +              <0x6 0x82000000 0x0 0x8000>,
> > +              <0x6 0x83000000 0x0 0x8000>;
> > +        reg-names = "config", "rc", "port0", "port1", "port2";
> > +
> > +        interrupt-parent = <&aic>;
> > +        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        msi-controller;
> > +        msi-parent = <&pcie0>;
> > +        msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
> > +
> > +        iommu-map = <0x100 &dart0 1 1>,
> > +                    <0x200 &dart1 1 1>,
> > +                    <0x300 &dart2 1 1>;
> > +        iommu-map-mask = <0xff00>;
> > +
> > +        bus-range = <0 3>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> > +                 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> > +
> > +        clocks = <&pcie_core_clk>, <&pcie_aux_clk>, <&pcie_ref_clk>;
> > +        pinctrl-0 = <&pcie_pins>;
> > +        pinctrl-names = "default";
> > +
> > +        pci@0,0 {
> > +          device_type = "pci";
> > +          reg = <0x0 0x0 0x0 0x0 0x0>;
> > +          reset-gpios = <&pinctrl_ap 152 0>;
> > +          max-link-speed = <2>;
> > +
> > +          #address-cells = <3>;
> > +          #size-cells = <2>;
> > +          ranges;
> > +        };
> > +
> > +        pci@1,0 {
> > +          device_type = "pci";
> > +          reg = <0x800 0x0 0x0 0x0 0x0>;
> > +          reset-gpios = <&pinctrl_ap 153 0>;
> > +          max-link-speed = <2>;
> > +
> > +          #address-cells = <3>;
> > +          #size-cells = <2>;
> > +          ranges;
> > +        };
> > +
> > +        pci@2,0 {
> > +          device_type = "pci";
> > +          reg = <0x1000 0x0 0x0 0x0 0x0>;
> > +          reset-gpios = <&pinctrl_ap 33 0>;
> > +          max-link-speed = <1>;
> > +
> > +          #address-cells = <3>;
> > +          #size-cells = <2>;
> > +          ranges;
> > +        };
> > +      };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c6b8a720c0bc..30bea4042e7e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1694,6 +1694,7 @@ C:	irc://chat.freenode.net/asahi-dev
> >  T:	git https://github.com/AsahiLinux/linux.git
> >  F:	Documentation/devicetree/bindings/arm/apple.yaml
> >  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > +F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> >  F:	arch/arm64/boot/dts/apple/
> >  F:	drivers/irqchip/irq-apple-aic.c
> > -- 
> > 2.32.0
> > 
> > 
> 
