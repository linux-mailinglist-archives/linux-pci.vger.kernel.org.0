Return-Path: <linux-pci+bounces-28222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14AABF8EB
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA067B91DC
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D1184540;
	Wed, 21 May 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvpSBcVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606719DF7A
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840155; cv=none; b=DvCEG85WSdc+PRkUKIma6lAQC5I3JE6WmZjM/Km3WunH/ntWvoyRc4h4f/1goCbtfJXCK8iNsPT+7gtZUOe8MyuwDZYY0hqQJbEUIIDKtsBGay3pO1+e/YgiY7C6rcGPVp1OC3qqz7c9XV2j/A9JXy+2hf4wF5z+ZcEiPH2SQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840155; c=relaxed/simple;
	bh=oSM7dC8BeF2n+l+fK5etAN8b2GMpufWdeSoyecVxaXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSNwPA/vu5Q6L9ekVb+5LLCriIGAAKnKEgKZ//MK6+cZ952WKZxA8dA+SjC4ToUydl9v2AsX7E4CV1NUFIjxozPUmLpmUVG2wjwcQ7kOARgBksw/8f72k3imHKaFKALI+DsmWGnU55XfllH4ghIP8VSt8d+95eM7i36BPlYLl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpSBcVC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747840153; x=1779376153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSM7dC8BeF2n+l+fK5etAN8b2GMpufWdeSoyecVxaXw=;
  b=UvpSBcVCVhs982l6xeWL2CptaIn1VF6Is3mHgfZsLKLqLuM3ZC2X/ge6
   CT31JBbYRjqz/USO8tvFMex/gXrJh0+a2fTvxpkN7luZmEPQgf+eIPqfk
   KKq1elzJh0he5i7w7zqx4dw9zlYLQ5sAEGe5oIc+lYs52apIahInAHm82
   QdppayLvy2prltutpVhJ0xxPPOjyGcSHAOLXsh5X6cOY9XxEwnAbztlTz
   keEN6tOQZeO+8WILsWRfPNTPQlxPhJPgyaNYSMYRfvLUCgHiXWk5YR5D6
   zO5Yr+xxhpnVD+aXSMzyRsvBhOgw0frrxIUZE3U+5VvOfdMyS1EnIoVES
   Q==;
X-CSE-ConnectionGUID: HG/YVKGhQYuSbEO6PTbpKQ==
X-CSE-MsgGUID: HAOJJYCNSUi2dGDavvEPCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67381225"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67381225"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:09:12 -0700
X-CSE-ConnectionGUID: DDhonru9RjKYKiuH43o3HQ==
X-CSE-MsgGUID: WjSIjTrkRSaCGrey4pBgWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163388024"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 21 May 2025 08:09:10 -0700
Date: Wed, 21 May 2025 23:03:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, lukas@wunner.de,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <aC3rM1LLmRPAGwFU@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516054732.2055093-14-dan.j.williams@intel.com>

> @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>  			return -EBUSY;
>  	}
>  
> -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
>  	if (!tdi)
>  		return -ENXIO;
>  
> +	tdi->pdev = pdev;
> +	tdi->dsm_dev = dsm_dev;
> +	tdi->kvm = kvm;

I think it is still better that platform TSM drivers assign these
fields in ->bind(), just as pci_tsm_ops.probe() do.  It is
inconveniente that struct pci_tdi is not initialized, then these
parameters have to be passed again and again between functions.

Thanks,
Yilun

>  	pdev->tsm->tdi = tdi;

