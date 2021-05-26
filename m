Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1ED391D18
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhEZQfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234665AbhEZQfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328E7613E5;
        Wed, 26 May 2021 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046829;
        bh=kovUxkfq29J2qv1KN2+/JPS+nX4ZQzEH6SoLPMxR0ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pbB6BAboDmEashbjaO40Qcj1N6kYAOe9sUDMk4k4AjKY+MSsvxhp9ey+5s6OTvuZI
         lOWycAeiw9xCcHTcLL7jUhOMUvweU7ruAbWufEJmIt3CXuLZuePSHnijaqJwtcZrWF
         b6z/7GTfX71n+Q8tojXzU34cJmOapGiRhD/T0ssjWklyEsIFQaUJwLq2noZjyzW4nE
         g++dlmXO46USHeNvNDThRunj1AzEvQo1xs5XSbkel8g1RoPO9ny9RNiQeUBs/aL+ey
         2K6emMGgpsef2wv0xhYpwABds9yJogfo2KAKNwjTNcnyGDNvV7ArsP3+Ew0TU0stCD
         OzrxsIHZtSrJA==
Received: by mail-ej1-f48.google.com with SMTP id s22so3403027ejv.12;
        Wed, 26 May 2021 09:33:49 -0700 (PDT)
X-Gm-Message-State: AOAM532OXToywRefEGBgeR+6n468GauorB9+rjWXlHTS5qgOEaRAHANg
        XfZ2/XLgv0tcy95hW9sk3iZETg5/xumT49ePlw==
X-Google-Smtp-Source: ABdhPJz/NQU3/oyiHOCSt1947VmfYPxPrIrrv74R97/vZaKYMNtIj0NNv/rt5oyOhC2oYOSh6w2uI57ApOhldcTPSs0=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr34108710ejc.108.1622046827604;
 Wed, 26 May 2021 09:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210524063004.132043-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210524063004.132043-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 May 2021 11:33:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKE0o9dUmJxgSg3_e_s7Dh3Vrjb60=u+xRd7erCVnFHWQ@mail.gmail.com>
Message-ID: <CAL_JsqKE0o9dUmJxgSg3_e_s7Dh3Vrjb60=u+xRd7erCVnFHWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
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

On Mon, May 24, 2021 at 1:30 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> This commit adds the Device Tree binding documentation that allows
> to describe the PCIe controller found in Toshiba Visconti SoCs.
>
> v1 -> v2:
>  - Remove white space.
>  - Drop num-viewport and bus-range from required.
>  - Drop status line from example.
>  - Drop bus-range from required.
>  - Removed lines defined in pci-bus.yaml from required.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml

Please resend to DT list. Otherwise, automated checks don't run
(though I'm sure you ran 'make dt_binding_check' already, right?).

>
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> new file mode 100644
> index 000000000000..d47a4a3c49e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> @@ -0,0 +1,110 @@
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

Just 'refclk'. Though 'clk' is redundant too. I'd go with 'ref',
'aux', and 'core'.

> +      - const: sysclk
> +      - const: auxclk
> +
> +  num-lanes:
> +    const: 2
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - num-lanes
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
> +        };
> +    };
> +...
> --
> 2.31.1
>
