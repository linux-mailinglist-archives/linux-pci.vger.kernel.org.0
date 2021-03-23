Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB63469E8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCWUfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 16:35:39 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34492 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhCWUfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 16:35:14 -0400
Received: by mail-io1-f52.google.com with SMTP id x16so19150956iob.1;
        Tue, 23 Mar 2021 13:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YIaGfAZj+YyjN7GR+t7YC8glZc4pR3XJSdqGay7KgQ=;
        b=PCqR+Q7DKUhZHvA6oybElnxGJanBIRnhoNvL+2VQwzoYNH8yah57kvEmzh+4zADU6B
         VufWbsb5EbgNXpPRZwcot/NQdu9pboaGKFAP7hyqx/k2zAqH5LvEc8two8CgSQ/726BX
         SqzbkZe5l9Zm1mZgdqR503jEt7baVB+0j1nrT6o48ET8tDY3Xhy9bX8fOsSes7wmMajq
         fpmQ41V+7rT+t6m3J4AXnqyxUJ20D6ks0ntOqN4MUB3RUQaHzZ5lE/SIekPTu1NxXrdH
         7RAwC9iwgoUZpR5JoW9/soPM3PVt5Kd0nkp8Ezixp2qc6RHtuWj5ujLxX3GbeyY5OCuq
         tdqg==
X-Gm-Message-State: AOAM5332uTg6pENsXebi/SIqtWtKl3ZqR75DhGk1ovsaB5Iq6KknuJXi
        vWewLhh398UwgnxC6ClZbQ==
X-Google-Smtp-Source: ABdhPJwzJ2B7jz3IcS2YFgHRhk8QN9GsvyttcWFvv1Wu+rg5K/Q853NzU1OV8ds7D7TbHLSDnOtZ4A==
X-Received: by 2002:a02:9986:: with SMTP id a6mr6462501jal.46.1616531713152;
        Tue, 23 Mar 2021 13:35:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o14sm9982424ilt.39.2021.03.23.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:35:12 -0700 (PDT)
Received: (nullmailer pid 1273621 invoked by uid 1000);
        Tue, 23 Mar 2021 20:35:08 -0000
Date:   Tue, 23 Mar 2021 14:35:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host
 controller
Message-ID: <20210323203508.GA1251968@robh.at.kernel.org>
References: <cover.1615954045.git.greentime.hu@sifive.com>
 <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 02:08:11PM +0800, Greentime Hu wrote:
> Add PCIe host controller DT bindings of SiFive FU740.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> new file mode 100644
> index 000000000000..c25a91b18cd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive fu740 PCIe host controller
> +
> +description:
> +  SiFive fu740 PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +maintainers:
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +  - Greentime Hu <greentime.hu@sifive.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: sifive,fu740-pcie
> +
> +  reg:
> +    maxItems: 4

What's the 4th item because there's only 3 names:

> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt
> +
> +  device_type:
> +    const: pci

Already in pci-bus.yaml

> +
> +  dma-coherent:
> +    description: Indicates that the PCIe IP block can ensure the coherency
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

Already in pci-bus.yaml

> +
> +  num-lanes: true

Need to define possible values if not all of 1,2,4,8,16.

> +
> +  msi-parent: true
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta
> +      - const: intb
> +      - const: intc
> +      - const: intd
> +
> +  resets:
> +    description: A phandle to the PCIe power up reset line
> +
> +  pwren-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device power on

maxItems: 1

> +
> +  perstn-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device reset

The DWC binding and pci.txt already define 'reset-gpios' for this 
purpose.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type

pci-bus.yaml already requires this.

> +  - dma-coherent
> +  - bus-range

This generally doesn't need to be required unless the h/w can't support 
0-0xff.

> +  - ranges

pci-bus.yaml already requires this.

> +  - num-lanes
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-parent
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clock-names
> +  - clocks
> +  - resets
> +  - pwren-gpios
> +  - perstn-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie@e00000000 {
> +        #address-cells = <3>;
> +        #interrupt-cells = <1>;
> +        #size-cells = <2>;
> +        compatible = "sifive,fu740-pcie";
> +        reg = <0xe 0x00000000 0x1 0x0

Humm, 4GB for DBI space? The DWC controller doesn't have that much 
space, and the kernel will map *all* of that. That's not an 
insignificant amount of memory just for page tables.

> +               0xd 0xf0000000 0x0 0x10000000
> +               0x0 0x100d0000 0x0 0x1000>;

<> around each reg entry.

> +        reg-names = "dbi", "config", "mgmt";
> +        device_type = "pci";
> +        dma-coherent;
> +        bus-range = <0x0 0xff>;
> +        ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000        /* I/O */
> +                  0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000      /* mem */
> +                  0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000      /* mem */
> +                  0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */

<> around each ranges entry.

> +        num-lanes = <0x8>;
> +        interrupts = <56 57 58 59 60 61 62 63 64>;

And here.

> +        interrupt-names = "msi", "inta", "intb", "intc", "intd";
> +        interrupt-parent = <&plic0>;
> +        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +        interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
> +                        <0x0 0x0 0x0 0x2 &plic0 58>,
> +                        <0x0 0x0 0x0 0x3 &plic0 59>,
> +                        <0x0 0x0 0x0 0x4 &plic0 60>;
> +        clock-names = "pcie_aux";
> +        clocks = <&prci PRCI_CLK_PCIE_AUX>;
> +        resets = <&prci 4>;
> +        pwren-gpios = <&gpio 5 0>;
> +        perstn-gpios = <&gpio 8 0>;
> +    };
> -- 
> 2.30.2
> 
