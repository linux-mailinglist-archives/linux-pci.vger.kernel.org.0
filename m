Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE12620FB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIHUVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 16:21:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37472 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgIHUVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 16:21:35 -0400
Received: by mail-io1-f66.google.com with SMTP id y13so763487iow.4;
        Tue, 08 Sep 2020 13:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mm/0h/U4Hk8WZoslYbu06tgoMG60luGtcEO7empM/LM=;
        b=HsoPU5zE+Y5aOvmSofhpBotS2gTlBoUIcsoCACkVH3xnGG8YlErKoF1j15hTAOJtYY
         ooxrOBIS7fsZoqpvr57fRFMWg5149Sb50SL4VCkW2m9C9dAUXGBP4CwXN/RLX8LpnUof
         jRZDFphnImygR1IBHnEMvEPZ2IrjoMxWzlF/M/DVzQ6DqtwPKrp9UgWe2Nsl2633X8qJ
         BFmLeY2fIWV+EWXwLBSMcrkBBZq3H2MYhn/Idm6ItCEqmtlUbrh+VYRODwS+62spEwpc
         /eohNJf3OrqxDYoA/aVdGKzmgS5oksPQ9Gu4v4E/hZ6XpLH2bKU1YVOe/GKTc/eE1HNO
         033Q==
X-Gm-Message-State: AOAM530Xcw8NtUGPWVQYDNxTIN3ANH35mo/KTSE8jjRmtfDnjdOoMRfG
        OlWSVKAFlYTmFvxO3KrrEg==
X-Google-Smtp-Source: ABdhPJzUbzrN+RY+vhi1RmrWGIbRcEKWdSSpIQ2B/z7XSscUwOM2o8va4ubaqnTUUjSxZudsonpogg==
X-Received: by 2002:a5e:820d:: with SMTP id l13mr566194iom.3.1599596494661;
        Tue, 08 Sep 2020 13:21:34 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c12sm143227ilm.17.2020.09.08.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:21:34 -0700 (PDT)
Received: (nullmailer pid 843613 invoked by uid 1000);
        Tue, 08 Sep 2020 20:21:31 -0000
Date:   Tue, 8 Sep 2020 14:21:31 -0600
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
        Sj Huang <sj.huang@mediatek.com>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
Message-ID: <20200908202131.GB795070@bogus>
References: <20200907120852.12090-1-jianjun.wang@mediatek.com>
 <20200907120852.12090-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907120852.12090-2-jianjun.wang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 08:08:50PM +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.

dt-bindings: PCI: mediatek: ... for the subject.

> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> new file mode 100644
> index 000000000000..108d29259c05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -0,0 +1,158 @@
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
> +      - const: mediatek,gen3-pcie
> +      - const: mediatek,mt8192-pcie
> +

> +  device_type:
> +    const: pci
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Can drop these 3. Already in pci-bus.yaml.

> +
> +  reg:
> +    items:
> +      - description: Controller control and status registers.

Just 'maxItems: 1'. The description doesn't add any value.

> +
> +  reg-names:
> +    items:
> +      - const: pcie-mac

Don't really need a name here.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
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

Doesn't the PHY's reset belong in the PHY node?

> +
> +  clocks:
> +    maxItems: 5
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
> +  phy-names:
> +    const: pcie-phy

Not really a useful name and there's only one. Please drop.

> +
> +  '#interrupt-cells':
> +    const: 1
> +

> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.

Can drop these.

> +
> +  legacy-interrupt-controller:

Just 'interrupt-controller'

And don't copy the same bug of using 'of_get_next_child'. You should get 
the child node by name.

> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      "#address-cells":
> +        const: 0
> +      "#interrupt-cells":
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +      - interrupt-controller

       additionalProperties: false

> +
> +required:
> +  - compatible

> +  - device_type
> +  - "#address-cells"
> +  - "#size-cells"

Don't need these, pci-bus.yaml already requires them.

> +  - reg
> +  - reg-names
> +  - bus-range

If the range is 0-0xff, then this isn't really required.

> +  - interrupts
> +  - ranges
> +  - clocks
> +  - '#interrupt-cells'
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - legacy-interrupt-controller
> +
> +additionalProperties: false

unevaluatedProperties: false

(Should be used when including a ref (pci-bus.yaml).)

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
> +            pcie_intc: legacy-interrupt-controller {
> +                      #address-cells = <0>;
> +                      #interrupt-cells = <1>;
> +                      interrupt-controller;
> +            };
> +        };
> +    };
> -- 
> 2.25.1
