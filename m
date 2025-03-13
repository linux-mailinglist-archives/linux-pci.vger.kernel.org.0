Return-Path: <linux-pci+bounces-23634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74236A5F75C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D561667BD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D5267B6A;
	Thu, 13 Mar 2025 14:12:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB881266EFF;
	Thu, 13 Mar 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875134; cv=none; b=qMpog+JtX3nsM7nkTalET23Yx9gL8EnzhGYOzN1xUJY3ohA+EkXrfleFHYfWx3y0ZKQb9k9tqWiz0Osx/E/YFnDelymELEA1Q6rwGs3k3FanqvVB9SMEXSYudAV07CcMDx2EkizJ5PkplKXgWN7gYxZ7ZYtUXFoC/pdPV3KVWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875134; c=relaxed/simple;
	bh=5xjCj3Uau/X756VnrbDbtV6ePBK/IMHky7tHSrV01Rc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cMMoL+MQ4lnElpSWTEYbaE9KosexpVtncyeDXeMjhupVKBh03nxlcqvnE/SREEPJECslWG/dj+A0+FZjKuw5nMYuySnJUvenQBa5YgoOuBVzLhNJRRHHhwZWJrNGUX6PEWmTbIlOnhD9cSyXDqgx+eNKh17cjQf3iJCMGVbJN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745B3150C;
	Thu, 13 Mar 2025 07:12:22 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7F23F694;
	Thu, 13 Mar 2025 07:12:07 -0700 (PDT)
Message-ID: <b63ff6b4-9dc3-42ea-8b87-d4fdead8d0eb@arm.com>
Date: Thu, 13 Mar 2025 14:12:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
From: Robin Murphy <robin.murphy@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
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
Content-Language: en-GB
In-Reply-To: <016bb7ca-f0d3-464e-ac74-46e6f78e90d7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-13 1:06 pm, Robin Murphy wrote:
> On 2025-03-13 12:23 pm, Marek Szyprowski wrote:
>> On 13.03.2025 12:01, Robin Murphy wrote:
>>> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
>>> [...]
>>>> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
>>>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my 
>>>> tests I
>>>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>>>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>>>> relevant kernel log:
>>>
>>> ...and the bug-flushing-out begins!
>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>> 00000000000003e8
>>>> Mem abort info:
>>>>      ESR = 0x0000000096000004
>>>>      EC = 0x25: DABT (current EL), IL = 32 bits
>>>>      SET = 0, FnV = 0
>>>>      EA = 0, S1PTW = 0
>>>>      FSC = 0x04: level 0 translation fault
>>>> Data abort info:
>>>>      ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>> [00000000000003e8] user address but active_mm is swapper
>>>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>> Modules linked in:
>>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
>>>> Hardware name: Hardkernel ODROID-M1 (DT)
>>>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : devm_kmalloc+0x2c/0x114
>>>> lr : rk_iommu_of_xlate+0x30/0x90
>>>> ...
>>>> Call trace:
>>>>     devm_kmalloc+0x2c/0x114 (P)
>>>>     rk_iommu_of_xlate+0x30/0x90
>>>
>>> Yeah, looks like this is doing something a bit questionable which can't
>>> work properly. TBH the whole dma_dev thing could probably be cleaned up
>>> now that we have proper instances, but for now does this work?
>>
>> Yes, this patch fixes the problem I've observed.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> BTW, this dma_dev idea has been borrowed from my exynos_iommu driver and
>> I doubt it can be cleaned up.
> 
> On the contrary I suspect they both can - it all dates back to when we 
> had the single global platform bus iommu_ops and the SoC drivers were 
> forced to bodge their own notion of multiple instances, but with the 
> modern core code, ops are always called via a valid IOMMU instance or 
> domain, so in principle it should always be possible to get at an 
> appropriate IOMMU device now. IIRC it was mostly about allocating and 
> DMA-mapping the pagetables in domain_alloc, where the private notion of 
> instances didn't have enough information, but domain_alloc_paging solves 
> that.

Bah, in fact I think I am going to have to do that now, since although 
it doesn't crash, rk_domain_alloc_paging() will also be failing for the 
same reason. Time to find a PSU for the RK3399 board, I guess...

(Or maybe just move the dma_dev assignment earlier to match Exynos?)

Thanks,
Robin.

