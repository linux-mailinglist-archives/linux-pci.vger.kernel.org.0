Return-Path: <linux-pci+bounces-41393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F71C64011
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8B9FC24006
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2825785E;
	Mon, 17 Nov 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCc9FN/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819732C929
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381541; cv=none; b=P55MWa98IlscLBABKIk5vaw5zgmIau2r9jHRFQS0GzLVcWvm8nqNJmOq+9Y3VR4lbd8UmBcGztOvLYLDxYnj5q4NrppvHDFjZ+2T9VyKlZLWrk/VXN088ILQYUMSpnnG0++ThiW4G/9HrmTZTiBeJkteIEniHbj76YgduYYU/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381541; c=relaxed/simple;
	bh=hHkkkuzcm+OZgcYuNf2+6konfNd6VrAMNQZDC0IlSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ055vdoPCbmRSL243RgnIkLyDNQJTJ8xfcu+Qgm1Tolj+SQVUrWgEj7FX+/IMq3njz/lIa7Au4UhI5g8cC30cKuK4fYziUTdq9XF8h2FKX8Jr5dKO4hpSHko5MtVNpPHMhSQNZm5UgebxUUX5dWqxGuiijKAc84MDaB88cXpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCc9FN/b; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763381539; x=1794917539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hHkkkuzcm+OZgcYuNf2+6konfNd6VrAMNQZDC0IlSeY=;
  b=BCc9FN/bievtA+XL58uIHwZlBBDz2Y+gdGu9dlPqauthsIR8WUXAftnW
   q0UjInJ39AbHdimPB0jntRY0VSpoMFEg0ZFAZbYQXHga2Cwj6AEPeVyof
   n9vUzOONpcTZonD1vPwKCE+FhNDwZEYzZydXZG8tydNmMw6YulZhXg6Bs
   Rwi2v/ZMS82nxmRzdRHf70XJBcmI84sS9c6o7/b01LtVDf/6CYItRaw1u
   rUWx+8iSadx2d3fHKvwVHOYNVSgBA6nw7Fmepi+J5GTpgLLm/c1ikvDdl
   trvh3z/cFZNRDvl1tI99/LrhX9Bn6b9SrKrcWAnJWEFhyWcX6M67jZ16k
   Q==;
X-CSE-ConnectionGUID: Us76Dz5wTV2EG/Exh72xpw==
X-CSE-MsgGUID: PigVFU5wTtamjG19CFU4xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65279958"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="65279958"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 04:12:18 -0800
X-CSE-ConnectionGUID: twGw8rNGQZilaZjenVGMPQ==
X-CSE-MsgGUID: R2rrSy3cSiKopfRyRGYLNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190230655"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2025 04:12:17 -0800
Date: Mon, 17 Nov 2025 19:57:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 7/8] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Message-ID: <aRsNrmcc5p2wUg9r@yilunxu-OptiPlex-7050>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-8-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113021446.436830-8-dan.j.williams@intel.com>

On Wed, Nov 12, 2025 at 06:14:45PM -0800, Dan Williams wrote:
> A PCIe device function interface assigned to a TVM is a TEE Device
> Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
> steps taken by the TVM to be accepted into the TVM's Trusted Compute
> Boundary (TCB) and transitioned to the RUN state.
> 
> pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
> like Device Interface Reports, and effect TDISP state changes, like
> LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
              ^
transition

[...]

> +ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> +			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
> +			  size_t out_len, u64 *tsm_code)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +	int rc;
> +
> +	/* Forbid requests that are not directly related to TDISP operations */
> +	if (scope > PCI_TSM_REQ_STATE_CHANGE)
> +		return -EINVAL;

So we are not ready for PCI_TSM_REQ_DEBUG_READ/WRITE, is it?

Others look good to me.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>


