Return-Path: <linux-pci+bounces-21344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA1A3407D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54C516A7A1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C161221554;
	Thu, 13 Feb 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVxxFiMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF823F439
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453865; cv=none; b=lyR5DBEGhKjRsb8GjHD2BMSK8nJZkFM9TK9p54Ob4ouSL6lpkDQGSZYGrwDzE59qVOLNh3w/lfdPWsxttRuWVm7dK+C5tTKjJyHykK709Zny8DDJyP1rwuuclxZrBhVcDQlh7YKoZGb1AbHjxwt9fNZnx99E2IVbUC6zRlpegK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453865; c=relaxed/simple;
	bh=VwoVqFvbHwOvEtHzMgL9ILbRzaH5KFuPLOLH75H5kRQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MVZ4f9qOrJqSzK1vp3WZe2J4eqkqlznGzsiHbFcqxmEIs3/jzo0G6ega78hMxT/ZlJBgQrb9yYRqwi+sz9qCql+94sqAFvhswnNd78N8QDVk1Xj5g2/QKN8OkPm5X9Q2NwoDJEAQPHDDgpcnFTf2k0yjignaLwmyeclaCkrdCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVxxFiMf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739453863; x=1770989863;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VwoVqFvbHwOvEtHzMgL9ILbRzaH5KFuPLOLH75H5kRQ=;
  b=WVxxFiMfoWQo69NBkr859nv6W9+FQRXta0+/pnGAPc+is+B+OuEtJSts
   vE5PKDV+6k3fYcXvhGmzg6/WQSbVNAROTFH1x2SmjNBtsV5+EukSrHRdG
   ohF7DP7AJApv04l021FRf9B17n0XS0adS4EwOtxJumvyk9LT2AO9Uq8rR
   sFsm/sEKsnh9lOlcTNTnq5F0dlFzOSd9X54lLIxNphombmmkQ0IlpHK+A
   wo4EQ+u1A1KsHq6B1Q5hWEpmKCEe+KLbFOIO0ypnbEIFR1ccoskbyCaLc
   y52ARUXaT/haUbIWkaMJD4krXcczXs9T8b0sKjGExFm06Jk/TZ6ykNHsk
   Q==;
X-CSE-ConnectionGUID: rlUOmFtqRxGdgET6FYLgYg==
X-CSE-MsgGUID: 73M52rh+SXuwHORBkvdS4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40026671"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40026671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:37:41 -0800
X-CSE-ConnectionGUID: ZKpJZHfTThenAWBo18umQw==
X-CSE-MsgGUID: BdLde0qWTkKY4lxcYt1ISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113675936"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:37:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Feb 2025 15:37:34 +0200 (EET)
To: Keith Busch <kbusch@meta.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: allow user specifiy a reset wait timeout
In-Reply-To: <20250207204310.2546091-1-kbusch@meta.com>
Message-ID: <693ad66c-877b-6ef8-50ef-50ca797787bd@linux.intel.com>
References: <20250207204310.2546091-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Feb 2025, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The spec does not provide any upper limit to how long a device may
> return Request Retry Status. It just says "Some devices require a
> lengthy self-initialization sequence to complete". The kernel
> arbitrarily chose 60 seconds since that really ought to be enough. But
> there are devices where this turns out not to be enough.
> 
> Since any timeout choice would be arbitrary, and 60 seconds is generally
> more than enough for the majority of hardware, let's make this a
> parameter so an admin can adjust it specifically to their needs if the
> default timeout isn't appropriate.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  drivers/pci/pci.c                               | 6 +++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec85..1aed555ef8b40 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4843,6 +4843,9 @@
>  
>  				Note: this may remove isolation between devices
>  				and may put more devices in an IOMMU group.
> +		reset_wait=nn	The number of milliseconds to wait after a
> +				reset while seeing Request Retry Status.
> +				Default is 60000 (1 minute).
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a37..20817dd5ebba7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -75,7 +75,8 @@ struct pci_pme_device {
>   * limit, but 60 sec ought to be enough for any device to become
>   * responsive.
>   */
> -#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
> +#define PCIE_RESET_READY_POLL_MS pci_reset_ready_wait
> +unsigned long pci_reset_ready_wait = 60000; /* msec */

I don't think masking variables with defines like that is a good idea.

I also suggest you put the unit as a postfix to the variable name.

>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
> @@ -6841,6 +6842,9 @@ static int __init pci_setup(char *str)
>  				disable_acs_redir_param = str + 18;
>  			} else if (!strncmp(str, "config_acs=", 11)) {
>  				config_acs_param = str + 11;
> +			} else if (!strncmp(str, "reset_wait=", 11)) {
> +				pci_reset_ready_wait =
> +					simple_strtoul(str + 11, &str, 0);
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> 

-- 
 i.


