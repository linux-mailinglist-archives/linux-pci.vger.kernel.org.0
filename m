Return-Path: <linux-pci+bounces-25847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3CA88791
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0493218820D2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32A2749F2;
	Mon, 14 Apr 2025 15:38:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8CE252297;
	Mon, 14 Apr 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645098; cv=none; b=me1pDa8eMGB/aHGkh+d9qiSJGZiOfHRDvTe0BNwQU4OpIva5fWFrgBGxNGb4kEOMFaeQKn9ySrwGIVbkuvS7rNJv/3FTFHH/tFLcIrKu4JIz0fo5DyADtDDIJOvh6xkR3ISWTmR6wHNBj64Z8jT9ntQUVfCAwYW9jF/wh66t04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645098; c=relaxed/simple;
	bh=0aZVGbEl/02D251casMOEEUyC3c3T0vU3dfpYMvmlIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk7og3gmia3zpUU6uYpm5h5z0xBajBxjbEi6dLCNxkBLTDQk+l3AJ0+gPPXDbtm2bafy/kq9xBujVdhMaAshMGBQ6Abnrupk0gIS2tyRUIGBxA2HQONLujDoWY+nWV3yMeVmb96mfdpiBo5v42fh9sZDd3tK/YmbwrEF9oZbzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 137701007;
	Mon, 14 Apr 2025 08:38:13 -0700 (PDT)
Received: from [192.168.1.102] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7993F66E;
	Mon, 14 Apr 2025 08:38:10 -0700 (PDT)
Message-ID: <50a06ba8-0a99-40d2-8601-778ebf451f6a@arm.com>
Date: Mon, 14 Apr 2025 16:37:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Johan Hovold <johan@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z_jMiC1uj_MJpKVj@hovoldconsulting.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z_jMiC1uj_MJpKVj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-11 9:02 am, Johan Hovold wrote:
> Hi Robin,
> 
> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
>> In hindsight, there were some crucial subtleties overlooked when moving
>> {of,acpi}_dma_configure() to driver probe time to allow waiting for
>> IOMMU drivers with -EPROBE_DEFER, and these have become an
>> ever-increasing source of problems. The IOMMU API has some fundamental
>> assumptions that iommu_probe_device() is called for every device added
>> to the system, in the order in which they are added. Calling it in a
>> random order or not at all dependent on driver binding leads to
>> malformed groups, a potential lack of isolation for devices with no
>> driver, and all manner of unexpected concurrency and race conditions.
>> We've attempted to mitigate the latter with point-fix bodges like
>> iommu_probe_device_lock, but it's a losing battle and the time has come
>> to bite the bullet and address the true source of the problem instead.
> 
>> @@ -426,6 +438,12 @@ static int iommu_init_device(struct device *dev)
>>   		ret = -ENODEV;
>>   		goto err_free;
>>   	}
>> +	/*
>> +	 * And if we do now see any replay calls, they would indicate someone
>> +	 * misusing the dma_configure path outside bus code.
>> +	 */
>> +	if (dev->driver)
>> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
>>   
>>   	if (!try_module_get(ops->owner)) {
>>   		ret = -EINVAL;
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index e10a68b5ffde..6b989a62def2 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>>   		dev_iommu_free(dev);
>>   	mutex_unlock(&iommu_probe_device_lock);
>>   
>> -	if (!err && dev->bus)
>> +	/*
>> +	 * If we're not on the iommu_probe_device() path (as indicated by the
>> +	 * initial dev->iommu) then try to simulate it. This should no longer
>> +	 * happen unless of_dma_configure() is being misused outside bus code.
>> +	 */
> 
> This assumption does not hold as there is nothing preventing iommu
> driver probe from racing with a client driver probe.

Not sure I follow - *this* assumption is that if we arrived here with 
dev->iommu already allocated then __iommu_probe_device() is already in 
progress for this device, either in the current callchain or on another 
thread, and so we can (and should) skip calling into it again. There's 
no ambiguity about that.

>> +	if (!err && dev->bus && !dev_iommu_present)
>>   		err = iommu_probe_device(dev);
>>   
>>   	if (err && err != -EPROBE_DEFER)
> 
> I hit the (now moved) dev_WARN() on the ThinkPad T14s where the GPU SMMU
> is probed late due to a clock dependency and can end up probing in
> parallel with the GPU driver.

And what *should* happen is that the GPU driver probe waits for the 
IOMMU driver probe to finish. Do you have fw_devlink enabled?

> [    3.805282] arm-smmu 3da0000.iommu: probing hardware configuration...
> [    3.806007] arm-smmu 3da0000.iommu: SMMUv2 with:
> [    3.806843] arm-smmu 3da0000.iommu:  stage 1 translation
> [    3.807562] arm-smmu 3da0000.iommu:  coherent table walk
> [    3.808253] arm-smmu 3da0000.iommu:  stream matching with 24 register groups
> [    3.808957] arm-smmu 3da0000.iommu:  22 context banks (0 stage-2 only)
> [    3.809651] arm-smmu 3da0000.iommu:  Supported page sizes: 0x61311000
> [    3.810339] arm-smmu 3da0000.iommu:  Stage-1: 48-bit VA -> 40-bit IPA
> [    3.811130] arm-smmu 3da0000.iommu:  preserved 0 boot mappings
> 
> [    3.829042] platform 3d6a000.gmu: Adding to iommu group 8
> 
> [    3.992050] ------------[ cut here ]------------
> [    3.993045] adreno 3d00000.gpu: late IOMMU probe at driver bind, something fishy here!
> [    3.994058] WARNING: CPU: 9 PID: 343 at drivers/iommu/iommu.c:579 __iommu_probe_device+0x2b0/0x4ac
> 
> [    4.003272] CPU: 9 UID: 0 PID: 343 Comm: kworker/u50:2 Not tainted 6.15.0-rc1 #109 PREEMPT
> [    4.003276] Hardware name: LENOVO 21N2ZC5PUS/21N2ZC5PUS, BIOS N42ET83W (2.13 ) 10/04/2024
> 
> [    4.025943] Call trace:
> [    4.025945]  __iommu_probe_device+0x2b0/0x4ac (P)
> [    4.030453]  iommu_probe_device+0x38/0x7c
> [    4.030455]  of_iommu_configure+0x188/0x26c
> [    4.030457]  of_dma_configure_id+0xcc/0x300
> [    4.030460]  platform_dma_configure+0x74/0xac
> [    4.030462]  really_probe+0x74/0x38c

Indeed this is exactly what is *not* supposed to be happening - does 
this patch help at all?

https://lore.kernel.org/linux-iommu/09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com/

If not then I guess I do need to do something to explicitly distinguish 
the "iommu_device_register() is still running" state after all...

Thanks,
Robin.

> [    4.030464]  __driver_probe_device+0x7c/0x160
> [    4.030465]  driver_probe_device+0x40/0x110
> [    4.030467]  __device_attach_driver+0xbc/0x158
> [    4.030468]  bus_for_each_drv+0x84/0xe0
> [    4.030470]  __device_attach+0xa8/0x1d4
> [    4.030472]  device_initial_probe+0x14/0x20
> [    4.030473]  bus_probe_device+0xb0/0xb4
> [    4.030476]  deferred_probe_work_func+0xa0/0xf4
> 
> [    4.030501] ---[ end trace 0000000000000000 ]---
> [    4.031269] adreno 3d00000.gpu: Adding to iommu group 9
> 
> Johan


