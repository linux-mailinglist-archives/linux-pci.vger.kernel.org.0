Return-Path: <linux-pci+bounces-45178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7799D3AA05
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827B33053301
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20F3659F1;
	Mon, 19 Jan 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b3AjMzJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CE36404B
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828389; cv=none; b=dkwlWvoLMw4/k5hWPKfgdibe3Kt7L3RJKoDn360/WMkdrWojVe0tOrfIQZLuBEJzVPzFWcfUuIxM1G0kAcUHx3BZKcdnNr7MtG0Ag45xcxxiUWnDSxEYKloHchTDHajzX4ZgIPlCB0DOunsaFHDxQUN8X89dBsWYC6lrZVMKLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828389; c=relaxed/simple;
	bh=k/h50n8vWqc+q0B9zN6Fs+ILbQYyrcMkfxlM47D6Gk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=llVx7IHTxefYtbLxSo/lyUyQ0Ajb/RdKvsZqM9L9JpUPbve5Y4ZI4n+8wL5P9u+z3R2sExeOI1i2ZYOdxptpy0WOBEtUYby5oksg9R9u9oRh7Y617O5Jzt6NAnETF/3davLUlCCzZ3lZ26j3CDIHF3rINUHWjoCAIt8jUzMVlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b3AjMzJl; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260119131304euoutp0246cb26c80e2eb3ad1d7687ddf2881c05~MJAtNFFbH1678816788euoutp02q
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 13:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260119131304euoutp0246cb26c80e2eb3ad1d7687ddf2881c05~MJAtNFFbH1678816788euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768828384;
	bh=Bj9sRPcxMKBSsLFWUn5X+Cp367Ih4xF1g80Xq3QtY4E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=b3AjMzJlNqVReL03wgAgp5fgYNwCUW7rqFdSOOTxXo58Orf5pGegGQPT5Ogx9dr34
	 bwfTyQ7iyTM6JqUepnojrRorYP4a5bEndWH8y9Wgih9NudniteO/PXe5L8uL6YBbph
	 lYzYKhKZ0K8+t3OkbLaE/QHEsXqukt/ad6WWyWeY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119131304eucas1p1d10c043c29d8fefa78dc1a3221231f27~MJAs1SWgR2584625846eucas1p1W;
	Mon, 19 Jan 2026 13:13:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260119131303eusmtip15c9111c50afc306b518769c68ae4c02b~MJAsVLxov2848728487eusmtip1s;
	Mon, 19 Jan 2026 13:13:03 +0000 (GMT)
Message-ID: <6e0c511f-1127-4a35-a40c-0161de0ec752@samsung.com>
Date: Mon, 19 Jan 2026 14:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner
	<lukas@wunner.de>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJZ5v0j=TM6DoGbW1agbiHUbq46G7pyd25E=ih2at7dvYr83Sg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260119131304eucas1p1d10c043c29d8fefa78dc1a3221231f27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
X-EPHeader: CA
X-CMS-RootMailID: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
References: <20260106222715.GA381397@bhelgaas>
	<CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
	<0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
	<aWf4KyTSIocWTmXw@google.com>
	<61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>
	<aWrjhqC_6I2UNXC5@google.com>
	<CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
	<CAJZ5v0gKZFWzuFT=cF_Ydjpro+sXzdeZ_+B4GEfiifa-cxpbGw@mail.gmail.com>
	<d2c006c3-44c3-4270-b1ca-5d1a0d7f4e09@samsung.com>
	<CAJZ5v0j=TM6DoGbW1agbiHUbq46G7pyd25E=ih2at7dvYr83Sg@mail.gmail.com>

On 19.01.2026 13:26, Rafael J. Wysocki wrote:
> On Mon, Jan 19, 2026 at 11:01 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 18.01.2026 12:59, Rafael J. Wysocki wrote:
>>> On Sun, Jan 18, 2026 at 12:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Sat, Jan 17, 2026 at 2:19 AM Brian Norris <briannorris@chromium.org> wrote:
>>>>> On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
>>>>>> On 14.01.2026 21:10, Brian Norris wrote:
>>>>>>> On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
>>>>>>>> On 06.01.2026 23:27, Bjorn Helgaas wrote:
>>>>>>>>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
>>>>>>>>>> Today, it's possible for a PCI device to be created and
>>>>>>>>>> runtime-suspended before it is fully initialized. When that happens, the
>>>>>>>>>> device will remain in D0, but the suspend process may save an
>>>>>>>>>> intermediate version of that device's state -- for example, without
>>>>>>>>>> appropriate BAR configuration. When the device later resumes, we'll
>>>>>>>>>> restore invalid PCI state and the device may not function.
>>>>>>>>>>
>>>>>>>>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
>>>>>>>>>> until we've fully initialized the device.
>>>>>>> ...
>>>>>>>> This patch landed recently in linux-next as commit c796513dc54e
>>>>>>>> ("PCI/PM: Prevent runtime suspend until devices are fully initialized").
>>>>>>>> In my tests I found that it sometimes causes the "pci 0000:01:00.0:
>>>>>>>> runtime PM trying to activate child device 0000:01:00.0 but parent
>>>>>>>> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board
>>>>>>>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
>>>>>>>> lockdep warning about console lock, but this is just a consequence of
>>>>>>>> the runtime pm warning. Reverting $subject patch on top of current
>>>>>>>> linux-next hides this warning.
>>>>>>>>
>>>>>>>> Here is a kernel log:
>>>>>>>>
>>>>>>>> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
>>>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
>>>>>>>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>>>>>>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0
>>>>>>>> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s
>>>>>>>> PCIe x1 link)
>>>>>>>> pci 0000:01:00.0: Adding to iommu group 13
>>>>>>>> pci 0000:01:00.0: ASPM: default states L0s L1
>>>>>>>> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
>>>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
>>>>>>>> pci 0000:01:00.0: runtime PM trying to activate child device
>>>>>>>> 0000:01:00.0 but parent (0000:00:00.0) is not active
>>>>>>> Thanks for the report. I'll try to look at reproducing this, or at least
>>>>>>> getting a better mental model of exactly why this might fail (or,
>>>>>>> "warn") this way. But if you have the time and desire to try things out
>>>>>>> for me, can you give v1 a try?
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>>>>>>>
>>>>>>> I'm pretty sure it would not invoke the same problem.
>>>>>> Right, this one works fine.
>>>>>>
>>>>>>> I also suspect v3
>>>>>>> might not, but I'm less sure:
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>>>>>> This one too, at least I was not able to reproduce any fail.
>>>>> Thanks for testing. I'm still not sure exactly how to reproduce your
>>>>> failure, but it seems as if the root port is being allowed to suspend
>>>>> before the endpoint is added to the system, and it remains so while the
>>>>> endpoint is about to probe. device_initial_probe() will be OK with
>>>>> respect to PM, since it will wake up the port if needed. But this
>>>>> particular code is not OK, since it doesn't ensure the parent device is
>>>>> active while preparing the endpoint power state.
>>>>>
>>>>> I suppose one way to "solve" that is (untested):
>>>>>
>>>>> --- a/drivers/pci/bus.c
>>>>> +++ b/drivers/pci/bus.c
>>>>> @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>>>>>                   put_device(&pdev->dev);
>>>>>           }
>>>>>
>>>>> +       if (dev->dev.parent)
>>>>> +               pm_runtime_get_sync(dev->dev.parent);
>>>>>           pm_runtime_set_active(&dev->dev);
>>>>>           pm_runtime_enable(&dev->dev);
>>>>> +       if (dev->dev.parent)
>>>>> +               pm_runtime_put(dev->dev.parent);
>>>>>
>>>>>           if (!dn || of_device_is_available(dn))
>>>>>                   pci_dev_allow_binding(dev);
>>>>>
>>>>> Personally, I'm more inclined to go back to v1, since it prepares the
>>>>> runtime PM status when the device is first discovered. That way, its
>>>>> ancestors are still active, avoiding these sorts of problems. I'm
>>>>> frankly not sure of all the reasons Rafael recommended I make the
>>>>> v1->v3->v4 changes, and now that they cause problems, I'm inclined to
>>>>> question them again.
>>>>>
>>>>> Rafael, do you have any thoughts?
>>>> Yeah.
>>>>
>>>> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
>>> Or rather leave it there to be precise, but I think you know what I mean. :-)
>>>
>>>> because that would prevent the parent from suspending and keep
>>>> pm_runtime_enable() here because that would prevent the device itself
>>>> from suspending between pm_runtime_init() and this place.
>>>>
>>>> And I would add comments in both places.
>> Confirmed, the following change (compared to $subject patch) fixed my issue:
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 3ef60c2fbd89..7e2b7e452d51 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -381,7 +381,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>>           }
>>
>>           pm_runtime_set_active(&dev->dev);
>> -       pm_runtime_enable(&dev->dev);
> That works too, but it would defeat the purpose of the original
> change, so I mean the other way around.
>
> That is, leave the pm_runtime_enable() here and move the
> pm_runtime_set_active() back to the other place.

Okay, I mixed that. This way it works too and fixes the observed issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


