Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D6100D9B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 22:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRVXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 16:23:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35479 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfKRVXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 16:23:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so16777316oig.2;
        Mon, 18 Nov 2019 13:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aslK2Zau5UQNVUGQIY5kjkRzSDnrxpv/018CjIjj4ig=;
        b=mv6vCotSGmRkeGWMuK2I6wjfKMKULk0bYHhARRslO8QHhQGfkccy2w7KAmmWgGVNT1
         Ll1v+5hos8J/d9Jh8zw4bbFylN3E5o3LDr/RzD6CXtx6kcoguPDU80NqSdpx4mpiVMTa
         zNS48DtOprhsfjKDbzkj5oessGbkvpSUbIQhWttXuB8LBytvC3rLbJ8PZ2zFTdW7SQ83
         QBlIH5Km6DOSWoFtgEGAJybmyBnpUgh+pf2a+0jj9EqpmRFOVol7qajdm20WsMflX5pF
         gnhUc8uPnVOFI2ucnkXRwREu/1v5e+gcKZlwunbhU2BqSFGzpIZeK8bROUZlGiP352zJ
         MYAA==
X-Gm-Message-State: APjAAAXkFaUepHbQ2IJxzAcLLMb0bwJRPIzaeU6ymd6wIpPf70IcqqGB
        cnAqppCTGdaQbdiUB11M5Q==
X-Google-Smtp-Source: APXvYqy9vLHIfptxJOZyAdofVkBHARL4vvFxl6WV3GMXs+WxxP4W8AujWNmvKD8eIz7DkSM9Gg1LIA==
X-Received: by 2002:aca:4e88:: with SMTP id c130mr895664oib.41.1574112193960;
        Mon, 18 Nov 2019 13:23:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm6575789otq.31.2019.11.18.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:23:12 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:23:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, jeremy.linton@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: Add bindings for brcmstb's PCIe
 device
Message-ID: <20191118212312.GA24969@bogus>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112155926.16476-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 04:59:21PM +0100, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> The DT bindings description of the brcmstb PCIe device is described.
> This node can only be used for now on the Raspberry Pi 4.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
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
>  .../bindings/pci/brcm,stb-pcie.yaml           | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> new file mode 100644
> index 000000000000..4cbb18821300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -0,0 +1,110 @@
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

I added a common PCI schema to dt-schema. You can reference it here:

allOf:
  - $ref: /schemas/pci/pci-bus.yaml#

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

Drop all these as the pci-bus.yaml will cover them.

> +
> +  ranges: true

Do you know many entries, if not, you can drop it too?

> +
> +  dma-ranges: true

Do you know many entries, if not, you can drop it too?

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

Assume these 2 have a type defined.

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

You can drop ranges, #address-cells and #size-cells as they are required 
in pci-bus.yaml.

Shouldn't interrupts, interrupt-names, and msi-controller all be 
required?

> +
> +additionalProperties: false

This won't work having the commmon binding, but 
'unevaluatedProperties: false' will (eventually when json-schema draft8 
is supported). 

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

Bracket each entry. The schema is making this stricter.

Rob
