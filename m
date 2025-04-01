Return-Path: <linux-pci+bounces-25098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D9A78357
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 22:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B03F1628EA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9ED20E703;
	Tue,  1 Apr 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SSuFcG0F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1320B81D
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539690; cv=none; b=ZXkDBVKr3KFMUss1aXIFIgKCzvpWODnEvIGgtrxxkbpY6HUA9M2XPj0YO96KF0wAnMsNQrRx1+oxJif5fIcjZyTnkrde+eQtVYAlfXhbR56TVKi7zp1oL3zb7ihiW3X6vyDvQpK3poeBOif51eiqcLOSwpuLD1PtVorTu0aF3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539690; c=relaxed/simple;
	bh=5y0j8RkNWMDeG/LqeB5Q+awyT5yqB2yaLvaDNNl6jzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jZPgvJivMl3aYOeqBsGN6O4Tk/1QCojwIb/uWS/o1tF33Jb8BxsenYgrZuUPHQYgXMGiR6sxSfr7KhsQYOblGGpmAYnMmoTNXQ86KUmCIJQ1H5pU4DYo8BlpDNLI20zCEEWwDI8/6A8MSjXcesZbEFggqbb8No1byRdHQ48EBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SSuFcG0F; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250401203446euoutp02e7f119c2adea7208fbcf174aa2ea6646~yTBt4QRNX1770917709euoutp02i
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 20:34:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250401203446euoutp02e7f119c2adea7208fbcf174aa2ea6646~yTBt4QRNX1770917709euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743539686;
	bh=0H8A293uJpSgajdKcRdI/f0ZLs9XeRQ/DZKILdHiCvU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SSuFcG0FILsA6auQw3HwZN2Jh+os1BdnIoCCYxTG56A6qRyHQztPjJhPRkyuGDwJQ
	 rd9HWAq6nxPEPvgLxdM7e3cespBi353rtmB7ieh4AM1Ws9dd1sD/N4luZGdtMEzWxt
	 xZI8BgsJvBWMs1J72g9qi1RsXVFgyfIyGpmYoRiM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250401203445eucas1p140ff2f20263e7a8c112a8470f2cb7ae8~yTBtIOLKq2958829588eucas1p1g;
	Tue,  1 Apr 2025 20:34:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.02.20821.5ED4CE76; Tue,  1
	Apr 2025 21:34:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250401203444eucas1p1e6112a37ce7d27cddf1fd185cdf95a10~yTBr5ij012654626546eucas1p1n;
	Tue,  1 Apr 2025 20:34:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250401203444eusmtrp189dc97ca8dde20072567ddf6741a3947~yTBr3DNxs0963609636eusmtrp1o;
	Tue,  1 Apr 2025 20:34:44 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-b6-67ec4de5c01b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.4D.19920.4ED4CE76; Tue,  1
	Apr 2025 21:34:44 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250401203441eusmtip16b2f51205bda47286f7023a313fdecf7~yTBpdWcE30550505505eusmtip1T;
	Tue,  1 Apr 2025 20:34:41 +0000 (GMT)
Message-ID: <16234667-a9fd-4530-853f-ce594670f5dc@samsung.com>
Date: Tue, 1 Apr 2025 22:34:40 +0200
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
	Yoder <stuyoder@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil
	Agarwal <nikhil.agarwal@amd.com>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Charan Teja Kalla
	<quic_charante@quicinc.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <135390b1-c0c5-4595-a3f3-1fb376473872@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHd3pvbx9JzbWinCCZSeNrJtZ1keZkJQ7dkt0tkjDcMtmWzIZe
	CxktrFf2cLIxaBU7wktBKNKWwmS6IqwUpFhwLbgODdUBY9i4KbOwweymtmyxgoxyceO/z+/7
	+31/j5PDx8QniQR+tvYQrdMqcySEEO/67qF/+2TqXfWzI/ptqLkoC/1Rc49AlgE/FxU3tRHI
	46rjoWgEoeP17TzkmggRqKWvHCDHnTEuGuk5TaAhs49A3upegPRzehzVdkvR7HQNjtosGtQQ
	qcbQgrubhzz3glxk9M4vdvwmgKGWK9040t9MSoFU0GPmUIbheYKym+2AGhn7AaNcpp95lNWR
	T+kHQlzKce44QV1qsPOojubPqN876gBV6f6UCjueThO9JUxW0TnZH9C6HbsOCLP8/ht4nivl
	o7OV6wtBZ5IRCPiQ3Amj314AMRaTXwFoNxw0AuEiRwAcLlvgsEEYQP3ZfvDE8ctEAGMTLQBG
	H9h5bHAfwFbHLBGrEpG7YNmNr7EY4+RGeHlwYFlfDQfrgniM15Ib4K1ALS/Ga8h98E/jryDW
	KI40cGH/lG1pBEZOAtj+4/iSGyPjYSBo4cSYIGXQGDIu6QJSAWv6JrlszQZY3Fm/ZIakUQiL
	uhqXF38Jdji7CJbXwBmfk8dyIrx6ohRnDccAtD66xWGDCgALfwssuxXwpj+66OYvjngGtvXs
	YOXd0BiuxmIyJFfB8dBqdolVsKrr1LIsgiVHxWz1Zmjynf9vrOf6MFYBJKYVD2NacaZpxTmm
	/+daAX4OxNP5jEZNMzIt/aGUUWqYfK1ampmrcYDFj3v1se9BN2iYuS/1Ag4feAHkY5I40f7Z
	abVYpFJ+fJjW5b6ry8+hGS9Yz8cl8SLbJYNaTKqVh+j3aDqP1j3JcviChEJO5mhviKiq2esU
	q2xb6OLr49SZjIuyBKZ9SpftLMveWXhk6P3IXPxshsuxpzPDTb+mTh54u9xi8zGZ8qQFztzz
	J6bWHqivTf9yNFO+rk/+cqOsoGRW+2LT1pOXn/tcIdcfPDoqZATff1L0U3iP+1jJOPeL9qFN
	bzxMuH3GHXlnpnTmzuGs7UcuCNITd9en1G2RTsqaE0WKSlvUbLX35m5umr5yrbdf+6r5hXRx
	9m1nqiqyv7H8bkHr6Z4UTmsVcf51RWnypDOpInFj2iuOiUfBgkGPqlTTKp/CsH5LZVrQ+tSm
	vcb5sXXc6mtbFeG/43KaO9y8N4Opj/MuOv/5S1NmOCXBmSylbBumY5T/AjbMVg0nBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsVy+t/xu7pPfN+kGzx6LGyxpCnD4vW0D2wW
	84+cY7VoXryezeLgzpnsFr++WFh0zt7AbrHz4Vs2i+X7+hktNj2+xmpxedccNouz846zWRya
	upfRouVPC4vFjB16Fl9fTmOxWD8/12Lul6nMFv/37GC3OPjhCatF16G/QBM33mK2WH5qB4tF
	yx1TBwmPJwfnMXm0XvrL5rFm3hpGj8vXLjJ77Jx1l91jwaZSj5Yjb1k9Nq3qZPPYP3cNu8fm
	JfUeLzbPZPSYuKfO4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
	fTublNSczLLUIn27BL2Mc+dushTsdKhYOVG6gXGraRcjJ4eEgInEvYe3mLsYuTiEBJYySjw9
	8JARIiEjcXJaAyuELSzx51oXG0TRe0aJX5+mghXxCthJ9N1czQxiswioSBw9eYQNIi4ocXLm
	ExYQW1RAXuL+rRnsILawQLDEu65HjCCDRAQ6WSV69jwAW80s8JRR4sv5Z6xQd7BKvFn/HayF
	WUBc4taT+UwgNpuAoUTX2y6wFZwC1hLT9j1lhagxk+ja2sUIYctLNG+dzTyBUWgWkktmIRk1
	C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSmmG3Hfm7ewTjv1Ue9Q4xMHIyH
	GCU4mJVEeCO+vkwX4k1JrKxKLcqPLyrNSS0+xGgKDI6JzFKiyfnAJJdXEm9oZmBqaGJmaWBq
	aWasJM7rdvl8mpBAemJJanZqakFqEUwfEwenVAOTSu9PXdHi4xo3Vh+5yTz7Gb+f2xHjTLcy
	DWuJnRVbZp1ikSvlVQzoMb+x+0Nep6PvednfQTpfn9rc9lp2N+upPr/D0ccPxb/sUhYW6/Br
	ubs9vv7ri2fmsX7CE9N4syfsrBJy7mrcF5b6fdImS3tWM2EmbkbfM5vVuDewtyXm8aZsmdh1
	kYth8vYC3+fGXu9Vgl9vkmlbZb2ytIPxAtcNMc+HR9+cbdvb9uPXf/v907MKuD9HJUZFrpxi
	28Opv2q/RvTpfzn9sz78Ode05t6nr6+aQx5zJSj98y97evXPSd/F6hOFRD45n5/yOtFnioJi
	Ee+UTGavPxZeDKvmHj9fcGSW3bkstgPfrLZ+eLBJiaU4I9FQi7moOBEA4Sua07oDAAA=
X-CMS-MailID: 20250401203444eucas1p1e6112a37ce7d27cddf1fd185cdf95a10
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
	<ace3a01f-4700-4455-ada3-0f88fc8ea4cd@samsung.com>
	<135390b1-c0c5-4595-a3f3-1fb376473872@arm.com>

On 21.03.2025 17:48, Robin Murphy wrote:
> On 21/03/2025 12:15 pm, Marek Szyprowski wrote:
>> On 17.03.2025 19:22, Robin Murphy wrote:
>>> On 17/03/2025 7:37 am, Marek Szyprowski wrote:
>>>> On 13.03.2025 15:12, Robin Murphy wrote:
>>>>> On 2025-03-13 1:06 pm, Robin Murphy wrote:
>>>>>> On 2025-03-13 12:23 pm, Marek Szyprowski wrote:
>>>>>>> On 13.03.2025 12:01, Robin Murphy wrote:
>>>>>>>> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
>>>>>>>> [...]
>>>>>>>>> This patch landed in yesterday's linux-next as commit 
>>>>>>>>> bcb81ac6ae3c
>>>>>>>>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my
>>>>>>>>> tests I
>>>>>>>>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>>>>>>>>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>>>>>>>>> relevant kernel log:
>>>>>>>>
>>>>>>>> ...and the bug-flushing-out begins!
>>>>>>>>
>>>>>>>>> Unable to handle kernel NULL pointer dereference at virtual 
>>>>>>>>> address
>>>>>>>>> 00000000000003e8
>>>>>>>>> Mem abort info:
>>>>>>>>>        ESR = 0x0000000096000004
>>>>>>>>>        EC = 0x25: DABT (current EL), IL = 32 bits
>>>>>>>>>        SET = 0, FnV = 0
>>>>>>>>>        EA = 0, S1PTW = 0
>>>>>>>>>        FSC = 0x04: level 0 translation fault
>>>>>>>>> Data abort info:
>>>>>>>>>        ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>>>>>>        CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>>>>>>        GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>>>>>> [00000000000003e8] user address but active_mm is swapper
>>>>>>>>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>>>>>> Modules linked in:
>>>>>>>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ 
>>>>>>>>> #15533
>>>>>>>>> Hardware name: Hardkernel ODROID-M1 (DT)
>>>>>>>>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>>>>> pc : devm_kmalloc+0x2c/0x114
>>>>>>>>> lr : rk_iommu_of_xlate+0x30/0x90
>>>>>>>>> ...
>>>>>>>>> Call trace:
>>>>>>>>>       devm_kmalloc+0x2c/0x114 (P)
>>>>>>>>>       rk_iommu_of_xlate+0x30/0x90
>>>>>>>>
>>>>>>>> Yeah, looks like this is doing something a bit questionable which
>>>>>>>> can't
>>>>>>>> work properly. TBH the whole dma_dev thing could probably be
>>>>>>>> cleaned up
>>>>>>>> now that we have proper instances, but for now does this work?
>>>>>>>
>>>>>>> Yes, this patch fixes the problem I've observed.
>>>>>>>
>>>>>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>>>
>>>>>>> BTW, this dma_dev idea has been borrowed from my exynos_iommu 
>>>>>>> driver
>>>>>>> and
>>>>>>> I doubt it can be cleaned up.
>>>>>>
>>>>>> On the contrary I suspect they both can - it all dates back to when
>>>>>> we had the single global platform bus iommu_ops and the SoC drivers
>>>>>> were forced to bodge their own notion of multiple instances, but 
>>>>>> with
>>>>>> the modern core code, ops are always called via a valid IOMMU
>>>>>> instance or domain, so in principle it should always be possible to
>>>>>> get at an appropriate IOMMU device now. IIRC it was mostly about
>>>>>> allocating and DMA-mapping the pagetables in domain_alloc, where the
>>>>>> private notion of instances didn't have enough information, but
>>>>>> domain_alloc_paging solves that.
>>>>>
>>>>> Bah, in fact I think I am going to have to do that now, since 
>>>>> although
>>>>> it doesn't crash, rk_domain_alloc_paging() will also be failing for
>>>>> the same reason. Time to find a PSU for the RK3399 board, I guess...
>>>>>
>>>>> (Or maybe just move the dma_dev assignment earlier to match Exynos?)
>>>>
>>>> Well I just found that Exynos IOMMU is also broken on some on my test
>>>> boards. It looks that the runtime pm links are somehow not correctly
>>>> established. I will try to analyze this later in the afternoon.
>>>
>>> Hmm, I tried to get an Odroid-XU3 up and running, but it seems unable
>>> to boot my original 6.14-rc3-based branch - even with the IOMMU driver
>>> disabled, it's consistently dying somewhere near (or just after) init
>>> with what looks like some catastrophic memory corruption issue - very
>>> occasionally it's managed to print the first line of various different
>>> panics.
>>>
>>> Before that point though, with the IOMMU driver enabled it does appear
>>> to show signs of working OK:
>>>
>>> [    0.649703] exynos-sysmmu 14650000.sysmmu: hardware version: 3.3
>>> [    0.654220] platform 14450000.mixer: Adding to iommu group 1
>>> ...
>>> [    2.680920] exynos-mixer 14450000.mixer:
>>> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42924000
>>> ...
>>> [    5.196674] exynos-mixer 14450000.mixer:
>>> exynos_iommu_identity_attach: Restored IOMMU to IDENTITY from pgtable
>>> 0x42924000
>>> [    5.207091] exynos-mixer 14450000.mixer:
>>> exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42884000
>>>
>>>
>>> The multi-instance stuff in probe/release does look a bit suspect,
>>> however - seems like the second instance probe would overwrite the
>>> first instance's links, and then there would be a double-del() if the
>>> device were ever actually released again? I may have made that much
>>> more likely to happen, but I suspect it was already possible with
>>> async driver probe...
>>
>> That is really strange. My Odroid XU3 boots fine from commit
>> bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path"),
>> although the IOMMU seems not to be working correctly. I've tested this
>> with 14450000.mixer device (one need to attach HDMI cable to get it
>> activated) and it looks that the video data are not being read from
>> memory at all (the lack of VSYNC is reported, no IOMMU fault). However,
>> from time to time, everything initializes and works properly.
>
> Urgh, seems my mistake was assuming exynos_defconfig was the right 
> thing to begin from - bcb81ac6ae3c with that still dies in the same 
> way (this time I saw a hint of spin_bug() being hit...), however a 
> multi_v7_defconfig build does get to userspace OK again with no 
> obvious signs of distress:
>
> [root@alarm ~]# grep -Hr . /sys/kernel/iommu_groups/*/type
> /sys/kernel/iommu_groups/0/type:identity
> /sys/kernel/iommu_groups/1/type:identity
> /sys/kernel/iommu_groups/10/type:identity
> /sys/kernel/iommu_groups/2/type:identity
> /sys/kernel/iommu_groups/3/type:identity
> /sys/kernel/iommu_groups/4/type:identity
> /sys/kernel/iommu_groups/5/type:identity
> /sys/kernel/iommu_groups/6/type:identity
> /sys/kernel/iommu_groups/7/type:identity
> /sys/kernel/iommu_groups/8/type:identity
> /sys/kernel/iommu_groups/9/type:identity
>
> Annoyingly I do have an adapter for the fiddly micro-HDMI, but it's at 
> home :(
>
>> It looks that this is somehow related to the different IOMMU/DMA-mapping
>> glue code, as the other boards (ARM64 based) with exactly the same
>> Exynos IOMMU driver always work fine. I've tried to figure out what
>> actually happens, but so far I didn't get anything for sure. Disabling
>> the call to dev->bus->dma_configure(dev) from iommu_init_device() seems
>> to be fixing this, but this is almost equal to the revert of the
>> $subject patch. I don't get why calling it in iommu_init_device() causes
>> problems. It also doesn't look that this is anyhow related to the
>> multi-instance stuff, as the same happens if I only leave a single
>> exynos-sysmmu instance and its client (only 14450000.mixer device in the
>> system).
>
> On a hunch I stuck a print in exynos_iommu_probe_device(), and it 
> looks like in fact device_link_add() isn't getting called at all, and 
> indeed your symptoms do sound like they could be explained by the 
> IOMMU not being reliably resumed... lemme stare at 
> exynos_iommu_of_xlate() a bit longer...

Just to let everyone know. The $subject change is okay. This is a bug in 
exynos-iommu driver, fixed by the following patch:

https://lore.kernel.org/all/20250401202731.2810474-1-m.szyprowski@samsung.com/


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


