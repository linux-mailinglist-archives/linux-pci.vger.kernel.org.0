Return-Path: <linux-pci+bounces-44936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA71D241DC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E6033093054
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F723376A3;
	Thu, 15 Jan 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nm07ZQy1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0A2DBF45
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475703; cv=none; b=k/zu6hvglviSGF4Le2uTxJIxxgezTRJkd7l3t07c2PJ0NYrQfaYB8T6madajO3dUIK2jeMwJbrdJNhbOrOkVVaJCvmsyI5c1wFilOzQvaP1kp6tdeqDykRa0wlAgqC89oDHJLtn77TPYXEY1pKfl/hd/4Vx7oqud8vRItFz5fJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475703; c=relaxed/simple;
	bh=oeFCSQd193B7M3U7GlanEaDjGvU31U3+p7TfFQNK5Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aJnKr6LGiquBxeSU2DbkSbVEU0Yw/PCcUVQScr60uof2Q4rxcJrsqsVNsrBW9sy+h0zPVF8goGt+eLkmqqX/5s/OY4XGkkNn9smEvsrLTu7FbpwfVcjrh6LUINMemgLLdHbgGjHjeS+1ZlSfv2S7NBRP6LnIfXX2YUBb4cSMkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nm07ZQy1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260115111452euoutp0185157814e86d15867f16658b168f691d~K40WsRH653153731537euoutp01e
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 11:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260115111452euoutp0185157814e86d15867f16658b168f691d~K40WsRH653153731537euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768475692;
	bh=ODlM0ncXnlrLvxb4ihqQBJ3CUEnwHzZLJ0VgMlXzdh8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nm07ZQy1IRUCTYodbBRF6jonHTbl+TsoF3782MwFWtr/OE16+IsQVG+cctI089KWa
	 uN8qkOZguPp9PMHzAm/0yGPHACY5mk3uYJW6J8e3RXoy8o6wkz3OB9X5Bo5e9JyP/d
	 6FsHbs3hYFZR0ryxpExac1CuhHH0EXvEqyPJAzlk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260115111451eucas1p145ac65c845c6cd3bcbb9bccf75993a2a~K40WSZZlf2186821868eucas1p1q;
	Thu, 15 Jan 2026 11:14:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260115111450eusmtip2851be6a89c0b4f48966dc2bbc0e6c902~K40VaBTI03110431104eusmtip2c;
	Thu, 15 Jan 2026 11:14:50 +0000 (GMT)
Message-ID: <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>
Date: Thu, 15 Jan 2026 12:14:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki"
	<rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aWf4KyTSIocWTmXw@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260115111451eucas1p145ac65c845c6cd3bcbb9bccf75993a2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
X-EPHeader: CA
X-CMS-RootMailID: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
References: <20260106222715.GA381397@bhelgaas>
	<CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
	<0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
	<aWf4KyTSIocWTmXw@google.com>

Hi Brian,

On 14.01.2026 21:10, Brian Norris wrote:
> On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
>> On 06.01.2026 23:27, Bjorn Helgaas wrote:
>>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
>>>> Today, it's possible for a PCI device to be created and
>>>> runtime-suspended before it is fully initialized. When that happens, the
>>>> device will remain in D0, but the suspend process may save an
>>>> intermediate version of that device's state -- for example, without
>>>> appropriate BAR configuration. When the device later resumes, we'll
>>>> restore invalid PCI state and the device may not function.
>>>>
>>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
>>>> until we've fully initialized the device.
> ...
>> This patch landed recently in linux-next as commit c796513dc54e
>> ("PCI/PM: Prevent runtime suspend until devices are fully initialized").
>> In my tests I found that it sometimes causes the "pci 0000:01:00.0:
>> runtime PM trying to activate child device 0000:01:00.0 but parent
>> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board
>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
>> lockdep warning about console lock, but this is just a consequence of
>> the runtime pm warning. Reverting $subject patch on top of current
>> linux-next hides this warning.
>>
>> Here is a kernel log:
>>
>> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
>> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0
>> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s
>> PCIe x1 link)
>> pci 0000:01:00.0: Adding to iommu group 13
>> pci 0000:01:00.0: ASPM: default states L0s L1
>> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
>> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
>> pci 0000:01:00.0: runtime PM trying to activate child device
>> 0000:01:00.0 but parent (0000:00:00.0) is not active
> Thanks for the report. I'll try to look at reproducing this, or at least
> getting a better mental model of exactly why this might fail (or,
> "warn") this way. But if you have the time and desire to try things out
> for me, can you give v1 a try?
>
> https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>
> I'm pretty sure it would not invoke the same problem.

Right, this one works fine.

> I also suspect v3
> might not, but I'm less sure:
>
> https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
This one too, at least I was not able to reproduce any fail.

>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.19.0-rc1+ #16398 Not tainted
>> ------------------------------------------------------
>> kworker/3:0/33 is trying to acquire lock:
>> ffffcd182ff1ae98 (console_owner){..-.}-{0:0}, at:
>> console_lock_spinning_enable+0x44/0x78
>>
>> but task is already holding lock:
>> ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at:
>> __pm_runtime_set_status+0x240/0x384
>>
>> which lock already depends on the new lock.
> The lockdep warning is a bit messier, and I'd also have to take some
> more time to be sure, but in principle, this sounds like a totally
> orthogonal problem. It seems like simply performing printk() to a qcom
> UART in the "wrong" context is enough to cause this. If so, that's
> definitely a console/UART bug (or maybe a lockdep false positive) and
> not a PCI/runtime-PM bug.

Yes, the lockdep warning is not really a problem, it is just a 
consequence of the printing that "runtime PM trying to activate child 
device 0000:01:00.0 but parent (0000:00:00.0) is not active" message. 
However that message is itself a problem imho.

>> (...)
>>
>> This looks a bit similar to the issue reported some time ago on a
>> different board:
>>
>> https://lore.kernel.org/all/6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com/
> Huh, yeah, the lockdep warning is rather similar looking. So that bug
> (whether real or false positive) may have been around a while.
>
> And the "Enabling runtime PM for inactive device with active children"
> log is similar, but it involves a different set of devices -- now we're
> dealing with the PCIe port and child device, whereas that report was
> about the host bridge/controller device.

Okay, so a bit different case. At least it confirms that the lockdep 
issue is not really a problem.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


