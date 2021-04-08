Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83F8357CAD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhDHGiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 02:38:03 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:46762 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDHGiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 02:38:01 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1386bNU3022923; Thu, 8 Apr 2021 15:37:23 +0900
X-Iguazu-Qid: 2wHHssSnbVqCDS96L2
X-Iguazu-QSIG: v=2; s=0; t=1617863843; q=2wHHssSnbVqCDS96L2; m=MK+itwrSUtN910qMWIa57PTH69k5sGpQgX66utEmjMI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 1386bMme023272
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 8 Apr 2021 15:37:23 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 580FA1000C8;
        Thu,  8 Apr 2021 15:37:22 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1386bLhH021840;
        Thu, 8 Apr 2021 15:37:22 +0900
Date:   Thu, 8 Apr 2021 15:37:19 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
X-TSB-HOP: ON
Message-ID: <20210408063719.jxh27ez375ezx3dc@toshiba.co.jp>
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210407031839.386088-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CAL_JsqJew19jBJ-WpGNCK2AD+nUQsQBjJ7-ye9Cgort8AuG8mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJew19jBJ-WpGNCK2AD+nUQsQBjJ7-ye9Cgort8AuG8mQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for your review.

On Wed, Apr 07, 2021 at 08:18:58AM -0500, Rob Herring wrote:
> On Tue, Apr 6, 2021 at 10:19 PM Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> >
> > This commit adds the Device Tree binding documentation that allows
> > to describe the PCIe controller found in Toshiba Visconti SoCs.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../bindings/pci/toshiba,visconti-pcie.yaml   | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> > new file mode 100644
> > index 000000000000..8ab60c235007
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/toshiba,visconti-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba Visconti5 SoC PCIe Host Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > +
> > +description: |+
> > +  Toshiba Visconti5 SoC PCIe host controller is based on the Synopsys DesignWare PCIe IP.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: toshiba,visconti-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: Data Bus Interface (DBI) registers.
> > +      - description: PCIe configuration space region.
> > +      - description: Visconti specific additional registers.
> > +      - description: Visconti specific SMU registers
> > +      - description: Visconti specific memory protection unit registers (MPU)
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +      - const: ulreg
> > +      - const: smu
> > +      - const: mpu
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: PCIe reference clock
> > +      - description: PCIe system clock
> > +      - description: Auxiliary clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie_refclk
> > +      - const: sysclk
> > +      - const: auxclk
> > +
> > +  num-lanes:
> > +    const: 2
> > +
> > +  num-viewport:
> > +    const: 8
> 
> Drop this, we detect this now.
> 

OK, I will drop this.

> > +
> > +required:
> 
> Drop everything that pci-bus.yaml already requires.

OK, I will check pci-bus.yaml, and update this.

> 
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - "#interrupt-cells"
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - ranges
> > +  - bus-range
> 
> If you support 0-0xff, there's no need for this to be required.
> 

OK, this device supports 0x0 -0xff, I will drop.

> > +  - device_type
> > +  - num-lanes
> > +  - num-viewport
> > +  - clocks
> > +  - clock-names
> > +  - max-link-speed
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcie: pcie@28400000 {
> > +            compatible = "toshiba,visconti-pcie";
> > +            reg = <0x0 0x28400000 0x0 0x00400000>,
> > +                  <0x0 0x70000000 0x0 0x10000000>,
> > +                  <0x0 0x28050000 0x0 0x00010000>,
> > +                  <0x0 0x24200000 0x0 0x00002000>,
> > +                  <0x0 0x24162000 0x0 0x00001000>;
> > +            reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
> > +            device_type = "pci";
> > +            bus-range = <0x00 0xff>;
> > +            num-lanes = <2>;
> > +            num-viewport = <8>;
> > +
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            #interrupt-cells = <1>;
> > +            ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000>,
> > +                     <0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
> > +            interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "intr";
> > +            interrupt-map-mask = <0 0 0 7>;
> > +            interrupt-map =
> > +                <0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> > +                 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> > +                 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> > +                 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
> > +            clock-names = "pcie_refclk", "sysclk", "auxclk";
> > +            max-link-speed = <2>;
> > +
> > +            status = "disabled";
> 
> Don't show status in examples.

OK, I will drop.

> 
> > +        };
> > +    };
> > +...
> > --
> > 2.30.0.rc2
> >
> 

Best regards,
  Nobuhiro

