Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F97302C73
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 21:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbhAYUX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 15:23:59 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35417 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbhAYUXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 15:23:05 -0500
Received: by mail-oi1-f178.google.com with SMTP id w8so16181911oie.2;
        Mon, 25 Jan 2021 12:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flH03nsBpe00qQdsxJOcf2ps7GrLZPGe76i1E36MC1w=;
        b=gOXNX+0k6xYzBLbgkk+c1iflRQC9AreciGxXDhQC2opllTLufH4xDsPldtcTBlmH7h
         PjEXb1nU3RwaOI56rOPCwny+ngr+T4zrEZZO+F45SFw6hjRzJ/RfrHwZ3TAT6dtNJ/Xb
         rOKCwt0laXMlYV2LjI4SczPSwNA278YHRHbQOWYz86E5KlVtD4HCJSrD334nWGgBYhW/
         8HD9rkcJD+Obo5vz/odp4Qe5/14LKBgg3131Dt6azdXyy32FRqez/poZgS/u6WC5EWT/
         R14zLIZQXN/o6Q6ayo4vt6FgdnfklrJ9ZVb/sDVsokjMNX3sX92Vl2Go6hdB90ciZU8D
         uLTA==
X-Gm-Message-State: AOAM5334Fh0ES8cjOat8hFpMc5hdYQZIKrVSuUcZtcYrjB34TQukXLPD
        8AYMZmrYKLDpq0/sUAjgTZaEwCkAUg==
X-Google-Smtp-Source: ABdhPJw8JJtpG3VCKMiMILQJceIiVEob/sgewfQC9q50O2WEX+Mur0PRRcu7fqAgtWlD3ee1xKkv4Q==
X-Received: by 2002:aca:c48b:: with SMTP id u133mr1195539oif.105.1611606143985;
        Mon, 25 Jan 2021 12:22:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm3761987oth.41.2021.01.25.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:22:22 -0800 (PST)
Received: (nullmailer pid 912195 invoked by uid 1000);
        Mon, 25 Jan 2021 20:22:20 -0000
Date:   Mon, 25 Jan 2021 14:22:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v7,1/7] dt-bindings: PCI: mediatek-gen3: Add YAML schema
Message-ID: <20210125202220.GA905995@robh.at.kernel.org>
References: <20210113114001.5804-1-jianjun.wang@mediatek.com>
 <20210113114001.5804-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113114001.5804-2-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 13, 2021 at 07:39:55PM +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> new file mode 100644
> index 000000000000..f133fb0184f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -0,0 +1,172 @@
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
> +description: |+
> +  PCIe Gen3 MAC controller for MediaTek SoCs, it supports Gen3 speed
> +  and compatible with Gen2, Gen1 speed.
> +
> +  This PCIe controller supports up to 256 MSI vectors, the MSI hardware
> +  block diagram is as follows:
> +
> +                    +-----+
> +                    | GIC |
> +                    +-----+
> +                       ^
> +                       |
> +                   port->irq
> +                       |
> +               +-+-+-+-+-+-+-+-+
> +               |0|1|2|3|4|5|6|7| (PCIe intc)
> +               +-+-+-+-+-+-+-+-+
> +                ^ ^           ^
> +                | |    ...    |
> +        +-------+ +------+    +-----------+
> +        |                |                |
> +  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
> +  |0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
> +  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
> +   ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
> +   | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
> +   | |      |  |    | |      |  |    | |      |  |
> +
> +    (MSI SET0)       (MSI SET1)  ...   (MSI SET7)
> +
> +  With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
> +  each set has its own address for MSI message, and supports 32 MSI vectors
> +  to generate interrupt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8192-pcie
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

Why the range? The SoC either has the reset lines or it doesn't.

> +
> +  reset-names:
> +    anyOf:
> +      - const: mac
> +      - const: phy

I don't think this should stay, but if so, better expressed like this:

minItems: 1
maxItems: 2
items:
  enum: [ mac, phy ]


> +
> +  clocks:
> +    maxItems: 6
> +
> +  clock-names:
> +    items:
> +      - const: pl_250m
> +      - const: tl_26m
> +      - const: tl_96m
> +      - const: tl_32k
> +      - const: peri_26m
> +      - const: top_133m
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

Not documented. Drop.

> +            interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0x00 0x12000000 0x00
> +                      0x12000000 0x00 0x1000000>;
> +            clocks = <&infracfg 44>,
> +                     <&infracfg 40>,
> +                     <&infracfg 43>,
> +                     <&infracfg 97>,
> +                     <&infracfg 99>,
> +                     <&infracfg 111>;
> +            clock-names = "pl_250m", "tl_26m", "tl_96m",
> +                          "tl_32k", "peri_26m", "top_133m";
> +            assigned-clocks = <&topckgen 50>;
> +            assigned-clock-parents = <&topckgen 91>;
> +
> +            phys = <&pciephy>;
> +            phy-names = "pcie-phy";
> +            resets = <&infracfg_rst 0>;
> +            reset-names = "phy";
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
> 
