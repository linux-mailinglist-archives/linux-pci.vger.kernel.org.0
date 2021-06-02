Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64912398D3E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFBOjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 10:39:51 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:39497 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhFBOju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 10:39:50 -0400
Received: by mail-pg1-f181.google.com with SMTP id v14so2395451pgi.6
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dMFAVrmRz8CzgxJ+6JZiw4ss/4Zrv9ro37d7xqtEycw=;
        b=CuiLUa62DihP4t3edU/8NgH5VfTa7dNBIuh+W8/E7VORyrkuatUMJB1yiblCmHR6Bn
         b3muVFHkXUMDP0S6sQVjp3Bf8MOp9ImQHEShjpr9ykpYGrpZuVDzZoOlxQDpaT6LvuMN
         FgxY0F+qS1OTtK9MCxbC7JZ0aawdzeLWpaKBcZ1oSWLS4nBPVOjYNXUPIH2oW2ipejLF
         lXWCNPmBfXNEHtC1mkeVEARPQLzVOaYkHCssLFzwlXtTH33cKUlZO1PniWXEUigxi4a2
         fvjJgOxeOE9JaGZg216ZgQtIDd3pXh/B5GsqSdfrhqcOB4cKSavL7o7pbZzhFZpg0WLR
         U82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMFAVrmRz8CzgxJ+6JZiw4ss/4Zrv9ro37d7xqtEycw=;
        b=gm0i2Er0L8ukhP9TiAky+dgvMdrVazY7Db8VQTLIhg+U6jmxR5n502G7SNGTfbxFLH
         GgtXTDMvP1cwEfsbdvSODPi+IrAb5QqlV3/hp7WMHYzI3Gqw67efqgGGk6q550mQBNUs
         XRFm7DnDmy45udzFcvyjAbP5HzrelIZXFWHK5NXaI8nY+U/szqJTvRSS5ewEr3VQZt8i
         rCUJRoaoNX0ablQPD/CLD6vbojfOPsfdD0lUdiEOk2nb3HhepMe4nLw5iFZWFeHYiler
         2yOFmCbAqQKQSQYfAsfxGwlBTxExP0RjXkpAhW3U/k0w4JuOHns+xva+3UX+lgIXo/9A
         W/rQ==
X-Gm-Message-State: AOAM531Td0i1QwHq/2ZB8+aOR5Q/7vK/eJvNNH48vkfdKUsMzNXdEOBM
        kZmhE0OBMQiY+0q0CcHZm2GU
X-Google-Smtp-Source: ABdhPJzzO0cN+lXa7lUfBGyVolwwG5lB/USl4roba8NCjWRvUZpH0Vz/+Tv1nBnz51jFdZiNSPxSyw==
X-Received: by 2002:a65:5684:: with SMTP id v4mr33199173pgs.218.1622644626876;
        Wed, 02 Jun 2021 07:37:06 -0700 (PDT)
Received: from workstation ([120.138.12.54])
        by smtp.gmail.com with ESMTPSA id g15sm15334370pfv.127.2021.06.02.07.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jun 2021 07:37:06 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:07:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pci: Add devicetree binding for
 Qualcomm PCIe EP controller
Message-ID: <20210602143702.GA8153@workstation>
References: <20210602120752.46154-1-manivannan.sadhasivam@linaro.org>
 <20210602120752.46154-2-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLdXsEfV6aj88e+ZjbL2EZxX2r8m+_MRMnUHuzKLV9_Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLdXsEfV6aj88e+ZjbL2EZxX2r8m+_MRMnUHuzKLV9_Yg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 09:22:29AM -0500, Rob Herring wrote:
> On Wed, Jun 2, 2021 at 7:08 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add devicetree binding for Qualcomm PCIe EP controller used in platforms
> > like SDX55. The EP controller is based on the Designware core with
> > Qualcomm specific wrappers.
> 
> Is the block EP only or configurable EP or host?
> 

Configurable core. We already support the RC mode in a separate driver and
binding. I initially thought about merging both in a single driver &
binding but that seemed unnecessarily complex, so settled with this.

> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 139 ++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > new file mode 100644
> > index 000000000000..0f9140e93bcb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -0,0 +1,139 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm PCIe Endpoint Controller binding
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +allOf:
> > +  - $ref: "pci-ep.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,pcie-ep
> 
> SoC specific please.
>

Okay

> > +
> > +  reg:
> > +    items:
> > +      - description: Designware PCIe registers
> > +      - description: External local bus interface registers
> > +      - description: Address Translation Unit (ATU) registers
> > +      - description: Memory region used to map remote RC address space
> > +      - description: Qualcomm specific PARF configuration registers
> > +      - description: Qualcomm specific TCSR registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: elbi
> > +      - const: atu
> > +      - const: addr_space
> > +      - const: parf
> > +      - const: tcsr
> 
> This should be in the same order as the host side. Unfortunately,
> that's not consistent, but to pick one:
> 
> reg-names = "parf", "dbi", "elbi", "atu", "config";
> 

Okay, I'll align with the RC binding.

> 
> > +
> > +  clocks:
> > +    items:
> > +      - description: PCIe CFG AHB clock
> > +      - description: PCIe Auxiliary clock
> > +      - description: PCIe Master AXI clock
> > +      - description: PCIe Slave AXI clock
> > +      - description: PCIe Reference clock
> > +      - description: PCIe Sleep clock
> > +      - description: PCIe Slave Q2A AXI clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: cfg
> > +      - const: aux
> > +      - const: bus_master
> > +      - const: bus_slave
> > +      - const: ref
> > +      - const: sleep
> > +      - const: slave_q2a
> 
> Again, try to keep the same ordering.
> 
> I have to wonder where 'pipe' clock is that most of the QCom
> implementations have?
> 

Pipe clock is managed by the PHY driver. So the PCIe drivers need not to
worry about it.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: PCIe Global interrupt
> > +
> > +  interrupt-names:
> > +    const: int_global
> 
> 'int_' is redundant, drop.
> 

Okay

> > +
> > +  perst-gpios:
> > +    description: PCIe endpoint reset GPIO
> 
> An input, right?
> 

Yes, will mention.

> > +    maxItems: 1
> > +
> > +  wake-gpios:
> > +    description: PCIe endpoint wake GPIO
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    const: core_reset
> 
> Not yet another name. We already have 'pci' and 'core' in the cases of
> a single reset.
> 

Okay

> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: pciephy
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - perst-gpios
> > +  - resets
> > +  - reset-names
> > +  - power-domains
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-sdx55.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    pcie_ep: pcie-ep@40000000 {
> > +        compatible = "qcom,pcie-ep";
> > +
> > +        reg = <0x40000000 0xf1d>,
> > +              <0x40000f20 0xc8>,
> > +              <0x40001000 0x1000>,
> > +              <0x42000000 0x1000>,
> > +              <0x01c00000 0x3000>,
> > +              <0x01fcb000 0x1000>;
> > +        reg-names = "dbi", "elbi", "atu", "addr_space", "parf", "tcsr";
> > +
> > +        clocks = <&gcc GCC_PCIE_CFG_AHB_CLK>,
> > +             <&gcc GCC_PCIE_AUX_CLK>,
> > +             <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> > +             <&gcc GCC_PCIE_SLV_AXI_CLK>,
> > +             <&gcc GCC_PCIE_0_CLKREF_CLK>,
> > +             <&gcc GCC_PCIE_SLEEP_CLK>,
> > +             <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>;
> > +        clock-names = "cfg", "aux", "bus_master", "bus_slave",
> > +                      "ref", "sleep", "slave_q2a";
> > +
> > +        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names = "int_global";
> > +        perst-gpios = <&tlmm 57 GPIO_ACTIVE_HIGH>;
> > +        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> > +        resets = <&gcc GCC_PCIE_BCR>;
> > +        reset-names = "core_reset";
> > +        power-domains = <&gcc PCIE_GDSC>;
> > +        phys = <&pcie0_lane>;
> > +        phy-names = "pciephy";
> > +        max-link-speed = <3>;
> > +        num-lanes = <2>;
> 
> Should be documented. I'd assume the max is less than 16 which is
> presumably what pcie-ep.yaml allows.
> 

okay

Thanks,
Mani

> > +    };
> > --
> > 2.25.1
> >
