Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064BF356D22
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhDGNT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 09:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235861AbhDGNTV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 09:19:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D90DC61394;
        Wed,  7 Apr 2021 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617801552;
        bh=LTkohUbPF6Bi0usi+I5EMI/7O/T2JNpdfdjkmll4mqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kqp8jArwrojMAJGeP7WVtOPuOJb6aLYI1QEAYtSX69pVNYOckcJv82nFfEUAkn22R
         KlQ2ugk7eqW8nUoO9zLMEDqF20/YlvesWxR3cl+aTfTEaAlXBPHh3jtdgc1PcbdBw/
         oly69z9hBpeNoy1kLCYLD7TOyIysnk3U/G3ZNby56pUoe5px6/masGj96nDAzy8EuB
         5mrZozq/gYR4DfqP5QZ+3weOFPxTN0c41uGVnL2feqVp5ahmMmdCc3ZXEPATH18oYV
         U42nGp/NvJtmBl8GR/sltvnc01LEaiQDIeSlNbdRqtSTzBMZBFSgi7qMg8ZGdbbEHx
         uQnmvBalRM7Fg==
Received: by mail-ed1-f47.google.com with SMTP id ba6so13313241edb.1;
        Wed, 07 Apr 2021 06:19:11 -0700 (PDT)
X-Gm-Message-State: AOAM532PU5w/4/8r0kEXwCQZH/LOxZ2mmlxsTdRYlJAHAERV9gSlpU0S
        NeVMWgofYvaQvtDa4BqH3+38tkcWtXi+H/RWLA==
X-Google-Smtp-Source: ABdhPJxouTy0fl89h71UvityxWxXCCSfDE+yhlKWwGiRJuvEWO5V5qJmXkmAupn88a+4qG04LBTr4o4N2tIv4Y6sAw4=
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr4435514edr.289.1617801550253;
 Wed, 07 Apr 2021 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210407031839.386088-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210407031839.386088-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Apr 2021 08:18:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJew19jBJ-WpGNCK2AD+nUQsQBjJ7-ye9Cgort8AuG8mQ@mail.gmail.com>
Message-ID: <CAL_JsqJew19jBJ-WpGNCK2AD+nUQsQBjJ7-ye9Cgort8AuG8mQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti
 PCIe controller
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 10:19 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> This commit adds the Device Tree binding documentation that allows
> to describe the PCIe controller found in Toshiba Visconti SoCs.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pci/toshiba,visconti-pcie.yaml   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> new file mode 100644
> index 000000000000..8ab60c235007
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/toshiba,visconti-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 SoC PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description: |+
> +  Toshiba Visconti5 SoC PCIe host controller is based on the Synopsys DesignWare PCIe IP.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration space region.
> +      - description: Visconti specific additional registers.
> +      - description: Visconti specific SMU registers
> +      - description: Visconti specific memory protection unit registers (MPU)
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: ulreg
> +      - const: smu
> +      - const: mpu
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PCIe reference clock
> +      - description: PCIe system clock
> +      - description: Auxiliary clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie_refclk
> +      - const: sysclk
> +      - const: auxclk
> +
> +  num-lanes:
> +    const: 2
> +
> +  num-viewport:
> +    const: 8

Drop this, we detect this now.

> +
> +required:

Drop everything that pci-bus.yaml already requires.

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

If you support 0-0xff, there's no need for this to be required.

> +  - device_type
> +  - num-lanes
> +  - num-viewport
> +  - clocks
> +  - clock-names
> +  - max-link-speed
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie: pcie@28400000 {
> +            compatible = "toshiba,visconti-pcie";
> +            reg = <0x0 0x28400000 0x0 0x00400000>,
> +                  <0x0 0x70000000 0x0 0x10000000>,
> +                  <0x0 0x28050000 0x0 0x00010000>,
> +                  <0x0 0x24200000 0x0 0x00002000>,
> +                  <0x0 0x24162000 0x0 0x00001000>;
> +            reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
> +            device_type = "pci";
> +            bus-range = <0x00 0xff>;
> +            num-lanes = <2>;
> +            num-viewport = <8>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000>,
> +                     <0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
> +            interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "intr";
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map =
> +                <0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +                 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +                 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +                 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
> +            clock-names = "pcie_refclk", "sysclk", "auxclk";
> +            max-link-speed = <2>;
> +
> +            status = "disabled";

Don't show status in examples.

> +        };
> +    };
> +...
> --
> 2.30.0.rc2
>
