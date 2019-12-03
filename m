Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF921100C5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCPDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 10:03:16 -0500
Received: from foss.arm.com ([217.140.110.172]:43988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLCPDQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 10:03:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78F531B;
        Tue,  3 Dec 2019 07:03:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3888E3F52E;
        Tue,  3 Dec 2019 07:03:14 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:03:12 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: PCI: Add bindings for brcmstb's PCIe
 device
Message-ID: <20191203150312.GD18399@e119886-lin.cambridge.arm.com>
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
 <20191203114743.1294-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203114743.1294-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 03, 2019 at 12:47:34PM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> The DT bindings description of the brcmstb PCIe device is described.
> This node can only be used for now on the Raspberry Pi 4.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
> Changes since v2:
>   - Add pci reference schema
>   - Drop all default properties
>   - Assume msi-controller and msi-parent are properly defined
>   - Add num entries on multiple properties
>   - use unevaluatedProperties
>   - Update required properties
>   - Fix license
> 
> Changes since v1:
>   - Fix commit Subject
>   - Remove linux,pci-domain
> 
> This was based on Jim's original submission[1], converted to yaml and
> adapted to the RPi4 case.
> 
> [1] https://patchwork.kernel.org/patch/10605937/
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> new file mode 100644
> index 000000000000..77d3e81a437b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
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
> +  ranges:
> +    maxItems: 1
> +
> +  dma-ranges:
> +    maxItems: 1
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
> +
> +  msi-parent:
> +    description: MSI controller the device is capable of using.
> +
> +  brcm,enable-ssc:
> +    description: Indicates usage of spread-spectrum clocking.
> +    type: boolean
> +
> +required:
> +  - reg
> +  - dma-ranges
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - msi-controller
> +
> +unevaluatedProperties: false
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
> +                    device_type = "pci";
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    #interrupt-cells = <1>;
> +                    interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "pcie", "msi";
> +                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +                    msi-parent = <&pcie0>;
> +                    msi-controller;
> +                    ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
> +                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
> +                    brcm,enable-ssc;
> +            };
> +    };
> -- 
> 2.24.0
> 
