Return-Path: <linux-pci+bounces-2271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BA830459
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87371287AB9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3B1D555;
	Wed, 17 Jan 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJG9/SSh"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0271B814;
	Wed, 17 Jan 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490176; cv=none; b=DWZYJPv1HQFSkRZaYDJNgTeyaiGFbPAGmoziSzfjK8XhEe37aQAP0OfH6/n8IpiLb6O41CsfADI/FzgD1CArUQE2OSfgQlfkdnpoiCW9qeCXifqMdHf8/KYKcO6cRV5ibMEK+A5O7kDnjIkp8d9n298WH3yv23yHlUstMoEJY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490176; c=relaxed/simple;
	bh=fnSmosHPC+x/JiwxXYkr5lrP52Jf6CQr3IcKZJn6slY=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=OEUsdCCIgOX3V9nuXgNkGBHdlQ5HWUEYrqLmMpiq0cd7EFFcn8BLDlC9azxVjMughVzWdpaXkk35vwXE+FN9x3waJON3jhSc/PXEtUF3uBlkFiQd77CyE3yj3GxDaMex5th7R1vp+pow065LmqNiGsxZD0RgSQmO+p3Klj0gxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJG9/SSh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HBFuc8046011;
	Wed, 17 Jan 2024 05:15:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705490156;
	bh=oNbdAGa1Ex4tt8z5/1N6Da7Zj6VObjuv7HWDiH8tqo8=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=AJG9/SShq+H50qmdX8ser0mPVUOyjwud1qkGbrF4S6cF4wNah9v63jDCyCCsSLtVC
	 uSTc29xblaEaUWrqHbYu7OdNKXB+DO5UJ4s5aEVuTPmMvFuI3KD6TI1+HhgxpZa9QD
	 c4fxGEUsLAzEdLpjXmHytX6DkqHhHmJhFuFBuHSI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HBFulM071669
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 05:15:56 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 05:15:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 05:15:55 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HBFpTR107080;
	Wed, 17 Jan 2024 05:15:52 -0600
Message-ID: <e79a1896-470e-4fba-85b0-f857a4290cbb@ti.com>
Date: Wed, 17 Jan 2024 16:45:50 +0530
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
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <42f44ecc-c7f4-4209-8cb5-805891c35413@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 16:30, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:58, Siddharth Vadapalli wrote:
>> On 17/01/24 16:05, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>> Extend the existing compatible based checks for validating and enforcing
>>>> the "max-link-speed" property.
>>>
>>> Based on what? Driver or hardware? Your entire change suggests you
>>
>> Hardware. The PCIe controller on AM64 SoC supports up to Gen2 link speed while
>> the PCIe controllers on other SoCs support Gen3 link speed.
>>
>>> should just drop it from the binding, because this can be deduced from
>>> compatible.
>>
>> Could you please clarify? Isn't the addition of the checks for "max-link-speed"
>> identical to the checks which were added for "num-lanes", both of which are
>> Hardware specific?
> 
> Compatible defines these values, at least what it looks like from the patch.

In this patch, I have added checks for the "max-link-speed" property in the same
section that "num-lanes" is being evaluated. The values for "max-link-speed" are
based on the Hardware support and this patch is validating the "max-link-speed"
property in the device-tree nodes for the devices against the Hardware supported
values which this patch is adding in the corresponding section. Kindly let me
know if I misunderstood what you meant to convey.

-- 
Regards,
Siddharth.

