Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574B329E30F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgJ2Cox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 22:44:53 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46643 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgJ1VeK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:34:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id a4so378123ybq.13;
        Wed, 28 Oct 2020 14:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwxLk3GHgi36+ENbUsQRZSih41j7F1eNza5P11dbWyY=;
        b=ZotwYlWWP1sUZsbyol8DnGU5lzSvnHMetd+046ehJps4MuOvYjazHw9P+SgMt9nDSF
         GT/diaV4NiYwa8Y8yBhE+WmKIvFU6GjnefQCDCdTDl4m63NrVDpy7bT/GDsrOUF6Urwq
         I82JHrheHZe2NArDayT9raS3rCAogkWpFYknmXgmlVOh3rSJlYeJWfMJ7n35OhmNP6Qk
         HFQOERu6UAcP/CS7dUfD8ISFX7Nhs1+n9sD0IRvqqnPRlVVKfPl83YJHJx9XZpq7u6QM
         C8tI2qHHYq/Uh+qHoX/xGx5kC4L/6egsCHbbQW564y8vyIGms/CUQbddW8p0KUF8/4Xh
         1OrA==
X-Gm-Message-State: AOAM531z0b0vw6vW/z0n3Zl9OPRXXP8Jc+N++tvHnm1GtU1Nskf8f0qy
        p+nVAiCAJUTdhYPDXRv0tMOrE3/rfw==
X-Google-Smtp-Source: ABdhPJzEcJbyDH5Jdd/gfoeQxWylqBhAxt5672gvJOxg+yKdgICAONZEh8Vzkszy1/5HA2DhQx5lMA==
X-Received: by 2002:a4a:d8c1:: with SMTP id c1mr6068680oov.31.1603896539880;
        Wed, 28 Oct 2020 07:48:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p10sm2521383oig.37.2020.10.28.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:48:59 -0700 (PDT)
Received: (nullmailer pid 4000736 invoked by uid 1000);
        Wed, 28 Oct 2020 14:48:58 -0000
Date:   Wed, 28 Oct 2020 09:48:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Message-ID: <20201028144858.GB3994930@bogus>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 11:05:49AM +0900, Yoshihiro Shimoda wrote:
> Convert Renesas PCIe Host controller bindings documentation to
> json-schema. Note that some compatible doesn't contain on
> the original documantation so that incremental patches are required
> for it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 146 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----------
>  2 files changed, 146 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> new file mode 100644
> index 0000000..d286454
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-pci-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car PCIe Host
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

allOf:
  - $ref: pci-bus.yaml#

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +            - renesas,pcie-r8a7742      # RZ/G1H
> +            - renesas,pcie-r8a7743      # RZ/G1M
> +            - renesas,pcie-r8a7744      # RZ/G1N
> +            - renesas,pcie-r8a7790      # R-Car H2
> +            - renesas,pcie-r8a7791      # R-Car M2-W
> +            - renesas,pcie-r8a7793      # R-Car M2-N
> +        - const: renesas,pcie-rcar-gen2 # R-Car Gen2 and RZ/G1
> +      - items:
> +        - enum:
> +            - renesas,pcie-r8a774a1     # RZ/G2M
> +            - renesas,pcie-r8a774b1     # RZ/G2N
> +            - renesas,pcie-r8a774c0     # RZ/G2E
> +            - renesas,pcie-r8a7795      # R-Car H3
> +            - renesas,pcie-r8a7796      # R-Car M3-W
> +            - renesas,pcie-r8a77961     # R-Car M3-W+
> +            - renesas,pcie-r8a77980     # R-Car V3H
> +            - renesas,pcie-r8a77990     # R-Car E3
> +        - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
> +
> +  reg:
> +    maxItems: 1
> +

> +  '#address-cells':
> +    const: 3
> +
> +  '#size-cells':
> +    const: 2

No need to define these here as pci-bus.yaml does.

> +
> +  bus-range: true
> +
> +  device_type:
> +    const: pci

Same here.

> +
> +  ranges:
> +    minItems: 4
> +    maxItems: 4
> +
> +  dma-ranges:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 3
> +    maxItems: 3
> +
> +  '#interrupt-cells':
> +    const: 1

And this.

> +
> +  interrupt-map-mask: true
> +
> +  interrupt-map: true
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie
> +
> +required:
> +  - compatible
> +  - reg

> +  - '#address-cells'
> +  - '#size-cells'

Already required by pci-bus.yaml

> +  - bus-range

This generally shouldn't be required if 0-255 is supported.

> +  - device_type
> +  - ranges

Both already required by pci-bus.yaml

> +  - dma-ranges
> +  - interrupts

> +  - '#interrupt-cells'
> +  - interrupt-map-mask
> +  - interrupt-map

And these.

> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false

Use unevaluatedProperties instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a7791-sysc.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie: pcie@fe000000 {
> +            compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
> +            reg = <0 0xfe000000 0 0x80000>;
> +             #address-cells = <3>;
> +             #size-cells = <2>;
> +             bus-range = <0x00 0xff>;
> +             device_type = "pci";
> +             ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000>,
> +                      <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
> +                      <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
> +                      <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +             dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>,
> +                          <0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
> +             interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                          <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +             #interrupt-cells = <1>;
> +             interrupt-map-mask = <0 0 0 0>;
> +             interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +             clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
> +             clock-names = "pcie", "pcie_bus";
> +             power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
> +             resets = <&cpg 319>;
> +             status = "disabled";

Don't show status in examples.

> +         };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> deleted file mode 100644
> index 14d307d..0000000
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -* Renesas R-Car PCIe interface
> -
> -Required properties:
> -compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
> -	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
> -	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> -	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> -	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
> -	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> -	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> -	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> -	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> -	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
> -	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
> -	    "renesas,pcie-r8a7796" for the R8A77960 SoC;
> -	    "renesas,pcie-r8a77961" for the R8A77961 SoC;
> -	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
> -	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
> -	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> -				     RZ/G1 compatible device.
> -	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
> -				     RZ/G2 compatible device.
> -
> -	    When compatible with the generic version, nodes must list the
> -	    SoC-specific version corresponding to the platform first
> -	    followed by the generic version.
> -
> -- reg: base address and length of the PCIe controller registers.
> -- #address-cells: set to <3>
> -- #size-cells: set to <2>
> -- bus-range: PCI bus numbers covered
> -- device_type: set to "pci"
> -- ranges: ranges for the PCI memory and I/O regions.
> -- dma-ranges: ranges for the inbound memory regions.
> -- interrupts: two interrupt sources for MSI interrupts, followed by interrupt
> -	source for hardware related interrupts (e.g. link speed change).
> -- #interrupt-cells: set to <1>
> -- interrupt-map-mask and interrupt-map: standard PCI properties
> -	to define the mapping of the PCIe interface to interrupt numbers.
> -- clocks: from common clock binding: clock specifiers for the PCIe controller
> -	and PCIe bus clocks.
> -- clock-names: from common clock binding: should be "pcie" and "pcie_bus".
> -
> -Optional properties:
> -- phys: from common PHY binding: PHY phandle and specifier (only make sense
> -	for R-Car gen3 SoCs where the PCIe PHYs have their own register blocks).
> -- phy-names: from common PHY binding: should be "pcie".
> -
> -Example:
> -
> -SoC-specific DT Entry:
> -
> -	pcie: pcie@fe000000 {
> -		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
> -		reg = <0 0xfe000000 0 0x80000>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		bus-range = <0x00 0xff>;
> -		device_type = "pci";
> -		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> -			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> -			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> -			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> -		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000
> -			      0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
> -		interrupts = <0 116 4>, <0 117 4>, <0 118 4>;
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &gic 0 116 4>;
> -		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
> -		clock-names = "pcie", "pcie_bus";
> -	};
> -- 
> 2.7.4
> 
