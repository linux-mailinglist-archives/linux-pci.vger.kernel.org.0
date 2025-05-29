Return-Path: <linux-pci+bounces-28579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A6AC7B25
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160001892BEE
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DC21CC79;
	Thu, 29 May 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCKBTPcN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93140219303
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511411; cv=none; b=kECT9Q6nQUwRWW7JwTQezMyCx4hDQeaRI6qLwycczFT6gjAiiNtGRJHS6vqvmbGQF45Y69ZXBtPCQUKqW7K6tmlNvbrtdtEJv5xtFXt/dfIZyNzNnZhjIl/scbfgwYeRGA4/NWsbxkUsa1YYevg87WAN13m/b59O4fVIVyO+apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511411; c=relaxed/simple;
	bh=E+Eeb0KYH2ceDW5aLdj3dqgcub1uVt8Pi2Kc4wHenx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IraBq/J/bLCqsFdnf6gOcvLDiZCYXvZzjzysM1u2Z77eMfUKYQNpVPyp8RUDhcpGpCZrVO6V+fNVi8yKL96e9H3VDwmYYn7m8zKXdSBiyz5hI+/dgXKdLOTlTp1fnKI0ToEDu/k7NTLSFJYwXtYOdUrKzKon8i1rs9Gb+Ri6dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCKBTPcN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748511410; x=1780047410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+Eeb0KYH2ceDW5aLdj3dqgcub1uVt8Pi2Kc4wHenx0=;
  b=GCKBTPcN71DyJ9LanwGa+c0pSWD7c765aGdNgFWYAgXQlp7LfqbKbQPt
   wb6O5XtYal2UBswL8U8PTDrs93Jz/lA0sMw1Yx2HsNoEPK2VCzUzvv87y
   jWf3eThx0ggN++4blHDeqMG30mJltq2eNixO2G442Hc/50DMDkOCm2Ize
   seMAPGUHIi9Ut+Wo2ooHFuRCYV7VGOkTI1uUn5Suc5zdNnh8PBuUYy9Ls
   dwXPwsevbK2rGNmVHayegMs6awac8TMmUPsh2U1pZqpgFsMJaqluNPK1P
   cXlUVc4Ls+vzcvP3SUIj2OMG8+f9+qshx6g9g2quLdzMPav1jlRrT5dtI
   g==;
X-CSE-ConnectionGUID: tza0AfrMT8SBAR5vEglzKw==
X-CSE-MsgGUID: GwOWovwKQvqOb6Q+GXrcng==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49681442"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="49681442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 02:36:48 -0700
X-CSE-ConnectionGUID: iR5PS7z6RfqZnz8Eq9bLlg==
X-CSE-MsgGUID: YCccViobQACX5e6VhlQY3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="148283577"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2025 02:36:45 -0700
Date: Thu, 29 May 2025 17:30:26 +0800
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
Message-ID: <aDgpMiGV1nzhwXKv@yilunxu-OptiPlex-7050>
References: <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
 <20250528165222.GT61950@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528165222.GT61950@nvidia.com>

On Wed, May 28, 2025 at 01:52:22PM -0300, Jason Gunthorpe wrote:
> On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
> > > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> > > +	struct iommufd_vdevice *vdev;
> > > +	int rc = 0;
> > > +
> > > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > > +					       IOMMUFD_OBJ_VDEVICE),
> > > +			    struct iommufd_vdevice, obj);
> > > +	if (IS_ERR(vdev))
> > > +		return PTR_ERR(vdev);
> > > +
> > > +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
> > 
> > Yeah, that makes alot of sense now, you are passing in the KVM for the
> > VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
> > enough for it to figure out what to do. The only other data would be
> > the TSM's VIOMMU handle..
> 
> Actually it should also check that the viommu type is compatible with
> the TSM, somehow.
> 
> The way I imagine this working is userspace would create a 
> IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
> TSM call to setup the secure vIOMMU
> 
> Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
> it will do a TSM call to create the secure vPCI function attached to
> the vIOMMU and register the vBDF. [1]

Then we should have more verbose TSM APIs,
pci_tsm_tdi_create/bind/unbind/free(), which seems workable. Now
according to Dan's series, we only have bind() which creates secure
vPCI and switch to T=1, and unbind() which switch to T=0 and free secure
vPCI.

Thanks,
Yilun

> 
> And finally bind will switch to T=1 mode.
> 
> But if someone creates a VIOMMU with IOMMU_VIOMMU_TYPE_ARM_SMMUV3 then
> the vdevice shouldn't be allowed to work in TSM mode at all.
> 
> Finally IOMMU_VIOMMU_TYPE_TSM_NO_VIOMMU would be a "NOP" viommu type
> that enables TSM support but has no vIOMMU and works with all the
> iommu drivers.
> 
> Not sure exactly how to wrangle this all, but it should be done
> here..
> 
> 1 - IMHO alot of the architectures I've seen have messed up the VIOMMU
> design by having completely separate IOMMUs for T=1 and T=0 traffic. I
> hope people will fix this and allow the secure VIOMMU to translate
> both T=0 and T=1 traffic as walking page tables in secure memory and
> then rejecting T=0 if the final physical is secure memory. Meaning
> from an API perspective we want the vPCI to possibly have a working
> secure vIOMMU before we reach bind.
> 
> Jason

