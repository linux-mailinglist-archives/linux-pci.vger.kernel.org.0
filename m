Return-Path: <linux-pci+bounces-33275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA418B17F4C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3FB7ADF27
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222622652D;
	Fri,  1 Aug 2025 09:30:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5221D3F6;
	Fri,  1 Aug 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040641; cv=none; b=nesXReyjGcXw5E4pBeEFYDzZfeItjTk3I6YKs3WtnUQcroaPohbEwhSOunWczUhmojkjKJHS3i5M9rotxk1fCUwGe3vKi3H03pI3Nq5BitE/fe/q3sOKRL4LnfUF7nesYoOPcFqOsX935ZaqViNDHIXpKeUSFp5cDEP2Dl44Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040641; c=relaxed/simple;
	bh=Q/Y0tbgbPrbBf99+QkFEhAXhItdfzeo+28ANDqH73Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajerbiXT701DKS6U0vcmlOMm7jh1XVowCriDSaw16Op000VOsDCowEasWuhayRZEJdA5SgfdDSvX475B4U1hVZr5lItT6Hb0S949ASo+sgkgG1mhFtlYBjnF18o0T4u+CdQLszZGxjL/EihUQMDiY4sfCYr+uvV58EIqtsJhtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9CBD169C;
	Fri,  1 Aug 2025 02:30:30 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC89A3F66E;
	Fri,  1 Aug 2025 02:30:36 -0700 (PDT)
Message-ID: <791e259b-3a57-487d-81ca-9d83f83ad685@arm.com>
Date: Fri, 1 Aug 2025 10:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
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
 <1388fb70-3d2d-4c41-9526-521cb75eb422@arm.com>
 <20250731164420.GW26511@ziepe.ca>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250731164420.GW26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2025 17:44, Jason Gunthorpe wrote:
> On Thu, Jul 31, 2025 at 02:48:23PM +0100, Suzuki K Poulose wrote:
>> On 31/07/2025 13:17, Jason Gunthorpe wrote:
>>> On Wed, Jul 30, 2025 at 11:09:35AM +0100, Suzuki K Poulose wrote:
>>>>>> It is unclear whether devices would need to perform DMA to shared
>>>>>> (unencrypted) memory while operating in this mode, as TLPs with T=1
>>>>>> are generally expected to target private memory.
>>>>>
>>>>> PCI SIG supports it, kernel should support it.
>>>>
>>>> ACK. On Arm CCA, the device can access shared IPA, with T=1 transaction
>>>> as long as the mapping is active in the Stage2 managed by RMM.
>>>
>>> Right, I expect that the T=0 SMMU S2 translation is a perfect subset of
>>> the T=1 S2 rmm translation. At most pages that are not available to
>>> T=0 should be removed when making the subset.
>>
>> Yes, this is what the VMM is supposed to do today, see [0] & [1].
> 
> Okay great!
> 
>>> I'm not sure what the plan is here on ARM though, do you expect to
>>> pre-load the entire T=0 SMMU S2 with the shared IPA aliases and rely
>>> on the GPT for protection or will the hypervisor dynamically change
>>> the T=0 SMMU S2 after each shared/private change? Same question for
>>
>> Yes, share/private transitions do go all the way back to VMM and it
>> is supposed to make the necessary changes to the SMMU S2 (as in [1]).
> 
> Okay, it works, but also why?
> 
>  From a hypervisor perspective when using VFIO I'd like the guestmemfd
> to fix all the physical memory immediately, so the entire physical map
> is fixed and known. Backed by 1G huge pages most likely.
> 
> Is there a reason not to just dump that into the T=0 SMMU using 1G
> huge pages and never touch it again? The GPT provides protection?

That is possible, once we get guest_memfd mmap support merged upstream.
GPT does provide protection. The only caveat is, does the guest_memfd
support this at all ? i.e., shared->private transitions with a shared
mapping in place (Though this is in SMMU only, not the Host CPU
pagetables)


> 
> Sure sounds appealing..
> 
>> As for the RMM S2, the current plan is to re-use the CPU S2 managed
>> by RMM.
> 
> Yes, but my question is if the CPU will be prepopulated
>   
>> Actually it is. But might solve the problem for confidential VMs,
>> where the S2 mapping is kind of pinned.
> 
> Not kind of pinned, it is pinned in the hypervisor..
>   
>> Population of S2 is a bit tricky for CVMs, as there are restrictions
>> due to :
>>    1) Pre-boot measurements
>>    2) Restrictions on modifying the S2 (at least on CCA).
> 
> I haven't dug into any of this, but I'd challenge you to try to make
> it run fast if the guestmemfd has a full fixed address map in 1G pages
> and could just dump them into the RMM efficiently once during boot.
> 
> Perhaps there are ways to optimize the measurements for huge amounts
> of zero'd memory.

There is. We (VMM) can choose not to "measure" the zero'd pages.


>> Filling in the S2, with already populated S2 is complicated for CCA
>> (costly, but not impossible). But the easier way is for the Realm to
>> fault in the pages before they are used for DMA (and S2 mappings can be
>> pinned by the hyp as default). Hence that suggestion.
> 
> I guess, but it's weird, kinda slow, and the RMM can never unfault them..
> 
> How will you reconstruct the 1G huge pages in the S2 if you are only
> populating on faults? Can you really fault the entire 1G page? If so
> why can't it be prepopulated?

It is tricky to prepopulate the 1G page, as parts of the pages may be
"populated" with contents. We can recreate the 1G block mapping by
"FOLD" ing the leaf level tables, all the way upto 1G, after the
mappings are created. We have to do that anyway for CCA.

I think we can go ahead with VMM pre-populating the entire DRAM
and keeping it pinned for DA. Rather than doing this from the
vfio kernel, it could be done by the VMM as it has better knowledge
of the populated contents and map the rest as "unmeasured" 0s.

Suzuki

