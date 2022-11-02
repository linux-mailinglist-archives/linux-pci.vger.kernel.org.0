Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041586169B8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKBQuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiKBQt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 12:49:58 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418DB12D3C;
        Wed,  2 Nov 2022 09:49:17 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322d768ba7so20934724fac.5;
        Wed, 02 Nov 2022 09:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cGQLnaWKabO+ARonzneZWAwfnDm0JeN7UBRoJVIGgY=;
        b=VXXF5f7DD+rsd2MJ96/hiBvpVnXwsPrh+dWVZQtNL5xFKn3ZRYvWFHKUpD3kCJ5HOB
         bugi1js1bzkLFnxLaY7P9ZjY77WDeVF8L5+qoUV3bXw10ZTpHEYZLwSNQgfLNU0orCDB
         V8Eh4euNHrJf07RS01K/+f7GhSQe3ihE0GlDbq2F23gfjbRISt1htBx5sZMB3PIL0Ywz
         BXnqK2QsngkjPaIx1K/0MfDppMjO3CZ8zoMTnXzuyiKX0Q6os9nXHEGuxrVagKmnbCVw
         thMz38z3YHx4Wu/lSPF0C6M3F0PZKe93mRP7Cx9AIDBPsff34R4YbFmctP5qsxBG1X3h
         9bmg==
X-Gm-Message-State: ACrzQf26vbvgOwD/PMkUQbNMjh6W7YwnXmeQeGA/YOXqT+60non+d0pw
        YIq28WICyfc8FQ/yo78Vyg==
X-Google-Smtp-Source: AMsMyM7FLBDTlI91OuH7aKx5Z9jQAKCRyJuEaial3vb9kSGPR3QEqEobZWs58ZzY3S4cxJ+MXqNcNA==
X-Received: by 2002:a05:6870:c08a:b0:132:dc3a:ecdf with SMTP id c10-20020a056870c08a00b00132dc3aecdfmr16378663oad.299.1667407756373;
        Wed, 02 Nov 2022 09:49:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w7-20020a0568080d4700b003546fada8f6sm4703745oik.12.2022.11.02.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:49:15 -0700 (PDT)
Received: (nullmailer pid 4025588 invoked by uid 1000);
        Wed, 02 Nov 2022 16:49:17 -0000
Date:   Wed, 2 Nov 2022 11:49:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bhelgaas@google.com, michals@xilinx.com,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Message-ID: <20221102164917.GA4019302-robh@kernel.org>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 10:50:48AM +0530, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt   | 88 -------------------
>  .../bindings/pci/xlnx,axi-pcie-host.yaml      | 87 ++++++++++++++++++
>  2 files changed, 87 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
> deleted file mode 100644
> index fd57a81180a4..000000000000
> --- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -* Xilinx AXI PCIe Root Port Bridge DT description
> -
> -Required properties:
> -- #address-cells: Address representation for root ports, set to <3>
> -- #size-cells: Size representation for root ports, set to <2>
> -- #interrupt-cells: specifies the number of cells needed to encode an
> -	interrupt source. The value must be 1.
> -- compatible: Should contain "xlnx,axi-pcie-host-1.00.a"
> -- reg: Should contain AXI PCIe registers location and length
> -- device_type: must be "pci"
> -- interrupts: Should contain AXI PCIe interrupt
> -- interrupt-map-mask,
> -  interrupt-map: standard PCI properties to define the mapping of the
> -	PCI interface to interrupt numbers.
> -- ranges: ranges for the PCI memory regions (I/O space region is not
> -	supported by hardware)
> -	Please refer to the standard PCI bus binding document for a more
> -	detailed explanation
> -
> -Optional properties for Zynq/Microblaze:
> -- bus-range: PCI bus numbers covered
> -
> -Interrupt controller child node
> -+++++++++++++++++++++++++++++++
> -Required properties:
> -- interrupt-controller: identifies the node as an interrupt controller
> -- #address-cells: specifies the number of cells needed to encode an
> -	address. The value must be 0.
> -- #interrupt-cells: specifies the number of cells needed to encode an
> -	interrupt source. The value must be 1.
> -
> -NOTE:
> -The core provides a single interrupt for both INTx/MSI messages. So,
> -created a interrupt controller node to support 'interrupt-map' DT
> -functionality.  The driver will create an IRQ domain for this map, decode
> -the four INTx interrupts in ISR and route them to this domain.
> -
> -
> -Example:
> -++++++++
> -Zynq:
> -	pci_express: axi-pcie@50000000 {
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -		compatible = "xlnx,axi-pcie-host-1.00.a";
> -		reg = < 0x50000000 0x1000000 >;
> -		device_type = "pci";
> -		interrupts = < 0 52 4 >;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc 1>,
> -				<0 0 0 2 &pcie_intc 2>,
> -				<0 0 0 3 &pcie_intc 3>,
> -				<0 0 0 4 &pcie_intc 4>;
> -		ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
> -
> -		pcie_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -
> -Microblaze:
> -	pci_express: axi-pcie@10000000 {
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -		compatible = "xlnx,axi-pcie-host-1.00.a";
> -		reg = <0x10000000 0x4000000>;
> -		device_type = "pci";
> -		interrupt-parent = <&microblaze_0_intc>;
> -		interrupts = <1 2>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc 1>,
> -				<0 0 0 2 &pcie_intc 2>,
> -				<0 0 0 3 &pcie_intc 3>,
> -				<0 0 0 4 &pcie_intc 4>;
> -		ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x10000000>;
> -
> -		pcie_intc: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> new file mode 100644
> index 000000000000..fc0761a7a2e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xlnx,axi-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI PCIe Root Port Bridge
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-pcie-host-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ranges:
> +    items:
> +      - description: |
> +          ranges for the PCI memory regions (I/O space region is not
> +          supported by hardware)
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object

       additionalProperties: false

> +    properties:
> +      "interrupt-controller": true

Don't need quotes.

> +      "#address-cells":
> +        const: 0

blank line

> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - 'interrupt-controller'
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    zynq:

Odd, but I guess a valid label because they can appear about anywhere or 
multiple labels in the same place.

Drop and adjust the indentation.

> +        pci_express: pcie@50000000 {

Drop unused labels.

> +            compatible = "xlnx,axi-pcie-host-1.00.a";
> +            reg = < 0x50000000 0x1000000 >;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            device_type = "pci";
> +            interrupts = < GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH >;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +                            <0 0 0 2 &pcie_intc 2>,
> +                            <0 0 0 3 &pcie_intc 3>,
> +                            <0 0 0 4 &pcie_intc 4>;
> +            ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
> +            pcie_intc: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> -- 
> 2.25.1
> 
> 
