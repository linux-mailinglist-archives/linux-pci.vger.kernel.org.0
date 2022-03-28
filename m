Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCEE4E9C2A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiC1QYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiC1QYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 12:24:25 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C022FFEA;
        Mon, 28 Mar 2022 09:22:44 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id w17-20020a056830111100b005b22c584b93so11009532otq.11;
        Mon, 28 Mar 2022 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1jMR9dXB4EBClhx/VkwbBtXY45OnmdTpgwd1QsgBQ0=;
        b=MhE+obHAa1C9fRo/5Blx9G6NbyqbnNQUzkUnOEuBMPi9fODml7nwUVMmZvjD8UpCO/
         18KVdmtxCZcpNqwfpHZa2GHAnH9R8e0srvxbDzg1z4iLWHp5SlOrD40oCaFh71Y61quu
         Dw+O7FXP7rM17uopU6UWBvJFsQUAGHLySh8z+M+EgR5thQs1RmwitNwn/Px6ZJ9GZOkH
         PrPxfC0KHTfXXXZQedxuDTxbld2M4/mYFnpkLwDMTNJnxtnYnduAhrmthUmczR4Xj28o
         ABm7uDcntb0PeDLp2GEAXT+QWcDbTbiS9xoSVHNrpd+LltcgnbCFo9mF6Aba8WOTs7aa
         dk7A==
X-Gm-Message-State: AOAM531NKXQMArL80WAFpRVChgbrs3lLgvsLGer3h2g+yFvnryWoVC6g
        ZvVMiR0SSed5STLsQodDtA==
X-Google-Smtp-Source: ABdhPJxrUjcZd0pzxFr4q2rWryMDDV/OHhC+GnOG4OjChVysYlaPrNdSQQtr2s79Mp1NPLmf4hpKdg==
X-Received: by 2002:a05:6830:1f5b:b0:5a2:2ec7:4ea4 with SMTP id u27-20020a0568301f5b00b005a22ec74ea4mr10412065oth.206.1648484563468;
        Mon, 28 Mar 2022 09:22:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056808148400b002d9be41b179sm7702224oiw.50.2022.03.28.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:22:42 -0700 (PDT)
Received: (nullmailer pid 2497885 invoked by uid 1000);
        Mon, 28 Mar 2022 16:22:41 -0000
Date:   Mon, 28 Mar 2022 11:22:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to
 json-schema
Message-ID: <YkHg0UeS9kPOW6Kf@robh.at.kernel.org>
References: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 11:11:38AM +0900, Kunihiko Hayashi wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie.yaml | 100 ++++++++++++++++++
>  .../devicetree/bindings/pci/uniphier-pcie.txt |  82 --------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 101 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> new file mode 100644
> index 000000000000..57176f62f955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/socionext,uniphier-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier PCIe host controller
> +
> +description: |
> +  UniPhier PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - socionext,uniphier-pcie
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 4
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: dbi
> +          - const: link
> +          - const: config
> +      - items:
> +          - const: dbi
> +          - const: link
> +          - const: config
> +          - const: atu

You can have just the 2nd list plus 'minItems: 3' to do the same thing.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  num-viewport: true
> +
> +  num-lanes: true
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie: pcie@66000000 {
> +        compatible = "socionext,uniphier-pcie";
> +        reg-names = "dbi", "link", "config";
> +        reg = <0x66000000 0x1000>, <0x66010000 0x10000>, <0x2fff0000 0x10000>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        clocks = <&sys_clk 24>;
> +        resets = <&sys_rst 24>;
> +        num-lanes = <1>;
> +        num-viewport = <1>;
> +        bus-range = <0x0 0xff>;
> +        device_type = "pci";
> +        ranges = <0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000>,
> +                 <0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
> +        phy-names = "pcie-phy";
> +        phys = <&pcie_phy>;
> +        #interrupt-cells = <1>;
> +        interrupt-names = "dma", "msi";
> +        interrupts = <0 224 4>, <0 225 4>;
> +        interrupt-map-mask = <0 0 0  7>;
> +        interrupt-map = <0 0 0  1  &pcie_intc 0>,
> +                        <0 0 0  2  &pcie_intc 1>,
> +                        <0 0 0  3  &pcie_intc 2>,
> +                        <0 0 0  4  &pcie_intc 3>;
> +
> +        pcie_intc: legacy-interrupt-controller {
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +            interrupt-parent = <&gic>;
> +            interrupts = <0 226 4>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> deleted file mode 100644
> index 359585db049f..000000000000
> --- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -Socionext UniPhier PCIe host controller bindings
> -
> -This describes the devicetree bindings for PCIe host controller implemented
> -on Socionext UniPhier SoCs.
> -
> -UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> -It shares common functions with the PCIe DesignWare core driver and inherits
> -common properties defined in
> -Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> -
> -Required properties:
> -- compatible: Should be "socionext,uniphier-pcie".
> -- reg: Specifies offset and length of the register set for the device.
> -	According to the reg-names, appropriate register sets are required.
> -- reg-names: Must include the following entries:
> -    "dbi"    - controller configuration registers
> -    "link"   - SoC-specific glue layer registers
> -    "config" - PCIe configuration space
> -    "atu"    - iATU registers for DWC version 4.80 or later
> -- clocks: A phandle to the clock gate for PCIe glue layer including
> -	the host controller.
> -- resets: A phandle to the reset line for PCIe glue layer including
> -	the host controller.
> -- interrupts: A list of interrupt specifiers. According to the
> -	interrupt-names, appropriate interrupts are required.
> -- interrupt-names: Must include the following entries:
> -    "dma" - DMA interrupt
> -    "msi" - MSI interrupt
> -
> -Optional properties:
> -- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> -	phys are required.
> -- phy-names: Must be "pcie-phy".
> -
> -Required sub-node:
> -- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
> -	interrupts.
> -
> -Required properties for legacy-interrupt-controller:
> -- interrupt-controller: identifies the node as an interrupt controller.
> -- #interrupt-cells: specifies the number of cells needed to encode an
> -	interrupt source. The value must be 1.
> -- interrupt-parent: Phandle to the parent interrupt controller.
> -- interrupts: An interrupt specifier for legacy interrupt.
> -
> -Example:
> -
> -	pcie: pcie@66000000 {
> -		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
> -		status = "disabled";
> -		reg-names = "dbi", "link", "config";
> -		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
> -		      <0x2fff0000 0x10000>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		clocks = <&sys_clk 24>;
> -		resets = <&sys_rst 24>;
> -		num-lanes = <1>;
> -		num-viewport = <1>;
> -		bus-range = <0x0 0xff>;
> -		device_type = "pci";
> -		ranges =
> -		/* downstream I/O */
> -			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
> -		/* non-prefetchable memory */
> -			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
> -		#interrupt-cells = <1>;
> -		interrupt-names = "dma", "msi";
> -		interrupts = <0 224 4>, <0 225 4>;
> -		interrupt-map-mask = <0 0 0  7>;
> -		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
> -				<0 0 0  2  &pcie_intc 1>,	/* INTB */
> -				<0 0 0  3  &pcie_intc 2>,	/* INTC */
> -				<0 0 0  4  &pcie_intc 3>;	/* INTD */
> -
> -		pcie_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <0 226 4>;
> -		};
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cc47b2dbdc9..c1d377be991c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15337,7 +15337,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
>  M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/uniphier-pcie*
> +F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
>  F:	drivers/pci/controller/dwc/pcie-uniphier*
>  
>  PCIE DRIVER FOR ST SPEAR13XX
> -- 
> 2.25.1
> 

