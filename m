Return-Path: <linux-pci+bounces-28669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A18AC7F51
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AF5189CBC1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557A224B0C;
	Thu, 29 May 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwsR4iLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC522687B
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526975; cv=none; b=fWqvM0VkOEL76EBj6NDJR2L2yNgdKr02oO/QVeCd0lgldPnK2PiePw377UjNp/fvwiP8Y7V6yNFNayLZb11pk0p37hA64sFqIzAJXZjTslieCoGJ54fN7ks7Pam1uJBIK6ivI0zazz2XK7Ym5wL4SArj9dKzPvEtXBx4gyVBRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526975; c=relaxed/simple;
	bh=j5Q3sX/YIUtqn5PpjjmEJ4Hp4cwg9WJvwuLWZ/prHJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDqeSbR4GYdd4b4KVtYImrzXRxGLH/bv2cYJGMHMOnV55fy6PbxAELnDlSjgblqpLMOYNAtbr5FAKF2gw9kAlR/KLUfCPNpEEQzrvr2dCNw5KYw7wNiuWYiCDEqyd2nnQhcBVZBxSfDGwpMvwit7tnDYBasUc3rd2uFW+Qndbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwsR4iLN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748526973; x=1780062973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j5Q3sX/YIUtqn5PpjjmEJ4Hp4cwg9WJvwuLWZ/prHJU=;
  b=JwsR4iLNRDOWbHwKbN8hqTPX2IN/eSoqwOr0QZApk10JcM9nCoP5UtKk
   ObqE+WDf+vSW7sNHz0M9IgPo9SkJlhaq+WnPFrA+VOhknbl/DxO9FijjH
   3ukDi3AdbiTL4GuTZR5bn1zLdv2zztz71BGFrDUPwpredWQp779chxHtP
   Osb8KXMtXs6YzFE0NKP3vkqxF0yhj3zDbp+5sbng+yLAmloWso0Z6FYtm
   pvyM0VAxve5hgGvA41ccoljCLkXSoYuIz5rCH8d+je/A/VISiU+JDAPr3
   GPcCh/tmSPBFy1gUVYiA+N5Zj7F3YS8pMnKpHWvqnAxX7p9il+jt9AIEg
   w==;
X-CSE-ConnectionGUID: jBjudhLCT+qTrUbMDtIMyA==
X-CSE-MsgGUID: E2aEh7BSSXWtb5fJ9sdRXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50288807"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50288807"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 06:56:12 -0700
X-CSE-ConnectionGUID: WfM2R1bkRsiM46zXzFf9rQ==
X-CSE-MsgGUID: o7pY8hpvTJWORXYYkEUdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148854885"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2025 06:56:10 -0700
Date: Thu, 29 May 2025 21:49:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aDhl//XH8HNwJPJ2@yilunxu-OptiPlex-7050>
References: <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528164225.GS61950@nvidia.com>

On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
> On Wed, May 28, 2025 at 05:47:19PM +0530, Aneesh Kumar K.V wrote:
> 
> > +#if IS_ENABLED(CONFIG_KVM)
> > +#include <linux/kvm_host.h>
> > +
> > +static void viommu_get_kvm_safe(struct iommufd_viommu *viommu, struct kvm *kvm)
> > +{
> > +	void (*put_fn)(struct kvm *kvm);
> > +	bool (*get_fn)(struct kvm *kvm);
> > +	bool ret;
> > +
> > +	if (!kvm)
> > +		return;
> > +
> > +	put_fn = symbol_get(kvm_put_kvm);
> > +	if (WARN_ON(!put_fn))
> > +		return;
> > +
> > +	get_fn = symbol_get(kvm_get_kvm_safe);
> > +	if (WARN_ON(!get_fn)) {
> > +		symbol_put(kvm_put_kvm);
> > +		return;
> > +	}
> > +
> > +	ret = get_fn(kvm);
> > +	symbol_put(kvm_get_kvm_safe);
> > +	if (!ret) {
> > +		symbol_put(kvm_put_kvm);
> > +		return;
> > +	}
> > +
> > +	viommu->put_kvm = put_fn;
> > +	viommu->kvm = kvm;
> > +}
> 
> Shameer was working on something like this too
> 
> I would probably split just the viommu kvm stuff into one patch so you
> two can share it.
> 
> > @@ -68,10 +121,32 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >  	 */
> >  	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
> >  
> > +	/* get the kvm details if specified. */
> > +	if (cmd->kvm_vm_fd) {
> 
> Pedantically a 0 fd is still valid, you should add a flag to indicate
> if the KVM is being supplied.

Did I miss something? Shameer's patch passed in struct kvm* through
iommufd_device_bind() then to viommu, and has your Reviewed-by. I'm a
little confused...

https://lore.kernel.org/all/20250319232848.GD126678@ziepe.ca/

Thanks,
Yilun

