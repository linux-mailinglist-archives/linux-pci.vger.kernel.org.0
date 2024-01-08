Return-Path: <linux-pci+bounces-1802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0419826CE6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020D31C20BA2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5014A93;
	Mon,  8 Jan 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c01Cec7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655129412;
	Mon,  8 Jan 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408BYJqA061459;
	Mon, 8 Jan 2024 05:34:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704713659;
	bh=6ybS2qS69K54f2tDvHXfkSmY2DjqqOxTa+HLeypQHJQ=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=c01Cec7it89xzE/bLC69pzucAOv1+iGa1pKsrNQKh4akhLHoM05X/1PS4S4VbwNXz
	 VxJdnCOndTny4ujBvAsefa0biv/aVIYT9GcPaTCssn3W0ws+XXhhBfomXWMOpvdKbQ
	 y54NSgP3jh3hfGnnGAkH04ynj75FiPt3Uug7nizc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408BYJMQ091423
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 05:34:19 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 05:34:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 05:34:18 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408BYE4R062021;
	Mon, 8 Jan 2024 05:34:15 -0600
Message-ID: <e4bd76d1-e5d9-4ff6-8917-db5784dea847@ti.com>
Date: Mon, 8 Jan 2024 17:04:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [RFC PATCH] dt-bindings: PCI: ti,j721e-pci-host: Add device-id
 for TI's J784S4 SoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
References: <20240108050735.512445-1-s-vadapalli@ti.com>
 <67af1724-6424-456a-aff6-85d9e010c430@linaro.org>
 <bc3a0fb0-6268-476a-a13a-2d538704f61d@ti.com>
 <7d3439c2-35e3-4318-aa99-af9b7c8ed53b@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <7d3439c2-35e3-4318-aa99-af9b7c8ed53b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 08/01/24 16:51, Krzysztof Kozlowski wrote:
> On 08/01/2024 11:20, Siddharth Vadapalli wrote:
>> Hello Krzysztof,
>>
>> On 08/01/24 12:39, Krzysztof Kozlowski wrote:
>>> On 08/01/2024 06:07, Siddharth Vadapalli wrote:
>>>> Add the device-id of 0xb012 for the PCIe controller on the J784S4 SoC as
>>>> described in the CTRL_MMR_PCI_DEVICE_ID register's PCI_DEVICE_ID_DEVICE_ID
>>>> field. The Register descriptions and the Technical Reference Manual for
>>>> J784S4 SoC can be found at: https://www.ti.com/lit/zip/spruj52
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>
>>>> This patch is based on linux-next tagged next-20240105.
>>>
>>> Why is this patch incomplete? What is missing here? What are you asking
>>> about as RFC?
>>
>> Since the merge window is closed, I was hoping to get the patch reviewed in
>> order to get any "Reviewed-by" tags if possible. That way, I will be able to
>> post it again as v1 along with the tags when the merge window opens. For that
> 
> This is v1, so that would be v2.
> 
>> reason, I have marked it as an RFC patch. Is there an alternative to this "RFC
>> patch" method that I have followed? Please let me know.
> 
> Then how does it differ from posting without RFC? Sorry, RFC is
> incomplete work. Often ignored during review.

I was under the impression that posting patches when the merge window is closed
will be met with a "post your patch later when the merge window is open"
response. That is why I chose the "RFC patch" path since RFCs can be posted anytime.

For the Networking Subsystem, it is documented that patches with new features
shouldn't be posted when the merge window is closed. I have mostly posted
patches for the Networking Subsystem and am not sure about the rules for the
device-tree bindings and PCI Subsystems. To be on the safe side I posted this
patch as an RFC patch.

Thank you for clarifying that it is alright to post patches even when merge
window is closed. Going forward I shall not post RFC patches unless it really
requires feedback and suggestions.

-- 
Regards,
Siddharth.

