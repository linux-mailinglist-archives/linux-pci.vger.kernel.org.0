Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF9619B3E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKDPR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKDPRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 11:17:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6F2497D
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 08:17:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x15so3185826qtv.9
        for <linux-pci@vger.kernel.org>; Fri, 04 Nov 2022 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cLY+j2UehI3N1Cnjntk9RLs62Wz6cAV41R6pOzQSck=;
        b=I9LTnBdQRy7hDe15H3LFzF2BYq1k8a8tSt86Sn11B3Y9NFgvZT4OOdBxF5dDzGRI3p
         H/LONrkCf3D4ruSzJflrzIKrqlOfROEV8K8SjApgpDquuChKfQ7iEbEE/jZhUEyyrfA5
         Uj4SKzW1YsokKpEh0jxL6dcgj4L2Sub930FjnN+HQMHOUR2weFcJr/wfgJQsbE96w7Z9
         in79FkaExeNpopSRz5zJmndh9zVYCoqjBmYqQf5It2bdim13yC6J6tlZZw1ZGqg9POmd
         oTbUCpuy2ss7E70ZTTrjQqVAsmoKoAMQMV8XWhHJYINuPCNr9mhRwULWTiqqGjUQGQRf
         bTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cLY+j2UehI3N1Cnjntk9RLs62Wz6cAV41R6pOzQSck=;
        b=3+z95VVcUTxW6JfpTAUM5zL/Rieh+UFvq90x9YzZ4Fhda2oLWmFe+G6K9FGRfNasZu
         90y6QqSxbubJ6vBIcAPf/iZv9/Ppkz8vaPzfnWtePL197uDoqYMuyPgIIGaQScohiNU0
         qCscBAvGKzNpO5dBpqIQ2TEYMDWoGgtRD7tBGcM1F/z9yJoHHNE77dqxoZUo+rOhP3TM
         0L5sW99MbX9rOomSwVheul2rdf9W0P8N0IFPze0UrpjFKGohmJFlbDVLk+TxD3Hgs2V1
         PQrcsdaJKQ+3VKIk7KE8AdIa4iZuDDytkQEXEYoz1NDrt+Utv66ndoaUZ9uDMx3x3cIq
         zujw==
X-Gm-Message-State: ACrzQf0WgOeTnvW2wsCcaZb5hmaa3Y7fxpztJkMYN+5/ekPSqtCp7vgb
        5PebfrSfjl62bficZzwrYqrrjQ==
X-Google-Smtp-Source: AMsMyM4VZj8Y+i4dKeRfFDw1FcQbs/x9vXFa3xTrnmE/r+YFQff64I49ER/W/df1O1Lz7TyRv/AWqg==
X-Received: by 2002:ac8:5b03:0:b0:3a5:a44:8dfd with SMTP id m3-20020ac85b03000000b003a50a448dfdmr29626236qtw.497.1667575070625;
        Fri, 04 Nov 2022 08:17:50 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a2a0600b006ce3f1af120sm3256977qkp.44.2022.11.04.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:17:49 -0700 (PDT)
Message-ID: <df373886-8bc6-1c4a-6c5d-ab6582175a72@linaro.org>
Date:   Fri, 4 Nov 2022 11:17:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221104044135.469797-1-thippeswamy.havalige@amd.com>
 <20221104044135.469797-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104044135.469797-2-thippeswamy.havalige@amd.com>
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

On 04/11/2022 00:41, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 152 ++++++++++++++++++
>  2 files changed, 152 insertions(+), 73 deletions(-)
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
> index 000000000000..e3484cc704e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -0,0 +1,152 @@
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
> +      - description: msi0 interrupt asserted when an MSI is received
> +      - description: msi1 interrupt asserted when an MSI is received
> +      - description: interrupt asserted when a legacy interrupt is received
> +      - description: unused interrupt(dummy)
> +      - description: interrupt asserted when miscellaneous interrupt is received
> +
> +  interrupt-names:
> +    minItems: 4

This does not match interrupts.

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
> +  msi-controller:
> +    description: Identifies the node as an MSI controller.

Drop, it comes from msi schema.

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
> +    description: Optional,present if DMA operations are coherent

Space after ", "

> +
> +  clocks:
> +    description: Optional,Input clock specifier. Refer to common clock bindings

maxItems: 1

Drop "Refer to common clock bindings". Space after "," and no capital
letter... Just make it an English sentence.

> +
> +  legacy-interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +      "interrupt-controller": true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'

Use same style of quotes - ' or "

> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-controller
> +  - power-domains

> +    };

Best regards,
Krzysztof

