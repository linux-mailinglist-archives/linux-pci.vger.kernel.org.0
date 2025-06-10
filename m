Return-Path: <linux-pci+bounces-29342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C106FAD3D9F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381B0179BFD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFE1F4190;
	Tue, 10 Jun 2025 15:38:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBD238C0F;
	Tue, 10 Jun 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569884; cv=none; b=rzHu67eZT+KzMiWIupSe1TUTUzKVp0zknzEj3WKn6qa9BbrRTtQGf+0Uu5zjY9NXIvWRy2ycNUs3s3QY7T1kkANFb4D+IXzA8mzmQjD3ePg+ABXm4aDkwxxPXV+QqVN2E5kss2OJ2K+1qIKocwzoDIOAIq6zg2SFErHNcKRHj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569884; c=relaxed/simple;
	bh=MAQtkSyNTXy0LbYyeAVF2nrjyLBxjjbONOKqNj4bFsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgUn6GsBa0yaSYRG54AFVwtJdqw9y/+J73OHrNA62YT75LelJsnKtsBu8/tQQWWG5jyxkFLEDHHJNRS3AES8mcFsRJ4gk4i/99YlogMDkFblZvA1NSHUVpEe/J5gN2dUGd1J0fV2K1i4vVuU/mN+12JDRYr2ldSKwpr/b80VvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B0F14BF;
	Tue, 10 Jun 2025 08:37:42 -0700 (PDT)
Received: from [10.57.79.109] (unknown [10.57.79.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B708C3F66E;
	Tue, 10 Jun 2025 08:37:59 -0700 (PDT)
Message-ID: <40f1971d-640a-44b4-b798-d1a5844063e2@arm.com>
Date: Tue, 10 Jun 2025 16:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, bhelgaas@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com
References: <cover.1749494161.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <cover.1749494161.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> Hi all,
> 
> Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> before initiating a Function Level Reset, and then ensure no invalidation
> requests being issued to a device when its ATS capability is disabled.

Not really - what it says is that software should not expect to receive 
invalidate completions from a function which is in the process of being 
reset or powered off, and if software doesn't want to be confused by 
that then it should take care to wait for completion or timeout of all 
outstanding requests, and avoid issuing new requests, before initiating 
such a reset or power transition.

> Both pci_enable_ats() and pci_disable_ats() are called by an IOMMU driver,
> but an unsolicited FLR can happen at any time in the PCI layer. This might
> result in a race between them, breaking the rules given by the PCIe Spec.

Can you clarify which rules? The Implementation Note itself is just an 
example of a possible software policy, and explicitly not normative.

> Therefore, there needs to be a sync between IOMMU and PCI subsystems, to
> ensure that ATS will be disabled and never gets re-enabled until the FLR
> finishes. Add a pair of new IOMMU helpers for PCI reset functions to call
> before and after the reset routines. These two helpers will temporally
> attach the device's RID/PASID to IOMMU_DOMAIN_BLOCKED, which should allow
> its IOMMU driver to pause any DMA traffic and disable ATS feature until
> the FLR is done.

FLR must inherently stop the function from issuing any kind of requests 
anyway (see 6.6.2), so "pausing" traffic at the IOMMU end seems like a 
non-issue. I guess I can see how messing with the domain attachment 
underneath the rest of the group manages to prevent new invalidate 
requests from group->domain being issued to the given function, but it's 
pretty horrid - leaving the mutex blocked might be just about tolerable 
for an FLR that's supposed to take no longer than 100ms, but what if we 
do want to do this for suspend/resume as well?

Thanks,
Robin.

> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/iommu_dev_reset-rfcv1
> 
> Thanks
> Nicolin
> 
> Nicolin Chen (2):
>    iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
>    pci: Suspend ATS before doing FLR
> 
>   include/linux/iommu.h |  12 +++++
>   drivers/iommu/iommu.c | 106 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.c     |  42 +++++++++++++++--
>   3 files changed, 156 insertions(+), 4 deletions(-)
> 


