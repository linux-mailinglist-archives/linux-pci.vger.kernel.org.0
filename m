Return-Path: <linux-pci+bounces-28767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF7AC9B89
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8079E51D9
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1323D281;
	Sat, 31 May 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRZyS/0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E54288CC
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705565; cv=none; b=A4ow4PZXouQXBd0PH2jYAdtsQcAaWdzsT6C2JqueoLhhnbdY1JrNfnD32URA3l+/5x8+Ie/b/KFAUDoOu2iYEOC1ATNlMGQjjnt28z8ntmSNL4emTbzGQ7tw4UtMokrM/yAWzGCtGZiNTfM+GGCzX/yqLbd/pohiyKkTSOoVFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705565; c=relaxed/simple;
	bh=F730Y5JFdCtbrLLanQtG+94w99ecKuxezU4bwh6HTRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOiciV5uwuOCL+O+nsUOuzjBpUeSZpIrOsHEOrRD3zvWhpzyQc/Bf3ev/7uiD5ThI/hcK796oyF6CEMe53TN2LCW+++PF3p0GFDc8vCb3DTkxm2ZKrzFRmEcbB/TB+X1x++1TOGbBIJBGvITFX6qXkAMO4ij8KiSh14SKWB6f30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRZyS/0k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748705565; x=1780241565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F730Y5JFdCtbrLLanQtG+94w99ecKuxezU4bwh6HTRE=;
  b=TRZyS/0kf7xPSXjSk0jk5TH/wgrn2MwL3n6doEbC4olEQ5036ia3zIYe
   cE5xgnFM70uGkCn+yWbn7eNem61vIyc7uNyg/NSrSj5ezhiB372d1eqxo
   MR+2Bgge+9zKthkcm4eF2/pp5i3Y0N9d/bdSgKXJia9eNjnfd11Wctub2
   S89+2kpoHA0oeAOXrbb7DyaOzHWs74sHX/4+DHnvfucPbzlH/9qbc3Gsd
   uW7x/IC1qnEg+Hsy4UKRQzAHReOLZ7ON2GnOEocHmXdqSqp2tfnYR1flu
   oxS2615LBWiw1YhhxqAOlDb4Lhlwy4PnR4qmVgpKi1of/Lfde5LZb+yA6
   Q==;
X-CSE-ConnectionGUID: UthOHp49RnSy3qfWSM7uXw==
X-CSE-MsgGUID: 3TfGfmXTQoauTqrsIBqLHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="73311632"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="73311632"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 08:32:44 -0700
X-CSE-ConnectionGUID: v/h+ZZzpQjunAD5a8gpA/A==
X-CSE-MsgGUID: qjDfzeOLRbKxO0nb5srXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="144048138"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 31 May 2025 08:32:41 -0700
Date: Sat, 31 May 2025 23:26:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aDsfmJpUqy53dans@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
 <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
 <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
 <4b3621d7-4bed-44c7-8139-57de5825e968@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3621d7-4bed-44c7-8139-57de5825e968@amd.com>

On Fri, May 30, 2025 at 12:54:44PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 30/5/25 00:20, Xu Yilun wrote:
> > > > > 
> > > > > > > + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> > > > > > > + * @type: identify the format of the following blobs
> > > > > > > + * @type_info: extra input/output info, e.g. firmware error code
> > > > > > 
> > > > > > Call it "fw_ret"?
> > > > > 
> > > > > Sure.
> > > > 
> > > > This field is intended for out-of-blob values, like fw_ret. But fw_ret
> > > > is specified in GHCB and is vendor specific. Other vendors may also
> > > > have different values of this kind.
> > > > 
> > > > So I intend to gather these out-of-blob values in type_info, like:
> > > > 
> > > > enum pci_tsm_guest_req_type {
> > > >     PCI_TSM_GUEST_REQ_TDXC,
> > > >     PCI_TSM_GUEST_REQ_SEV_SNP,
> > > > };
> > > 
> > > 
> > > The pci_tsm_ops hooks already know what they are - SEV or TDX.
> > 
> > I think this is for type safe check to some extend. The tsm driver hook
> > assumes the blobs are for its known format, but userspace may pass in
> > another format ...
> 
> The blobs are guest_request blobs, they enter the kernel via iommufd's viommu ioctl and viommu already has  iommu_viommu_type which is (in my tree):
> 
> enum iommu_viommu_type {
>         IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>         IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
>        IOMMU_VIOMMU_TYPE_AMD_TSM = 2,
>        IOMMU_VIOMMU_TYPE_AMD = 3,
>  };

That's a good point. So I think we don't have to use a 'type' field for
ioctl(IOMMUFD_VDEVICE_GUEST_REQUEST). But I didn't see these viommu_type
would be passed to TSM driver. So for this pci_tsm_guest_req kAPI, is it
still good we keep the 'type' for type safe check in TSM driver?

> 
> 
> > > 
> > > 
> > > > /* SEV SNP guest request type info */
> > > > struct pci_tsm_guest_req_sev_snp {
> > > > 	s32 fw_err;
> > > > };
> > > > 
> > > > Since IOMMUFD has the userspace entry, maybe these definitions should be
> > > > moved to include/uapi/linux/iommufd.h.
> > > > 
> > > > In pci-tsm.h, just define:
> > > > 
> > > > struct pci_tsm_guest_req_info {
> > > > 	u32 type;
> > > > 	void __user *type_info;
> > > > 	size_t type_info_len;
> > > > 	void __user *req;
> > > > 	size_t req_len;
> > > > 	void __user *resp;
> > > > 	size_t resp_len;
> > > > };
> > > > 
> > > > BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0
> > > 
> > > 
> > > No TDX Connect fw error handling on the host OS whatsoever, always return to the guest?
> > 
> > Always return to guest. The fw error info (not raw fw error code) is
> > embedded in response blob.
> > 
> > For QEMU/IOMMUFD, Guest Request doesn't care blob data, so don't have
> > to judge fw_error either. Alway return to the guest and let the guest
> > decide what to do.
> 
> So whatever is inside such requests, the host is not told about it ever? How does DOE bouncing work on Intel then if the fw cannot ask the host to do DOE? Thanks,
> 

No, I just say QEMU/IOMMUFD don't care about the execution, so no need
an explicit fw_err return to them. Platform TSM driver should definitely
know about fw_err and handle it (to do DOE or anything else) internally,
but don't have to EXPLICITLY propagate these error code to up layers (TSM
core/QEMU/IOMMUFD).

Thanks,
Yilun

> > > oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.
> > 
> > But for out-of-blob data, it is the same effort as packing into type_info.
> > At least we could have a clear idea, which blob is SW defined, which blob
> > is GHCI/GHCB defined.
> > 
> > Thanks,
> > Yilun
> 
> -- 
> Alexey
> 

