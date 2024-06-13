Return-Path: <linux-pci+bounces-8748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA49079A2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEC285B12
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887D14A4F5;
	Thu, 13 Jun 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjlSjOR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40A14A093;
	Thu, 13 Jun 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299201; cv=none; b=uLn3LXHhpEPkDU8uvd16Yvn+1jUBlV4fgF+7HHXJd44vkUGsknlx4GpzvMYqHjjhyYfZP6C6exYkA5hj9Q8yOc4ERbXTX94RhUcTHmYMpRQaUgDuN+sx/14DKZTOyxgJnlSI6Mwu6eHg4NJ47zzRXFQhPsz7n51FLKQk5yGY+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299201; c=relaxed/simple;
	bh=RmIpd1nTc1q4Ns6AOINhQ9/9u4E1Af4vqvSzsOt87Yw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uVhgi/05OKpi2n3cHXch22Ycl/WTRY5jltSZJpeEBfo441khCO7mkKGoBkFoAKGB9wadM48VGxQ3H8LAK/EFafnYtBV1sIgZ9vK/OclpgTfPnVQm6U28KvrCRrzQJYp8whQ5AP3k5JRXVUuXjpUHDJBx47QndpR4dA5NlKCcXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjlSjOR5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718299197; x=1749835197;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RmIpd1nTc1q4Ns6AOINhQ9/9u4E1Af4vqvSzsOt87Yw=;
  b=gjlSjOR5q/hfWxiHDjGiAEd1HEW3IRsOzq7yInyMg7OhWaU3mC+dKmaf
   ZqPTRrgkt2uFJYe2p2e3qiquHgDEbV0n2cSBUvKqFB7TRhdQ6Z1t8cZyq
   U6TBxRcvVQOFx3+Y0GjK9dNLHkkN94/NXOvkMyZIxql1JWyyMQTYVEeGp
   GIoTIITPxERS1Beku5rtbGJ5Rfh2RBUZj+IQhJXxCgr/yghVCCKSzuEBZ
   /uKfTqsRIyrNgAZRkdj0hFe8rGWimLm76qRYYS6E4KnEmA3usNYZnr1MK
   81pO0Eq0MCze31YLkHTgwEQr8cqdkyQsoVTISaZ4Wxz/IDBM3l8n3HRq1
   Q==;
X-CSE-ConnectionGUID: sEnjKcM0R3uwyZeYbfvbqg==
X-CSE-MsgGUID: 4wRacEt1SHainxEdilpZ/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25726091"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="25726091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 10:19:56 -0700
X-CSE-ConnectionGUID: invZadp7R+ur/ZhVQAYztw==
X-CSE-MsgGUID: Ae4SEmaGQEyLuXKXD6POJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="77680971"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 10:19:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 20:19:47 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
    Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
    dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/13] PCI: Give pcim_set_mwi() its own devres
 callback
In-Reply-To: <20240605081605.18769-11-pstanner@redhat.com>
Message-ID: <17445053-18a1-a56d-79d0-3b3d3ecab033@linux.intel.com>
References: <20240605081605.18769-2-pstanner@redhat.com> <20240605081605.18769-11-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Jun 2024, Philipp Stanner wrote:

> Managing pci_set_mwi() with devres can easily be done with its own
> callback, without the necessity to store any state about it in a
> device-related struct.
> 
> Remove the MWI state from struct pci_devres.
> Give pcim_set_mwi() a separate devres-callback.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 29 ++++++++++++++++++-----------
>  drivers/pci/pci.h    |  1 -
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 936369face4b..0bafb67e1886 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -361,24 +361,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
>  }
>  EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
>  
> +static void __pcim_clear_mwi(void *pdev_raw)
> +{
> +	struct pci_dev *pdev = pdev_raw;
> +
> +	pci_clear_mwi(pdev);
> +}
> +
>  /**
>   * pcim_set_mwi - a device-managed pci_set_mwi()
> - * @dev: the PCI device for which MWI is enabled
> + * @pdev: the PCI device for which MWI is enabled
>   *
>   * Managed pci_set_mwi().
>   *
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
>   */
> -int pcim_set_mwi(struct pci_dev *dev)
> +int pcim_set_mwi(struct pci_dev *pdev)
>  {
> -	struct pci_devres *dr;
> +	int ret;
>  
> -	dr = find_pci_dr(dev);
> -	if (!dr)
> -		return -ENOMEM;
> +	ret = devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = pci_set_mwi(pdev);
> +	if (ret != 0)
> +		devm_remove_action(&pdev->dev, __pcim_clear_mwi, pdev);

I'm sorry if this is a stupid question but why this cannot use 
devm_add_action_or_reset()?

> -	dr->mwi = 1;
> -	return pci_set_mwi(dev);
> +	return ret;
>  }
>  EXPORT_SYMBOL(pcim_set_mwi);

-- 
 i.


