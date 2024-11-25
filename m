Return-Path: <linux-pci+bounces-17283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB129D8949
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C629281574
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33891B3920;
	Mon, 25 Nov 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Dy9MnAF4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56F199FD0;
	Mon, 25 Nov 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548419; cv=none; b=mV7aKAH3R95JvLlyDq5D3wKgYDmalRwLRZPaSRCvqqjykUSpnrTpGVvj3gxJNj94wn98Cje66JB18o5E80QF/Y2+9/vgdEa3EukwC0Jf50x3tUYfiL0Vb79P81IJlVXevNvG5e0eKrxfQoOXLWiWVAlcjUFkM5darAr8EwxpNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548419; c=relaxed/simple;
	bh=oTFi8I23DaO8+WXyQ9nQwK41e2f6j/VbN37hCDTad7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=An6CtgOCLckHrYoup5I+NgWiWrZHPhnNcFAbPbydERsFtIcgXunuYQ2d+tSCgLEwAPGxpCVOqxDRkvHqQZ3Svwu7U0B2vCPgGDxvC9vttevhDz6xGcOIqkBpQA3iGtpVHOrrrT5Nim0MVto/j4Y9RXDGAkYU7S0S8ZPYY2wEUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Dy9MnAF4; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBlfgd028895;
	Mon, 25 Nov 2024 16:26:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	J3iU4957LIS/H10yjQyEKVHjKHXAXZQsDhA8RML+rwE=; b=Dy9MnAF4bXAHtXxw
	MHgwNFWZKTyu3ZLMY7dAq6jeFyj0NJxrGzKuvHMK/L8g/jPKwJIoefaf3HV8BUPV
	2GepDWrgQpTotVIWaKEpEAiHbhGNvll4vJx2YVY3YcMcwGLwBptYu5DXc99U2w8L
	yErJJUS9mGwc/clGqMxEW3r0r4RUs5BLuHLkoyRhgo4CXITltOM90kOyN8caqh7U
	Kkn98GP1dwafDhmCDwYbnX/fOJHIjheHNWY5/1ZWuB4VWH+AX4reqdDnFNKoDI7F
	7foAXFNmm9/EMd8Wy59GJQkB5403jr4SAwOUtLRaD6w2U9YFLF5lcNnpohT8oUSK
	KWFB8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4336tfg57c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:26:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 713F240045;
	Mon, 25 Nov 2024 16:24:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A23B62A1036;
	Mon, 25 Nov 2024 16:23:47 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 25 Nov
 2024 16:23:46 +0100
Message-ID: <a4908b60-9b81-4d87-942e-d581946bcc82@foss.st.com>
Date: Mon, 25 Nov 2024 16:23:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
To: Rob Herring <robh@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241112161925.999196-1-christian.bruel@foss.st.com>
 <20241112161925.999196-2-christian.bruel@foss.st.com>
 <20241115163603.GA3188739-robh@kernel.org>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241115163603.GA3188739-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 11/15/24 17:36, Rob Herring wrote:
> On Tue, Nov 12, 2024 at 05:19:21PM +0100, Christian Bruel wrote:
>> Document the bindings for STM32MP25 PCIe Controller configured in
>> root complex mode.
>> Supports 4 legacy interrupts and MSI interrupts from the ARM
>> GICv2m controller.
>>
>> Allow tuning to change payload (default 128B) thanks to the
>> st,max-payload-size entry.
>> Can also limit the Maximum Read Request Size on downstream devices to the
>> minimum possible value between 128B and 256B.
>>
>> STM32 PCIE may be in a power domain which is the case for the STM32MP25
>> based boards.
>> Supports wake# from wake-gpios
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   .../bindings/pci/st,stm32-pcie-host.yaml      | 149 ++++++++++++++++++
>>   1 file changed, 149 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..d7d360b63a08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>> @@ -0,0 +1,149 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32MP25 PCIe root complex driver
>> +
>> +maintainers:
>> +  - Christian Bruel <christian.bruel@foss.st.com>
>> +
>> +description:
>> +  PCIe root complex controller based on the Synopsys DesignWare PCIe core.
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      const: st,stm32mp25-pcie-rc
>> +  required:
>> +    - compatible
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> 
> snps,dw-pcie.yaml instead of these 2.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-pcie-rc
>> +
>> +  reg:
>> +    items:
>> +      - description: Data Bus Interface (DBI) registers.
>> +      - description: PCIe configuration registers.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: dbi
>> +      - const: config
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: core
> 
> -names with a single entry is kind of pointless.

ok, will update the driver accordinly

> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: PCIe system clock
>> +
>> +  clock-names:
>> +    const: core
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: pcie-phy
>> +
>> +  num-lanes:
>> +    const: 1
>> +
>> +  msi-parent:
>> +    maxItems: 1
> 
> Just 'msi-parent: true'. It's already only ever 1 entry.
> 
>> +
>> +  reset-gpios:
>> +    description: GPIO controlled connection to PERST# signal
>> +    maxItems: 1
>> +
>> +  wake-gpios:
>> +    description: GPIO controlled connection to WAKE# input signal
>> +    maxItems: 1
>> +
> 
>> +  st,limit-mrrs:
>> +    description: If present limit downstream MRRS to 256B
>> +    type: boolean
>> +
>> +  st,max-payload-size:
>> +    description: Maximum Payload size to use
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [128, 256]
>> +    default: 128
> 
> IIRC, other hosts have similar restrictions, so you should be able to do
> the same and imply it from the compatible. Though I'm open to a common
> property as Bjorn suggested.
> 
>> +
>> +  wakeup-source: true
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    maxItems: 1
>> +
>> +if:
>> +  required:
>> +    - wakeup-source
>> +then:
>> +  required:
>> +    - wake-gpios
> 
> This can be just:
> 
> dependentRequired:
>    wakeup-source: [ wake-gpios ]
> 
> (dependentRequired supercedes dependencies)
> 
>> +
>> +required:
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - ranges
>> +  - resets
>> +  - reset-names
>> +  - clocks
>> +  - clock-names
>> +  - phys
>> +  - phy-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/phy/phy.h>
>> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
>> +
>> +    pcie@48400000 {
>> +        compatible = "st,stm32mp25-pcie-rc";
>> +        device_type = "pci";
>> +        num-lanes = <1>;
>> +        reg = <0x48400000 0x400000>,
>> +              <0x10000000 0x10000>;
>> +        reg-names = "dbi", "config";
>> +        #interrupt-cells = <1>;
>> +        interrupt-map-mask = <0 0 0 7>;
>> +        interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        ranges = <0x01000000 0 0x10010000 0x10010000 0 0x10000>,
>> +                 <0x02000000 0 0x10020000 0x10020000 0 0x7fe0000>,
>> +                 <0x42000000 0 0x18000000 0x18000000 0 0x8000000>;
>> +        bus-range = <0x00 0xff>;
> 
> Don't need this unless it's restricted to less than bus 0-255.
> 
>> +        clocks = <&rcc CK_BUS_PCIE>;
>> +        clock-names = "core";
>> +        phys = <&combophy PHY_TYPE_PCIE>;
>> +        phy-names = "pcie-phy";
>> +        resets = <&rcc PCIE_R>;
>> +        reset-names = "core";
>> +        msi-parent = <&v2m0>;
>> +        wakeup-source;
>> +        wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> +        access-controllers = <&rifsc 76>;
>> +        power-domains = <&CLUSTER_PD>;
>> +    };
>> -- 
>> 2.34.1
>>

thanks


