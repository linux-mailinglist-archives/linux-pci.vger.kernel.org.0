Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33037EE19
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhELVJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:09:43 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34742 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385206AbhELUHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 16:07:08 -0400
Received: by mail-ot1-f49.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso21699238ote.1;
        Wed, 12 May 2021 13:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLAgg1gzIwdTJswqs10Z8L6pyAmoGzdVA4WiAm0IcvQ=;
        b=IdAuqMotdNNnEY9C+BSrb+mSU5j76kHNQyY/ZNgTNUeROF8PptBZl0RhcU6z0SewgE
         1cCk57rsnU1WIpdllxNZHdRCEvGb+jlBWwanlZNbgRWkmJBqyv7JMEta/aa37/Emembh
         XB18mcFXP5C2niYGbAHW+tpKl9maR3zjGCqCIW/lxb8OSiCIebotQK/b5+GBeJ6ei5tV
         psk25X57uEgLsrptq273x2eyUIXX74u6T9tCbCLUn9DL9IJPF4+5LAKwmLZyLe+K88vh
         jlisBf+UgrrTFP1MVvSqZiSUM7GqIirUI8Imm4uG53jbffSUtolZtK9FJi1bdOvl0wKM
         iaEA==
X-Gm-Message-State: AOAM532cyFjWAFq0UDsr92OjgauX4V671wJEnzYbRDchvjgYziNlKWUg
        rnZEk10F9rNSbBhwMO+weQ==
X-Google-Smtp-Source: ABdhPJyuWZk1Wk9zTwsbFHmiX58y2iCMICm9GxgSIv3STi5Xmp5lpk1hQrLoGAwSa/rBz8YmN3Op4Q==
X-Received: by 2002:a9d:1d01:: with SMTP id m1mr32607870otm.155.1620849959372;
        Wed, 12 May 2021 13:05:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x24sm178645otq.34.2021.05.12.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:05:58 -0700 (PDT)
Received: (nullmailer pid 2445249 invoked by uid 1000);
        Tue, 11 May 2021 19:12:31 -0000
Date:   Tue, 11 May 2021 14:12:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: PCI: ftpci100: convert faraday,ftpci100
 to YAML
Message-ID: <20210511191231.GA2435099@robh.at.kernel.org>
References: <20210510203041.4024411-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510203041.4024411-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 08:30:41PM +0000, Corentin Labbe wrote:
> Converts pci/faraday,ftpci100.txt to yaml.
> Some change are also made:
> - example has wrong interrupts place
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed issues reported by Rob Herring https://patchwork.kernel.org/project/linux-pci/patch/20210503185228.1518131-1-clabbe@baylibre.com/
> - moved comment as asked by Linus Walleij
>  .../bindings/pci/faraday,ftpci100.txt         | 135 -------------
>  .../bindings/pci/faraday,ftpci100.yaml        | 178 ++++++++++++++++++
>  2 files changed, 178 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
> deleted file mode 100644
> index 5f8cb4962f8d..000000000000
> --- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -Faraday Technology FTPCI100 PCI Host Bridge
> -
> -This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
> -is a generic IP block from Faraday Technology. It exists in two variants:
> -plain and dual PCI. The plain version embeds a cascading interrupt controller
> -into the host bridge. The dual version routes the interrupts to the host
> -chips interrupt controller.
> -
> -The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
> -Technology) and product ID 0x4321.
> -
> -Mandatory properties:
> -
> -- compatible: ranging from specific to generic, should be one of
> -  "cortina,gemini-pci", "faraday,ftpci100"
> -  "cortina,gemini-pci-dual", "faraday,ftpci100-dual"
> -  "faraday,ftpci100"
> -  "faraday,ftpci100-dual"
> -- reg: memory base and size for the host bridge
> -- #address-cells: set to <3>
> -- #size-cells: set to <2>
> -- #interrupt-cells: set to <1>
> -- bus-range: set to <0x00 0xff>
> -- device_type, set to "pci"
> -- ranges: see pci.txt
> -- interrupt-map-mask: see pci.txt
> -- interrupt-map: see pci.txt
> -- dma-ranges: three ranges for the inbound memory region. The ranges must
> -  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB, 64MB,
> -  128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
> -  pre-fetchable.
> -
> -Optional properties:
> -- clocks: when present, this should contain the peripheral clock (PCLK) and the
> -  PCI clock (PCICLK). If these are not present, they are assumed to be
> -  hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
> -- clock-names: when present, this should contain "PCLK" for the peripheral
> -  clock and "PCICLK" for the PCI-side clock.
> -
> -Mandatory subnodes:
> -- For "faraday,ftpci100" a node representing the interrupt-controller inside the
> -  host bridge is mandatory. It has the following mandatory properties:
> -  - interrupt: see interrupt-controller/interrupts.txt
> -  - interrupt-controller: see interrupt-controller/interrupts.txt
> -  - #address-cells: set to <0>
> -  - #interrupt-cells: set to <1>
> -
> -I/O space considerations:
> -
> -The plain variant has 128MiB of non-prefetchable memory space, whereas the
> -"dual" variant has 64MiB. Take this into account when describing the ranges.
> -
> -Interrupt map considerations:
> -
> -The "dual" variant will get INT A, B, C, D from the system interrupt controller
> -and should point to respective interrupt in that controller in its
> -interrupt-map.
> -
> -The code which is the only documentation of how the Faraday PCI (the non-dual
> -variant) interrupts assigns the default interrupt mapping/swizzling has
> -typically been like this, doing the swizzling on the interrupt controller side
> -rather than in the interconnect:
> -
> -interrupt-map-mask = <0xf800 0 0 7>;
> -interrupt-map =
> -	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> -	<0x4800 0 0 2 &pci_intc 1>,
> -	<0x4800 0 0 3 &pci_intc 2>,
> -	<0x4800 0 0 4 &pci_intc 3>,
> -	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> -	<0x5000 0 0 2 &pci_intc 2>,
> -	<0x5000 0 0 3 &pci_intc 3>,
> -	<0x5000 0 0 4 &pci_intc 0>,
> -	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> -	<0x5800 0 0 2 &pci_intc 3>,
> -	<0x5800 0 0 3 &pci_intc 0>,
> -	<0x5800 0 0 4 &pci_intc 1>,
> -	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> -	<0x6000 0 0 2 &pci_intc 0>,
> -	<0x6000 0 0 3 &pci_intc 1>,
> -	<0x6000 0 0 4 &pci_intc 2>;
> -
> -Example:
> -
> -pci@50000000 {
> -	compatible = "cortina,gemini-pci", "faraday,ftpci100";
> -	reg = <0x50000000 0x100>;
> -	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> -			<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> -			<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> -			<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> -	#address-cells = <3>;
> -	#size-cells = <2>;
> -	#interrupt-cells = <1>;
> -
> -	bus-range = <0x00 0xff>;
> -	ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
> -		 <0x01000000 0 0          0x50000000 0 0x00100000>,
> -		 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
> -		 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
> -
> -	/* DMA ranges */
> -	dma-ranges =
> -	/* 128MiB at 0x00000000-0x07ffffff */
> -	<0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
> -	/* 64MiB at 0x00000000-0x03ffffff */
> -	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
> -	/* 64MiB at 0x00000000-0x03ffffff */
> -	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
> -
> -	interrupt-map-mask = <0xf800 0 0 7>;
> -	interrupt-map =
> -		<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> -		<0x4800 0 0 2 &pci_intc 1>,
> -		<0x4800 0 0 3 &pci_intc 2>,
> -		<0x4800 0 0 4 &pci_intc 3>,
> -		<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> -		<0x5000 0 0 2 &pci_intc 2>,
> -		<0x5000 0 0 3 &pci_intc 3>,
> -		<0x5000 0 0 4 &pci_intc 0>,
> -		<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> -		<0x5800 0 0 2 &pci_intc 3>,
> -		<0x5800 0 0 3 &pci_intc 0>,
> -		<0x5800 0 0 4 &pci_intc 1>,
> -		<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> -		<0x6000 0 0 2 &pci_intc 0>,
> -		<0x6000 0 0 3 &pci_intc 0>,
> -		<0x6000 0 0 4 &pci_intc 0>;
> -	pci_intc: interrupt-controller {
> -		interrupt-parent = <&intcon>;
> -		interrupt-controller;
> -		#address-cells = <0>;
> -		#interrupt-cells = <1>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> new file mode 100644
> index 000000000000..0321f5091c25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/faraday,ftpci100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTPCI100 PCI Host Bridge
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +    This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
> +    is a generic IP block from Faraday Technology. It exists in two variants:
> +    plain and dual PCI. The plain version embeds a cascading interrupt controller
> +    into the host bridge. The dual version routes the interrupts to the host
> +    chips interrupt controller.
> +    The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
> +    Technology) and product ID 0x4321.
> +    I/O space considerations:
> +    The plain variant has 128MiB of non-prefetchable memory space, whereas the
> +    "dual" variant has 64MiB. Take this into account when describing the ranges.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: cortina,gemini-pci
> +          - const: faraday,ftpci100
> +      - items:
> +          - const: cortina,gemini-pci-dual
> +          - const: faraday,ftpci100-dual
> +      - const: faraday,ftpci100
> +      - const: faraday,ftpci100-dual
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  ranges:
> +    minItems: 2
> +
> +  dma-ranges:
> +    minItems: 3
> +    description: |
> +      three ranges for the inbound memory region. The ranges must
> +      be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB, 64MB,
> +      128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
> +      pre-fetchable.
> +
> +  clocks:
> +    minItems: 2

You can drop this.

> +    items:
> +      - description: peripheral clock (PCLK)
> +      - description: PCI clock (PCICLK).
> +    description: |
> +      If these are not present, they are assumed to be
> +      hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
> +
> +  clock-names:
> +    items:
> +      - const: PCLK
> +      - const: PCICLK
> +
> +  interrupt-controller:
> +    type: object
> +
> +required:
> +  - reg
> +  - compatible
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - dma-ranges
> +
> +#Interrupt map considerations:

Did you forget about moving this? If not under a property, you could 
also put under the top 'description'. The problem with these as comments 
is if we ever start generating documentation from the schema docs we'll 
loose these.

> +
> +#The "dual" variant will get INT A, B, C, D from the system interrupt controller
> +#and should point to respective interrupt in that controller in its
> +#interrupt-map.
> +
> +#The code which is the only documentation of how the Faraday PCI (the non-dual
> +#variant) interrupts assigns the default interrupt mapping/swizzling has
> +#typically been like this, doing the swizzling on the interrupt controller side
> +#rather than in the interconnect:
> +
> +#interrupt-map-mask = <0xf800 0 0 7>;
> +#interrupt-map =
> +#	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +#	<0x4800 0 0 2 &pci_intc 1>,
> +#	<0x4800 0 0 3 &pci_intc 2>,
> +#	<0x4800 0 0 4 &pci_intc 3>,
> +#	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> +#	<0x5000 0 0 2 &pci_intc 2>,
> +#	<0x5000 0 0 3 &pci_intc 3>,
> +#	<0x5000 0 0 4 &pci_intc 0>,
> +#	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> +#	<0x5800 0 0 2 &pci_intc 3>,
> +#	<0x5800 0 0 3 &pci_intc 0>,
> +#	<0x5800 0 0 4 &pci_intc 1>,
> +#	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> +#	<0x6000 0 0 2 &pci_intc 0>,
> +#	<0x6000 0 0 3 &pci_intc 1>,
> +#	<0x6000 0 0 4 &pci_intc 2>;
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        items:
> +          - const: cortina,gemini-pci
> +          - const: faraday,ftpci100
> +then:
> +  required:
> +    - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pci@50000000 {
> +      compatible = "cortina,gemini-pci", "faraday,ftpci100";
> +      reg = <0x50000000 0x100>;
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      #interrupt-cells = <1>;
> +
> +      bus-range = <0x00 0xff>;
> +      ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
> +        <0x01000000 0 0          0x50000000 0 0x00100000>,
> +        /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
> +        <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
> +
> +      /* DMA ranges */
> +      dma-ranges =
> +        /* 128MiB at 0x00000000-0x07ffffff */
> +        <0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
> +        /* 64MiB at 0x00000000-0x03ffffff */
> +        <0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
> +        /* 64MiB at 0x00000000-0x03ffffff */
> +        <0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
> +
> +      interrupt-map-mask = <0xf800 0 0 7>;
> +      interrupt-map =
> +        <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +        <0x4800 0 0 2 &pci_intc 1>,
> +        <0x4800 0 0 3 &pci_intc 2>,
> +        <0x4800 0 0 4 &pci_intc 3>,
> +        <0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> +        <0x5000 0 0 2 &pci_intc 2>,
> +        <0x5000 0 0 3 &pci_intc 3>,
> +        <0x5000 0 0 4 &pci_intc 0>,
> +        <0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> +        <0x5800 0 0 2 &pci_intc 3>,
> +        <0x5800 0 0 3 &pci_intc 0>,
> +        <0x5800 0 0 4 &pci_intc 1>,
> +        <0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> +        <0x6000 0 0 2 &pci_intc 0>,
> +        <0x6000 0 0 3 &pci_intc 0>,
> +        <0x6000 0 0 4 &pci_intc 0>;
> +      pci_intc: interrupt-controller {
> +        interrupt-parent = <&intcon>;
> +        interrupt-controller;
> +        interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <0>;
> +        #interrupt-cells = <1>;
> +      };
> +    };
> -- 
> 2.26.3
> 
