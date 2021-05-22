Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF238D614
	for <lists+linux-pci@lfdr.de>; Sat, 22 May 2021 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhEVN7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 May 2021 09:59:06 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:51824 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhEVN6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 May 2021 09:58:55 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id c4a205f5;
        Sat, 22 May 2021 15:57:27 +0200 (CEST)
Date:   Sat, 22 May 2021 15:57:27 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Robin Murphy <robin.murphy@arm.com>, sven@svenpeter.dev
Cc:     devicetree@vger.kernel.org, maz@kernel.org, arnd@arndb.de,
        kettenis@openbsd.org, marcan@marcan.st, bhelgaas@google.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <be890747-5f6d-8a7d-3e20-db58463028b1@arm.com> (message from
        Robin Murphy on Tue, 18 May 2021 15:10:01 +0100)
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
 <20210516211851.74921-2-mark.kettenis@xs4all.nl> <be890747-5f6d-8a7d-3e20-db58463028b1@arm.com>
Message-ID: <5612ef8f8dd80e4d@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Robin Murphy <robin.murphy@arm.com>
> Date: Tue, 18 May 2021 15:10:01 +0100

Hi Robin,

> On 2021-05-16 22:18, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > The Apple PCIe host controller is a PCIe host controller with
> > multiple root ports present in Apple ARM SoC platforms, including
> > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >   .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
> >   MAINTAINERS                                   |   1 +
> >   2 files changed, 151 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > new file mode 100644
> > index 000000000000..af3c9f64e380
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > @@ -0,0 +1,150 @@
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
> > +    minItems: 4
> > +    maxItems: 6
> > +
> > +  reg-names:
> > +    minItems: 4
> > +    maxItems: 7
> > +    items:
> > +      - const: ecam
> > +      - const: rc
> > +      - const: phy
> > +      - const: port0
> > +      - const: port1
> > +      - const: port2
> > +
> > +  ranges:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 3
> > +    maxItems: 3
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
> > +    #include <dt-bindings/pinctrl/apple.h>
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
> > +              <0x6 0x8c000000 0x0 0x4000>,
> > +              <0x6 0x81000000 0x0 0x8000>,
> > +              <0x6 0x82000000 0x0 0x8000>,
> > +              <0x6 0x83000000 0x0 0x8000>;
> > +        reg-names = "ecam", "rc", "phy", "port0", "port1", "port2";
> > +
> > +        interrupt-parent = <&aic>;
> > +        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        msi-controller;
> > +        msi-parent = <&pcie0>;
> > +        msi-ranges = <704 32>;
> > +
> > +        iommu-map = <0x0 &dart0 0x8000 0x100>,
> > +                    <0x100 &dart0 0x100 0x100>,
> > +                    <0x200 &dart1 0x200 0x100>,
> > +                    <0x300 &dart2 0x300 0x100>;
> > +        iommu-map-mask = <0xff00>;
> 
> This doesn't quite add up - if the mask is ignoring the bottom 8 bits, 
> then each of those map entries is describing one single ID mapping, not 256.
> 
> > +        bus-range = <0 7>;
> 
> Given that the iommu-map only covers buses 0-3, what happens to traffic 
> from buses 4-7?

Yes, that probably needs a little bit of thought.

The hardware is somewhat "interesting".  The PCIe host bridge has (up
to) three ports.  Each port is associated with its own IOMMU/DART.
Each port provides mapping logic that maps the RID to an SID.  There
are 16 mapping registers for the PCIe host bridge that connects the
onboard devices and 64 mapping registers for the PCIe host bridges
that are asociated with the Thunderbolt ports.

If no mappings are enabled, it seems that all RIDs get mapped to SID
0.  The Apple firmware doesn't enable any mappings and my U-Boot code
doesn't change it either.

The Corellium folks in their port chose a 1:1 mapping from bus number
to SID and that is what the example above came from.  Both my U-Boot
driver and my OpenBSD actually ignore the SID and install the same
IOMMU translation table for all the SIDs.  That's probably good enough
for U-Boot as long as we don't enable the Thunderbolt ports.  But for
the OS itself a bit more control is certainly desirable.

Would it be reasonable to allow the device tree some flexibility in
specifying the desired iommu mapping and let the OS PCIe host bride
driver program the RID to SID mappings to match what's specified in
the "iommu-map" and "iommu-map-mask" properties?

Or is it better to just pick a mapping scheme like Corellium did and
make that part of the DT binding?

Thanks,

Mark

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
> > index 7327c9b778f1..789d79315485 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1654,6 +1654,7 @@ C:	irc://chat.freenode.net/asahi-dev
> >   T:	git https://github.com/AsahiLinux/linux.git
> >   F:	Documentation/devicetree/bindings/arm/apple.yaml
> >   F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > +F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
> >   F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> >   F:	arch/arm64/boot/dts/apple/
> >   F:	drivers/irqchip/irq-apple-aic.c
> > 
> 
