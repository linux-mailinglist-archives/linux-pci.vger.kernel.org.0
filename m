Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32A375992
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhEFRo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 13:44:27 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:40496 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhEFRoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 13:44:25 -0400
Received: by mail-oo1-f46.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so1416208ooo.7;
        Thu, 06 May 2021 10:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KY+lNZjWq9ZgLiUiLyt3DXqjhKZuimW2lNubxuPtsOc=;
        b=bIoSo19GdjgxlLvrIpS1QKl8iFyetKc/gvphV3O284rE/nZDVWKwMvHz+lkZd6rVLF
         zp+w8K6qv6gw37TSajQM9iwNIqvZp6xzTwRtHt4zxxdEocvwgaPNgAYIDsD0COdgUSC7
         hnqcV9M2wRB0rqIpIUl4O/JMqONDCpF1GFqFVYeD5qXwuQ4xPlf2rhzCltlmUCfcfVeJ
         cV93hGltvvC9is7nuUq2Aps6GFs3aHx2R5f56p9wpcxOlhPikgn4EzzO/Y2CK4ohCrrA
         BhyTofsbwyXY3WHXdjTHR9NsxyGv+32o4OuU3edjBRQ67PSOyawLHK9ZXKBVlX0mnIlF
         REew==
X-Gm-Message-State: AOAM530d40YV9PLc/6mK5ZDUoEH0taOxDua94QyKKJUa1DK/gK7LH9xr
        cZ9wELRKlVkKhVLwqfOctA==
X-Google-Smtp-Source: ABdhPJxbdtvMkpUek+cv6nQacMp2/jGhvnepprPGdWk8cRVD77uMXDL1Il7T9l8mnLZkvp/1ZUVoNg==
X-Received: by 2002:a4a:8311:: with SMTP id f17mr1183015oog.83.1620323005650;
        Thu, 06 May 2021 10:43:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m67sm673301otm.69.2021.05.06.10.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 10:43:24 -0700 (PDT)
Received: (nullmailer pid 536127 invoked by uid 1000);
        Thu, 06 May 2021 17:43:22 -0000
Date:   Thu, 6 May 2021 12:43:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     bhelgaas@google.com, linus.walleij@linaro.org,
        ulli.kroll@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
Message-ID: <20210506174322.GA523813@robh.at.kernel.org>
References: <20210503185228.1518131-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503185228.1518131-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 06:52:27PM +0000, Corentin Labbe wrote:
> Converts pci/faraday,ftpci100.txt to yaml.
> Some change are also made:
> - example has wrong interrupts place
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/pci/faraday,ftpci100.txt         | 135 -----------
>  .../bindings/pci/faraday,ftpci100.yaml        | 211 ++++++++++++++++++
>  2 files changed, 211 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml


> diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> new file mode 100644
> index 000000000000..9be27e71526c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> @@ -0,0 +1,211 @@
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
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: "cortina,gemini-pci"
> +          - const: "faraday,ftpci100"
> +      - items:
> +          - const: "cortina,gemini-pci-dual"
> +          - const: "faraday,ftpci100-dual"
> +      - const: "faraday,ftpci100"
> +      - const: "faraday,ftpci100-dual"

Don't need quotes.

> +
> +  reg:
> +    minItems: 1
> +

> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Covered by pci-bus.yaml.

> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  bus-range:
> +    items:
> +      - const: 0x00
> +      - const: 0xff

That's the default range, so drop.

> +
> +  ranges:
> +    minItems: 2
> +    description: see pci.txt

Drop the description.

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
> +    description: |
> +      when present, this should contain the peripheral clock (PCLK) and the
> +      PCI clock (PCICLK). If these are not present, they are assumed to be
> +      hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.

Split the description:

items:
  - description: peripheral clock (PCLK)
  - description: PCI bus? clock (PCICLK). The PCI clock will be 33 or 66 MHz.


> +
> +  clock-names:
> +    items:
> +      - const: "PCLK"
> +      - const: "PCICLK"

Drop quotes.

> +
> +  interrupt-controller:
> +    allOf:
> +      - $ref: /schemas/interrupt-controller.yaml#

Drop, this will be applied based on the node name.

> +    type: object
> +    properties:
> +      interrupts:
> +        minItems: 1
> +
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - interrupts
> +      - interrupt-controller
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +
> +required:
> +  - reg
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +  - bus-range
> +  - ranges
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - dma-ranges

Drop all the ones required in pci-bus.yaml already.

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
> +#I/O space considerations:
> +
> +#The plain variant has 128MiB of non-prefetchable memory space, whereas the
> +#"dual" variant has 64MiB. Take this into account when describing the ranges.

Could go under 'ranges'?

> +
> +#Interrupt map considerations:

Could go under 'interrupt-map'.

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
