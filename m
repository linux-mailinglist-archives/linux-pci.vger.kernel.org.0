Return-Path: <linux-pci+bounces-29337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC2AD3B78
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28AE1BA0E9F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FC1A8419;
	Tue, 10 Jun 2025 14:40:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B91D9663;
	Tue, 10 Jun 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566446; cv=none; b=GSoyop82NFW1iCI64ql7eFUE0h5595yXxVkpQvUh4PWuIKga6QCw/euC8D9x/lfli2HXytPTZe/BY+YqFYGdSlAHfy7dhdowxpDeTVT8vTtzd8rlDivAAsmDtliLNQL4531Wx4+jU6rCI0Adjk3xt5/0E4NqQTl7XAJsNfhSuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566446; c=relaxed/simple;
	bh=DzZVmglec9q7k00c2GslMflWVP8EzyraC82JMED2rUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObHQUvTKQTeuYA4f/i/q+PLFlsrhk8dcmP3Lp8+9+JEPJHreg0NXX2oXPKU1WkEWX8QrPvY+QoODiV/IgELIxjVdbXLIFqaXrIlUuqUD+FMPLINuAR7TwfDqu7SkT8WxWEXLxkq7tq0HnAJzM9QVdXvUpZhF343E8kLeuW/U/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8946214BF;
	Tue, 10 Jun 2025 07:40:24 -0700 (PDT)
Received: from [10.57.79.109] (unknown [10.57.79.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215FD3F673;
	Tue, 10 Jun 2025 07:40:42 -0700 (PDT)
Message-ID: <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
Date: Tue, 10 Jun 2025 15:40:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 bhelgaas@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com> <20250610130416.GC543171@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250610130416.GC543171@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-10 2:04 pm, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 12:07:00AM -0700, Nicolin Chen wrote:
>> On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
>>> On 6/10/25 02:45, Nicolin Chen wrote:
>>>> +	ops = dev_iommu_ops(dev);
>>>
>>> Should this be protected by group->mutext?
>>
>> Not seemingly, but should require the iommu_probe_device_lock I
>> think.
> 
> group and ops are not permitted to change while a driver is attached..
> 
> IIRC the FLR code in PCI doesn't always ensure that (due to the sysfs
> paths), so yeah, this looks troubled. iommu_probe_device_lock perhaps
> would fix it.

No, iommu_probe_device_lock is for protecting access to dev->iommu in 
the probe path until the device is definitively assigned to a group (or 
not). Fundamentally it defends against multiple sources triggering a 
probe of the same device in parallel - once the device *is* probed it is 
no longer relevant, and the group mutex is the right thing to protect 
all subsequent operations.

Also I'm still working towards getting rid of iommu_probe_device_lock as 
soon as I can because it's horrid... I now have most of a plan for 
making it safe to rely on device_lock() for probe, which should nicely 
solve the dev->driver races as well.

Thanks,
Robin.

