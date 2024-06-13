Return-Path: <linux-pci+bounces-8747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF989078E7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D51C233C1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B55012FB15;
	Thu, 13 Jun 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwh7SOf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF517FD;
	Thu, 13 Jun 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297854; cv=none; b=Jec0euAeDKS2fC+TjHml3QJEHnFUAXGBgu2QV+xORebozGdMWbGg/vLOowIzBeqPXhzN1O9FnUli0NyPunEel3A0694c3t4gYzAUFfEYRf89LECpv7Slrd+Dqefd7h0EF3zRNciWzvybUY6OiiLBfVlRs1dlHbHGFvF0jq4+uFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297854; c=relaxed/simple;
	bh=hd9vc6MALzfwEyeQxQIYvuAxlS8U6K9tjwKHqZH1mZE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CHrnFiKL2IsmzAucmb6tacNXltLRfiKscR5bgpMQLjF/1R59gQGeSpYtJNKX9c9grk2yBrXPLvpcotvo52od+d1xSbAP2ze/wMfUgv7DJD/OXuIaWJdMYUDbllamoiwTs1KaEzvmmToKOcNTPp2ZwqjfNHDP6RVuv1kCeQA2Jao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwh7SOf/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718297853; x=1749833853;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hd9vc6MALzfwEyeQxQIYvuAxlS8U6K9tjwKHqZH1mZE=;
  b=Bwh7SOf/OpYPpLHJwLaimVviGaQpLiod2oxqt1DDVF+F0s7oz7UAPq2K
   Nid5ClzaXhcEP3UAsUk+dpQ0/q0nabJzrjF2Bb9Zbpn+Pc4504FBGkY9r
   y2EHPBzVoLAdagoQgRNO1jvB+baKzltpI6zgPFBUKobOxJKdHTmua2PST
   dKjJwhVbn+5HY7OGGnrJT6JqdgTFQ41IL0QZax60dlZc0uZoJI11W0HLR
   ID0XSTNfNfImatXX/YVYGfqocLhd12F7/4TF63/dEpwB6ngul9XrubAmQ
   hXN9+MJL//LjXBxSN6uRhWpHP8msCqRBCH35tkI+OrP20O35k6lVdJC4N
   w==;
X-CSE-ConnectionGUID: QIPi6kfHSQOeF6Is1ig83A==
X-CSE-MsgGUID: y80ol5GVQOOWxem56xeAQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="26561749"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="26561749"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:57:32 -0700
X-CSE-ConnectionGUID: raO9RN/gQDSJ86BMnHowAA==
X-CSE-MsgGUID: Y90vooGuQBaEo/L6sctEwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="71007612"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:57:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 19:57:24 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
    Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
    dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 01/13] PCI: Add and use devres helper for bit masks
In-Reply-To: <20240605081605.18769-3-pstanner@redhat.com>
Message-ID: <c1ae8732-357a-fce7-8853-9ea7051d306d@linux.intel.com>
References: <20240605081605.18769-2-pstanner@redhat.com> <20240605081605.18769-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Jun 2024, Philipp Stanner wrote:

> The current derves implementation uses manual shift operations to check
> whether a bit in a mask is set. The code can be made more readable by
> writing a small helper function for that.
> 
> Implement mask_contains_bar() and use it where applicable.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 2c562b9eaf80..f13edd4a3873 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -161,6 +161,10 @@ int pcim_set_mwi(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcim_set_mwi);
>  
> +static inline bool mask_contains_bar(int mask, int bar)

Why these are signed? Using & for signed values is an indication that the 
types should have been unsigned. The typing change has ripple effects to 
caller-side typing.

> +{
> +	return mask & BIT(bar);
> +}

-- 
 i.

>  
>  static void pcim_release(struct device *gendev, void *res)
>  {
> @@ -169,7 +173,7 @@ static void pcim_release(struct device *gendev, void *res)
>  	int i;
>  
>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
> -		if (this->region_mask & (1 << i))
> +		if (mask_contains_bar(this->region_mask, i))
>  			pci_release_region(dev, i);
>  
>  	if (this->mwi)
> @@ -363,7 +367,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  		unsigned long len;
>  
> -		if (!(mask & (1 << i)))
> +		if (!mask_contains_bar(mask, i))
>  			continue;
>  
>  		rc = -EINVAL;
> @@ -386,7 +390,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
>  	pci_release_region(pdev, i);
>   err_inval:
>  	while (--i >= 0) {
> -		if (!(mask & (1 << i)))
> +		if (!mask_contains_bar(mask, i))
>  			continue;
>  		pcim_iounmap(pdev, iomap[i]);
>  		pci_release_region(pdev, i);
> @@ -438,7 +442,7 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
>  		return;
>  
>  	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
> -		if (!(mask & (1 << i)))
> +		if (!mask_contains_bar(mask, i))
>  			continue;
>  
>  		pcim_iounmap(pdev, iomap[i]);
> 

