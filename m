Return-Path: <linux-pci+bounces-28674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC22AC7FAD
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89221890557
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAE21C9EB;
	Thu, 29 May 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fea+OfqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743821ADDB
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528813; cv=none; b=dAGD0bZ189ygS3Z8+xoKhwhzJsd3LQK5A+hNe71+Ybs7B35wGCdAn3usIQDZ0/4RUWD++BRvj/e6RMsC9AOzSECDxRjPqw9UVL5M+wMMUsZlky1oO5O5xak8i5DNjLqKCaZAyODjDbXGoFQo8M/K4dNzSvtGj7xQCcnoszLFkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528813; c=relaxed/simple;
	bh=c6qPLvXTq8f1OnSpjvSsEUsr7iZfLor+dApuKN8QAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co49wvwcCzRTY74SJhAolhHG7+Ictzqe+alWI0PAHKbvQUW/4zCBpKB4efD0sBTsguOcxwBa/cU47yBZaPPHoXIpSfgT8jExaRb+Y5YtBQuvdBz7CEgirEiKf1eb3lkqNm8uK4WgU9GiqLdprnOrynyc3GiePdIbu8YmwmoQ168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fea+OfqB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748528812; x=1780064812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6qPLvXTq8f1OnSpjvSsEUsr7iZfLor+dApuKN8QAc8=;
  b=fea+OfqB9aYt9Cj0SAfMASPg24kQNIDJmVPMHEzgLJWzd7HxdGPZkX2j
   TkoozTiRxBVH4h+L+FE02KjuiNQGAQydPy3rCb4eXSg2SfwWnprSJlEJQ
   vmN10t8zm46CDWC2tQWfcyyZvPH9E5JqPBORZM53ZTBuv1b4sbFqEqHOc
   3qoYvEvWJAwYWGx7lFjmbd77HKR86Z1nsadfYifoDcSA6i3mpBnZ6xVDB
   TUJCLT55YYN53aLZLT17DKn7vuBa3e0wXqnqvDNmURrBcbFAdx/zyKL6r
   HwfRcqIkwYZueSeH2Y4PtrjYCaaZL17Xx9tyvkUDuTW5hdToxV3/dkQnF
   A==;
X-CSE-ConnectionGUID: 530k1R6bQwWZpr8vBj1z3w==
X-CSE-MsgGUID: 3p1WOmaqStKf5mUCINwmCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50744010"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50744010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 07:26:51 -0700
X-CSE-ConnectionGUID: PoecBxn0SoOMPIdwVauhOA==
X-CSE-MsgGUID: WAHq5MtARmOS7Qd7Ti87DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="174464487"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 29 May 2025 07:26:49 -0700
Date: Thu, 29 May 2025 22:20:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
 <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>

> > > 
> > > > > + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> > > > > + * @type: identify the format of the following blobs
> > > > > + * @type_info: extra input/output info, e.g. firmware error code
> > > > 
> > > > Call it "fw_ret"?
> > > 
> > > Sure.
> > 
> > This field is intended for out-of-blob values, like fw_ret. But fw_ret
> > is specified in GHCB and is vendor specific. Other vendors may also
> > have different values of this kind.
> > 
> > So I intend to gather these out-of-blob values in type_info, like:
> > 
> > enum pci_tsm_guest_req_type {
> >    PCI_TSM_GUEST_REQ_TDXC,
> >    PCI_TSM_GUEST_REQ_SEV_SNP,
> > };
> 
> 
> The pci_tsm_ops hooks already know what they are - SEV or TDX.

I think this is for type safe check to some extend. The tsm driver hook
assumes the blobs are for its known format, but userspace may pass in
another format ...

> 
> 
> > /* SEV SNP guest request type info */
> > struct pci_tsm_guest_req_sev_snp {
> > 	s32 fw_err;
> > };
> > 
> > Since IOMMUFD has the userspace entry, maybe these definitions should be
> > moved to include/uapi/linux/iommufd.h.
> > 
> > In pci-tsm.h, just define:
> > 
> > struct pci_tsm_guest_req_info {
> > 	u32 type;
> > 	void __user *type_info;
> > 	size_t type_info_len;
> > 	void __user *req;
> > 	size_t req_len;
> > 	void __user *resp;
> > 	size_t resp_len;
> > };
> > 
> > BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0
> 
> 
> No TDX Connect fw error handling on the host OS whatsoever, always return to the guest?

Always return to guest. The fw error info (not raw fw error code) is
embedded in response blob.

For QEMU/IOMMUFD, Guest Request doesn't care blob data, so don't have
to judge fw_error either. Alway return to the guest and let the guest
decide what to do.

> oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.

But for out-of-blob data, it is the same effort as packing into type_info.
At least we could have a clear idea, which blob is SW defined, which blob
is GHCI/GHCB defined.

Thanks,
Yilun

