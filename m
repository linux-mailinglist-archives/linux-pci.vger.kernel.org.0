Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24C42A6FB8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKDVfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 16:35:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44392 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDVfm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 16:35:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id t16so6418451oie.11;
        Wed, 04 Nov 2020 13:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsTIGAagzOnMRm7sMHojCYBN2wI108e8FrvxB5eYOtQ=;
        b=hPpUyyjscPGGM2LvgcZ/VaZBiN4cLDDSM02uc9jUYG1jP+SePWZbSQq/wl05D5Osve
         JTJ+pMNy1O5V129ItJO3BPdnqTTPWSV6GICI8a3ja40KPFJfyDIZyTJRZxviJ7UHPOkM
         9GWjpIkl/1pjXXXIzE6/BDAqojvxpit+165Dxuy9mWRtGOUWkBePYe0NAbVZIyqGscls
         xmlUiIn4siZ1GH7qKmutt5nJriNWh3Q4mX7mA8PlueAdaUC7sFHebcv//wFQNj7YvDJ1
         Rlv8wGYkCX3oPVlYlfhtRo96Lmel39wo24HY1Ro1xUtiRiC8hUVJ/xwfsc5ep2FZ0EGo
         876g==
X-Gm-Message-State: AOAM531RVb13hU3FcTb2yvxCLhxzxyx0HHl3d4DBRpVrw1muRA4VSKXh
        +pGt4T9VsKhacZ5TdYvifA==
X-Google-Smtp-Source: ABdhPJyNHCIleN5pdM4VTuW7A8t+EwS1FMDVPZZfBh64Vpq2rBA54/k5ISX86pTWQ4vqWPhYl1VYag==
X-Received: by 2002:aca:2111:: with SMTP id 17mr3648355oiz.139.1604525740674;
        Wed, 04 Nov 2020 13:35:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm769596otc.36.2020.11.04.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:35:40 -0800 (PST)
Received: (nullmailer pid 4163321 invoked by uid 1000);
        Wed, 04 Nov 2020 21:35:39 -0000
Date:   Wed, 4 Nov 2020 15:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Message-ID: <20201104213539.GA4144654@bogus>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47@eucas1p2.samsung.com>
 <20201029134017.27400-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029134017.27400-3-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 02:40:13PM +0100, Marek Szyprowski wrote:
> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> variant). Based on the text dt-binding posted by Jaehoon Chung.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> new file mode 100644
> index 000000000000..1810bf722350
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Marek Szyprowski <m.szyprowski@samsung.com>
> +  - Jaehoon Chung <jh80.chung@samsung.com>
> +
> +description: |+
> +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,exynos5433-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: External Local Bus interface (ELBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: elbi
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PCIe bridge clock
> +      - description: PCIe bus clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +
> +  phys:
> +    maxItems: 1
> +
> +  vdd10-supply:
> +    description:
> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
> +
> +  vdd18-supply:
> +    description:
> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
> +
> +  num-lanes:
> +    const: 1
> +
> +  num-viewport:
> +    const: 3

I'm confused why you need this. This is only used with the iATU except 
for keystone. Platforms like Exynos with their own child bus config 
space accessors don't have an iATU. 

BTW, for cases with an iATU, I'm working on making the number of 
viewports runtime detected.

> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - ranges
> +  - bus-range
> +  - device_type
> +  - num-lanes
> +  - num-viewport
> +  - clocks
> +  - clock-names
> +  - phys
> +  - vdd10-supply
> +  - vdd18-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/exynos5433.h>
> +
> +    pcie: pcie@15700000 {
> +        compatible = "samsung,exynos5433-pcie";
> +        reg = <0x15700000 0x1000>, <0x156b0000 0x1000>, <0x0c000000 0x1000>;
> +        reg-names = "dbi", "elbi", "config";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <1>;
> +        device_type = "pci";
> +        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
> +        clock-names = "pcie", "pcie_bus";
> +        phys = <&pcie_phy>;
> +        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
> +        pinctrl-names = "default";
> +        num-lanes = <1>;
> +        num-viewport = <3>;
> +        bus-range = <0x00 0xff>;
> +        ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
> +                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
> +        vdd10-supply = <&ldo6_reg>;
> +        vdd18-supply = <&ldo7_reg>;
> +        interrupt-map-mask = <0 0 0 0>;
> +        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> -- 
> 2.17.1
> 
