Return-Path: <linux-pci+bounces-33245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0AB1724E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC01A7AF035
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5122C159E;
	Thu, 31 Jul 2025 13:48:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC31E502;
	Thu, 31 Jul 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969707; cv=none; b=s5xIaS4kz2ePLg4YE5kLQGo2k7+QTa3k0mQc8qjH1ZlB8vF5t4hesIXMB2m2P3iD2b5jWmzRglmAL7FJYIJEp1f/UH4bhEY7woTPqSlGwjdgwJh2ZZSK1P+2AcNgMIUEwDSJ1Zhphlx5J/TCL72ecfAeMdLPc3udRG1bpZqsVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969707; c=relaxed/simple;
	bh=NloZ91FtjGRUUfozNMTh9M6AUWMCMkA/ecwZ7j8+wBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/lQvBpdghtJjZb+jQ/Nw5/UtWaG+tI0tGC4/B5/9TTE2Ftpe0Rs/pYe9DYJOkQzjy5U5zQsyFGNTm2VP1k2DJgJ+7R9HU5B3ZmCMREWMCUp9Vc3pW5vvLvRZdNoL4IY8b2fn4YPySjW3OB4ek5qnWFz3e3Le+WHZ0GUluT9p8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C03181D13;
	Thu, 31 Jul 2025 06:48:17 -0700 (PDT)
Received: from [10.57.3.194] (unknown [10.57.3.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0A433F66E;
	Thu, 31 Jul 2025 06:48:23 -0700 (PDT)
Message-ID: <1388fb70-3d2d-4c41-9526-521cb75eb422@arm.com>
Date: Thu, 31 Jul 2025 14:48:23 +0100
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev,
 kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca> <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>
 <20250731121740.GQ26511@ziepe.ca>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250731121740.GQ26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2025 13:17, Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 11:09:35AM +0100, Suzuki K Poulose wrote:
>>>> It is unclear whether devices would need to perform DMA to shared
>>>> (unencrypted) memory while operating in this mode, as TLPs with T=1
>>>> are generally expected to target private memory.
>>>
>>> PCI SIG supports it, kernel should support it.
>>
>> ACK. On Arm CCA, the device can access shared IPA, with T=1 transaction
>> as long as the mapping is active in the Stage2 managed by RMM.
> 
> Right, I expect that the T=0 SMMU S2 translation is a perfect subset of
> the T=1 S2 rmm translation. At most pages that are not available to
> T=0 should be removed when making the subset.

Yes, this is what the VMM is supposed to do today, see [0] & [1].

> 
> I'm not sure what the plan is here on ARM though, do you expect to
> pre-load the entire T=0 SMMU S2 with the shared IPA aliases and rely
> on the GPT for protection or will the hypervisor dynamically change
> the T=0 SMMU S2 after each shared/private change? Same question for

Yes, share/private transitions do go all the way back to VMM and it
is supposed to make the necessary changes to the SMMU S2 (as in [1]).

> the RMM S2?
> 

As for the RMM S2, the current plan is to re-use the CPU S2 managed
by RMM.

> The first option sounds fairly appealing, IMHO
> 
>> Rather than mapping the entire memory from the host, it would be ideal
>> if the Coco vms have some sort of a callback to "make sure the DMA
>> wouldn't fault for a device".
> 
> Isn't that a different topic? For right now we expect that all pages
> are pinned and loaded into both S2s. Upon any private/shared

Actually it is. But might solve the problem for confidential VMs,
where the S2 mapping is kind of pinned.

Population of S2 is a bit tricky for CVMs, as there are restrictions
due to :
   1) Pre-boot measurements
   2) Restrictions on modifying the S2 (at least on CCA).

Thus, "the preload S2 and pin" must be done, after the "Initial images 
are loaded". And that becomes tricky from the Hypervisor (thinking of 
this, the VMM may be able to do this properly, as long as it remembers
which areas where loaded).

Filling in the S2, with already populated S2 is complicated for CCA
(costly, but not impossible). But the easier way is for the Realm to
fault in the pages before they are used for DMA (and S2 mappings can be
pinned by the hyp as default). Hence that suggestion.

Suzuki

[0] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/7c34972ddc
[1] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/ab4e654c4

> conversion the pages should be reloaded into the appropriate S2s if
> required. The VM never needs to tell the hypervisor that it wants to
> do DMA.

> 
> There are all sorts of options here to relax this but exploring them
> it an entirely different project that CCA, IMHO.
> 
> Jason


