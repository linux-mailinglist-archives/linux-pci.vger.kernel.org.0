Return-Path: <linux-pci+bounces-24337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CCEA6BA7F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592A419C696C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15913227BA2;
	Fri, 21 Mar 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uJ66fLs7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795C227599
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559319; cv=none; b=msor1QntUw2m6BDCespPwiHZuzzplLiapWxZCZdkpPpl7AFEAL/9FILGGU81tir0Jm20LPczur2IIkGLeBMY6RBnd9N5rMmW5XAFxBW5MRBBGMi1ldKZu3JdwHyvPNHFaYKVy/lyUDQrxhSlBNRQ/sN1ze+tCjeqk+JCsQO6wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559319; c=relaxed/simple;
	bh=jdxnifYvhpOegrtIsz4x1N9dIvwhi//1Du1rbtxiZ2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pn2D0iNRzV7t+UhbeyhfICA+5qVFsIF+34zfxPtTdf/JERD+f96oivINxyIoHXs1jz53kt/BaAMCdUtZa+iYIC9RKsRQewG8m2S7uZNMJUK69f0MUyGsQ1Rru9gChNREMgsIurFRPgKNy4RpJNXp04RXc5ml1g/GIkzvijZoirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uJ66fLs7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250321121514euoutp0227898c65b51ea4038adede19bfed4d6c~u0HbYU76-0264602646euoutp02R
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 12:15:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250321121514euoutp0227898c65b51ea4038adede19bfed4d6c~u0HbYU76-0264602646euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742559314;
	bh=MHO6SdbNFs1J7nO+41CHx9xqMsSu4tdXH9vnU5Jzzo4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uJ66fLs7Obilq9mId7yKjwF50346mYhfbEOPUZxyOKN8Sh5Pn9OhQnju0XagfuJMS
	 jH6Cm7ik0xZAj9fwzXRS7Iz6nGn4plED88CovnWjXA8BxbPtxi6FbzjDr6IL4+0k2L
	 +bFl6wNnY1LtrhnzNhe+HGyaJY+PB5PZVwUJY7KM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250321121514eucas1p1ee13ac2a07d447599b9c7c32b594ecc0~u0Ha9Jj1p0634006340eucas1p1V;
	Fri, 21 Mar 2025 12:15:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.10.20821.2585DD76; Fri, 21
	Mar 2025 12:15:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250321121513eucas1p2c17d32842a41ad058b914bf3d9ff7512~u0HaTDMvC0313803138eucas1p2b;
	Fri, 21 Mar 2025 12:15:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250321121513eusmtrp18028559e7e8c3a8d821562fa4b64ad93~u0HaRrSkW3246232462eusmtrp1h;
	Fri, 21 Mar 2025 12:15:13 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-cc-67dd58525c00
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.C1.19920.1585DD76; Fri, 21
	Mar 2025 12:15:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250321121511eusmtip23c2fe1a430242457999298218d0d3fd7~u0HYaApUO3026630266eusmtip21;
	Fri, 21 Mar 2025 12:15:11 +0000 (GMT)
Message-ID: <ace3a01f-4700-4455-ada3-0f88fc8ea4cd@samsung.com>
Date: Fri, 21 Mar 2025 13:15:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Stuart
	Yoder <stuyoder@gmail.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun
	Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Charan Teja Kalla
	<quic_charante@quicinc.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <d6cd5e64-e2c0-4c6e-9c89-ce8b3e0a4a5b@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxj26zk9PdS0HgqOD9xG0kQHmxYZunyJzMmi2XGXhOCWEZc56zgp
	ILe14PAyRlYQ7NgGVlQKpc3A1WgDtDBXGi6jNC13GUUgXMZgMBQGUqnEOdBZDtv49z7P+7y3
	Jy+JiXREEJmQks7IU6RJYoKP33L8dXtXTOyYbPfqDwSq/CoezV1eJJDO3sNFyopqArXUl/DQ
	Yw9CF0preMhT2Imj+ol5AhmavgPI/PsAF7msZQTqLncSyFbcCFDOSg6Orlok6OG9yziq1iUj
	racYQ08bLDzUsjjFRSrb6rO2pmEMGTosOMoZ3XsgkJ5qKefQuX2rBG0sNwLaNfALRtdrxni0
	3pxB59jnubT5xgWCbtYaeXRt5Zf03doSQJsWLBy6qCGLXjK/GC08yo+MY5ISTjHysP3H+fGD
	mlZeWm94Zn/REzwb2ENUgCQhtQcuKM+oAJ8UUdcBNDm6OCzwAGhp6SdYsASgNbcZUwGftQqX
	Xr+eMAD46OvldeAG8HzNAu5VCaj9sLwvj/DGOLUd9toGeCzvC9tLptY0W6lgOD58dY33o47A
	BdUk8Dbyp8xcOJjbxfUCjJoGsObO0FonjAqAw1M6jjcmqHComlet8T7UPjhw3wxYTTBU/liK
	eYshpeVDm2mRxy5+EKpHZrhs7AdnnXXr/POwU12AswV5AOr/HuewoBDA7JlhwKr2wdGex4TX
	NIwKhdXWMJaOgqqlYoz1UgiH5n3ZJYTw4q0r67QA5p8XseodUOOs+m9sS28fVgjEmg3GaDac
	qdlwjub/uXqA3wABTIYiWcYowlOYzyUKabIiI0Um+TQ12Qye/XDnE+cDC9DOuiU2wCGBDUAS
	E/sL/PNHZCJBnPT0GUae+ok8I4lR2MA2EhcHCL5vzpWJKJk0nTnJMGmM/N8sh/QJyuZsr+RE
	3QykWj9WGE+dMG6JeNB29w4d2hE7bzzk2LW32pkeM9k5veSOiyx4/7nJbh/fkvYeUv3bztdc
	jqbG1ar2CM9bb5/9ItF8752J1ANDh7c2BkWIrMcSihIKLwnmNg+oNte8/ub0TQCVJ8u0Ev/E
	0baK3aPCn7r28F6KXF4OfSVv08ziwysFrcdL+/saVAfxsu5NcQ71ubA/Plv59aI+OiT/bKDb
	9YLpgxGy6ZunIVW3pYnqa/bZrK4ThqzwIsN7FRNRf0ZH1V6HTY++Pf2R8NWYmXc70rDgQ207
	75ubKpZi6yK2uD9sMzReOzcWZLdu+7nuDZ1f5qD46LHxuUJlbNXKZOZhMa6Il4a/jMkV0n8A
	DUX1DjIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsVy+t/xe7qBEXfTDVZvl7JY0pRh8XraBzaL
	+UfOsVo0L17PZnFw50x2i19fLCw6Z29gt/gy4TSLxc6Hb9kslu/rZ7TY9Pgaq8XlXXPYLM7O
	O85mcWjqXkaLlj8tLBYzduhZfH05jcVi/fxci7lfpjJb/N+zg93i4IcnrBZdh/4Cjd14i9li
	+akdLBYtd0wdJD2eHJzH5NF66S+bx5p5axg9Ll+7yOyxc9Zddo8Fm0o9Wo68ZfXYtKqTzWP/
	3DXsHpuX1Hu82DyT0WPjux1MHhP31Hl83iQXwBelZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
	YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F91mH2gguGFVcm/mNpYDyi0cXIySEhYCJxecEC
	ti5GLg4hgaWMEkt/HWeESMhInJzWwAphC0v8udYFVfSeUWLNsZlgRbwCdhLzLrWzgdgsAqoS
	Fw5dY4eIC0qcnPmEBcQWFZCXuH9rBlhcWCBY4l3XI0aQQSIC21glrs3byQziMAs8ZZT4cv4Z
	K8SK/SwSZx8vZwZpYRYQl7j1ZD4TiM0mYCjR9bYLbB2ngLXEtfebGCFqzCS6tnZB2fISzVtn
	M09gFJqF5JJZSEbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGJZ9uxn5t3
	MM579VHvECMTB+MhRgkOZiURXpGO2+lCvCmJlVWpRfnxRaU5qcWHGE2BwTGRWUo0OR+Y+vJK
	4g3NDEwNTcwsDUwtzYyVxHndLp9PExJITyxJzU5NLUgtgulj4uCUamBKr338iTny7zIjk+aH
	7FeXbVs918HcnjGPtX7XvGyxe9P2qnxlLoxpt3iSV7maoeC+QeHhtNzYqXYl6kqi17orxa5P
	4eP9GZ1369HXo6t7VHVPyd94bCGtzruobem8kmp5Mw+XU+s8DHYeO32Cbcoctw0z/8yx0Twh
	ciO86cqG+R2p3vZbTKJWNtwNLd7u8+1xIUeGfinHsmSG6Qutjj74dr96m1dC2Ibffduv7mUz
	f1Sp0f3pOVf/wc977xp9X5fG+t1K/auarsHmbpliprusbmwpUglPEm9xMzlIdrOKp1sYWZu9
	bOi0fTzhwsR7M3KVd2uUvJm5w1/u717N9d/vWGZwvbudHhd/w11CqUCJpTgj0VCLuag4EQBP
	2Er8xQMAAA==
X-CMS-MailID: 20250321121513eucas1p2c17d32842a41ad058b914bf3d9ff7512
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
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

On 17.03.2025 19:22, Robin Murphy wrote:
> On 17/03/2025 7:37 am, Marek Szyprowski wrote:
>> On 13.03.2025 15:12, Robin Murphy wrote:
>>> On 2025-03-13 1:06 pm, Robin Murphy wrote:
>>>> On 2025-03-13 12:23 pm, Marek Szyprowski wrote:
>>>>> On 13.03.2025 12:01, Robin Murphy wrote:
>>>>>> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
>>>>>> [...]
>>>>>>> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
>>>>>>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my
>>>>>>> tests I
>>>>>>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>>>>>>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>>>>>>> relevant kernel log:
>>>>>>
>>>>>> ...and the bug-flushing-out begins!
>>>>>>
>>>>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>>>>> 00000000000003e8
>>>>>>> Mem abort info:
>>>>>>>       ESR = 0x0000000096000004
>>>>>>>       EC = 0x25: DABT (current EL), IL = 32 bits
>>>>>>>       SET = 0, FnV = 0
>>>>>>>       EA = 0, S1PTW = 0
>>>>>>>       FSC = 0x04: level 0 translation fault
>>>>>>> Data abort info:
>>>>>>>       ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>>>>       CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>>>>       GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>>>> [00000000000003e8] user address but active_mm is swapper
>>>>>>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>>>> Modules linked in:
>>>>>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
>>>>>>> Hardware name: Hardkernel ODROID-M1 (DT)
>>>>>>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>>> pc : devm_kmalloc+0x2c/0x114
>>>>>>> lr : rk_iommu_of_xlate+0x30/0x90
>>>>>>> ...
>>>>>>> Call trace:
>>>>>>>      devm_kmalloc+0x2c/0x114 (P)
>>>>>>>      rk_iommu_of_xlate+0x30/0x90
>>>>>>
>>>>>> Yeah, looks like this is doing something a bit questionable which
>>>>>> can't
>>>>>> work properly. TBH the whole dma_dev thing could probably be
>>>>>> cleaned up
>>>>>> now that we have proper instances, but for now does this work?
>>>>>
>>>>> Yes, this patch fixes the problem I've observed.
>>>>>
>>>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>
>>>>> BTW, this dma_dev idea has been borrowed from my exynos_iommu driver
>>>>> and
>>>>> I doubt it can be cleaned up.
>>>>
>>>> On the contrary I suspect they both can - it all dates back to when
>>>> we had the single global platform bus iommu_ops and the SoC drivers
>>>> were forced to bodge their own notion of multiple instances, but with
>>>> the modern core code, ops are always called via a valid IOMMU
>>>> instance or domain, so in principle it should always be possible to
>>>> get at an appropriate IOMMU device now. IIRC it was mostly about
>>>> allocating and DMA-mapping the pagetables in domain_alloc, where the
>>>> private notion of instances didn't have enough information, but
>>>> domain_alloc_paging solves that.
>>>
>>> Bah, in fact I think I am going to have to do that now, since although
>>> it doesn't crash, rk_domain_alloc_paging() will also be failing for
>>> the same reason. Time to find a PSU for the RK3399 board, I guess...
>>>
>>> (Or maybe just move the dma_dev assignment earlier to match Exynos?)
>>
>> Well I just found that Exynos IOMMU is also broken on some on my test
>> boards. It looks that the runtime pm links are somehow not correctly
>> established. I will try to analyze this later in the afternoon.
>
> Hmm, I tried to get an Odroid-XU3 up and running, but it seems unable 
> to boot my original 6.14-rc3-based branch - even with the IOMMU driver 
> disabled, it's consistently dying somewhere near (or just after) init 
> with what looks like some catastrophic memory corruption issue - very 
> occasionally it's managed to print the first line of various different 
> panics.
>
> Before that point though, with the IOMMU driver enabled it does appear 
> to show signs of working OK:
>
> [    0.649703] exynos-sysmmu 14650000.sysmmu: hardware version: 3.3
> [    0.654220] platform 14450000.mixer: Adding to iommu group 1
> ...
> [    2.680920] exynos-mixer 14450000.mixer: 
> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42924000
> ...
> [    5.196674] exynos-mixer 14450000.mixer: 
> exynos_iommu_identity_attach: Restored IOMMU to IDENTITY from pgtable 
> 0x42924000
> [    5.207091] exynos-mixer 14450000.mixer: 
> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42884000
>
>
> The multi-instance stuff in probe/release does look a bit suspect, 
> however - seems like the second instance probe would overwrite the 
> first instance's links, and then there would be a double-del() if the 
> device were ever actually released again? I may have made that much 
> more likely to happen, but I suspect it was already possible with 
> async driver probe...

That is really strange. My Odroid XU3 boots fine from commit 
bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path"), 
although the IOMMU seems not to be working correctly. I've tested this 
with 14450000.mixer device (one need to attach HDMI cable to get it 
activated) and it looks that the video data are not being read from 
memory at all (the lack of VSYNC is reported, no IOMMU fault). However, 
from time to time, everything initializes and works properly.

It looks that this is somehow related to the different IOMMU/DMA-mapping 
glue code, as the other boards (ARM64 based) with exactly the same 
Exynos IOMMU driver always work fine. I've tried to figure out what 
actually happens, but so far I didn't get anything for sure. Disabling 
the call to dev->bus->dma_configure(dev) from iommu_init_device() seems 
to be fixing this, but this is almost equal to the revert of the 
$subject patch. I don't get why calling it in iommu_init_device() causes 
problems. It also doesn't look that this is anyhow related to the 
multi-instance stuff, as the same happens if I only leave a single 
exynos-sysmmu instance and its client (only 14450000.mixer device in the 
system).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


