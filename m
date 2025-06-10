Return-Path: <linux-pci+bounces-29345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C9AD3EFB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C82B1881634
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB2241122;
	Tue, 10 Jun 2025 16:31:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3F2356A2;
	Tue, 10 Jun 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573074; cv=none; b=f2PRHpHpynn6U3b5ussYqADqeJUPU7CI4ePQ0Pzags6ULrpRai64lb0eOAcxpH3bPF3dMP33BhC4utn3neoSU2wcBNz3EMm6u/acEGSkgyWrOXxOnceCY+YtoBhqOgYNUIifbRWEHhUw/xQeN2+x/8F3HWmySpu1uuPEHfZFxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573074; c=relaxed/simple;
	bh=F5xlE2EujIwTysz180YfE4hRvqugMR5h8O/RMB/zU2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZy/zw/ZoCK2Re3bVJDVwcxmDJJmQb0gMdtIdPuAtMvBkC8YDMiht2D2A+V6dbDpFe2LT8Cg+JIaE7+DaaVMUURPd3WnPAyIFtm1VHQxHpCRwWkdI7fss4Pgbp7+dJUBJnXXAfldC5JhW9q/MYXb/IE9I2cfGFdd4YMvPywlLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E640814BF;
	Tue, 10 Jun 2025 09:30:52 -0700 (PDT)
Received: from [10.57.79.109] (unknown [10.57.79.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BB1C3F673;
	Tue, 10 Jun 2025 09:31:10 -0700 (PDT)
Message-ID: <f66bf027-5dbb-473b-b57f-ed3ed7914800@arm.com>
Date: Tue, 10 Jun 2025 17:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com> <20250610130416.GC543171@nvidia.com>
 <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
 <20250610153646.GH543171@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250610153646.GH543171@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-10 4:36 pm, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 03:40:40PM +0100, Robin Murphy wrote:
>> On 2025-06-10 2:04 pm, Jason Gunthorpe wrote:
>>> On Tue, Jun 10, 2025 at 12:07:00AM -0700, Nicolin Chen wrote:
>>>> On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
>>>>> On 6/10/25 02:45, Nicolin Chen wrote:
>>>>>> +	ops = dev_iommu_ops(dev);
>>>>>
>>>>> Should this be protected by group->mutext?
>>>>
>>>> Not seemingly, but should require the iommu_probe_device_lock I
>>>> think.
>>>
>>> group and ops are not permitted to change while a driver is attached..
>>>
>>> IIRC the FLR code in PCI doesn't always ensure that (due to the sysfs
>>> paths), so yeah, this looks troubled. iommu_probe_device_lock perhaps
>>> would fix it.
>>
>> No, iommu_probe_device_lock is for protecting access to dev->iommu in the
>> probe path until the device is definitively assigned to a group (or not).
>> Fundamentally it defends against multiple sources triggering a probe of the
>> same device in parallel - once the device *is* probed it is no longer
>> relevant, and the group mutex is the right thing to protect all subsequent
>> operations.
> 
> Yes, adding iommu_probe_device_lock to iommu_deinit_device() would be
> gross.
> 
> but something is required to protect the load of
> dev->iommu_group.. dev->iommu_group->mutex can't protect itself
> against a race UAF on deinit.

Then you do iommu_group_get/put() around it as well. And I suppose 
technically you also ought to check that the device is still actually in 
the group once you have acquired the mutex (although perhaps that case 
ends up crashing anyway once we proceed to attempting to reset the 
already-disappeared device itself...)

> READ_ONCE is good enough to protect from races with the probe path, no
> need for iommu_probe_device_lock there.
> 
> In this case need to look at the PCI sysfs for races against the
> iommu_release_device()/etc that is freeing the dev->iommu_group.
> 
> Maybe the sysfs is always removed before we get to release. Or maybe
> the PCI FLR sysfs code should hold the device_lock..

 From a quick skim I suspect it's probably OK - at least device_del() 
gets to bus_remove_device()->device_remove_groups() well enough before 
the BUS_NOTIFY_REMOVED_DEVICE call that triggers iommu_release_device().

And on an unrelated thought that's just come to mind, if we ever did FLR 
with PASIDs enabled, presumably that's going to wipe out the PASID 
configuration, so will the caller who requested the reset actually 
expect the attachments at the IOMMU end to be preserved, or would they 
assume to start over from scratch? Seems like there's not necessarily 
one right answer there :/

Thanks,
Robin.

