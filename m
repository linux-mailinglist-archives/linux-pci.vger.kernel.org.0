Return-Path: <linux-pci+bounces-24378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D97A6C092
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55EE188790D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181A22B59D;
	Fri, 21 Mar 2025 16:48:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681D155A25;
	Fri, 21 Mar 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575737; cv=none; b=NFnmlNMkNd0Z6yU9UCuEhpTdsx/sq+6MK+PqytoXA0g34piRG0BUmUPY+AsBWj3Phk06kWjOSbRt9n08t+JgL3ywGHiuHOm0U2kPRv2unnKzyR9WgQnAhd5d7UzVh6Q0RaggQ6u5LbQm2rldv/vJCln7asKJXo/esk5/d9psqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575737; c=relaxed/simple;
	bh=JBdg7xMBLd5iIqOC0TaR5k4K2Igly/gZ0cV4AKosEWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faBHcupuM+NTzWoSBngJksg4r107iWuLqMWum7fKufEsxANAYLMN/wLIvzHWlLTQAOCtCBmNRC4c9qfjRiTYsQngOttF96f/aK7CAayoM2Y45dO/ci4dEKeIYAshOG81iSD2Ut+YfwNz/rtKpqiZdO7sEFCJDOsWMxvwExd5f0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A25106F;
	Fri, 21 Mar 2025 09:49:01 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 791DD3F63F;
	Fri, 21 Mar 2025 09:48:50 -0700 (PDT)
Message-ID: <135390b1-c0c5-4595-a3f3-1fb376473872@arm.com>
Date: Fri, 21 Mar 2025 16:48:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com>
 <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
 <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
 <bf2adf5d-1432-4bb7-846c-e1bcfa84858b@samsung.com>
 <016bb7ca-f0d3-464e-ac74-46e6f78e90d7@arm.com>
 <b63ff6b4-9dc3-42ea-8b87-d4fdead8d0eb@arm.com>
 <cdc333e4-25bb-4171-9f6e-01f1de947db3@samsung.com>
 <d6cd5e64-e2c0-4c6e-9c89-ce8b3e0a4a5b@arm.com>
 <ace3a01f-4700-4455-ada3-0f88fc8ea4cd@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ace3a01f-4700-4455-ada3-0f88fc8ea4cd@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/03/2025 12:15 pm, Marek Szyprowski wrote:
> On 17.03.2025 19:22, Robin Murphy wrote:
>> On 17/03/2025 7:37 am, Marek Szyprowski wrote:
>>> On 13.03.2025 15:12, Robin Murphy wrote:
>>>> On 2025-03-13 1:06 pm, Robin Murphy wrote:
>>>>> On 2025-03-13 12:23 pm, Marek Szyprowski wrote:
>>>>>> On 13.03.2025 12:01, Robin Murphy wrote:
>>>>>>> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
>>>>>>> [...]
>>>>>>>> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
>>>>>>>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my
>>>>>>>> tests I
>>>>>>>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>>>>>>>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>>>>>>>> relevant kernel log:
>>>>>>>
>>>>>>> ...and the bug-flushing-out begins!
>>>>>>>
>>>>>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>>>>>> 00000000000003e8
>>>>>>>> Mem abort info:
>>>>>>>>        ESR = 0x0000000096000004
>>>>>>>>        EC = 0x25: DABT (current EL), IL = 32 bits
>>>>>>>>        SET = 0, FnV = 0
>>>>>>>>        EA = 0, S1PTW = 0
>>>>>>>>        FSC = 0x04: level 0 translation fault
>>>>>>>> Data abort info:
>>>>>>>>        ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>>>>>        CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>>>>>        GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>>>>> [00000000000003e8] user address but active_mm is swapper
>>>>>>>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>>>>> Modules linked in:
>>>>>>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
>>>>>>>> Hardware name: Hardkernel ODROID-M1 (DT)
>>>>>>>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>>>> pc : devm_kmalloc+0x2c/0x114
>>>>>>>> lr : rk_iommu_of_xlate+0x30/0x90
>>>>>>>> ...
>>>>>>>> Call trace:
>>>>>>>>       devm_kmalloc+0x2c/0x114 (P)
>>>>>>>>       rk_iommu_of_xlate+0x30/0x90
>>>>>>>
>>>>>>> Yeah, looks like this is doing something a bit questionable which
>>>>>>> can't
>>>>>>> work properly. TBH the whole dma_dev thing could probably be
>>>>>>> cleaned up
>>>>>>> now that we have proper instances, but for now does this work?
>>>>>>
>>>>>> Yes, this patch fixes the problem I've observed.
>>>>>>
>>>>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>>
>>>>>> BTW, this dma_dev idea has been borrowed from my exynos_iommu driver
>>>>>> and
>>>>>> I doubt it can be cleaned up.
>>>>>
>>>>> On the contrary I suspect they both can - it all dates back to when
>>>>> we had the single global platform bus iommu_ops and the SoC drivers
>>>>> were forced to bodge their own notion of multiple instances, but with
>>>>> the modern core code, ops are always called via a valid IOMMU
>>>>> instance or domain, so in principle it should always be possible to
>>>>> get at an appropriate IOMMU device now. IIRC it was mostly about
>>>>> allocating and DMA-mapping the pagetables in domain_alloc, where the
>>>>> private notion of instances didn't have enough information, but
>>>>> domain_alloc_paging solves that.
>>>>
>>>> Bah, in fact I think I am going to have to do that now, since although
>>>> it doesn't crash, rk_domain_alloc_paging() will also be failing for
>>>> the same reason. Time to find a PSU for the RK3399 board, I guess...
>>>>
>>>> (Or maybe just move the dma_dev assignment earlier to match Exynos?)
>>>
>>> Well I just found that Exynos IOMMU is also broken on some on my test
>>> boards. It looks that the runtime pm links are somehow not correctly
>>> established. I will try to analyze this later in the afternoon.
>>
>> Hmm, I tried to get an Odroid-XU3 up and running, but it seems unable
>> to boot my original 6.14-rc3-based branch - even with the IOMMU driver
>> disabled, it's consistently dying somewhere near (or just after) init
>> with what looks like some catastrophic memory corruption issue - very
>> occasionally it's managed to print the first line of various different
>> panics.
>>
>> Before that point though, with the IOMMU driver enabled it does appear
>> to show signs of working OK:
>>
>> [    0.649703] exynos-sysmmu 14650000.sysmmu: hardware version: 3.3
>> [    0.654220] platform 14450000.mixer: Adding to iommu group 1
>> ...
>> [    2.680920] exynos-mixer 14450000.mixer:
>> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42924000
>> ...
>> [    5.196674] exynos-mixer 14450000.mixer:
>> exynos_iommu_identity_attach: Restored IOMMU to IDENTITY from pgtable
>> 0x42924000
>> [    5.207091] exynos-mixer 14450000.mixer:
>> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42884000
>>
>>
>> The multi-instance stuff in probe/release does look a bit suspect,
>> however - seems like the second instance probe would overwrite the
>> first instance's links, and then there would be a double-del() if the
>> device were ever actually released again? I may have made that much
>> more likely to happen, but I suspect it was already possible with
>> async driver probe...
> 
> That is really strange. My Odroid XU3 boots fine from commit
> bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path"),
> although the IOMMU seems not to be working correctly. I've tested this
> with 14450000.mixer device (one need to attach HDMI cable to get it
> activated) and it looks that the video data are not being read from
> memory at all (the lack of VSYNC is reported, no IOMMU fault). However,
> from time to time, everything initializes and works properly.

Urgh, seems my mistake was assuming exynos_defconfig was the right thing 
to begin from - bcb81ac6ae3c with that still dies in the same way (this 
time I saw a hint of spin_bug() being hit...), however a 
multi_v7_defconfig build does get to userspace OK again with no obvious 
signs of distress:

[root@alarm ~]# grep -Hr . /sys/kernel/iommu_groups/*/type
/sys/kernel/iommu_groups/0/type:identity
/sys/kernel/iommu_groups/1/type:identity
/sys/kernel/iommu_groups/10/type:identity
/sys/kernel/iommu_groups/2/type:identity
/sys/kernel/iommu_groups/3/type:identity
/sys/kernel/iommu_groups/4/type:identity
/sys/kernel/iommu_groups/5/type:identity
/sys/kernel/iommu_groups/6/type:identity
/sys/kernel/iommu_groups/7/type:identity
/sys/kernel/iommu_groups/8/type:identity
/sys/kernel/iommu_groups/9/type:identity

Annoyingly I do have an adapter for the fiddly micro-HDMI, but it's at 
home :(

> It looks that this is somehow related to the different IOMMU/DMA-mapping
> glue code, as the other boards (ARM64 based) with exactly the same
> Exynos IOMMU driver always work fine. I've tried to figure out what
> actually happens, but so far I didn't get anything for sure. Disabling
> the call to dev->bus->dma_configure(dev) from iommu_init_device() seems
> to be fixing this, but this is almost equal to the revert of the
> $subject patch. I don't get why calling it in iommu_init_device() causes
> problems. It also doesn't look that this is anyhow related to the
> multi-instance stuff, as the same happens if I only leave a single
> exynos-sysmmu instance and its client (only 14450000.mixer device in the
> system).

On a hunch I stuck a print in exynos_iommu_probe_device(), and it looks 
like in fact device_link_add() isn't getting called at all, and indeed 
your symptoms do sound like they could be explained by the IOMMU not 
being reliably resumed... lemme stare at exynos_iommu_of_xlate() a bit 
longer...

Thanks,
Robin.

