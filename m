Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF7FA7E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 05:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMEPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 23:15:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35707 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKMEPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 23:15:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id z6so478140otb.2;
        Tue, 12 Nov 2019 20:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fu3Y/4lCeDSudNWi+wvYdwt8kDwqIxhy6RedI/4rb48=;
        b=I0kEQgPZzvbMz3kEE2r6A6XpCNlpBFKHOCcwuFO7y38oZkWBQnWBfzKGWQVscdnvPD
         Wx94zwVO2teY/zniBbr+oNhUxWu66HQ90fX7V2vhbPn9QWRALsuzoyNSYJBb41Igi3N0
         6t6Mf0PwxuhnHL6xcwLqO/2dJ+p7IeUVeug0uwzoLcIgMMz5oasdE0JBDLeZfd70LPSx
         lxFih57Y7e0v3ZPjpxzmou8fxP7856lal3acVql6EJze0Um3aPhhJEqDLZfNDrAaQFc3
         gKCrRWYS2yKaSXSuZKLSj7dNzOkwX7U3ljEEJHY9Ez4D0fhb0PkTVVXZaA7gcisBp6oY
         DTBA==
X-Gm-Message-State: APjAAAWEpwURm34coqfWGN1ClL5cwTUgyllxx/dvVmely23MpZGS0Pss
        fIWSaO3sHvEFZljdabxcNw==
X-Google-Smtp-Source: APXvYqxbN5/QlD1YTfwus6CP4J23kgOsBx8dLDfsU2Js+cOxTe7uQW9y/ENAShKBJ4fIZy7N6jInJw==
X-Received: by 2002:a9d:a63:: with SMTP id 90mr1061108otg.346.1573618534975;
        Tue, 12 Nov 2019 20:15:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o14sm295660oie.24.2019.11.12.20.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 20:15:34 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:15:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pci: add bindings for brcmstb's PCIe
 device
Message-ID: <20191113041533.GA25497@bogus>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106214527.18736-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 10:45:23PM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> The DT bindings description of the brcmstb PCIe device is described.
> This node can only be used for now on the Raspberry Pi 4.
> 
> This was based on Jim's original submission[1], converted to yaml and
> adapted to the RPi4 case.
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

I'm working on a common PCI host schema that should cut down some of the 
standard props.

> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> new file mode 100644
> index 000000000000..0b81c26f8568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

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

4 entries?

You'll need to bracket <> each entry in the example and dts.

> +
> +  ranges: true

How many entries?

> +
> +  dma-ranges: true

How many entries?

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
