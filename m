Return-Path: <linux-pci+bounces-2275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAD830479
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90931C2117A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC81DDD3;
	Wed, 17 Jan 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oomhJT+q"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961721DA53;
	Wed, 17 Jan 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490712; cv=none; b=KvOLWi9LhJPmlAsT1ZF7hoaXoQx4ASu7y/wnmdaf50m6yUlX/EA+2x7VV0cCTIsspWzGpvq2zvVWZe+7G/LTeLs9anWWVRfSnBRevi9cNQv6E4c6v9njAR6CkcGsOYblYA0ojEW+Axix4skbzonTLK3RrMNZK92F7LYE+zUSy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490712; c=relaxed/simple;
	bh=Mm6cJf3yCBnqK/5Q4ll7WgOxkcjCl5CCetmlrYsOS+s=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=g/LIniVjzB9QPF7oVHmrqeVhqPD2rtEOIULBQZcd2VFAh+jufJ8t28Qez8SZyqhq9RoxFswXcAKqiHqWHoPlJEF9sq4E8hEGN9D48yKL80xtCYlemFcEDeFaikAiJDS6A2SoTZ9gyK+cM6rOGx22l+p4/AAccz7MNsYFn4lhBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oomhJT+q; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HBOxM7047672;
	Wed, 17 Jan 2024 05:24:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705490699;
	bh=PHwouQHxPlx83jFBHQHsF+LebyCBIZR/95liko83I7A=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=oomhJT+qj0bKd0ZcrjTox3LftxPYql2b6SiJIghYb7rSMuORoQmFxH8cJzCbScu5S
	 GNfjh6BLqA1Jlg53eLytguHNqQtGrRCZ6Fi4VaiXYCs2KSMW1Ks8HCjDHDJxinCaxD
	 dK3lA4+0idxbUIVfWWiViHQ48PfZ1fp7QhsWSDSs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HBOx24088260
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 05:24:59 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 05:24:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 05:24:59 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HBOoQV117451;
	Wed, 17 Jan 2024 05:24:50 -0600
Message-ID: <a34eb14b-9944-476a-8b86-e8bb77bcad82@ti.com>
Date: Wed, 17 Jan 2024 16:54:49 +0530
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
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <c2c7c1fb-af71-4a5d-9e35-13f6066a2ed6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 16:06, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>> TI's J722S SoC has one instance of a Gen3 Single Lane PCIe controller.
>> The controller on J722S SoC is similar to the one present on TI's AM64
>> SoC, with the difference being that the controller on AM64 SoC supports
>> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>>
>> Update the bindings with a new compatible for J722S SoC and enforce checks
>> for "num-lanes" and "max-link-speed".
>>
>> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> index 005546dc8bd4..b7648f7e73c9 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -14,6 +14,7 @@ properties:
>>    compatible:
>>      oneOf:
>>        - const: ti,j721e-pcie-host
>> +      - const: ti,j722s-pcie-host
>>        - const: ti,j784s4-pcie-host
>>        - description: PCIe controller in AM64
>>          items:
>> @@ -134,6 +135,18 @@ allOf:
>>            minimum: 1
>>            maximum: 4
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          items:
> 
> enum
> 
>> +            - const: ti,j722s-pcie-host
>> +    then:
>> +      properties:
>> +        max-link-speed:
>> +          const: 3
>> +        num-lanes:
>> +          const: 1
> 
> Similarly to previous patch: What is the point of all this? You have
> direct mapping compatible-property, so encode these in the drivers.

Ok. I will drop patches 1 and 2 of this series and only post v2 of this patch
for adding a new compatible for J722S SoC without any checks for
"max-link-speed" or "num-lanes" for the new compatible.

-- 
Regards,
Siddharth.

