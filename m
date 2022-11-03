Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35F617CBC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiKCMhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiKCMhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 08:37:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CD13F66
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 05:36:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a27so1063110qtw.10
        for <linux-pci@vger.kernel.org>; Thu, 03 Nov 2022 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WH99neEEF4ndCzZ27ZhavDYbl2sP8EQtKZZ9qhohbBM=;
        b=wDnKGkJoKZgeL+ViBFb3h4PTkhiV6cns9BfFClJsmTXWwlwuK4JxWJMfPYjOSC5XCs
         1JGMo/KRSHOVYwA0MgLtniDG1rrvmXIjN/LaC3VJxBgaPZ34iy/NEuUvvp1MAeRUOoz4
         wOHsYcjp7XLh3oVhaQ5wc0hZuhexn+2IHqk2X3S8Gnumaa71zRYMEPyR4jCwT72sUyyq
         ghof/BQ0c+YtA4CpanAVrrzJO3jYsJjciEegCD1W5o0TsIvV98jfL5NFpxp+j5epRmrH
         cUxf0OTD3Pd7wwc8QfDV4Nr6JPSxjQoT5yvuE+Tmhp09Nre+Bc+N1KreqybPlgxrZ1PV
         Bqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH99neEEF4ndCzZ27ZhavDYbl2sP8EQtKZZ9qhohbBM=;
        b=QAv5ogUc15kcY2BlrIXmx70GZMLJXvoJGz250dlQKkq85wQmAhug4zrocDStEOyOe9
         lH/lhfzcKRywlzzBcHAvrnkt1bDDo2TbLVMQsTBnhuU8rsSb2xcnlsLMNXhhHFb3dWED
         brJVHH1cWTk+dCshAuBCsrGrEJKWDB0aD2Y6nUP/rvYV/PKvTSKJfTEIVdasH111qBY9
         KWuGhrP6xeMV9SODGkvUv3Qa7NKx7yBBaTN2oUfLkQc3y8cDaNdRessCdiaATGvTh4Sn
         AuQw2Up2CQ2SkB+tX9w0v/NF57C4AhWxN9UlQSDtCs8qB2+5MfDaUXMeS+1gDYL1zGTv
         e7bA==
X-Gm-Message-State: ACrzQf0AcWUdPHxJf6poFRwVc4ILVZu7c8U72Cw380lVr1NpQ7EGWtxM
        MQCGViQyspKoCc/pDELVyWFB5A==
X-Google-Smtp-Source: AMsMyM5HGeWbExC08urlksifHHABUR8tSalLHd1u9dUB+UreB1r74Ql/zO/D8dkMEx31NyUvO9QA4Q==
X-Received: by 2002:ac8:4710:0:b0:3a5:2580:6169 with SMTP id f16-20020ac84710000000b003a525806169mr18383204qtp.338.1667478994895;
        Thu, 03 Nov 2022 05:36:34 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05620a318b00b006eeca296c00sm634806qkb.104.2022.11.03.05.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:36:34 -0700 (PDT)
Message-ID: <40fe8a7c-7a6e-8c07-4d61-8ebef57a9c66@linaro.org>
Date:   Thu, 3 Nov 2022 08:36:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
 <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
 <9f2a50db-0cfe-b9ce-11f4-be406cb9888e@linaro.org>
 <CY4PR1201MB01353B0CE46F22DFF55DFFAB8B389@CY4PR1201MB0135.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CY4PR1201MB01353B0CE46F22DFF55DFFAB8B389@CY4PR1201MB0135.namprd12.prod.outlook.com>
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

On 03/11/2022 04:59, Havalige, Thippeswamy wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, November 2, 2022 8:53 PM
>> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
>> pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Cc: bhelgaas@google.com; michals@xilinx.com; robh+dt@kernel.org;
>> Yeleswarapu, Nagaradhesh <nagaradhesh.yeleswarapu@amd.com>;
>> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
>> Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
>> schemas of Xilinx NWL PCIe Root Port Bridge
>>
>> On 01/11/2022 01:20, Thippeswamy Havalige wrote:
>>> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge dt
>>> binding.
>>>
>>> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>>> ---
>>>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ----------
>>>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 137 ++++++++++++++++++
>>>  2 files changed, 137 insertions(+), 73 deletions(-)  delete mode
>>> 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>>>  create mode 100644
>>> Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>>> b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>>> deleted file mode 100644
>>> index f56f8c58c5d9..000000000000
>>> --- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>>> +++ /dev/null
>>> @@ -1,73 +0,0 @@
>>> -* Xilinx NWL PCIe Root Port Bridge DT description
>>> -
>>> -Required properties:
>>> -- compatible: Should contain "xlnx,nwl-pcie-2.11"
>>> -- #address-cells: Address representation for root ports, set to <3>
>>> -- #size-cells: Size representation for root ports, set to <2>
>>> -- #interrupt-cells: specifies the number of cells needed to encode an
>>> -	interrupt source. The value must be 1.
>>> -- reg: Should contain Bridge, PCIe Controller registers location,
>>> -	configuration space, and length
>>> -- reg-names: Must include the following entries:
>>> -	"breg": bridge registers
>>> -	"pcireg": PCIe controller registers
>>> -	"cfg": configuration space region
>>> -- device_type: must be "pci"
>>> -- interrupts: Should contain NWL PCIe interrupt
>>> -- interrupt-names: Must include the following entries:
>>> -	"msi1, msi0": interrupt asserted when an MSI is received
>>> -	"intx": interrupt asserted when a legacy interrupt is received
>>> -	"misc": interrupt asserted when miscellaneous interrupt is received
>>> -- interrupt-map-mask and interrupt-map: standard PCI properties to
>> define the
>>> -	mapping of the PCI interface to interrupt numbers.
>>> -- ranges: ranges for the PCI memory regions (I/O space region is not
>>> -	supported by hardware)
>>> -	Please refer to the standard PCI bus binding document for a more
>>> -	detailed explanation
>>> -- msi-controller: indicates that this is MSI controller node
>>> -- msi-parent:  MSI parent of the root complex itself
>>> -- legacy-interrupt-controller: Interrupt controller device node for Legacy
>>> -	interrupts
>>> -	- interrupt-controller: identifies the node as an interrupt controller
>>> -	- #interrupt-cells: should be set to 1
>>> -	- #address-cells: specifies the number of cells needed to encode an
>>> -		address. The value must be 0.
>>> -
>>> -Optional properties:
>>> -- dma-coherent: present if DMA operations are coherent
>>> -- clocks: Input clock specifier. Refer to common clock bindings
>>> -
>>> -Example:
>>> -++++++++
>>> -
>>> -nwl_pcie: pcie@fd0e0000 {
>>> -	#address-cells = <3>;
>>> -	#size-cells = <2>;
>>> -	compatible = "xlnx,nwl-pcie-2.11";
>>> -	#interrupt-cells = <1>;
>>> -	msi-controller;
>>> -	device_type = "pci";
>>> -	interrupt-parent = <&gic>;
>>> -	interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
>>> -	interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
>>> -	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>>> -	interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
>>> -			<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
>>> -			<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
>>> -			<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
>>> -
>>> -	msi-parent = <&nwl_pcie>;
>>> -	reg = <0x0 0xfd0e0000 0x0 0x1000>,
>>> -	      <0x0 0xfd480000 0x0 0x1000>,
>>> -	      <0x80 0x00000000 0x0 0x1000000>;
>>> -	reg-names = "breg", "pcireg", "cfg";
>>> -	ranges = <0x02000000 0x00000000 0xe0000000 0x00000000
>> 0xe0000000 0x00000000 0x10000000  /* non-prefetchable memory */
>>> -		  0x43000000 0x00000006 0x00000000 0x00000006
>> 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
>>> -
>>> -	pcie_intc: legacy-interrupt-controller {
>>> -		interrupt-controller;
>>> -		#address-cells = <0>;
>>> -		#interrupt-cells = <1>;
>>> -	};
>>> -
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>>> b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..f6634be618a2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>>> @@ -0,0 +1,137 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/xlnx,nwl-pcie.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx NWL PCIe Root Port Bridge
>>> +
>>> +maintainers:
>>> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: xlnx,nwl-pcie-2.11
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: PCIe bridge registers location.
>>> +      - description: PCIe Controller registers location.
>>> +      - description: PCIe Configuration space region.
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: breg
>>
>> const: bridge
>>
>>> +      - const: pcireg
>>
>> const: pci
> 
> These reg-names are used in driver and existing customers are using these reg-names. 
> Please let me know why reg-names need to be changed ?

You're right, I missed that this is a conversion... It's fine.

>  
>>> +      - const: cfg
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: msi0 interrupt asserted when an MSI is received
>>> +      - description: msi1 interrupt asserted when an MSI is received
>>> +      - description: interrupt asserted when a legacy interrupt is received
>>> +      - description: unused interrupt(dummy)
>>> +      - description: interrupt asserted when miscellaneous interrupt
>>> + is received
>>> +
>>> +  interrupt-names:
>>> +    maxItems: 5
>>
>> I didn't notice last time - what are the names? They need to be defined.


Best regards,
Krzysztof

