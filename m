Return-Path: <linux-pci+bounces-2407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A6835AD3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 07:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C5F1C221B4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 06:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D815673;
	Mon, 22 Jan 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="otfN9K2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690D63A0
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904087; cv=none; b=bw0OgHEBQgE4dgbPQeFJTvkRI/8jrT+GEZDfv+4ExtH/x6Jpk74etLZgqhZrKZTZ8d6cWv5T70O6a8MRFF74UVgMdhFCPcTe5nOo8TqOCp4Fznu/7cnA4wPeb1NA9G0qs9xXnToJ/pgsi0C9jjTbIBNNfDYkrAAiyov3wytCO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904087; c=relaxed/simple;
	bh=IqFk0ZG+Ywe8d9lKcc11GMakHlu6AOCXT6tR+0OpWxY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KvCylPvVxPtRvwSG6UDOFBEcrJwR8mvkzLxOYeLBlV2VgrzvrqT3uU+6xk+2HeSgt5pazEW1BQ2JsxfQGdLRvoCSx213pBIBoNnV+dZxsKPyOsM3rCWkL86GNIeyCyJbFg07VxqVbncTOge0RdkQxSMcXkOVxbFN5dNXj39mdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=otfN9K2E; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M6Ds3P056965;
	Mon, 22 Jan 2024 00:13:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705904034;
	bh=aMRk3G/zudbpMm1J9wHh8HkzZmrJoEqNPMez3+2ReM0=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=otfN9K2Ef89mBE+UDlXbLXAJtjnrehwXyO1ZywSCPyGM2fGHeOO5W55cgMlCtWzAz
	 m1p86JV1b4T/A5C2AIqu4hXb7g4vFS3dCiJJ7bNEvW4h+BxyA2Twox62Nd+lwPR8oU
	 E6y9ZoCXdyODXJX0qT0gZXyhl5RKsjLEUMozUEyU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M6DsFw008279
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 00:13:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 00:13:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 00:13:52 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M6Dmaf083625;
	Mon, 22 Jan 2024 00:13:49 -0600
Message-ID: <5b7cd38c-7047-4528-ac6b-8d7a31a1f22f@ti.com>
Date: Mon, 22 Jan 2024 11:43:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
        <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <ylal@codeaurora.org>, <regressions@lists.linux.dev>,
        <jan.kiszka@siemens.com>, <s-vadapalli@ti.com>
Subject: Re: [REGRESSION] Keystone PCI driver probing and SerDes PLL timeout
Content-Language: en-US
To: Kishon Vijay Abraham I <kvijayab@amd.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240111141331.3715265-1-diogo.ivo@siemens.com>
 <2024011246-corned-disregard-7123@gregkh>
 <1cce86b1-b309-40e0-afff-45baeb013e1f@siemens.com>
 <88e450b5-5be0-2203-3474-45778503699d@amd.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <88e450b5-5be0-2203-3474-45778503699d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 22/01/24 11:22, Kishon Vijay Abraham I wrote:
> +Siddharth
> 
> Hi Diogo,
> 
> On 1/12/2024 5:16 PM, Diogo Ivo wrote:
>>
>> On 1/12/24 07:57, Greg KH wrote:
>>> On Thu, Jan 11, 2024 at 02:13:30PM +0000, Diogo Ivo wrote:
>>>> Hello,
>>>>
>>>> When testing the IOT2050 Advanced M.2 platform with Linux CIP 6.1
>>>> we came across a breakage in the probing of the Keystone PCI driver
>>>> (drivers/phy/ti/pci-keystone.c). This probing was working correctly
>>>> in the previous version we were using, v5.10.
>>>>
>>>> In order to debug this we changed over to mainline Linux and bissecting
>>>> lead us to find that commit e611f8cd8717 is the culprit, and with it applied
>>>> we get the following messages:
>>>>
>>>> [   10.954597] phy-am654 910000.serdes: Failed to enable PLL
>>>> [   10.960153] phy phy-910000.serdes.3: phy poweron failed --> -110
>>>> [   10.967485] keystone-pcie 5500000.pcie: failed to enable phy
>>>> [   10.973560] keystone-pcie: probe of 5500000.pcie failed with error -110
>>>>
>>>> This timeout is occuring in serdes_am654_enable_pll(), called from the
>>>> phy_ops .power_on() hook.
>>>>
>>>> Due to the nature of the error messages and the contents of the commit we
>>>> believe that this is due to an unidentified race condition in the probing of
>>>> the Keystone PCI driver when enabling the PHY PLLs, since changes in the
>>>> workqueue the deferred probing runs on should not affect if probing works
>>>> or not. To further support the existence of a race condition, commit
>>>> 86bfbb7ce4f6 (a scheduler commit) fixes probing, most likely unintentionally
>>>> meaning that the problem may arise in the future again.
>>>>
>>>> One possible explanation is that there are pre-requisites for enabling the PLL
>>>> that are not being met when e611f8cd8717 is applied; to see if this is the case
>>>> help from people more familiar with the hardware details would be useful.
>>>>
>>>> As official support specifically for the IOT2050 Advanced M.2 platform was
>>>> introduced in Linux v6.3 (so in the middle of the commits mentioned above)
>>>> all of our testing was done with the latest mainline DeviceTree with [1]
>>>> applied on top.
>>>>
>>>> This is being reported as a regression even though technically things are
>>>> working with the current state of mainline since we believe the current fix
>>>> to be an unintended by-product of other work.
>>>>
>>>> #regzbot introduced: e611f8cd8717
>>> A "regression" for a commit that was in 5.13, i.e. almost 2 years ago,
>>> is a bit tough, and not something I would consider really a "regression"
>>> as it is core code that everyone runs.  Given you point at scheduler
>>> changes also fixing the issue, this seems like a hint as to what is
>>> wrong with your driver/platform, but is not the root cause of it and
>>> needs to be resolved.  Please look at fixing it in your drivers?  Are
>>> they all in Linus's tree?
>>>
>>> thanks,
>>>
>>> greg k-h
>> Hello,
>>
>> I see the point that this code has been living in the kernel for a
>> long time now and that it becomes more difficult to justify it as
>> a regression; I reported it as such based on the supposition that
>> the current fix is not the proper one and that technically this
>> support was broken between the identified commits.
>>
>> If this situation is incompatible with a regression report then it
>> can be dropped as one and we keep it is as a bug report for which
>> we are looking for input from the community.
>>
>> I agree that this needs to be fixed in the driver since all other
>> drivers are working fine with e611f8cd8717, and yes, all of the
>> drivers in question are in mainline, where we performed the bissection.
> 
> Looks like Siddharth from TI fixed a similar issue reported by you here.
> https://lore.kernel.org/r/20230927041845.1222080-1-s-vadapalli@ti.com

Kishon,

Thank you for looping me in.

Diogo,

The issue you are referring to is identical to the one fixed in the patch shared
above by Kishon. I had also bisected the culprit to commit e611f8cd8717 which
doesn't have anything to do with PCIe/Serdes in particular. It only seems to
expose the underlying race condition which has always existed. The fix has been
merged and is now a part of mainline Linux:
https://github.com/torvalds/linux/commit/c12ca110c613a81cb0f0099019c839d078cd0f38

Additionally, you might run into an issue once you fix the above which happens
to be a 45 second delay when no Endpoint Device is connected to the PCIe
connector. I have posted a patch for fixing that issue as well:
https://lore.kernel.org/r/20231019081330.2975470-1-s-vadapalli@ti.com/

-- 
Regards,
Siddharth.

