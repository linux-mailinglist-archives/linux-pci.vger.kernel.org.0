Return-Path: <linux-pci+bounces-29250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F10AD2453
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CF3A3FA3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AA1DDC18;
	Mon,  9 Jun 2025 16:43:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E21401C
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487384; cv=none; b=rsL4I+CKzt+fxfFYTZb/ghmD0/0Mo0zrRsb4z6IHfBLyQh+ZtuTEHQGoX/lOqSfhjYuaItCNRP+0PY/RaMpt53r9tfUeU03KYAOvuzv6vbV7e72AetjD26KJVpn+Bm9gqZORi0IMJ6O3mAjKe/62UX+QtnkMvBNspMCU/gwFaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487384; c=relaxed/simple;
	bh=s2upxlrxJ+Rtk9BkE01z5t+cov/SI/oaWOZRvbfxygk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzOLugt+0J1texwoZlKSAK3RFRm9ti5hVNpLZFneJekV/KdpOpuYZAogq7Kve62EBM8BU5Kwb6sSNyEokGKP1kOj3kKQqPMw2bSyrnFmlUfR8tH77HJvQg/jx/MgN9Pjib/Uv9VXDx2cNbqUtx8y5wCZXybCmNaC+Yps4vtcRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15E9114BF;
	Mon,  9 Jun 2025 09:42:43 -0700 (PDT)
Received: from [10.57.48.120] (unknown [10.57.48.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 697183F673;
	Mon,  9 Jun 2025 09:43:00 -0700 (PDT)
Message-ID: <0e313cc0-b673-4d13-ab22-741c7fde39df@arm.com>
Date: Mon, 9 Jun 2025 17:42:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Content-Language: en-GB
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, lukas@wunner.de, sameo@rivosinc.com,
 zhiw@nvidia.com
References: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org> <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org> <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com> <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <20250604123118.GE5028@nvidia.com> <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
 <20250605145435.GA19710@nvidia.com> <aEZ65MtawOTjGZ9R@yilunxu-OptiPlex-7050>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aEZ65MtawOTjGZ9R@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2025 07:10, Xu Yilun wrote:
> On Thu, Jun 05, 2025 at 11:54:35AM -0300, Jason Gunthorpe wrote:
>> On Thu, Jun 05, 2025 at 11:25:29AM +0800, Xu Yilun wrote:
>>
>>> That's good point, thanks. S-EPT is controlled by TSM, but the fact is,
>>> unlike RMP it needs too much help from VMM side, and now KVM is the
>>> helper. I will continue to investigate if TDX TSM driver could opt in to
>>> become another helper and how to coordinate with KVM.
>>
>> I think it would be quite a simplification if the iommufd operation
>> would also cause the TSM to setup the secure MMIO directly from the
>> pPCI device and remove hypervisor access to it.
>>
>> Then you don't need DMABUF to KVM at all.
> 
> I thought about this for sometime. It may be possible to trigger KVM
> to populate/zap the S-EPT but cannot let TSM direct setup/remove S-EPT.
> RMP could be updated by a single instruction, but S-EPT update involves
> generic KVM MMU flow like Page Table Page management, TLB invalidation,
> even mirror EPT management (specific to x86 KVM MMU).
> 
> To make KVM populate S-EPT, we need KVM memory slots and in turn need
> DMABUF.

May be this is answered/discussed already, but why can't we use 
(vfio->fd, offset) similar to the gmem_fd for KVM memory slot ? VFIO 
could prevent mmap if the device is bound and also pervent bind, when 
there is a mapping ?

Suzuki


> 
> Thanks,
> Yilun
> 
>>
>> The create vPCI call would have to specify the base virtual addresses
>> of all the BARs from userspace, which is probably OK as I suspose you
>> also cannot disable or relocate the MMIO BAR while in T=1 mode.
>>
>> Jason


