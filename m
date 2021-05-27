Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7EC3923BD
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 02:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhE0AYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 20:24:50 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:48174 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhE0AYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 20:24:50 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 14R0MtW5007322; Thu, 27 May 2021 09:22:55 +0900
X-Iguazu-Qid: 2wGr6xj2A4N7nHCAbL
X-Iguazu-QSIG: v=2; s=0; t=1622074974; q=2wGr6xj2A4N7nHCAbL; m=oAyYE0zOoy+KHvpZv9ULWYJ46KmGQ8jR3H8ooPGk2nw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 14R0MrdZ029273
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 May 2021 09:22:54 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 5B9181000D9;
        Thu, 27 May 2021 09:22:53 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 14R0Mq2Q005890;
        Thu, 27 May 2021 09:22:53 +0900
Date:   Thu, 27 May 2021 09:22:51 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
X-TSB-HOP: ON
Message-ID: <20210527002251.zyrpmy4u2asdn7bo@toshiba.co.jp>
References: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524063004.132043-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CAL_JsqKE0o9dUmJxgSg3_e_s7Dh3Vrjb60=u+xRd7erCVnFHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKE0o9dUmJxgSg3_e_s7Dh3Vrjb60=u+xRd7erCVnFHWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 11:33:35AM -0500, Rob Herring wrote:
> On Mon, May 24, 2021 at 1:30 AM Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> >
> > This commit adds the Device Tree binding documentation that allows
> > to describe the PCIe controller found in Toshiba Visconti SoCs.
> >
> > v1 -> v2:
> >  - Remove white space.
> >  - Drop num-viewport and bus-range from required.
> >  - Drop status line from example.
> >  - Drop bus-range from required.
> >  - Removed lines defined in pci-bus.yaml from required.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> 
> Please resend to DT list. Otherwise, automated checks don't run
OK, I will resent to DT list.
> (though I'm sure you ran 'make dt_binding_check' already, right?).

Yes, I ran it enerytime.


> >
> > diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> > new file mode 100644
> > index 000000000000..d47a4a3c49e3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> > @@ -0,0 +1,110 @@
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
> 
> Just 'refclk'. Though 'clk' is redundant too. I'd go with 'ref',
> 'aux', and 'core'.
> 

Ok, I will update.

> > +      - const: sysclk
> > +      - const: auxclk
> > +
> > +  num-lanes:
> > +    const: 2
> > +
> > +required:
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - "#interrupt-cells"
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - num-lanes
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
> > +        };
> > +    };
> > +...
> > --
> > 2.31.1
> >
> 

Best regards,
  Nobuhiro
