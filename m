Return-Path: <linux-pci+bounces-3379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D185289D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632911F23FD1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67912E40;
	Tue, 13 Feb 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dtrye5rG"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51B1428E;
	Tue, 13 Feb 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804813; cv=none; b=kq9ahtP/QVZT34/4j9pjAUJ/TRYSc4oFX7s85dD+/z2hbmI0JiSqojXxMeJYT7SnE7/1Cz2P1sG4gY3BBkxoA+QS4CcUyXEN6si20KYe5W06A79LqhFfAehHqwEBphpRVPc+Ek5JcWoFG7hVSp2K9+cvNDF1m1h9d91IpWXo0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804813; c=relaxed/simple;
	bh=+OluaC2nfCC3QuXSPU0HcOwT7ap3mPRpLCz86/Gs6DA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpM1Bcn5RlEnIhubDnSXUfiPHcdLyTL3hypTLU9Nde4z93jayy+n8y57zht1PtdetIRnsV+1j838Qjxi4biewGUy2Lcm0xGRCUdPwCectsp4a5k9Ca26ceW2kjOlFG3NWklM4WOkJoPIBYkLVzGpNa8B/2PhrJ49dD+ZuaIgMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dtrye5rG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D6DMbg023971;
	Tue, 13 Feb 2024 00:13:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707804802;
	bh=Rv/j7HNyUc7U+67Hp/SX9I0XSishaJ1nAKVKGyANHvI=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=Dtrye5rGo1nQPIp3HoTylynJzEGI+L3lO8Gfjyt213nQferSwJjmsg1CfsE6vhSyM
	 H/kxPTGg8VRKQQcbcAUjP672UCUcUkRmz/DzCAX9p9tAmEf7qrnHxmWtupHyOFEYgP
	 dPOLz2162GUNkB/KKLvYnetC3kJ7Kj4kunTzP6Ic=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D6DMSe013493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 00:13:22 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 00:13:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 00:13:21 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D6DHkN050952;
	Tue, 13 Feb 2024 00:13:18 -0600
Message-ID: <619dd947-a3da-49ee-9bee-8b21c7e7ca1a@ti.com>
Date: Tue, 13 Feb 2024 11:43:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, Conor Dooley <conor@kernel.org>
References: <20240124122936.816142-1-s-vadapalli@ti.com>
 <20240124-unmatched-plating-019a3055cf5e@spud>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240124-unmatched-plating-019a3055cf5e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 24/01/24 21:40, Conor Dooley wrote:
> On Wed, Jan 24, 2024 at 05:59:36PM +0530, Siddharth Vadapalli wrote:
>> TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
>> The controller on J722S SoC is similar to the one present on TI's AM64
>> SoC, with the difference being that the controller on AM64 SoC supports
>> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>>
>> Update the bindings with a new compatible for J722S SoC.
>>
>> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Bjorn, Rob,

Could you please merge this patch? This patch applies cleanly on the latest
linux-next tagged next-20240213.

> 
> Cheers,
> Conor.
> 
>> ---
>>
>> Hello,
>>
>> This patch is based on linux-next tagged next-20240124.
>>
>> v2:
>> https://lore.kernel.org/r/20240122064457.664542-1-s-vadapalli@ti.com/
>> Changes since v2:
>> - Added fallback compatible for "ti,j722s-pcie-host" as
>>   "ti,j721e-pcie-host" based on Conor's suggestion at:
>>   https://lore.kernel.org/r/20240122-getting-drippy-bb22a0634092@spud/#t
>>
>> v1:
>> https://lore.kernel.org/r/20240117102526.557006-1-s-vadapalli@ti.com/
>> Changes since v1:
>> - Dropped patches 1/3 and 2/3 of the v1 series as discussed in the v1
>>   thread.
>> - Updated patch 3/3 which is the v1 for this patch by dropping the checks
>>   for the "num-lanes" property and "max-link-speed" property since the PCI
>>   driver already validates the "num-lanes" property.
>>
>> Regards,
>> Siddharth.
>>
>>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> index b7a534cef24d..ac69deeaf1ee 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -23,6 +23,10 @@ properties:
>>          items:
>>            - const: ti,j7200-pcie-host
>>            - const: ti,j721e-pcie-host
>> +      - description: PCIe controller in J722S
>> +        items:
>> +          - const: ti,j722s-pcie-host
>> +          - const: ti,j721e-pcie-host
>>  
>>    reg:
>>      maxItems: 4
>> -- 
>> 2.34.1
>>

-- 
Regards,
Siddharth.

