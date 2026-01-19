Return-Path: <linux-pci+bounces-45161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747AD3A3F4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30DB3300294C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94B3563CA;
	Mon, 19 Jan 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EDU0X9a3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4E283CA3
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816863; cv=none; b=eTdQxPL1mgp0yRF1E433eZ6GlfNRgROOWCKaUUXhdoz7HJ+j+0aA6fqzqbx+o70kEwZR2Dsk8qgBB5jz+syW+CsnbVtwo22zgXtLgEolPk34fR2+ugp2h9KpucWHm8bD8mGhwJWENpNxGmSdfb5BKR0jr3lo20wnM/19gKID/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816863; c=relaxed/simple;
	bh=ndrynrTslXrAPNuW5C8G1/k3yNfdAGrgdXfaEDYnkAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PLM2bycDyly/XccDFpFcZUFlhdJSlBh8MhCQLY2tGDBTr1Z3iqiaCjlzekuWfCke2h13IHm67zAPSRZvfm2cbbQpZUZh7GnwSo3LvYo5RH+yBP98dJPW2wmvhrXIlXWxuuN6bsv7JpcRiVclyYMXrrX8WfStGFPz9wkQ8ul2VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EDU0X9a3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260119100057euoutp013077e7ee61e6f91d9943e32c7bd8d5cc~MGY_AXysJ0654706547euoutp01O
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260119100057euoutp013077e7ee61e6f91d9943e32c7bd8d5cc~MGY_AXysJ0654706547euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768816857;
	bh=vaXf1R8CIvjwww4l9M6k/6HVZU+7VYvCT9sGPrBBGgs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EDU0X9a3i5dsk4J10f6rV9fxfjcRrX+u1mRBeEa8dXkAPWbiH/UjV9c45DfbWiUYM
	 jAe/NMp6T7dEIWSmpdDj9s8kvUi4yG822UuQDaoVEEO4K1hDmecnzvMjbWAz2ZSiw1
	 IRnNLTZ0TyOmGqXyziRFYavE6yrOvPSLNKkrXpWI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119100057eucas1p12c904747d189904648799e60afbf5166~MGY9yXBnd0835908359eucas1p1v;
	Mon, 19 Jan 2026 10:00:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260119100056eusmtip2200a37839f4767fbc25bd7e6d661337c~MGY82qHxu2005420054eusmtip2_;
	Mon, 19 Jan 2026 10:00:56 +0000 (GMT)
Message-ID: <d2c006c3-44c3-4270-b1ca-5d1a0d7f4e09@samsung.com>
Date: Mon, 19 Jan 2026 11:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: "Rafael J. Wysocki" <rafael@kernel.org>, Brian Norris
	<briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJZ5v0gKZFWzuFT=cF_Ydjpro+sXzdeZ_+B4GEfiifa-cxpbGw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260119100057eucas1p12c904747d189904648799e60afbf5166
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

On 18.01.2026 12:59, Rafael J. Wysocki wrote:
> On Sun, Jan 18, 2026 at 12:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Jan 17, 2026 at 2:19 AM Brian Norris <briannorris@chromium.org> wrote:
>>> On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
>>>> On 14.01.2026 21:10, Brian Norris wrote:
>>>>> On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
>>>>>> On 06.01.2026 23:27, Bjorn Helgaas wrote:
>>>>>>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
>>>>>>>> Today, it's possible for a PCI device to be created and
>>>>>>>> runtime-suspended before it is fully initialized. When that happens, the
>>>>>>>> device will remain in D0, but the suspend process may save an
>>>>>>>> intermediate version of that device's state -- for example, without
>>>>>>>> appropriate BAR configuration. When the device later resumes, we'll
>>>>>>>> restore invalid PCI state and the device may not function.
>>>>>>>>
>>>>>>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
>>>>>>>> until we've fully initialized the device.
>>>>> ...
>>>>>> This patch landed recently in linux-next as commit c796513dc54e
>>>>>> ("PCI/PM: Prevent runtime suspend until devices are fully initialized").
>>>>>> In my tests I found that it sometimes causes the "pci 0000:01:00.0:
>>>>>> runtime PM trying to activate child device 0000:01:00.0 but parent
>>>>>> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board
>>>>>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
>>>>>> lockdep warning about console lock, but this is just a consequence of
>>>>>> the runtime pm warning. Reverting $subject patch on top of current
>>>>>> linux-next hides this warning.
>>>>>>
>>>>>> Here is a kernel log:
>>>>>>
>>>>>> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
>>>>>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>>>>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0
>>>>>> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s
>>>>>> PCIe x1 link)
>>>>>> pci 0000:01:00.0: Adding to iommu group 13
>>>>>> pci 0000:01:00.0: ASPM: default states L0s L1
>>>>>> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
>>>>>> pci 0000:01:00.0: runtime PM trying to activate child device
>>>>>> 0000:01:00.0 but parent (0000:00:00.0) is not active
>>>>> Thanks for the report. I'll try to look at reproducing this, or at least
>>>>> getting a better mental model of exactly why this might fail (or,
>>>>> "warn") this way. But if you have the time and desire to try things out
>>>>> for me, can you give v1 a try?
>>>>>
>>>>> https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>>>>>
>>>>> I'm pretty sure it would not invoke the same problem.
>>>> Right, this one works fine.
>>>>
>>>>> I also suspect v3
>>>>> might not, but I'm less sure:
>>>>>
>>>>> https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>>>> This one too, at least I was not able to reproduce any fail.
>>> Thanks for testing. I'm still not sure exactly how to reproduce your
>>> failure, but it seems as if the root port is being allowed to suspend
>>> before the endpoint is added to the system, and it remains so while the
>>> endpoint is about to probe. device_initial_probe() will be OK with
>>> respect to PM, since it will wake up the port if needed. But this
>>> particular code is not OK, since it doesn't ensure the parent device is
>>> active while preparing the endpoint power state.
>>>
>>> I suppose one way to "solve" that is (untested):
>>>
>>> --- a/drivers/pci/bus.c
>>> +++ b/drivers/pci/bus.c
>>> @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>>>                  put_device(&pdev->dev);
>>>          }
>>>
>>> +       if (dev->dev.parent)
>>> +               pm_runtime_get_sync(dev->dev.parent);
>>>          pm_runtime_set_active(&dev->dev);
>>>          pm_runtime_enable(&dev->dev);
>>> +       if (dev->dev.parent)
>>> +               pm_runtime_put(dev->dev.parent);
>>>
>>>          if (!dn || of_device_is_available(dn))
>>>                  pci_dev_allow_binding(dev);
>>>
>>> Personally, I'm more inclined to go back to v1, since it prepares the
>>> runtime PM status when the device is first discovered. That way, its
>>> ancestors are still active, avoiding these sorts of problems. I'm
>>> frankly not sure of all the reasons Rafael recommended I make the
>>> v1->v3->v4 changes, and now that they cause problems, I'm inclined to
>>> question them again.
>>>
>>> Rafael, do you have any thoughts?
>> Yeah.
>>
>> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
> Or rather leave it there to be precise, but I think you know what I mean. :-)
>
>> because that would prevent the parent from suspending and keep
>> pm_runtime_enable() here because that would prevent the device itself
>> from suspending between pm_runtime_init() and this place.
>>
>> And I would add comments in both places.

Confirmed, the following change (compared to $subject patch) fixed my issue:

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3ef60c2fbd89..7e2b7e452d51 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -381,7 +381,6 @@ void pci_bus_add_device(struct pci_dev *dev)
         }

         pm_runtime_set_active(&dev->dev);
-       pm_runtime_enable(&dev->dev);

         if (!dn || of_device_is_available(dn))
                 pci_dev_allow_binding(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fae5a683cf87..22b897416025 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3201,6 +3201,7 @@ void pci_pm_init(struct pci_dev *dev)
  poweron:
         pci_pm_power_up_and_verify_state(dev);
         pm_runtime_forbid(&dev->dev);
+       pm_runtime_enable(&dev->dev);
  }

  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)


Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


