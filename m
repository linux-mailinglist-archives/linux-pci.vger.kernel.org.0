Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1C616600
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKBPXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBPXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 11:23:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51516617B
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 08:23:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cg5so2751014qtb.12
        for <linux-pci@vger.kernel.org>; Wed, 02 Nov 2022 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DBOh0seZgVfpZ5tlyQZIQ8LgeABKZUQUWQr8sZ8L+M=;
        b=OHUJ9LQ+YcZvdDRODUwinUi0s4L6WDWIhSOMy3lhOeAtiy05cbA6YnLCLpYkGl1ZZB
         xWoZmwOGmI1ofM/jlpj+t6Bqs4uMbFfTiajcru0Ckv2Ih15i7W001X0lio0AXIPuyKzX
         TQnS7LZRnGXWWkG3DrrZo5HGRmom2HIokZCV9v+N+4DH8cE2xUpgsL1phg6+lrRbGrbT
         DDjbeCTptWa0tQlC8PnsPHkmomakmoVBpmGU6cgBVpuOI2EdnVWMjaPihhigSVZmeFbZ
         HoAaMP+Uo220bFxfLSQZf1G/aR/aEIIHcf7/AIv6vM/eT9bh57JmrtHFPUbn54zQaa9Y
         IfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DBOh0seZgVfpZ5tlyQZIQ8LgeABKZUQUWQr8sZ8L+M=;
        b=45r24RRBoFSDY83dTGIKnqzLnHml97t/BiRWq+Pvzbuq8phC5sQ4K6lnIZg/cSGnHb
         3JIE2qfF+31yimY/JqC64etXbl4Kmw8tPZv9iV6EoDux1lbDH4lYzrvvPqXLhzOE7Mke
         g40TrHXh2y+tV8VoDlVtC2jZ5QvwmHJIxc5FiKoSdL4vGvWwV2CTWYIzeyg0X2J2c0GG
         QVvdoxuQmA9ykGtIzhkRCB+Cg9q0xm7L0mA4N3uulcK7AxPS/C8/9RB/R7/dizCEe8Ix
         MiJBxXrQksMKwnYfF8ni2eCay1ftBAZIvqTQA7hB+jO9xXQR3oXEQK4CP/pzOHtgrmQ3
         Tldg==
X-Gm-Message-State: ACrzQf25vatkD+LiO/pngoHiBwUGu95lVW1zhYe9dmdBAJCpeK5ZkTWk
        8MIc5hpVx6/J8rbjID/aSVmYe7q2y1IAkQ==
X-Google-Smtp-Source: AMsMyM4xHlDk7Aw1fehJcfDTAAhh/xQs5ETuj4GUQm09yy35CI3KEq6yxgP08X9zUDqwqL5Su7YqFw==
X-Received: by 2002:a05:622a:1751:b0:39c:cbba:d07d with SMTP id l17-20020a05622a175100b0039ccbbad07dmr19882299qtk.30.1667402581464;
        Wed, 02 Nov 2022 08:23:01 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006bba46e5eeasm8731216qkl.37.2022.11.02.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 08:23:00 -0700 (PDT)
Message-ID: <9f2a50db-0cfe-b9ce-11f4-be406cb9888e@linaro.org>
Date:   Wed, 2 Nov 2022 11:22:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
 <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
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

On 01/11/2022 01:20, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ----------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 73 deletions(-)
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
> index 000000000000..f6634be618a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -0,0 +1,137 @@
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

const: bridge

> +      - const: pcireg

const: pci

> +      - const: cfg
> +
> +  interrupts:
> +    items:
> +      - description: msi0 interrupt asserted when an MSI is received
> +      - description: msi1 interrupt asserted when an MSI is received
> +      - description: interrupt asserted when a legacy interrupt is received
> +      - description: unused interrupt(dummy)
> +      - description: interrupt asserted when miscellaneous interrupt is received
> +
> +  interrupt-names:
> +    maxItems: 5

I didn't notice last time - what are the names? They need to be defined.

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

