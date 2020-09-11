Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5459726761D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgIKWqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 18:46:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36234 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKWp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 18:45:57 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so10443328ils.3;
        Fri, 11 Sep 2020 15:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fs8hJLKKuPyihlvosCyrS95zzNN/iMkcZrv6osKY3zA=;
        b=Pwtlu4HvJVHgI1wuOEzCTOu66ZCETiDrb/miksjCS6ZMpTG+Ey4SPN5WQRVTKuerSl
         5HznVMTLeJwjXZ6QFF6bB1exq/8SNiYvI0ClN/9ipfJeVKv8uWAiUfksUaSHqZAqWyjz
         OBhiqzQWsGMfEVCbDs0Rd6hLwqRNdrCMzGfr2DV2V8pxekxTGQ812S7sKOIqk7pkdJUZ
         vswtDFq6WiuXy+SXOPKlzKf/r+rpi0tF+S4LSwiS3PeFky7VygFFM6/sjEn3qObsj/jl
         jsmMthrNuwuWx5zDtwNSMHflXiZdQKOQe5VyAlxQrwojrGD3hNvE5J1XR5ZDyw2tN6F2
         hiQA==
X-Gm-Message-State: AOAM530JWULlOr6Mfv8JdoP98th82usF9Z99O3Vb4tpbQrfaUzlrlwbQ
        yDF/ZFNuN3yxbFflnaoZIA==
X-Google-Smtp-Source: ABdhPJyTOxbDQQhiOFwx0WSd2Hhwm1KX9bxfrHOz+sl9GPyks/Kgrf2FM2rVgq9ty7FDRvCpnpaIHg==
X-Received: by 2002:a92:8548:: with SMTP id f69mr3610656ilh.46.1599864356073;
        Fri, 11 Sep 2020 15:45:56 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q191sm1796222iod.30.2020.09.11.15.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:45:55 -0700 (PDT)
Received: (nullmailer pid 2959952 invoked by uid 1000);
        Fri, 11 Sep 2020 22:45:54 -0000
Date:   Fri, 11 Sep 2020 16:45:54 -0600
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
Subject: Re: [v2,1/3] dt-bindings: PCI: mediatek: Add YAML schema
Message-ID: <20200911224554.GB2905744@bogus>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
 <20200910034536.30860-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910034536.30860-2-jianjun.wang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 11:45:34AM +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> new file mode 100644
> index 000000000000..a2dfc0d15d2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -0,0 +1,130 @@
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

Generic compatibles like this should only be a fallback string, not on 
its own.

> +      - const: mediatek,mt8192-pcie
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

Drop this. Standard property.

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
