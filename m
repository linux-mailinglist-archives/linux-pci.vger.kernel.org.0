Return-Path: <linux-pci+bounces-2274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EAA830472
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1B1C2169E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913511DDCD;
	Wed, 17 Jan 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C04WzTBG"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EC1DA50;
	Wed, 17 Jan 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490570; cv=none; b=ejNAbeXAF1Oov7HkhHoxpZszVGokBY4FYYr3GWe5+kH+GeQ2OhIv5UxenUgpWK3Lvpxue+26JaRebmHGFfI5dzbKzmj6O1XHNJuPvde20gCDMe+ClB05jsR9SzKHDEuoFB8MZEG3SJvK7r6HSqhS6nSJtWs0RBvT4iZbAF3NjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490570; c=relaxed/simple;
	bh=4fetrFSdasXeEVrXdaQv8kjKAkcb99RQ2PjhuR6Z4+0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=VxCapnUmb25f4X2qcE9E1C8a/Isaqr9uppToC37+sWW3FPU9SPUKltDpdDaLOz7Nbyf3FdRX6u5ddpx3akHIIu5gxfXDBbT+a4PB8cpGZtV1MNG4E9vlJUzWx3DlDA8+QuHoYUqlzwdCITkmnCFWfnyieap+L7n1U0fyTuD8Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C04WzTBG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HBMceB104318;
	Wed, 17 Jan 2024 05:22:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705490558;
	bh=y/VRMBpiqpBxekLBaciOj9zTMljaaG0DOCVnXi1xyCg=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=C04WzTBG5YhpcLoJod5ShSjVgCLF9UbjBKW9Z2hdwt5JgJfRRpq1U3cCp94+yBBVI
	 tfeJK4crBkUD8zNiaFQHIQLT4rT0g+MikHG+NjQLSP2/FAPXxlABrBT21wQ5LXPL5H
	 CxwEa20lGkP6ZhEfO1KRUuX0UueO7v9WOlxSSHNY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HBMcKF003836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 05:22:38 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 05:22:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 05:22:38 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HBMX5h115076;
	Wed, 17 Jan 2024 05:22:34 -0600
Message-ID: <b8fb2e37-17c5-4af5-8e5d-b65a70c37734@ti.com>
Date: Wed, 17 Jan 2024 16:52:32 +0530
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
Subject: Re: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-*: Add checks for
 max-link-speed
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-3-s-vadapalli@ti.com>
 <4282b248-cb7f-4486-bde6-105a3aed6be2@linaro.org>
 <92ceb1ea-78db-4bc4-af1f-a1690eaca24c@ti.com>
 <42f44ecc-c7f4-4209-8cb5-805891c35413@linaro.org>
 <e79a1896-470e-4fba-85b0-f857a4290cbb@ti.com>
 <d8fba488-bdea-420b-84f2-a222315e1b81@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <d8fba488-bdea-420b-84f2-a222315e1b81@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 16:49, Krzysztof Kozlowski wrote:
> On 17/01/2024 12:15, Siddharth Vadapalli wrote:
>>
>>
>> On 17/01/24 16:30, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 11:58, Siddharth Vadapalli wrote:
>>>> On 17/01/24 16:05, Krzysztof Kozlowski wrote:
>>>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>>>> Extend the existing compatible based checks for validating and enforcing
>>>>>> the "max-link-speed" property.
>>>>>
>>>>> Based on what? Driver or hardware? Your entire change suggests you
>>>>
>>>> Hardware. The PCIe controller on AM64 SoC supports up to Gen2 link speed while
>>>> the PCIe controllers on other SoCs support Gen3 link speed.
>>>>
>>>>> should just drop it from the binding, because this can be deduced from
>>>>> compatible.
>>>>
>>>> Could you please clarify? Isn't the addition of the checks for "max-link-speed"
>>>> identical to the checks which were added for "num-lanes", both of which are
>>>> Hardware specific?
>>>
>>> Compatible defines these values, at least what it looks like from the patch.
>>
>> In this patch, I have added checks for the "max-link-speed" property in the same
>> section that "num-lanes" is being evaluated. 
> 
> I know what you did in patch. I read it.
> 
>> The values for "max-link-speed" are
>> based on the Hardware support and this patch is validating the "max-link-speed"
>> property in the device-tree nodes for the devices against the Hardware supported
>> values which this patch is adding in the corresponding section. Kindly let me
>> know if I misunderstood what you meant to convey.
> 
> Nothing of this is relevant.
> 
> I used two entirely different wordings for this and you still don't get
> it, so I don't know if I have third one.
> 
> Maybe this:
> Move it to driver match data.

Ok. I will drop the checks for "max-link-speed" and move them to the driver. But
I wonder why the checks for "num-lanes" are needed in the first place when they
could be in the driver as well.

> 
> So three entirely different wordings for the same. I don't have fourth...
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Siddharth.

