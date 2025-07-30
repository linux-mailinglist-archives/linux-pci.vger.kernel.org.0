Return-Path: <linux-pci+bounces-33167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C2B15DD4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EC43A3E67
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3426CE1D;
	Wed, 30 Jul 2025 10:09:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A015E96;
	Wed, 30 Jul 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870181; cv=none; b=TikqV5r7jhU/gYkdEqpTmou1vFDNW5gzUslAobC4NVGK64sCWGYhlb3HWiAjVc9FagtQJfuoVekvdJ60lrh6aHwEFOoGu48OXEdPGgAScBRTqPV3PXHxWZj4R+y8CLU4DYjDAko07H7E9SYF+Iyn9CSlDiWuXI3S78CvWLAQLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870181; c=relaxed/simple;
	bh=UCyVpLH87cSFpHt6B2Knjye0VwgeSGRgyWbokISmTG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUSe4TC3PZHSMtF827crdhxmI+JcoTDCzU46oYdj605Qmnk2i3ozzJMk3k5GeHFHj9r7tD+Iz9X+jtpU/5KKjquLUgIcT4Mjq1GkEea/PtfFfPFxPAPG4eOfJOHKOZMUJiLWYVT7GJaXJ5xhDEsto4Y2796mCDJ4ezWM2kF7GzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36201BC0;
	Wed, 30 Jul 2025 03:09:30 -0700 (PDT)
Received: from [10.57.3.117] (unknown [10.57.3.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94F683F673;
	Wed, 30 Jul 2025 03:09:36 -0700 (PDT)
Message-ID: <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>
Date: Wed, 30 Jul 2025 11:09:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca> <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250729143339.GH26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 15:33, Jason Gunthorpe wrote:
> On Tue, Jul 29, 2025 at 01:53:10PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>
>>> On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>>>>   	return crypt_ops->decrypt(addr, numpages);
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(set_memory_decrypted);
>>>> +
>>>> +bool force_dma_unencrypted(struct device *dev)
>>>> +{
>>>> +	if (dev->tdi_enabled)
>>>> +		return false;
>>>
>>> Is this OK? I see code like this:
>>>
>>> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>>> 		phys_addr_t phys)
>>> {
>>> 	if (force_dma_unencrypted(dev))
>>> 		return phys_to_dma_unencrypted(dev, phys);
>>> 	return phys_to_dma(dev, phys);
>>>
>>> What are the ARM rules for generating dma addreses?
>>>
>>> 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
>>>     and do "top bit IBA set"
>>>
>>> 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
>>>
>>> 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
>>>     normally??? Seems odd, I would have guessed the DMA address sould
>>>     be the same as case #1?
>>>
>>> Can you document this in a comment?
>>>
>>
>> If a device is operating in secure mode (T=1), it is currently assumed
>> that only access to private (encrypted) memory is supported.
> 
> No, this is no how the PCI specs were written as far as I
> understand. The XT bit thing is supposed to add more fine grained
> device side control over what memory the DMA can target. T alone does
> not do that.
> 
>> It is unclear whether devices would need to perform DMA to shared
>> (unencrypted) memory while operating in this mode, as TLPs with T=1
>> are generally expected to target private memory.
> 
> PCI SIG supports it, kernel should support it.

ACK. On Arm CCA, the device can access shared IPA, with T=1 transaction
as long as the mapping is active in the Stage2 managed by RMM.

Rather than mapping the entire memory from the host, it would be ideal
if the Coco vms have some sort of a callback to "make sure the DMA
wouldn't fault for a device". e.g, it could be as simple as touching
the page in Arm CCA (GFP_ZERO could do the trick, well one byte
per Granule is good). or an ACCEPT a given page.

Is this a problem for AMDE SNP / Intel TDX ?

Suzuki




> 
> Jason


