Return-Path: <linux-pci+bounces-28827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D0ACBF19
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 06:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE5A3A40D9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 04:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940371AA786;
	Tue,  3 Jun 2025 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAGiJLnE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004471A5B95
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923938; cv=none; b=LVuCyIwJ1hDGQ/e44FP2ttYCEIScgiqAT+hy3rGzp6OTmgaw5azE1hDE3hY7XTO+HGl9bpV47zpNuY+k5cFXQ7uW8+hblWM9ZBnA9QFBZt70OPIKeqh2ux6tyqrGWrYIwSmbSbgssNLArVwBQE4YygnjpnM+qk7STAKRJJgPDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923938; c=relaxed/simple;
	bh=I0K77ynWRWFakYsSzTa11tPdCaW/k1nmFqRDWJiEcP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgxgEKa+KLfOALf8IR/HJgKtlQsiqYa4zCFxxXIAywRuxHvhDF+/RrKMTVIkmDv8FoAE1pD0h/GTdOUqcTnY2wDBEmM5qQ+C8NP0udUCkGvIk8Va7sP4vvkKppBdBRn8T2pG4wJbuCGUgWCUsaiTu7fcoWi5BTR16hN7d/1wwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAGiJLnE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748923937; x=1780459937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I0K77ynWRWFakYsSzTa11tPdCaW/k1nmFqRDWJiEcP8=;
  b=oAGiJLnEgmSn8nJkrhJNt5pWc/H/b96wXzNnO7h2Q0NW8vQsl+KOI2cL
   D5IiXdxPrhEto9UNN8fz5Hjo0r6AOBIqcHsHPBsXHDe9nVu6PvRWBPpSP
   u6fcBURxvWmq8tF4NCHjU+mcDbWjqukh14UgZE/zTSqS6r6bGZKn+9xyh
   w2kbqmX5LY+ZUIPhQGTe+uZ+EHuZbe9iUC75CU+8BgX6NEzT7KtiJK3HR
   V0f3Q51XsAtuYy0v9JNvBQSSe/ivm6bPsM10LzRwzgWmMuQGZHRMsaSyE
   dv0xhqiOY46/6CHD678ntxaZtz1hY9B6EJmkq39cKFe66M2CfLBTHs1O6
   g==;
X-CSE-ConnectionGUID: HThv9geQRP20DGyuUGl8XQ==
X-CSE-MsgGUID: KpieshuXROeK2m7YRW5QYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51014588"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="51014588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 21:12:16 -0700
X-CSE-ConnectionGUID: DCwd83g0SmK5anRUxGD9Ng==
X-CSE-MsgGUID: AjKdimCnRtyPpAVwyzcXcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145223610"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 02 Jun 2025 21:12:14 -0700
Date: Tue, 3 Jun 2025 12:05:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602164857.GE233377@nvidia.com>

On Mon, Jun 02, 2025 at 01:48:57PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:
> 
> > > Looking at your patch series, I understand the reason you need a vfio
> > > ioctl is to call pci_request_regions_exclusive—is that correct?
> > 
> > The immediate reason is to unbind the TDI before unmapping the BAR.
> 
> Maybe you should just do this directly, require the TSM layer to issue
> an unbind if it gets any requests to change the secure EPT?

The TSM layer won't touch S-EPT, KVM manages S-EPT. 

Similarly IOMMUFD/IOMMU driver manages IOMMUPT. When p2p is
involved, still need to unbind the TDI first then unmap the BAR for
IOMMUPT.

Thanks,
Yilun

> 
> Jason

