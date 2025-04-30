Return-Path: <linux-pci+bounces-27052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E2AA5522
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5B39C27C3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893864C8E;
	Wed, 30 Apr 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UCulZlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF81E9B1F
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043024; cv=none; b=aEZUDZZBfxiogS8b7vDD9+qrr2svmdYkAc8iRKOydPwUm0UhdfoQX+21s2JYewjy9Urb63tTybIYtTwZxXQ2dvQf89wRfyzPb08LIGAojxI0dqas0qCWi5MSfHZjWEeTp00mNcgCnH0SYK+44Gl2L43YQQGLFOWnmS66JO1JSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043024; c=relaxed/simple;
	bh=3qDTN+MBFQnDotoSGCXSC0TIqshMNt8VgM+VnIIfAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIXFpTm2bMY2CJ1DJRKtY6t1mxmSQcat/ZFF9KWo61x1ZNqe5eU7ghP9AazNicMK/KIanmfv4SJ9zP1LI1vGBxMkXHMjM/9uzsV3rfdRDxuVX62m1YoYPqIWix3pKvb8hH/3kRj6f22bS4wXMuaeahtHxbApxTNXn3GCX12YO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UCulZlC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so212480a12.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746043022; x=1746647822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+qKL+MUCJJ9XsZqOZSeMflU/a6s+djka0YUBDd9w14=;
        b=0UCulZlCbxaaCS3q43QZ3WRx/9PzbnP9nvapKHzj4tFYNZexmgPVwAi47XnyVAAtRF
         Mbe2Wn8vuwL4dQrzZLT5vGJBktrt7bD5a9GO9qskzgZNLKNVTLv0kJB0neRMq7A/VKcE
         jJUtZ5x+QwVQIEAKOBNo2Fcsc07nGy5lrQ1msL0UN5HRNvb7NzpUjJeH1D8Hhj630Cy4
         DoTMhccWcdy2IFqaTSeP5w+q6NW/6DWhxPSHjK1ph5wNpS0L0qQLiXAVrOD6MhK2MaEs
         3PyFO3f2FwQD2o96VoJZDsWF5oGeMBedKfiXWeEeksdW87hfaVGWQh+8Lt1Ml7UykgCu
         Of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746043022; x=1746647822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+qKL+MUCJJ9XsZqOZSeMflU/a6s+djka0YUBDd9w14=;
        b=ZrsJBpWvUyZ2+xvqkGqvIogjLnW42lBMO194R0rNxOSQmGn47EH6Sl4u6QqB5+DlsV
         zlkCoqafFP6H60tht+EWbO87r8c2FgYKt9I/rBzMubWIbJ6G4EADzAzWw6AZ+xWDiZ3S
         IOST68FWApzAd7vMhEHSz7yj9VjF5D0GnHyKd2B5Ygs6veS3HPtWLMuK6VwBbbgyVBcu
         hTHh+l5ckgIaJbu5qj7cRlOeNPsWtlqC9KQ2nhlZgiY7gwQlodnO9ME9H5hZ5bJlYuYV
         pDrX9JgwYXirtbTD3btTLoiSyoVP8zuXRVM+izP5cSPHdMGBKrh/AwlMjuE6r/7fTJF1
         SdUA==
X-Forwarded-Encrypted: i=1; AJvYcCXwGiDl0Vf1F68DZMc/Ho9MCFj22knGpHwiAr4Zl+AaRnBnoBQzeZQ0e7giqNyCpJvUOBhOU4mnbxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3IIjczrBRBqD5f6P8nMvhJoqCQhe/QoS/XuQXsd8bx1STiOz
	M9z8Jlg0NkHw56cE9aH0y3VXdJGuWaxmT8UR14MMJznNaqut/yPzjTo08SRyVA==
X-Gm-Gg: ASbGncvYyGmOJLCEkPBnkdXoI9vR+0234suiMpl95VXmQkP4OEAr1rcMAtEGBFNzodf
	HedtTDIULeI5p3WUG4AaEaXc3WJkJWvwfb6Oq7mkETjIk2fX22210+OKrOfpMTZZMV89gGHSJvM
	aEAIo3iBZQegHpgQMTfz+ojIh9LvAHuQ0IMaZSst3xuNe5XsD2Yf4T4ee0nZ9AYO8QNyqSq2aAg
	VAXhIot3wWvzeQqEjbAAyvXQ8ssNzHoe6qtfep+mDUwZIzQ0dUYENkmoBVe4rAJCrmflQEhT1eg
	b1tMCsRDHJ/oLyPicrWlphdtCbb7bCo6I2EKPH7c01cWlMlyVopGFCd+2AGJp2V3VFL2lw9f+zR
	4IL9Mug==
X-Google-Smtp-Source: AGHT+IFYLwXsSVzpZ58dXpoeXLiC5qkI9bTIycsk32TydeZra3btf6V9VE3JspqpRKaeMTjXf206sg==
X-Received: by 2002:a17:90b:3812:b0:2fe:b016:a6ac with SMTP id 98e67ed59e1d1-30a41e6c2fdmr10756a91.15.1746043022099;
        Wed, 30 Apr 2025 12:57:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3471ee7esm2100393a91.4.2025.04.30.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:57:01 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:56:57 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix driver_managed_dma check
Message-ID: <aBKAibjRdrYVEWAM@google.com>
References: <20250425133929.646493-4-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-4-robin.murphy@arm.com>

On 04/25/2025, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_pci_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> Will and I both hit this with the platform bus, but the pattern here is
> the same, so fix it for correctness too.

Thanks!

Reviewed-by: Will McVicker <willmcvicker@google.com>

> 
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/pci/pci-driver.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f7..66e3bea7dc1a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1634,7 +1634,7 @@ static int pci_bus_num_vf(struct device *dev)
>   */
>  static int pci_dma_configure(struct device *dev)
>  {
> -	struct pci_driver *driver = to_pci_driver(dev->driver);
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	struct device *bridge;
>  	int ret = 0;
>  
> @@ -1651,8 +1651,8 @@ static int pci_dma_configure(struct device *dev)
>  
>  	pci_put_host_bridge_device(bridge);
>  
> -	/* @driver may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !driver->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

