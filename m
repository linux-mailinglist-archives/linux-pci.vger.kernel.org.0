Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16545F2C6E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfKGKcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 05:32:39 -0500
Received: from foss.arm.com ([217.140.110.172]:53698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbfKGKci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 05:32:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 139551FB;
        Thu,  7 Nov 2019 02:32:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5D83F71A;
        Thu,  7 Nov 2019 02:32:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:32:35 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pci: add bindings for brcmstb's PCIe
 device
Message-ID: <20191107103235.GW9723@e119886-lin.cambridge.arm.com>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106214527.18736-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 10:45:23PM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>

Nit: Looking at past git history, ideally the patch subject would be
'dt-bindings: *PCI*: *A*dd bindings for brcmstb's PCIe.

> 
> The DT bindings description of the brcmstb PCIe device is described.
> This node can only be used for now on the Raspberry Pi 4.
> 
> This was based on Jim's original submission[1], converted to yaml and
> adapted to the RPi4 case.

Thanks for picking this up.

> 
> [1] https://patchwork.kernel.org/patch/10605937/
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> new file mode 100644
> index 000000000000..0b81c26f8568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: PCIe host controller
> +      - description: builtin MSI controller
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: pcie
> +      - const: msi
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-map-mask: true
> +
> +  interrupt-map: true
> +
> +  ranges: true
> +
> +  dma-ranges: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sw_pcie
> +
> +  msi-controller:
> +    description: Identifies the node as an MSI controller.
> +    type: boolean
> +
> +  msi-parent:
> +    description: MSI controller the device is capable of using.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  linux,pci-domain:
> +    description: PCI domain ID. Should be unique for each host controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  brcm,enable-ssc:
> +    description: Indicates usage of spread-spectrum clocking.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - ranges
> +  - dma-ranges
> +  - linux,pci-domain

I don't think pci-domain is *required* is it?

Thanks,

Andrew Murray

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    scb {
> +            #address-cells = <2>;
> +            #size-cells = <1>;
> +            pcie0: pcie@7d500000 {
> +                    compatible = "brcm,bcm2711-pcie";
> +                    reg = <0x0 0x7d500000 0x9310>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    #interrupt-cells = <1>;
> +                    interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "pcie", "msi";
> +                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH
> +                                     0 0 0 2 &gicv2 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH
> +                                     0 0 0 3 &gicv2 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH
> +                                     0 0 0 4 &gicv2 GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +                    msi-parent = <&pcie0>;
> +                    msi-controller;
> +                    ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
> +                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
> +                    linux,pci-domain = <0>;
> +                    brcm,enable-ssc;
> +            };
> +    };
> -- 
> 2.23.0
> 
