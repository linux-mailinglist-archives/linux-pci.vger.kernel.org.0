Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC35398CA1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFBOY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 10:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFBOY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 10:24:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C767610CB;
        Wed,  2 Jun 2021 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622643763;
        bh=j2Vucv7j48HxGa0rmULQUiDA8vOA5lkReOpPS+DWX0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kWSNltbOxaUHNz7Oy82/Q+RVGRp7zGnvRgNvBvVbQ3lCd8/QJHQAQyy2X7kzPcOxF
         xuDQRYjGNg9iJRLwwlpyKt7Dkmd5baI11N4QCi26WZ1pn6dbVjRBXUGEKSvp7+QatG
         s6ojB0Y30ORJsCC+mkzh23WWj4qU7u/amyoxlrYdyLQXSz2prhPijFvZzjOSi0vCI1
         eWdC4SxaX9/3zVvlps7NRwvbbf9IX3u+x20IB0Grcjh2/YrN8X8wb8t1vfqFxpyIYE
         m/mQIOH4kjPsW9DDaw24yHS+Dn+wq1bKrs0TX7DLVz00buOm86O51+iO/+PDlVvMDW
         wQz37ZgMtb3cg==
Received: by mail-ed1-f49.google.com with SMTP id ba2so1429329edb.2;
        Wed, 02 Jun 2021 07:22:43 -0700 (PDT)
X-Gm-Message-State: AOAM53117+tNtIk+kJyEJtCAuM987wPtZzKYDzzdRiR9riZVaSEM54WP
        6iUy0cFH5v6n2x8/smYAQCBFICrVcufs453cDg==
X-Google-Smtp-Source: ABdhPJyIR6oYQn8q1KYvTQQteC/8OV+grbQU5QShD2x+i4fSDS+34Gh1WDg1MaRCWzgXaIfO5gte9k4P4zSCNbbkelI=
X-Received: by 2002:a05:6402:1d85:: with SMTP id dk5mr21036040edb.289.1622643761769;
 Wed, 02 Jun 2021 07:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210602120752.46154-1-manivannan.sadhasivam@linaro.org> <20210602120752.46154-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210602120752.46154-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Jun 2021 09:22:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdXsEfV6aj88e+ZjbL2EZxX2r8m+_MRMnUHuzKLV9_Yg@mail.gmail.com>
Message-ID: <CAL_JsqLdXsEfV6aj88e+ZjbL2EZxX2r8m+_MRMnUHuzKLV9_Yg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: Add devicetree binding for Qualcomm
 PCIe EP controller
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 2, 2021 at 7:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree binding for Qualcomm PCIe EP controller used in platforms
> like SDX55. The EP controller is based on the Designware core with
> Qualcomm specific wrappers.

Is the block EP only or configurable EP or host?

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> new file mode 100644
> index 000000000000..0f9140e93bcb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -0,0 +1,139 @@
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
> +    const: qcom,pcie-ep

SoC specific please.

> +
> +  reg:
> +    items:
> +      - description: Designware PCIe registers
> +      - description: External local bus interface registers
> +      - description: Address Translation Unit (ATU) registers
> +      - description: Memory region used to map remote RC address space
> +      - description: Qualcomm specific PARF configuration registers
> +      - description: Qualcomm specific TCSR registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: elbi
> +      - const: atu
> +      - const: addr_space
> +      - const: parf
> +      - const: tcsr

This should be in the same order as the host side. Unfortunately,
that's not consistent, but to pick one:

reg-names = "parf", "dbi", "elbi", "atu", "config";


> +
> +  clocks:
> +    items:
> +      - description: PCIe CFG AHB clock
> +      - description: PCIe Auxiliary clock
> +      - description: PCIe Master AXI clock
> +      - description: PCIe Slave AXI clock
> +      - description: PCIe Reference clock
> +      - description: PCIe Sleep clock
> +      - description: PCIe Slave Q2A AXI clock
> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: aux
> +      - const: bus_master
> +      - const: bus_slave
> +      - const: ref
> +      - const: sleep
> +      - const: slave_q2a

Again, try to keep the same ordering.

I have to wonder where 'pipe' clock is that most of the QCom
implementations have?

> +
> +  interrupts:
> +    maxItems: 1
> +    description: PCIe Global interrupt
> +
> +  interrupt-names:
> +    const: int_global

'int_' is redundant, drop.

> +
> +  perst-gpios:
> +    description: PCIe endpoint reset GPIO

An input, right?

> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: PCIe endpoint wake GPIO
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: core_reset

Not yet another name. We already have 'pci' and 'core' in the cases of
a single reset.

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
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - perst-gpios
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
> +        compatible = "qcom,pcie-ep";
> +
> +        reg = <0x40000000 0xf1d>,
> +              <0x40000f20 0xc8>,
> +              <0x40001000 0x1000>,
> +              <0x42000000 0x1000>,
> +              <0x01c00000 0x3000>,
> +              <0x01fcb000 0x1000>;
> +        reg-names = "dbi", "elbi", "atu", "addr_space", "parf", "tcsr";
> +
> +        clocks = <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +             <&gcc GCC_PCIE_AUX_CLK>,
> +             <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +             <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +             <&gcc GCC_PCIE_0_CLKREF_CLK>,
> +             <&gcc GCC_PCIE_SLEEP_CLK>,
> +             <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>;
> +        clock-names = "cfg", "aux", "bus_master", "bus_slave",
> +                      "ref", "sleep", "slave_q2a";
> +
> +        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "int_global";
> +        perst-gpios = <&tlmm 57 GPIO_ACTIVE_HIGH>;
> +        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +        resets = <&gcc GCC_PCIE_BCR>;
> +        reset-names = "core_reset";
> +        power-domains = <&gcc PCIE_GDSC>;
> +        phys = <&pcie0_lane>;
> +        phy-names = "pciephy";
> +        max-link-speed = <3>;
> +        num-lanes = <2>;

Should be documented. I'd assume the max is less than 16 which is
presumably what pcie-ep.yaml allows.

> +    };
> --
> 2.25.1
>
