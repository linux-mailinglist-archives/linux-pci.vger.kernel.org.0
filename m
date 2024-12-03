Return-Path: <linux-pci+bounces-17583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B89E286D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 17:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CD52827E2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB731F8F04;
	Tue,  3 Dec 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hp1Q6c8f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A371304BA;
	Tue,  3 Dec 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245192; cv=none; b=uWIzQwZ05WSH6ZY4eQvAqAZLUgVXb44OatHgH5g4i5LgTGKwfhl8BIrbKIEIzz7sgoEHFIk93m6wScPjAgslUT5rV9bevhrQ3XNB8G/8toIDwTAiY7i1sjqCEtYH/nSllDOv1u53itfDaMXw9Jyw45rMUFDJmUGNUtiRus+qgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245192; c=relaxed/simple;
	bh=CFTh4QAkWsM3pft0UqsdKCu1M/fd9Se6lNKhC5MvqGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PkE+WtqvLHrHHyc3Qjuu+JExvM7I2d9ySy3izmrEgPfbypnHPPNRHWszqCQ8uVPmtX2t6Dd0/WTjiqqZQNrbR6c71wZiDtdAMQLEWTyYQihYEfuuPZfoFL8wHk1JDv7HUe1959/onMv1Huck9wOs3wVTQIHZNk1K+O8Wv+HFd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hp1Q6c8f; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3C8lFK020831;
	Tue, 3 Dec 2024 17:59:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	q/Xhc9aYsCrB35OHKPGNT6A2apruI007LpsUF64OvsA=; b=hp1Q6c8fchh0K+FE
	4VRHW9jkgg76o9u0YLe9Q0bJwSuAPbdsWEFBTT8wSwNKb37Surw35LbIi+bu6TZ+
	grPKoQ8iImnUHBv+SftlMki5t8j8j7ZhUPafW8QWV2a5PW8CONXFAp9i/3YHsm5M
	TCfoENMHDPY2L3NAL+arifGyV/RIzZwpFZw9g5GU//n9xKQtAoChCyiDfe397htR
	lhlY2pM1VCOuo4tOUTiiw9vGqWmI56MhU0E87mBobWw5dMqFBFkUe1S6SaUrP5hu
	K5YhIBtNSpS90D2X8nCpJovuoLMDujg1PlKJCxJihvvuH0hGWTLkqL5BpTEdnBEF
	fZy0EQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 438d54bsfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 17:59:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CD3EC4008D;
	Tue,  3 Dec 2024 17:57:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8F84270D6D;
	Tue,  3 Dec 2024 17:55:35 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 17:55:34 +0100
Message-ID: <4a56d133-0173-4ad5-8d36-70d538c88ba7@foss.st.com>
Date: Tue, 3 Dec 2024 17:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-2-christian.bruel@foss.st.com>
 <20241203133434.2qbohwi3wrjjja5a@thinkpad>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241203133434.2qbohwi3wrjjja5a@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 12/3/24 14:34, Manivannan Sadhasivam wrote:
> On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
>> Document the bindings for STM32MP25 PCIe Controller configured in
>> root complex mode.
>>
>> Supports 4 legacy interrupts and MSI interrupts from the ARM
>> GICv2m controller.
>>
>> STM32 PCIe may be in a power domain which is the case for the STM32MP25
>> based boards.
>>
>> Supports wake# from wake-gpios
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   .../bindings/pci/st,stm32-pcie-common.yaml    | 45 +++++++++
>>   .../bindings/pci/st,stm32-pcie-host.yaml      | 99 +++++++++++++++++++
>>   2 files changed, 144 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>> new file mode 100644
>> index 000000000000..479c03134da3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32MP25 PCIe RC/EP controller
>> +
>> +maintainers:
>> +  - Christian Bruel <christian.bruel@foss.st.com>
>> +
>> +description:
>> +  STM32MP25 PCIe RC/EP common properties
>> +
>> +properties:
>> +  clocks:
>> +    maxItems: 1
>> +    description: PCIe system clock
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: pcie-phy
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: GPIO controlled connection to PERST# signal
>> +    maxItems: 1
>> +
>> +required:
>> +  - clocks
>> +  - resets
>> +  - phys
>> +  - phy-names
>> +
>> +additionalProperties: true
>> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..18083cc69024
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>> @@ -0,0 +1,99 @@
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
>> +allOf:
>> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
>> +  - $ref: /schemas/pci/st,stm32-pcie-common.yaml#
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      const: st,stm32mp25-pcie-rc
>> +  required:
>> +    - compatible
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
>> +  num-lanes:
>> +    const: 1
>> +
>> +  msi-parent:
>> +    maxItems: 1
>> +
>> +  wake-gpios:
>> +    description: GPIO controlled connection to WAKE# input signal
>> +    maxItems: 1
>> +
>> +  wakeup-source: true
>> +
>> +dependentRequired:
>> +  wakeup-source: [ wake-gpios ]
>> +
>> +required:
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - ranges
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
> 
> PCI address of I/O region should start from address 0x00000000.
> 
ok, thanks !

> Also use hex notation for all values.
> 
> - Mani
> 

