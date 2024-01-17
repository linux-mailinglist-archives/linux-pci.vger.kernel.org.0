Return-Path: <linux-pci+bounces-2278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A030C8304AA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6FE289026
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6801DFC7;
	Wed, 17 Jan 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b5vf9in9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEC1DDE9;
	Wed, 17 Jan 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491696; cv=none; b=GFNTI8RQC4qjHlVNf1cgxj3wg4PnRV/fZBfim8Y/2EvVwXDcR2+Eoin5SUwabgd410TExgkZroC8pkE9PE8JipntTqjF1rxg9gFsITFdzlgjLlbPGx0ErTwIK3zG4HQjVx+AptiR11ct8ikDGHPq8KJp+bZpwPhd46CSREmQLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491696; c=relaxed/simple;
	bh=CLZU5rgT2UFPrdbWUWo8qe1nxndlAx/KoEsCF7HwcZM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=nX06llOel64pqukDyhtP3eBsUbOwK8SSYT2awq1OHIwir/QElrzlj01as6frVxcNpPFIPqszKkbFGapgy4RhpL4bUalLteA2YPfJyAoyOaz/8AhsnImMECY15apz/Q6ZE0F0uJD48uT0mzj4t9qDK8MGiG7yRzkLYy2xeh6OysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b5vf9in9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HBfMl9110899;
	Wed, 17 Jan 2024 05:41:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705491682;
	bh=nKBZZkUtb2ZgBspyTSuabJzlE9paUH9JoSo5Pe+Frb0=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=b5vf9in90phnLmHICN8986V0EGwQSdpDD4P9jHl/reS1nvELz+D1VbDE7z5JRL6Bg
	 2WDJuk3M3hKvuTkj2JVYm6Pm+TOUnAhf72LnTpWctt5C4Y4vw8Xu9imYmZnvBNSz5M
	 3j71ZxlOrumwvkSfV9ilkdnUyncdA74epSA5Do50=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HBfM6G020916
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 05:41:22 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 05:41:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 05:41:21 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HBfH8q006472;
	Wed, 17 Jan 2024 05:41:17 -0600
Message-ID: <a3548cfc-ca20-4f55-990c-097cc68e9750@ti.com>
Date: Wed, 17 Jan 2024 17:11:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-4-s-vadapalli@ti.com>
 <c2c7c1fb-af71-4a5d-9e35-13f6066a2ed6@linaro.org>
 <a34eb14b-9944-476a-8b86-e8bb77bcad82@ti.com>
 <6119a057-0ed9-46f0-9232-3839d7d4b2e6@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <6119a057-0ed9-46f0-9232-3839d7d4b2e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 17:05, Krzysztof Kozlowski wrote:
> On 17/01/2024 12:24, Siddharth Vadapalli wrote:
>>
>>
>> On 17/01/24 16:06, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>> TI's J722S SoC has one instance of a Gen3 Single Lane PCIe controller.
>>>> The controller on J722S SoC is similar to the one present on TI's AM64
>>>> SoC, with the difference being that the controller on AM64 SoC supports
>>>> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>>>>
>>>> Update the bindings with a new compatible for J722S SoC and enforce checks
>>>> for "num-lanes" and "max-link-speed".
>>>>
>>>> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>>> index 005546dc8bd4..b7648f7e73c9 100644
>>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>>> @@ -14,6 +14,7 @@ properties:
>>>>    compatible:
>>>>      oneOf:
>>>>        - const: ti,j721e-pcie-host
>>>> +      - const: ti,j722s-pcie-host
>>>>        - const: ti,j784s4-pcie-host
>>>>        - description: PCIe controller in AM64
>>>>          items:
>>>> @@ -134,6 +135,18 @@ allOf:
>>>>            minimum: 1
>>>>            maximum: 4
>>>>  
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          items:
>>>
>>> enum
>>>
>>>> +            - const: ti,j722s-pcie-host
>>>> +    then:
>>>> +      properties:
>>>> +        max-link-speed:
>>>> +          const: 3
>>>> +        num-lanes:
>>>> +          const: 1
>>>
>>> Similarly to previous patch: What is the point of all this? You have
>>> direct mapping compatible-property, so encode these in the drivers.
>>
>> Ok. I will drop patches 1 and 2 of this series and only post v2 of this patch
>> for adding a new compatible for J722S SoC without any checks for
>> "max-link-speed" or "num-lanes" for the new compatible.
> 
> Without driver change? So how does it solve my comment. I want to move
> all these unnecessary properties to the driver.

Driver support for verifying "num-lanes" is already present. I meant to say that
I will drop the checks in bindings in the v2 patch since "num-lanes" is verified
in driver too. However, "max-link-speed" is not verified either in the driver or
in the bindings prior to this series.

-- 
Regards,
Siddharth.

