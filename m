Return-Path: <linux-pci+bounces-21628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D5A38727
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8816166ACC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C42248A5;
	Mon, 17 Feb 2025 15:00:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2221D58E;
	Mon, 17 Feb 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804455; cv=none; b=tQ2Pev6inBm0q2ZwaV7PUg+iq57RxDcOUfH4x2jww03QoBg4C5VYnPvvaPgpYQoDWvuePFYgiI1S/+pOP/Qbkge9VSGF82DPtLv95aTy0ukWFs1N3ZOIrMMkotGZ3oDHqTRjL/D5aezoOfXXU2DMaFW+bcKJRDkzpZc2boKgLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804455; c=relaxed/simple;
	bh=jMq0rzaJsv+MpOoTrFRgRWYF77w0q1RbPXY+cKmV/mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+KxtSd0WdRlO0MjF2ZIijjOwGIaVakXW21rVBO7je+92SrXqQzW+/DxZPCPk1muzUyaYy4Sweq1KO15FGhflpXsgf3Nby5l4LFCBHvUwD3nQyF3P0PUE470gZJYSDqxqoIhoUA4D4eil4luHemUL/K1Wy8tJpMBoaQJRv42hHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D949C152B;
	Mon, 17 Feb 2025 07:01:11 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CF9D3F6A8;
	Mon, 17 Feb 2025 07:00:49 -0800 (PST)
Message-ID: <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>
Date: Mon, 17 Feb 2025 15:00:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
To: Jason Gunthorpe <jgg@ziepe.ca>
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
References: <cover.1739486121.git.robin.murphy@arm.com>
 <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
 <20250214201435.GF3696814@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250214201435.GF3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2025 8:14 pm, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:
> 
>> much just calling the same path twice. At client driver probe time,
>> dev->driver is obviously set; conversely at device_add(), or a
>> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> 
> Could you put the dev->driver test into iommu_device_use_default_domain()?
> 
> It looks like many of the cases are just guarding that call.
> 
>> should *not* have a driver already, so we can use that as a condition to
>> disambiguate the two cases, and avoid recursing back into the IOMMU core
>> at the wrong times.
> 
> Which sounds like this:
> 
>> +		mutex_unlock(&iommu_probe_device_lock);
>> +		dev->bus->dma_configure(dev);
>> +		mutex_lock(&iommu_probe_device_lock);
>> +	}
> 
> Shouldn't call iommu_device_use_default_domain() ?

Semantically it shouldn't really be called at this stage, but it won't 
be anyway since "to_<x>_driver(NULL)->driver_managed_dma" is not false - 
trouble is it's also not true ;)

> But... I couldn't guess what the problem with calling it is?
> 
> In the not-probed case it will see dev->iommu_group is NULL and succeed.
> 
> The probed case could be prevented by checking dev->iommu_group sooner
> in __iommu_probe_device()?
> 
> Anyhow, the approach seems OK
> 
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 9f4efa8f75a6..42b8f1833c3c 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1619,6 +1619,9 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>>   {
>>   	int err;
>>   
>> +	if (device_iommu_mapped(dev))
>> +		return 0;
> 
> This is unlocked and outside a driver context, it should have a
> comment explaining why races with probe can't happen?

Sure, for now this is more just an opportunistic thing - since we'll now 
expect to come through this path twice, if we see a group assigned then 
we know for sure that someone else already set up the fwspec for that to 
happen, so there's definitely nothing to do here and we can skip 
potentially waiting for iommu_probe_device_lock.

>> +	/*
>> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
>> +	 * is buried in the bus dma_configure path. Properly unpicking that is
>> +	 * still a fairly big job, so for now just invoke the whole thing. Our
>> +	 * bus_iommu_probe() walk may see devices with drivers already bound,
>> +	 * but that must mean they're already configured - either probed by
>> +	 * another IOMMU, or there was no IOMMU for iommu_fwspec_init() to wait
>> +	 * for - so either way we can safely skip this and avoid worrying about
>> +	 * those recursing back here thinking they need a replay call.
>> +	 */
>> +	if (!dev->driver && dev->bus->dma_configure) {
>> +		mutex_unlock(&iommu_probe_device_lock);
>> +		dev->bus->dma_configure(dev);
>> +		mutex_lock(&iommu_probe_device_lock);
>> +	}
>> +
>> +	/*
>> +	 * At this point, either valid devices now have a fwspec, or we can
>> +	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
>> +	 * be present, and that any of their registered instances has suitable
>> +	 * ops for probing, and thus cheekily co-opt the same mechanism.
>> +	 */
>> +	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
>> +	if (!ops)
>> +		return -ENODEV;
>> +
>>   	/* Device is probed already if in a group */
>>   	if (dev->iommu_group)
>>   		return 0;
> 
> This is the test I mean, if iommu_group is set then
> dev->iommu->iommu_dev->ops is supposed to be valid too. It seems like
> it should be done earlier..

Yeah, looking at it now I'm really not sure why this ended up in this 
order - I guess I was effectively adding the dma_configure() call to the 
front of the existing iommu_fwspec_ops() check, and then I moved the 
lockdep_assert() up to make more sense. But then the ops check probably 
should have been after the group check to begin with, for much the same 
reasoning as above. I'll sort that out for v2.

>> +	/*
>> +	 * And if we do now see any replay calls, they would indicate someone
>> +	 * misusing the dma_configure path outside bus code.
>> +	 */
>> +	if (dev_iommu_fwspec_get(dev) && dev->driver)
>> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> 
> WARN_ON_ONCE or dump_stack() to get the stack trace out?

Indeed, hence dev_WARN() (!= dev_warn())

>> @@ -121,6 +121,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>>   	if (!master_np)
>>   		return -ENODEV;
>>   
>> +	if (device_iommu_mapped(dev))
>> +		return 0;
> 
> Same note

Ack.

>> @@ -151,7 +154,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>>   		iommu_fwspec_free(dev);
>>   	mutex_unlock(&iommu_probe_device_lock);
>>   
>> -	if (!err && dev->bus)
>> +	/*
>> +	 * If we have reason to believe the IOMMU driver missed the initial
>> +	 * iommu_probe_device() call for dev, try to fix it up. This should
>> +	 * no longer happen unless of_dma_configure() is being misused.
>> +	 */
>> +	if (!err && dev->driver)
>>   		err = iommu_probe_device(dev);
> 
> This is being conservative? After some time of nobody complaining
> it can be removed?

Indeed I feel sufficiently confident about the ACPI path (which at the 
moment is effectively arm64-only) to remove it from there already, but 
less so about all the assorted DT platforms. That said, I guess adding a 
new dependency on dev->driver here might still represent a change of 
behaviour for the sketchy direct calls of of_dma_configure() outside bus 
code, since in a lot of those the target device doesn't actually have 
its own driver either. Maybe I need to think about this a bit more...

Thanks,
Robin.

