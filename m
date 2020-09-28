Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B927B32F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1R3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 13:29:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38436 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI1R3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 13:29:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id 26so2203163ois.5;
        Mon, 28 Sep 2020 10:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jJg+JuBS7envIzSlxdKWB79rWdVga1m/Jc0k1s7APE=;
        b=mGL8vbiyWaTqzSIKHGYxrThQQgKZl4UbVfr1TOB5UAx/gPrZRTRMveugHsaGTZsiFe
         K9IHq6p0GWRo4efgSbT7euCg7s+lLz4P9XRxl8xKaXWvaUOJ/ePc61hrAE5LD0Zq3Nju
         57t90ul0yKz+6x9C0dw0ZjwbKtnzORWt0DgpXU97SkaQTNeaE2MEdb7FrPJipLc2+c/E
         A4csVkrKwMQrCy/O6iX02L5K1q8VoAXomM/c5uKwmV2cDuiT5wQW3zHgjOEH+jzMU6yn
         hVZrlRyzzJ3SH1I6c8INL0SEWGlZ+asVZOTIpiAQHY1D+yQ7pYxhzQJHc3h9IDtetYIS
         bP5A==
X-Gm-Message-State: AOAM532kb5l0o+I4JFDiXtuInDX0UJbxU2Wkt2oSGH4uiL3gWoRyXaW5
        Ks+z6t3JZJKwwxVRX3LOvQ==
X-Google-Smtp-Source: ABdhPJy5vjnHX7nJ+IXg07n+MLxnmaQB29B6dSjy/9SrBF43Kf2N0Zk7KHwt3e7ikmX+aBGQUrd7eA==
X-Received: by 2002:aca:60d5:: with SMTP id u204mr3937oib.8.1601314143845;
        Mon, 28 Sep 2020 10:29:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y84sm342766oia.10.2020.09.28.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:29:03 -0700 (PDT)
Received: (nullmailer pid 2937065 invoked by uid 1000);
        Mon, 28 Sep 2020 17:29:02 -0000
Date:   Mon, 28 Sep 2020 12:29:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com
Subject: Re: [v3,1/3] dt-bindings: PCI: mediatek: Add YAML schema
Message-ID: <20200928172902.GA2934170@bogus>
References: <20200927074555.4155-1-jianjun.wang@mediatek.com>
 <20200927074555.4155-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927074555.4155-2-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 03:45:53PM +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> new file mode 100644
> index 000000000000..c7b5dd132ebd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek-pcie-gen3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gen3 PCIe controller on MediaTek SoCs
> +
> +maintainers:
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt8192-pcie

Don't need 'oneOf' with only 1 entry.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ranges:
> +    minItems: 1
> +    maxItems: 8
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    anyOf:
> +      - const: mac-rst
> +      - const: phy-rst
> +
> +  clocks:
> +    maxItems: 5

Need to define what the clocks are and order.

> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +      '#interrupt-cells':
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ranges
> +  - clocks
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie: pcie@11230000 {
> +            compatible = "mediatek,mt8192-pcie";
> +            device_type = "pci";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            reg = <0x00 0x11230000 0x00 0x4000>;
> +            reg-names = "pcie-mac";
> +            interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0x00 0x12000000 0x00 0x12000000 0x00 0x1000000>;
> +            clocks = <&infracfg 40>,
> +                     <&infracfg 43>,
> +                     <&infracfg 97>,
> +                     <&infracfg 99>,
> +                     <&infracfg 111>;
> +            assigned-clocks = <&topckgen 50>;
> +            assigned-clock-parents = <&topckgen 91>;
> +
> +            phys = <&pciephy>;
> +            phy-names = "pcie-phy";
> +            resets = <&infracfg_rst 0>;
> +            reset-names = "phy-rst";
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0x7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +                            <0 0 0 2 &pcie_intc 1>,
> +                            <0 0 0 3 &pcie_intc 2>,
> +                            <0 0 0 4 &pcie_intc 3>;
> +            pcie_intc: interrupt-controller {
> +                      #address-cells = <0>;
> +                      #interrupt-cells = <1>;
> +                      interrupt-controller;
> +            };
> +        };
> +    };
> -- 
> 2.25.1
