Return-Path: <linux-pci+bounces-28411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C5AC4289
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999403A39A0
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526886D17;
	Mon, 26 May 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjgf5MA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927E2DCBE3;
	Mon, 26 May 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274273; cv=none; b=BtgCFfvfGpH+KG+lnutb+0r7VGGQJY94fM1awP2FTXcMCfNQPHo8bY5AH19cUgF1aLGc5CanuekgoRP8vjMItDTCwFmfoLLvGAHL0y5CO2HsofqWssuVpNcRA/9ehtsmqRyh1h8rS0kCsuOC31X6aibCQ+wJR8+n+tXD4RRTBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274273; c=relaxed/simple;
	bh=VF1GJoLMYENpN/SWYPUyAzq+4f7IakSVH75Hl+zGqIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZI2U4IWDuPe5CsJ38bfSCJ1Be0kWZ2QXOXUIz4X2l71NPyEkwUIjkzYvySroLMqYbUHvhpEdRQamEqHMW7dumbbZIESfq5crw4mpaDmOTnNE4W9OKLvnWLcod9PPOp/TsqpEEehAIElYkXReiBxtc0a31DqenPc+LY8N50TXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjgf5MA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3654C4CEE7;
	Mon, 26 May 2025 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748274272;
	bh=VF1GJoLMYENpN/SWYPUyAzq+4f7IakSVH75Hl+zGqIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mjgf5MA2jyY1ncNYt28XkE5irhhBU88mlMESvdhvJ0bEZFbaCbBWxBXtIXZWtvTTs
	 wGZeoOkcjK9TYykzf5RxDomWczk127Zi5glbXL9wl8pco4NQEz+UCZBtt+z87gkWkq
	 pztomgU48DWcBuU28vz9XHz6wgffkVT2BX7PknbBhG2tpRyh8JRCBQDpyrrA3t4mJd
	 0Q6IYri5oDe4hdMW2lsHpzH+l9QTnkw9fQbmSGAxi5DREY6sfX+O29qHLreOCmpIIA
	 1vT2stJzgd9+YK4yQgh2GOP/KwQg0ohWZc9P/UCwcoTP6Mlr07MVQ9Tj0UdXccSwbW
	 UwwcjaXfFntpw==
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
In-Reply-To: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
Date: Mon, 26 May 2025 21:14:23 +0530
Message-ID: <yq5ah617s7fs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>> 
>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>
>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>
>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>
>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>> configurations to make the assigned device ready to be validated by
>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>
>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>
>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>
>>>>
>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>
>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>> Jason, and make TDX Connect work to verify, so need more time...
>>>
>> 
>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>
> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>

Ok, something like this? and iommufd will call tsm_bind()?

int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
{
	if (!dev_is_pci(dev))
		return -EINVAL;

	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
}
EXPORT_SYMBOL_GPL(tsm_bind);

int tsm_unbind(struct device *dev)
{
	if (!dev_is_pci(dev))
		return -EINVAL;

	return pci_tsm_unbind(to_pci_dev(dev));
}
EXPORT_SYMBOL_GPL(tsm_unbind);


-aneesh

