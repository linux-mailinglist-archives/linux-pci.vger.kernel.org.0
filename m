Return-Path: <linux-pci+bounces-29009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF2ACE892
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 05:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7053AA28C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 03:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF71F4174;
	Thu,  5 Jun 2025 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUD/3y8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A71C5F06
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749093149; cv=none; b=jVHEur8dP1h31Bx4M42PmBo0pA838kiuzgOfBU6JRC5OutQKGrmdS55GRsrCq8VbuLx4NpMI1R6FvIIqnof6G4q3G7Lkwn/EsdPqdWdxQ3bOqH43DhhDCp/Xd58T9F7+E45VEHLaBdvWJdbwd1QkBeY0ro1ufQFShpbUkehpyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749093149; c=relaxed/simple;
	bh=RARMEFCKxo44B6B9+nY4zeTF4gfaDoIOpQB1M1i8Uvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwErYBe/02BmVKRk3CFvqx9eGcnTt3vynrHbsxTdxF42OZ70PA169cpppaP7ey+pswoa135HFOlZYQgu0iO4TtOTtW95neWhXmMJiy3Ow+WoGOjggHHS+RAiHat2bf2KBhH+m5ea0T9899bo/nb72VyERPmEn+EVU1Uppe3+bUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUD/3y8K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749093147; x=1780629147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RARMEFCKxo44B6B9+nY4zeTF4gfaDoIOpQB1M1i8Uvo=;
  b=SUD/3y8Kx/QaLNcPJ22upcDWsqdt9/b624hx/h6knetkZVczXICPwmBx
   a/HV/biziw/lcznk85Gi35Z8X49d06cK/h3qRYA4z238DtS8bDXZWtQht
   3+2NHhOYLeABV7lG8EV/qMh/WiulFZy+wSjbiQQcqiOfF6m3xPVmvl9E+
   9CnJQzqSF5jWjiDi6bu7nXR8nuSt0q8QANDuew89hvfm98zc+VKaEOEv4
   MEgK9fMYRnSAgs2DM+/GUVqwnp51OGdp3uSFEilWrUKt7bnxBJfcRlYf2
   0xUFBkqpOJvRkUf8TLMkbk395IIyGmDjFiM1BMSykhlb2vmET9cLJCZ4G
   A==;
X-CSE-ConnectionGUID: a3YVBuoUT7G/BqiGv0ILCQ==
X-CSE-MsgGUID: TgW1eZbNRr6+FeUFDfcytg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62552436"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="62552436"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 20:12:26 -0700
X-CSE-ConnectionGUID: C5PXCXUOS/+c3vtwOhbX6w==
X-CSE-MsgGUID: RjtxRQntQZSpQS3S98MQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150649663"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2025 20:12:24 -0700
Date: Thu, 5 Jun 2025 11:05:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEEJi6ZLQUetiwWA@yilunxu-OptiPlex-7050>
References: <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <20250603121142.GE376789@nvidia.com>
 <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050>
 <20250604123637.GF5028@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123637.GF5028@nvidia.com>

On Wed, Jun 04, 2025 at 09:36:37AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 01:58:55PM +0800, Xu Yilun wrote:
> 
> > But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
> > DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
> > bound, may trigger HW protection mechanism against DMA silent drop.
> 
> As I understand AMD it sort of has a single translation and relies on
> its RMP for security. So I think the MMIO remains mapped always in
> the iommufd IOAS on AMD?

Depends on how IOMMUFD/IOMMU driver reacts to VFIO's MMIO invalidation
when bound. Legacy IOMMUPT is not controlled by firmware, but it's part
of AMD's secure DMA path, so we have to do something on VMM side.

In legacy case I assume IOMMUFD should unmap MMIO range in response to
MMIO invalidation (via DMABUF move notify), is it? Will do something
different when bound?

Anyway, seems we all agreed VFIO should ensure device unbound first,
or no MMIO invalidation. This blocks the issue from happening.

> 
> > SEV-TIO Firmware Interface SPEC, Section 2.11
> > 
> > "If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
> > configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
> > fault is either a host page table fault or an RMP check violation. ASID fencing means that the
> > IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
> > root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
> > silently dropped. When a guest reads from MMIO, the guest reads 1s."
> 
> Sounds to me like the guest has to do things properly or the guest
> gets itself killed. I wonder how feasible this really is..

I think both guest & host. If host unmaps some legacy IOMMUPT entry
delibrately or accidently, the issue happens.

> 
> > BTW: What is ARM's secure DMA path, does it goes through independent
> > Secure IOPT? So for p2p when VFIO invalidates MMIO, how the Secure IOPT
> > react? How to avoid DMA slient drop?
> 
> On ARM T=1/0 traffic goes to two different iommu instances.
> 
> As I understand it the T=1 traffic will go through an TSM controlled
> IOMMU that uses the ARM equivalent of the S-EPT for translation. Ie
> the CPU and IOMMU translation are enforced to be identical.

We are on the same boat... I need to check how ARM operates on this
S-EPT equivalent, also in KVM?

Based on this I doubt ARM also has the immediate DMA silent drop issue.

Anyway, unbind the device first.

> 
> T=0 traffic will go through an iommufd controlled iommu and it will
> use the IOAS for translation.
> 
> I've also understood this is quite similar to Intel.
> 
> (IMHO this design is a mistake, but oh well)
> 
> Jason

