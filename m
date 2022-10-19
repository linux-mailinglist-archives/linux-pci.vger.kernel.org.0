Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6F604AC6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiJSPL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiJSPK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 11:10:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E9900C3
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 08:04:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z30so10839235qkz.13
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIba4LQ00ttMU3jX8PFfsaELx8frRr91MUBlfYSr2kI=;
        b=vsmdeYcbOirVkIwVp69K0/B/Q2G8pj5aImsLGSphSCOkdyOtVK4s+2f3JpaBxGkjMX
         hJO02Hssoq5its4BAfIW39nttxpgNxjT1robK16PB6u0FasQKcHfZjT2d6t8yR3xB9FO
         +f9bnHcJ4B1+Zv+etkxUy54f48qZESHPiLBpNB2ipipQS80b/wXUHWgv94jp0i75dnq4
         XSEc8lr0a9ThTsxyJJjnuJu6pHyaMQb8Mnh1mArbWkSO9kY6I+oUuCMUqmdC/C+Pll5x
         59V4VcW1H1XbZW74BsMCayRw8As4dtO0IezTlweUN+2Cgp64uWmubZQwsHXPiW11qTM1
         wSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIba4LQ00ttMU3jX8PFfsaELx8frRr91MUBlfYSr2kI=;
        b=qshvF3XT8daQQuWC8nV9yo/tjvc5W72oPxmgyzOVmaoWEx3Y81tFKzl5PdeoVhrr2M
         OEPXMOqODp1AHnD1IfjCJNBRuPWfxCSLfM9nVD1s7rkHhhlB5imzTy3tLo8mHDUUuvJi
         qVwYQNbmNWyuMP/GgHZ2gAp5REfkq0dQqE+LxdPEDvjE37q35/1ij2J/IY0/a8naKoWh
         VQ5ZXUu+mfUqzfGklw2GAvFiYI9EB0pZWvo5ZB9uVe5CiGhhP/ILb1dmNUhAkweZ3k43
         LA+AQsjvilrav6fkPQolLjTAfih2NzwJRahiLAIczUVx5+CWg4zNebsRemqTSqaBcgIX
         ihag==
X-Gm-Message-State: ACrzQf2TWcsVdytnX9GJz3BuYMvtpfyEKliRXuErBbv6w1VKpMkQUx8p
        WVqa9R9+x4WlFk6Tob0+ZnC0WQ==
X-Google-Smtp-Source: AMsMyM66zRdjEsWkpeQJV2uIpQ6hyK3beuGQqjZeWEqSkjNlyGOYQkFrNhdKvmWqwkiCfpzs5N8Mbg==
X-Received: by 2002:ae9:e604:0:b0:6ec:c872:a0d5 with SMTP id z4-20020ae9e604000000b006ecc872a0d5mr5644764qkf.684.1666191852713;
        Wed, 19 Oct 2022 08:04:12 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id d18-20020a05620a241200b006bc192d277csm5266084qkn.10.2022.10.19.08.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:04:11 -0700 (PDT)
Message-ID: <a45bbe87-9ce0-4b52-c275-cf1a361b7afe@linaro.org>
Date:   Wed, 19 Oct 2022 11:04:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        bharat.kumar.gogada@amd.com
References: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/10/2022 10:46, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt   | 88 -------------------
>  .../devicetree/bindings/pci/xilinx-pcie.yaml  | 81 +++++++++++++++++
>  2 files changed, 81 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.yaml
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
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml b/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml
> new file mode 100644
> index 000000000000..6b372ac1763e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xilinx-pcie.yaml#

Filename based on compatible, so:
xlnx,axi-pcie-host.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI PCIe Root Port Bridge DT description

Drop "DT description"

> +
> +maintainers:
> +  - Thippeswamy Havalige <thippesw@xilinx.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-pcie-host-1.00.a
> +
> +  reg:
> +    items:
> +      - description: should contain AXI PCIe registers location and length

Drop description, just maxItems: 1

> +
> +  interrupts:
> +    items:
> +      - description: should contain AXI PCIe interrupt

Ditto


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
> +      "#address-cells":
> +        const: 0
> +      "#interrupt-cells":
> +        const: 1

Add also required properties for this node.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ranges
> +  - device_type
> +  - interrupt-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    Zynq:
> +        pci_express: pcie@50000000 {
> +               #address-cells = <3>;

Use 4 spaces for example indentation.

> +               #size-cells = <2>;
> +               #interrupt-cells = <1>;
> +               compatible = "xlnx,axi-pcie-host-1.00.a";
> +               reg = < 0x50000000 0x1000000 >;

Fix style.

compatible goes first, then reg, then the rest.

> +               device_type = "pci";
> +               interrupts = < 0 52 4 >;

Fix the style, use defines.

> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +                               <0 0 0 2 &pcie_intc 2>,
> +                               <0 0 0 3 &pcie_intc 3>,
> +                               <0 0 0 4 &pcie_intc 4>;
> +                ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;

Original example looked correct, so how did it become with these spaces?

> +                pcie_intc: interrupt-controller {
> +                         interrupt-controller;
> +                         #address-cells = <0>;
> +                         #interrupt-cells = <1>;
> +                };
> +    };

Best regards,
Krzysztof

