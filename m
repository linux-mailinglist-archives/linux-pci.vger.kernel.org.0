Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BED29284D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgJSNiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 09:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgJSNiy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 09:38:54 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CDF42223C;
        Mon, 19 Oct 2020 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603114733;
        bh=QLl//rSYnpjI4XjsLivmaRA2q702aMuao3NMwW0AZCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZJ0UeatYQoCfuwjODgSFqcdGke2T/VzdRlInpmZ8BW5LGWfYNWT6Us7AD7LSvghAw
         ovGl1TIHvNQ1Sik3JLTWfyDAndg1U+svVh3VWmUaKrDtjgiTDSyC7LZJHgri7Y4Lum
         sBVeb1uXisrOJIxuAsOY6PKTBBO7RZkwfiv/NJgs=
Received: by mail-ot1-f44.google.com with SMTP id e20so10432464otj.11;
        Mon, 19 Oct 2020 06:38:53 -0700 (PDT)
X-Gm-Message-State: AOAM530TEX2PGRION19xoUwOSsLg6yhtDxFyg4kuwTBINxxZoPXRgCbB
        zw+jg7fyyOYnANSDZ8amaF+RjCOhH5R/jHvdug==
X-Google-Smtp-Source: ABdhPJxPScoNZrlBxS9IlCTidVRXbPv6VWkKWABPQ2lSmgTF04BwvvKmDYpcVnycQB3EFkkwQ2mstx5y1VG7XAji/kU=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr10559otm.129.1603114732682;
 Mon, 19 Oct 2020 06:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
 <20201019094715.15343-1-m.szyprowski@samsung.com> <20201019094715.15343-3-m.szyprowski@samsung.com>
In-Reply-To: <20201019094715.15343-3-m.szyprowski@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Oct 2020 08:38:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+X3w=1-_SpXPTdO_UGg5er9vU-XETT-NbS96LSfNLUVQ@mail.gmail.com>
Message-ID: <CAL_Jsq+X3w=1-_SpXPTdO_UGg5er9vU-XETT-NbS96LSfNLUVQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 4:47 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> variant).
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
>            rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> new file mode 100644
> index 000000000000..48fb569c238c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
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
> +    enum:
> +      - samsung,exynos5433-pcie
> +
> +  reg:
> +    items:
> +      - description: External Local Bus interface (ELBI) registers.
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: elbi
> +      - const: bdi

dbi

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
> +  phy-names:
> +    const: pcie-phy

Kind of a pointless name.

> +
> +  vdd10-supply:
> +    description:
> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
> +
> +  vdd18-supply:
> +    description:
> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - vdd10-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/exynos5433.h>
> +
> +    pcie: pcie@15700000 {
> +        compatible = "samsung,exynos5433-pcie";
> +        reg = <0x156b0000 0x1000>, <0x15700000 0x1000>, <0x0c000000 0x1000>;
> +        reg-names = "elbi", "dbi", "config";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <1>;
> +        device_type = "pci";
> +        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
> +        clock-names = "pcie", "pcie_bus";
> +        phys = <&pcie_phy>;
> +        phy-names = "pcie-phy";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
> +        num-lanes = <1>;
> +        bus-range = <0x00 0xff>;
> +        ranges = <0x81000000 0 0         0x0c001000 0 0x00010000>,
> +                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
> +        vdd10-supply = <&ldo6_reg>;
> +        vdd18-supply = <&ldo7_reg>;
> +        iterrupt-map-mask = <0 0 0 0>;

typo

> +        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> --
> 2.17.1
>
