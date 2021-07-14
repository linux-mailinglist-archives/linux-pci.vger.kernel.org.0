Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2B3C7B8A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 04:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhGNCQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 22:16:43 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:39567 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbhGNCQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 22:16:43 -0400
Received: by mail-io1-f48.google.com with SMTP id h6so159884iok.6;
        Tue, 13 Jul 2021 19:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Z/tZKf0aO1xZoDSmm5DT5QLfVwlo8xPEjAU//SkRvw=;
        b=ohJxfK1yBHVjiovH634DdI2n/C72NjvhTB/yblm1tNW8Cm25xo+QF8/ETm/OVFCf0I
         1jbz5d2bq4vf8OL8aGp1Oz/jCTpwcs+uxJIxhwwW+eGDZMJou9R7ixZHQIJkDJfBsv8i
         Z2+PerNJED3CA8IIXAshNULGY80iUzzbdtnkcfILD6WQHwGOuWbkkDrJd9qnKNfTJI7x
         kPjW56KgaSNaO4ZUqe+7jOEZjY/7F6rihQyZdGP4Www/lZ1YsT0FoGXPui2qXf/55d96
         pchznHihC6wzLa9r1wg+qpnABDrBbzLHA67j9PD84jDWFAoEDxMX3VzjspHrjPzKIbeI
         ae/Q==
X-Gm-Message-State: AOAM531k0Nz+88lGmavFQohc8IGNSZ+/zPn0u+xIvRwlc2+DmH/TLa2q
        7PAG4lJbY6kK2NQv4aAHjA==
X-Google-Smtp-Source: ABdhPJyGycRTbO/9c2EWLHRjrDhvSrVs9AADZSCbP1Zmc+vSCeJI8j7lLZxtqwcsyaMkFhpNIMVurQ==
X-Received: by 2002:a5e:a816:: with SMTP id c22mr5597258ioa.94.1626228831107;
        Tue, 13 Jul 2021 19:13:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w1sm424335ilv.59.2021.07.13.19.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:13:50 -0700 (PDT)
Received: (nullmailer pid 1309349 invoked by uid 1000);
        Wed, 14 Jul 2021 02:13:48 -0000
Date:   Tue, 13 Jul 2021 20:13:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org
Subject: Re: [PATCH v5 1/3] dt-bindings: pci: Add devicetree binding for
 Qualcomm PCIe EP controller
Message-ID: <20210714021348.GA1302552@robh.at.kernel.org>
References: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
 <20210630034653.10260-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630034653.10260-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 30, 2021 at 09:16:51AM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Qualcomm PCIe EP controller used in platforms
> like SDX55. The EP controller is based on the Designware core with
> Qualcomm specific wrappers.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> new file mode 100644
> index 000000000000..9110d33809cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PCIe Endpoint Controller binding
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +allOf:
> +  - $ref: "pci-ep.yaml#"
> +
> +properties:
> +  compatible:
> +    const: qcom,sdx55-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: Qualcomm specific PARF configuration registers
> +      - description: Designware PCIe registers
> +      - description: External local bus interface registers
> +      - description: Address Translation Unit (ATU) registers
> +      - description: Memory region used to map remote RC address space
> +      - description: BAR memory region
> +
> +  reg-names:
> +    items:
> +      - const: parf
> +      - const: dbi
> +      - const: elbi
> +      - const: atu
> +      - const: addr_space
> +      - const: mmio
> +
> +  clocks:
> +    items:
> +      - description: PCIe Auxiliary clock
> +      - description: PCIe CFG AHB clock
> +      - description: PCIe Master AXI clock
> +      - description: PCIe Slave AXI clock
> +      - description: PCIe Slave Q2A AXI clock
> +      - description: PCIe Sleep clock
> +      - description: PCIe Reference clock
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: cfg
> +      - const: bus_master
> +      - const: bus_slave
> +      - const: slave_q2a
> +      - const: sleep
> +      - const: ref
> +
> +  qcom,perst-regs:
> +    description: Reference to a syscon representing TCSR followed by the two
> +                 offsets within syscon for Perst enable and Perst separation
> +                 enable registers
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    items:
> +      minItems: 3
> +      maxItems: 3
> +
> +  interrupts:
> +    items:
> +      - description: PCIe Global interrupt
> +      - description: PCIe Doorbell interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: global
> +      - const: doorbell
> +
> +  reset-gpios:
> +    description: GPIO that is being used as PERST# input signal
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO that is being used as WAKE# output signal
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: core
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pciephy
> +
> +  num-lanes:
> +    default: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - qcom,perst-regs
> +  - interrupts
> +  - interrupt-names
> +  - reset-gpios
> +  - resets
> +  - reset-names
> +  - power-domains
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdx55.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pcie_ep: pcie-ep@40000000 {
> +        compatible = "qcom,sdx55-pcie-ep";
> +        reg = <0x01c00000 0x3000>,
> +              <0x40000000 0xf1d>,
> +              <0x40000f20 0xc8>,
> +              <0x40001000 0x1000>,
> +              <0x40002000 0x1000>,
> +              <0x01c03000 0x3000>;
> +        reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> +                    "mmio";
> +
> +        clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +             <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +             <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +             <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +             <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +             <&gcc GCC_PCIE_SLEEP_CLK>,
> +             <&gcc GCC_PCIE_0_CLKREF_CLK>;
> +        clock-names = "aux", "cfg", "bus_master", "bus_slave",
> +                      "slave_q2a", "sleep", "ref";
> +
> +        qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +        	     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "global", "doorbell";
> +        reset-gpios = <&tlmm 57 GPIO_ACTIVE_HIGH>;
> +        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +        resets = <&gcc GCC_PCIE_BCR>;
> +        reset-names = "core";
> +        power-domains = <&gcc PCIE_GDSC>;
> +        phys = <&pcie0_lane>;
> +        phy-names = "pciephy";
> +        max-link-speed = <3>;
> +        num-lanes = <2>;
> +
> +        status = "disabled";

Why are you disabling the example? Drop status.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
