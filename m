Return-Path: <linux-pci+bounces-28819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56230ACBA2C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCD63A979B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46F22541B;
	Mon,  2 Jun 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz4DQavJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD12221FD0
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885022; cv=none; b=bP38+NWToxUFo1HJyJA1LJTolXd14cNQTWBUsVDADK+vM/h5L53ltNBn7aAlGOg1ovv/4+df84PLvdsymddsfhK4JRW84h0Ai0gIVBE1DQiyGTh4N2JSUyaej5/D+3+2VDLaieecvQfUBT0pgiizZ/2svBKLsRxR1sVtjWUtqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885022; c=relaxed/simple;
	bh=tKtj8c+Xr13Z1eRDH4LWyZEPx1ZPPsV6VpEfJ4Azgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T31H1plLrXBp5GERwtw5jhP3SwZtDdHtAnqtx1N2EFwRraevRbyH7bae8zqS1WvFVwQS0RSY9u4kAp8Fyn6fdInjWYkpyvZ+7iFAuN/+PXYBTuwF/o7V0Q79Alav3AezUrOmddKYA/k/E6gDUSTTxRHUmw89hxz9qUzzC/j+oXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz4DQavJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748885021; x=1780421021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKtj8c+Xr13Z1eRDH4LWyZEPx1ZPPsV6VpEfJ4Azgdg=;
  b=Kz4DQavJ3iCb9eSiHiYlmyYwE9l8iuGenslOHOYlxXE7CVtm4Qmn0hiV
   GCuzNKjDGXWWtMsKj2jFJ8/0DkzEFczNs7oW0oykdlvfF8X2dLHdUfFbF
   E04kMesInY0eF/JZy15L7WB47SdzTBT+Q+IsluKZBToav+uprNjc87hyu
   aUetlPxYKHMh1EQ652ux0CXRTUPt52vOYfvkrz7SvIviICM/aJCuSndHB
   zSEUHhWKW8gJdCUjVnocCGfSPH5EnkdzZ7IpAPfKcsDIOIkK29SmtKMA9
   4VW0nDPaVS26SjoqcpaCayWA9R346n0bh0s6L5nITyx8SmlnAirdc0bzQ
   A==;
X-CSE-ConnectionGUID: WHbEaIWCQbC/59qR9NIuSw==
X-CSE-MsgGUID: x9yeyR+dRNWbXIfzJsEEgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61159331"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="61159331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 10:23:40 -0700
X-CSE-ConnectionGUID: XLiBA8M7RUabxRhhRC1sSA==
X-CSE-MsgGUID: 6Ddq33vzTi+AZlIFbXgeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="149433990"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2025 10:23:38 -0700
Date: Tue, 3 Jun 2025 01:17:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>

On Mon, Jun 02, 2025 at 02:52:52PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 1/6/25 02:25, Xu Yilun wrote:
> > > + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> > > + * @size: sizeof(struct iommu_vdevice_id)
> > > + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> > > + */
> > > +struct iommu_vdevice_id {
> > > +	__u32 size;
> > > +	__u32 vdevice_id;
> > > +} __packed;
> > > +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> > > +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> > 
> > Hello, I see you are talking about the detailed implementation. But
> > could we firstly address the confusing whether this TSM Bind/Unbind
> > should be a VFIO uAPI or IOMMUFD uAPI?
> > 
> > In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> > behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> 
> 
> What will the host VFIO-PCI driver do differently? I only remember "stop mmaping to the userspace", is that all?

And do unbind before zapping MMIO.

> Or, more to the point, what is that exact thing which cannot be done from QEMU? Thanks,

But kernel don't want incorrect userspace calls crash kernel, e.g. VFIO
zaps MMIO on TDI bound then KVM just crashes. So you need to check if
zapping MMIOs are allowed in VFIO, that means VFIO still needs to know
if device is bound.  Scatter BIND/UNBIND & other device controls in both
IOMMUFD & VFIO makes life harder.

Thanks,
Yilun

