Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853661EFEF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiKGKII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKGKIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 05:08:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA118B0A
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 02:08:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o12so16040619lfq.9
        for <linux-pci@vger.kernel.org>; Mon, 07 Nov 2022 02:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ihj0upNdkTP55gXuF0SUa0clYb3PNSzxkMOUUfBgT4M=;
        b=Paae27v+L/eQvjKoT4BCsAJ2K+JkOAm+t4Ad6nE8rK+fhE68s629t83Il/dn4z/qVr
         79BR61WYsX7AX9UeyqNFIOV6OV6nKTr3jWMx0tH2nCXCkGD8Z2PesilplJn9gPsSo2Cz
         TregEhz6VT9GF4EdD23J2FOXcR5KJzlB7Eil+aj55fy+jbtm9YNLlBua0esNafGjNVJb
         /hlhqzOGXm0sZTmdx/R/Xu5g6cUfGfwIEvNiKCrMuHnwdg/MiqM3jN0Z3OoBdq/jhPOe
         pOgTqUGXpsrsdBlCo3rjKyeQzr+FBaGq2++eB8JbmAqKhmNmpDhQmncG83jDmJeAgUXv
         FESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihj0upNdkTP55gXuF0SUa0clYb3PNSzxkMOUUfBgT4M=;
        b=Us0wGacx9ZItAvinQYe+4AwWIrkJWPCQigyDIf80zOKntAx46/B2FifGGY+n929DFA
         QsR+dIvJZe1h3bOxoyXFYrBn5DIvBI5toP/P+fRwAHuoVRpVH7xYdufvCiZsKTpACJQR
         HRMCy/KsmfJGs+bm7QahmfCsyIM9195+w/KJEs3AcrZdVhH1OzrzzPYpXKEyFdL01u3/
         eukLpjwWEuMp4QnPVrExftX5MbyMHCwUS6VNiQwNtlTZoe/EZcUlArM59r7mJUMGN2eO
         IDEOeg7kdHBvQGIeK7ukZgrYK1sUjOeFLbcL/3/dZGlcpnrJDimYyTYrXIvEnSIjMgoj
         EPrQ==
X-Gm-Message-State: ANoB5pnjOnVFXdklGauV6QXJRwE/EnoISLFFBjOJ6dK5qKJbVQCvgMWW
        NM4oRk0YmcckAUi0b0jgKVRkTw==
X-Google-Smtp-Source: AA0mqf6Jn0feh+iMrb5BBlE+JQYZx1nv9rkhFWyyWQVlwaOcW+zjT9ZWEVzYNTj5t6u7wOikBTRCWA==
X-Received: by 2002:a05:6512:21ae:b0:4b3:daf9:8647 with SMTP id c14-20020a05651221ae00b004b3daf98647mr566521lft.92.1667815681106;
        Mon, 07 Nov 2022 02:08:01 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j29-20020a056512029d00b004a03fd4476esm1152261lfp.287.2022.11.07.02.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:08:00 -0800 (PST)
Message-ID: <f2d5982d-f1cc-ba49-dd82-62302c08a029@linaro.org>
Date:   Mon, 7 Nov 2022 11:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
 <20221107095408.924778-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107095408.924778-2-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/2022 10:54, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v4:
> Dropped, msi-controller property as it comes from msi schema.
> Rearranged interrupts description as per example.
> Used same style of quotes.
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> deleted file mode 100644
> index f56f8c58c5d9..000000000000
> --- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -* Xilinx NWL PCIe Root Port Bridge DT description
> -
> -Required properties:
> -- compatible: Should contain "xlnx,nwl-pcie-2.11"
> -- #address-cells: Address representation for root ports, set to <3>
> -- #size-cells: Size representation for root ports, set to <2>
> -- #interrupt-cells: specifies the number of cells needed to encode an
> -	interrupt source. The value must be 1.
> -- reg: Should contain Bridge, PCIe Controller registers location,
> -	configuration space, and length
> -- reg-names: Must include the following entries:
> -	"breg": bridge registers
> -	"pcireg": PCIe controller registers
> -	"cfg": configuration space region
> -- device_type: must be "pci"
> -- interrupts: Should contain NWL PCIe interrupt
> -- interrupt-names: Must include the following entries:
> -	"msi1, msi0": interrupt asserted when an MSI is received
> -	"intx": interrupt asserted when a legacy interrupt is received
> -	"misc": interrupt asserted when miscellaneous interrupt is received
> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> -	mapping of the PCI interface to interrupt numbers.
> -- ranges: ranges for the PCI memory regions (I/O space region is not
> -	supported by hardware)
> -	Please refer to the standard PCI bus binding document for a more
> -	detailed explanation
> -- msi-controller: indicates that this is MSI controller node
> -- msi-parent:  MSI parent of the root complex itself
> -- legacy-interrupt-controller: Interrupt controller device node for Legacy
> -	interrupts
> -	- interrupt-controller: identifies the node as an interrupt controller
> -	- #interrupt-cells: should be set to 1
> -	- #address-cells: specifies the number of cells needed to encode an
> -		address. The value must be 0.
> -
> -Optional properties:
> -- dma-coherent: present if DMA operations are coherent
> -- clocks: Input clock specifier. Refer to common clock bindings
> -
> -Example:
> -++++++++
> -
> -nwl_pcie: pcie@fd0e0000 {
> -	#address-cells = <3>;
> -	#size-cells = <2>;
> -	compatible = "xlnx,nwl-pcie-2.11";
> -	#interrupt-cells = <1>;
> -	msi-controller;
> -	device_type = "pci";
> -	interrupt-parent = <&gic>;
> -	interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
> -	interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
> -	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> -	interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
> -			<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
> -			<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
> -			<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> -
> -	msi-parent = <&nwl_pcie>;
> -	reg = <0x0 0xfd0e0000 0x0 0x1000>,
> -	      <0x0 0xfd480000 0x0 0x1000>,
> -	      <0x80 0x00000000 0x0 0x1000000>;
> -	reg-names = "breg", "pcireg", "cfg";
> -	ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000  /* non-prefetchable memory */
> -		  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
> -
> -	pcie_intc: legacy-interrupt-controller {
> -		interrupt-controller;
> -		#address-cells = <0>;
> -		#interrupt-cells = <1>;
> -	};
> -
> -};
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> new file mode 100644
> index 000000000000..35c2d9fb3b9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xlnx,nwl-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx NWL PCIe Root Port Bridge
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,nwl-pcie-2.11
> +
> +  reg:
> +    items:
> +      - description: PCIe bridge registers location.
> +      - description: PCIe Controller registers location.
> +      - description: PCIe Configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: breg
> +      - const: pcireg
> +      - const: cfg
> +
> +  interrupts:
> +    items:
> +      - description: interrupt asserted when miscellaneous interrupt is received
> +      - description: unused interrupt(dummy)
> +      - description: interrupt asserted when a legacy interrupt is received
> +      - description: msi1 interrupt asserted when an MSI is received
> +      - description: msi0 interrupt asserted when an MSI is received
> +
> +  interrupt-names:
> +    minItems: 4

This still does not match your interrupts. It should not be different.
Either you require 4 or 5 interrupts. Not 4 and 5...

> +    items:
> +      - const: misc
> +      - const: dummy
> +      - const: intx
> +      - const: msi1
> +      - const: msi0
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +

Best regards,
Krzysztof

