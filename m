Return-Path: <linux-pci+bounces-28648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CBAC7EC2
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0780CA201AF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7828F4;
	Thu, 29 May 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Qan5EH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0682110;
	Thu, 29 May 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525659; cv=none; b=R4fN0pN53EesjyrEguof+sr/p6djkfzZVafXZKgTH/nA0rePZ/cGuhjykBlHTBATs6qq24lVpWZU1oKtHFk4miVnuRxtgvLgSdUpK43dSL/C94I0qbQuXVqT3ECY3w8r8Yxhe+YevHv7WigVJRRz7K2pDwF6iZ0jA0/Vai9NA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525659; c=relaxed/simple;
	bh=gGrPcUbjKM6TOgRqHUDQ5O4yAB1Xa1r59brAeraY4Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQDNrmag2cZ7te5ask/ay4AXx/gQWjx1qk78rHg04kXzWH6Y7oJW73kcTJoMSROtDpPLLsi5L85HnlbsLMw0drDbvktQEBnHu810P3P4t/95UQi3Y2U8IRHGFH3+37b6wFTQRotAgmbVc5fyxWK+N67culmOJHAlT/D4wQg+N28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Qan5EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7988CC4CEE7;
	Thu, 29 May 2025 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525659;
	bh=gGrPcUbjKM6TOgRqHUDQ5O4yAB1Xa1r59brAeraY4Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V0Qan5EHlAvol6V/NKAopzFvGEhSt7zbvOqq3ktGIGQvCU2Gy1fD/l3XsfyJhf4hZ
	 BUUmCrux3Euu9ytpV+Y/hBxpeSkk7xjKvdbhtvbxmb61kBrbNveb2n4g2y/mpvyWDd
	 8elN/Hz3X2jg+d/arQ+0WKQBKUTtciGsMqn+yDbMEenuN7nQvcoTEEA2sQkK2ECdqX
	 F5zuXrjXf53V9U01hbRBHfqmot9w83HaiqX8lgL/QhQvOCBOMyoo2SOFw1mic3jw8D
	 Y1W09otXsltMpCNuOBRnR8uz5cgr2otN6ROCvrwRSXKXUzDMNB0B9ylbENPEbmweF9
	 O0dWQYgrkTYWA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <b96cb784-6097-49af-ae3c-bf469cd609de@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <b96cb784-6097-49af-ae3c-bf469cd609de@amd.com>
Date: Thu, 29 May 2025 19:04:11 +0530
Message-ID: <yq5a5xhj5yng.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 27/5/25 21:48, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@amd.com> writes:
>> 
>>> On 27/5/25 01:44, Aneesh Kumar K.V wrote:
>>>> Alexey Kardashevskiy <aik@amd.com> writes:
>>>>
>>>>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>
>>>>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>>>
>>>>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>>>>
>>>>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>>>>
>>>>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>>>>
>>>>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>>>>
>>>>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>>>>
>>>>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>>>>
>>>>>>
>>>>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>>>>
>>>>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>>>>
>>>>
>>>> Ok, something like this? and iommufd will call tsm_bind()?
>>>
>>> yeah, I guess, there is a couple of places like this
>>>
>>> git grep pci_dev drivers/iommu/iommufd/
>>>
>>> drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
>>> drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>>>
>>> Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
>> 
>> Getting the kvm reference is tricky here. Also the locking while
>> updating vdevice->tsm_bound needs some solution. Here is what I am
>> improving. Are you also planning something similar?
>
>
> At the moment I am planning getting/holding the KVM reference in the TSM:
>
> https://lore.kernel.org/r/20250218111017.491719-15-aik@amd.com
>
> but may push it even further to the AMD TSM (CCP, the firmware driver) as this where I actually need the kvm struct to get GCTX+ASID from kvm_svm; Intel folks have a similar intimate knowledge sharing between kvm_intel and TDX-connect. Thanks,

So you won't be able to work with already available kvm reference in
viommu alloc? I will send the tsm_bind changes i have done so that we
can share the diff against that with explanation of why things can't
work that way?

-aneesh

