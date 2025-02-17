Return-Path: <linux-pci+bounces-21637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC4A38926
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3FD7A37EC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3D225766;
	Mon, 17 Feb 2025 16:30:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24852225783;
	Mon, 17 Feb 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809806; cv=none; b=FZGBgPQPUhnGovGu6gkLYaULWkf7K4192BMxoX4rKPFomhP64M4CTqHm7sGd+Ft/gVw8AgALlRDvekc9cN4XjW4Vsc6IDEKyiNlQs3nDD7e/w3ko4vLDt/jp7oKMZ4pf/ig7+novEl2KkRAUWzbyuAsbHkhrh6PMnAZGLCFGjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809806; c=relaxed/simple;
	bh=1ET7ngNwdP/7uhiBrI0skP0NwZt8InzQ+yuq7r3vEOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWgQyjLTtwWGyO/HA8YY0igei7rSBt4KoEOqfaQXUMBC9rEMVXmjy7G0JVOOMSTEEkltxT1sv32lfSNO6cp7nrsN/2d670HhWPUlbQDQWhiSVChtBZ8+ddRggnwJtywhbG9EE5OqBF/NKCF84zz9yurI2kPuwO6mwu4qV5/3KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C364152B;
	Mon, 17 Feb 2025 08:30:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766D73F5A1;
	Mon, 17 Feb 2025 08:29:54 -0800 (PST)
Message-ID: <f882ec8a-c577-4487-bf46-8c406c60aa67@arm.com>
Date: Mon, 17 Feb 2025 16:29:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Handle race with default domain setup
To: Charan Teja Kalla <quic_charante@quicinc.com>,
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
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <cover.1739486121.git.robin.murphy@arm.com>
 <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
 <2a090f80-e145-410d-8d02-efdaf324c8c9@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2a090f80-e145-410d-8d02-efdaf324c8c9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2025 12:57 pm, Charan Teja Kalla wrote:
> Thanks a lot for posting these patches, Robin.
> 
> On 2/14/2025 5:18 AM, Robin Murphy wrote:
>>   drivers/iommu/iommu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 870c3cdbd0f6..2486f6d6ef68 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3097,6 +3097,11 @@ int iommu_device_use_default_domain(struct device *dev)
>>   		return 0;
>>   
>>   	mutex_lock(&group->mutex);
>> +	/* We may race against bus_iommu_probe() finalising groups here */
>> +	if (!group->default_domain) {
>> +		ret = -EPROBE_DEFER;
>> +		goto unlock_out;
>> +	}
> 
> We just hit the issue again even after picking up this patch, though
> very hard to reproduce, on 6.6 LTS.
> 
> After code inspection, it seems the issue is that - default domain is
> setup in the bus_iommu_probe() before hitting of this replay.
> 
> A:async client probe in platform_dma_configure(), B:bus_iommu_probe() :-
> 
> 1) A: sets up iommu_fwspec under iommu_probe_device_lock.
> 
> 2) B: Sets the dev->iommu_group under iommu_probe_device_lock. Domain
> setup is deferred.
> 
> 3) A: Returns with out allocating the default domain, as
> dev->iommu_group is set, whose checks are also made under the same
> 'iommu_probe_device_lock'. __This miss setting of the valid dev->dma_ops__.
> 
> 4) B: Sets up the group->default_domain under group->mutex.
> 
> 5) A: iommu_device_use_default_domain(): Relies on this
> group->default_domain, under the same mutex, to decide if need to go for
> replay, which is skipped. This is skipping the setting up of valid
> dma_ops and that's an issue.
> 
> But I don't think that the same issue exists on 6.13 because of your
> patch, b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()").
> bus_iommu_probe():
>       list_for_each_entry_safe(group, next, &group_list, entry) {
> 		mutex_lock(&group->mutex);
> 		for_each_group_device(group, gdev)
> 			iommu_setup_dma_ops(gdev->dev);
> 		mutex_unlock(&group->mutex);
>       }
> 
> This makes the step4 above force to use the valid dma_iommu api, thus I
> see no issue when there is no probe deferral.
> 
> So, I think we are good with this patch on 6.13.
> 
> Now coming back to 6.6 LTS, any ideas you have here, please?

Thanks for the analysis once again! I've not looked closely at 6.6 yet, 
but if we're all happy this looks like the right fix for mainline then 
I'll start having a look at the backport as soon as I can (so much for 
hoping it would be simple...)

Cheers,
Robin.

> 
>>   	if (group->owner_cnt) {
>>   		if (group->domain != group->default_domain || group->owner ||
>>   		    !xa_empty(&group->pasid_array)) {
> 
> 
> Thanks,
> Charan

