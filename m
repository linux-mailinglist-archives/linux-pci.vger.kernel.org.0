Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F5620D84
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiKHKkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 05:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiKHKkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 05:40:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0331637F
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 02:40:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f37so20623660lfv.8
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 02:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHhB7eiS7mF4sRQWVxyV5ZdD/PaKPOewsqlcl27mhp8=;
        b=pUDX3tYgKVoiy+Cwf0NY6PF3YTGOzJ1sPT/hUQYzlq06nbj2qKsmYm8/RDCIgHu+I5
         66lcW6BW1GFTRIXnvn1L2hYRtYuGAYRIna9GYcqw5k62NT24r/KdDHSBKUEOPWrh9Kdp
         ZIO5kcuRcFfebQRtQ/QqK8x9umZNB4A0majStmTq9a3zEp+Ie2wSxqRSnpKF4aPvwIuT
         P/jK4/vWdSGhcxNsN6chBwFDLdvwHxytahUsIrNYbaMw26IdfcGQ9C+Bcm99LtaHQH/9
         FVkqi/N1Qdh5uB6oGLZpLeQBk/TmHlWtel6nAmuTrttdoCy/r50nlxOCE5qDSa6qF6O0
         stSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHhB7eiS7mF4sRQWVxyV5ZdD/PaKPOewsqlcl27mhp8=;
        b=Iuiw6AGlG1rVgRSe8+4vepDKKcmW/0c2ENK2UWe2zCRgHn5MMgMWHQ0ejzoIl2FhRQ
         Ka7klaaiijNy71zQV+MaCcIkse3pRVaosO26hn29CVq/JsA6XbZc6zmW0MBGmeqDKmF/
         0T7y88U7avJ0MvGSHRGHTazNTDsb8iJh01aAdiTLO3NbOW10ZsFVMtGtztLBaiUz5a+3
         xfoyXWgExANy2RsmVfKRuV7tmaQbVlBGZbkIVOkf210fsZzdc73Vfb1CM9oc9YnGaSVW
         0Xq2J1Pgpvu3nWDlx+kEeisHgiXxzR694wk7JaHT+S7IDVtYQ/pb46C/9rZNIK4S1Vjd
         y9GQ==
X-Gm-Message-State: ACrzQf2eGrSEkqbnxdxXeTLRxzJUh4fPTZFmcf5KFFceIi8YRWFJlFhu
        A0da5k89ldOM+wVin4mqjW3BHg==
X-Google-Smtp-Source: AMsMyM6iPLN/tcEOQyFVWtbBFoqeRq/JZj0IEgFIDFjkAzfPzj7Ie0I09iQ5Ribjj8ar7P6CPz8mVA==
X-Received: by 2002:ac2:58c7:0:b0:4ae:394b:6a97 with SMTP id u7-20020ac258c7000000b004ae394b6a97mr21254370lfo.291.1667904010260;
        Tue, 08 Nov 2022 02:40:10 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512358600b00497ac6b2b15sm1729283lfr.157.2022.11.08.02.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:40:09 -0800 (PST)
Message-ID: <d45ea394-5c51-2f95-e5ef-641af663fbb3@linaro.org>
Date:   Tue, 8 Nov 2022 11:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
 <20221108035030.1040202-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108035030.1040202-2-thippeswamy.havalige@amd.com>
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

On 08/11/2022 04:50, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Dropped minItems for interrupt-names property.
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 148 ++++++++++++++++++
>  2 files changed, 148 insertions(+), 73 deletions(-)
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
> index 000000000000..af20e02500f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -0,0 +1,148 @@
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
> +  "#interrupt-cells":
> +    const: 1
> +
> +  msi-parent:
> +    description: MSI controller the device is capable of using.
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent:
> +    description: Optional, present if DMA operations are coherent
> +
> +  clocks:
> +    description: Optional, input clock specifier.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Hint: same comment as v3.

Best regards,
Krzysztof

