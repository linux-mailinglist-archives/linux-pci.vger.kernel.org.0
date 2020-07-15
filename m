Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F68221597
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGOTzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 15:55:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37047 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGOTzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 15:55:33 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so3582345iob.4;
        Wed, 15 Jul 2020 12:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wwLSc8ACOFK5x6W6Wvc0FQ/VTmCQze+BtXUUtGB4oGs=;
        b=Nu7O4X1RDHmNsyZ406/6JhkNjwV9+v31JLfRLDpZAhFFhc2pc6uflmIpYa9wqrJZlo
         JhcmWXfCDmvzFTQW2459T0B19dsCqENVhO2548AZozqVvm/mir0dTsRrYMCRNKV6MSZE
         kmqLB8vlyyuiPD62aJXvmf3tnpBiMeI+j2xB0TsOqBMNJ+XL+52jViUJbN7BG9oqqRXn
         FohWKtaaDttbLWKBbZdxRZ9MuDCZAdgW5cku3x6fzmlA61E/wGy7SnuY1brZOYcETWNb
         J3JNkNfgJsQ9Ruf+4wYzgV/6Ik6PVP/Y9K+fpiO45pwmVVOFEchEfYc5RuIPxaZ4aIs4
         2n6A==
X-Gm-Message-State: AOAM533DrcHnwgzsJkFKYz9Aklhin7oy/B5VhYmEAOqrJDegLsBjghH0
        XZIrrog4v9tOcAI00RwlpQ==
X-Google-Smtp-Source: ABdhPJzbwNj6HZcfmjrTSF00MePBWZMUTjuo0Qfo+4m272Hj76BlzCDEDKDNRCkcQY54y9jeKs+5XA==
X-Received: by 2002:a02:b0d5:: with SMTP id w21mr1176522jah.27.1594842931059;
        Wed, 15 Jul 2020 12:55:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t7sm1579252iol.2.2020.07.15.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:55:30 -0700 (PDT)
Received: (nullmailer pid 720192 invoked by uid 1000);
        Wed, 15 Jul 2020 19:55:29 -0000
Date:   Wed, 15 Jul 2020 13:55:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: convert QCOM pci bindings to YAML
Message-ID: <20200715195529.GA710312@bogus>
References: <1592982124-27160-1-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592982124-27160-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 12:32:04PM +0530, Sivaprakash Murugesan wrote:
> Convert QCOM pci bindings to YAML schema
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          | 330 ---------------
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 470 +++++++++++++++++++++
>  2 files changed, 470 insertions(+), 330 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml


> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> new file mode 100644
> index 000000000000..b119ce4711b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -0,0 +1,470 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/qcom,pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm PCI express root complex
> +
> +maintainers:
> +  - Sivaprakash Murugesan <sivaprak@codeaurora.org>
> +
> +description:
> +  QCOM PCIe controller uses Designware IP with Qualcomm specific hardware
> +  wrappers.
> +

Need to reference pci-bus.yaml.

> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pcie-apq8064
> +      - qcom,pcie-apq8084
> +      - qcom,pcie-ipq4019
> +      - qcom,pcie-ipq8064
> +      - qcom,pcie-ipq8074
> +      - qcom,pcie-msm8996
> +      - qcom,pcie-qcs404
> +      - qcom,pcie-sdm845
> +
> +  reg:
> +    description: Register ranges as listed in the reg-names property
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: elbi
> +      - const: parf
> +      - const: config
> +

> +  "#size-cells":
> +    const: 2
> +
> +  device_type:
> +    items:
> +      - const: pci
> +
> +  "#address-cells":
> +    const: 3

Drop these, pci-bus.yaml covers them.

> +
> +  ranges:
> +    maxItems: 2
> +
> +  interrupts:
> +    items:
> +      - description: MSI interrupts
> +
> +  interrupt-names:
> +    const: msi
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-map-mask:
> +    items:
> +      - description: standard PCI properties to define mapping of PCIe
> +                     interface to interrupt numbers.
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 7
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 7
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 12
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 12
> +
> +  power-domains:
> +    items:
> +      - description: phandle to the power domain responsible for collapsing
> +                     and restoring power to peripherals

Just 'maxItems: 1'. No need for generic descriptions.

> +
> +  vdda-supply:
> +    items:
> +      - description: phandle to power supply

*-supply is not an array.

> +
> +  vdda_phy-supply:
> +    items:
> +      - description: phandle to the power supply to PHY
> +
> +  vdda_refclk-supply:
> +    items:
> +      - description: phandle to power supply for ref clock generator
> +
> +  vddpe-3v3-supply:
> +    items:
> +      - description: PCIe endpoint power supply
> +
> +  phys:
> +    items:
> +      - description: phandle to the PHY block

maxItems: 1

> +
> +  phy-names:
> +    const: pciephy
> +
> +  perst-gpios:
> +    description: Endpoint reset signal line

Add 'maxItems: 1' as *-gpios is an array.

> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller

Can drop.

> +
> +  num-lanes:
> +    const: 1
> +
> +  linux,pci-domain:
> +    description: pci host bridge domain number

Can drop.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names

Can drop everything pci-bus.yaml says is required.

> +
> +additionalProperties: false

Will need to be 'unevaluatedProperties: false' with pci-bus.yaml 
referenced.

> +
> +allOf:
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-apq8064
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: clock for pcie hw block
> +           - description: clock for pcie phy block
> +       clock-names:
> +         items:
> +           - const: core
> +           - const: phy
> +       resets:
> +         items:
> +           - description: AXI reset
> +           - description: AHB reset
> +           - description: POR reset
> +           - description: PCI reset
> +           - description: PHY reset
> +       reset-names:
> +         items:
> +           - const: axi
> +           - const: ahb
> +           - const: por
> +           - const: pci
> +           - const: phy
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-apq8084
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: AUX clock
> +           - description: Master AXI clock
> +           - description: Slave AXI clock
> +       clock-names:
> +         items:
> +           - const: aux
> +           - const: bus_master
> +           - const: bus_slave
> +       resets:
> +         items:
> +           - description: core reset
> +       reset-names:
> +         items:
> +           - const: core
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-ipq4019
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: AUX clock
> +           - description: Master AXI clock
> +           - description: Slave AXI clock
> +       clock-names:
> +         items:
> +           - const: aux
> +           - const: master_bus
> +           - const: master_slave
> +       resets:
> +         items:
> +           - description: AXI master reset
> +           - description: AXI slave reset
> +           - description: PCIE pipe reset
> +           - description: AXI vmid reset
> +           - description: AXI XPU reset
> +           - description: parf reset
> +           - description: PHY reset
> +           - description: AXI master sticky reset
> +           - description: PCIE pipe sticky reset
> +           - description: pwr reset
> +           - description: AHB reset
> +           - description: PHY AHB reset
> +       reset-names:
> +         items:
> +           - const: axi_m
> +           - const: axi_s
> +           - const: pipe
> +           - const: axi_m_vmid
> +           - const: axi_s_xpu
> +           - const: parf
> +           - const: phy
> +           - const: axi_m_sticky
> +           - const: pipe_sticky
> +           - const: pwr
> +           - const: ahb
> +           - const: phy_ahb
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-ipq8064
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: core clock
> +           - description: interface clock
> +           - description: phy clock
> +           - description: Auxilary clock
> +           - description: reference clock
> +       clock-names:
> +         items:
> +           - const: core
> +           - const: iface
> +           - const: phy
> +           - const: aux
> +           - const: ref
> +       resets:
> +         items:
> +           - description: AXI reset
> +           - description: AHB reset
> +           - description: POR reset
> +           - description: PCI reset
> +           - description: PHY reset
> +           - description: External reset
> +       reset-names:
> +         items:
> +           - const: axi
> +           - const: ahb
> +           - const: por
> +           - const: pci
> +           - const: phy
> +           - const: ext
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-ipq8074
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: sys noc interface clock
> +           - description: AXI master clock
> +           - description: AXI slave clock
> +           - description: AHB clock
> +           - description: Auxilary clock
> +       clock-names:
> +         items:
> +           - const: iface
> +           - const: axi_m
> +           - const: axi_s
> +           - const: ahb
> +           - const: aux
> +       resets:
> +         items:
> +           - description: PIPE reset
> +           - description: PCIe sleep reset
> +           - description: PCIe sticky reset
> +           - description: AXI master reset
> +           - description: AXI slave reset
> +           - description: AHB reset
> +           - description: AXI master sticky reset
> +       reset-names:
> +         items:
> +           - const: pipe
> +           - const: sleep
> +           - const: sticky
> +           - const: axi_m
> +           - const: axi_s
> +           - const: ahb
> +           - const: axi_m_sticky
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-msm8996
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: PCIe pipe clock
> +           - description: Auxilary clock
> +           - description: AHB config clock
> +           - description: AXI master clock
> +           - description: AXI slave clock
> +       clock-names:
> +         items:
> +           - const: pipe
> +           - const: aux
> +           - const: cfg
> +           - const: bus_master
> +           - const: bus_slave
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-qcs404
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: interface clock
> +           - description: Auxilary clock
> +           - description: AXI master clock
> +           - description: AXI slave clock
> +       clock-names:
> +         items:
> +           - const: iface
> +           - const: aux
> +           - const: master_bus
> +           - const: slave_bus
> +       resets:
> +         items:
> +           - description: AXI master reset
> +           - description: AXI slave reset
> +           - description: AXI master sticky reset
> +           - description: PCIe pipe sticky reset
> +           - description: power reset
> +           - description: AHB reset
> +       reset-names:
> +         items:
> +           - const: axi_m
> +           - const: axi_s
> +           - const: axi_m_sticky
> +           - const: pipe_sticky
> +           - const: pwr
> +           - const: ahb
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
> +             - qcom,pcie-sdm845
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: PCIE pipe clock
> +           - description: Auxilary clock
> +           - description: AHB config clock
> +           - description: AXI Master clock
> +           - description: AXI Slave clock
> +           - description: AXI Slave Q2A clock
> +           - description: NOC TBU clock
> +       clock-names:
> +         items:
> +           - const: pipe
> +           - const: aux
> +           - const: cfg
> +           - const: bus_master
> +           - const: bus_slave
> +           - const: slave_q2a
> +           - const: tbu
> +       resets:
> +         items:
> +           - description: PCI reset
> +       reset-names:
> +         items:
> +           - const: pci
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pcie: pci@10000000 {
> +        compatible = "qcom,pcie-qcs404";
> +        reg =  <0x10000000 0xf1d>,
> +               <0x10000f20 0xa8>,
> +               <0x07780000 0x2000>,
> +               <0x10001000 0x2000>;
> +        reg-names = "dbi", "elbi", "parf", "config";
> +        device_type = "pci";
> +        linux,pci-domain = <0>;
> +        bus-range = <0x00 0xff>;
> +        num-lanes = <1>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ranges = <0x01000000 0 0          0x10003000 0 0x00010000>, /* I/O */
> +                 <0x02000000 0 0x10013000 0x10013000 0 0x007ed000>; /* memory */
> +
> +        interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 0x7>;
> +        interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                        <0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                        <0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                        <0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +        clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +                 <&gcc GCC_PCIE_0_AUX_CLK>,
> +                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
> +        clock-names = "iface", "aux", "master_bus", "slave_bus";
> +
> +        resets = <&gcc 18>,
> +                 <&gcc 17>,
> +                 <&gcc 15>,
> +                 <&gcc 19>,
> +                 <&gcc GCC_PCIE_0_BCR>,
> +                 <&gcc 16>;
> +        reset-names = "axi_m",
> +                      "axi_s",
> +                      "axi_m_sticky",
> +                      "pipe_sticky",
> +                      "pwr",
> +                      "ahb";
> +
> +        phys = <&pcie_phy>;
> +        phy-names = "pciephy";
> +
> +    };
> -- 
> 2.7.4
> 
