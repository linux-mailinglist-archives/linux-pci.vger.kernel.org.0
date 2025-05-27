Return-Path: <linux-pci+bounces-28445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7687AC4C3C
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E27C3ABCCC
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E691DFD8B;
	Tue, 27 May 2025 10:25:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9A142E6F
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341539; cv=none; b=krNcF5vkODttQiIaOympoDSsB0wGth4hPMphwdMBZwNXWaqoRgV2pjlKkrBH9WMmTwaTBkWfIN8dLVNLjA3LH7Ud1l3+ckoeXTYfMAemT7exEJ81zuwU8C2BJSu08bq72vTkC8Jr/VrU+IX9ZZsml2IMh9yxMgCsLpBKohGw1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341539; c=relaxed/simple;
	bh=/QgYA5m1tj4fYFiP4hmvase7uXi3+iKyghPscijWHSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahM+K6HQAmy1p+K7mGTvFqui4H0Uznee5Dag+gVm843A4tMt6JHfsyLim1k5d5DMuJ+NDf86UN/SG+PHnNzKohhqPO/U1frnguiocsrcPZbhlGieJjIBq0fN+rNZnRpRfwjKK5TBLxTZyYYn5VLR/Dc0sOdHl8/UGeGkzl67XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7019114BF;
	Tue, 27 May 2025 03:25:21 -0700 (PDT)
Received: from [10.57.46.233] (unknown [10.57.46.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF6FC3F5A1;
	Tue, 27 May 2025 03:25:35 -0700 (PDT)
Message-ID: <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
Date: Tue, 27 May 2025 11:25:34 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
Content-Language: en-GB
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com> <yq5ah617s7fs.fsf@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <yq5ah617s7fs.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2025 16:44, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>
>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>
>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>
>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>
>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>
>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>
>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>
>>>>>
>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>
>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>
>>>
>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>
>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>
> 
> Ok, something like this? and iommufd will call tsm_bind()?

Remember that there may be other devices, AMBA CHI based devices
being assigned. Not sure if they pretend to be PCI or not.

Cheers
Suzuki


> 
> int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
> {
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
> 
> 	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
> }
> EXPORT_SYMBOL_GPL(tsm_bind);
> 
> int tsm_unbind(struct device *dev)
> {
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
> 
> 	return pci_tsm_unbind(to_pci_dev(dev));
> }
> EXPORT_SYMBOL_GPL(tsm_unbind);
> 
> 
> -aneesh


