Return-Path: <linux-pci+bounces-8086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB878D5011
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38B91F23C6C
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A970224D4;
	Thu, 30 May 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlwYK5QE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A22E84E
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087589; cv=none; b=tFVqmb0a7cHYLVgBLsEVR4yxMX0dD/3k6A0VrbBrREb5uAs2zu/v45gXOzEvRpczK4VjXcezS9gULwEzHhwhx6mTX8J6e3oI6QcTHyrEigT7X9mOMu3OAljs2lIACoxWuXqUDWEdE1zu5OcWrD4BsDPRn2d77eIe3IYuyrJt3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087589; c=relaxed/simple;
	bh=S3koTg/Gg0yDRSQEsIXG0A5glf4bKujAHcfOsarPm/4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V/Oo8HkIi0m7s6RAyKgq7HqKhgCGwDW0dlY94KEqPkodKtU94yRUmBU1Z8vp8bqFjk1Vq+2QJbot51V1FaAfKd+jK1d/Z1e14GBrEek5IVqqugtM/rZ6Du9CoSoYmJGNZ7fsAsvunG4It3sOC3Eoz15P/fFyofgO2N7NsYMfQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlwYK5QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782AEC2BBFC;
	Thu, 30 May 2024 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717087588;
	bh=S3koTg/Gg0yDRSQEsIXG0A5glf4bKujAHcfOsarPm/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IlwYK5QEc5jZojeIE7fls0S6awoOL8B4l93N+JaQvALOU0cEQ7+8h4gC2rLY987Ci
	 BE8D0HY4tUV8DQQaD5ervJmPCmqZM8BlEJk6Y/k1CKNGx8QKMqwEzPLdsnaa3sLayA
	 y4pwKg+DLgS/Iym2vMg7qQhwsNu7b1/QhUmilGouGSfE/qfttx2DhOt6QX2HSIDsjV
	 dftrkgbX+o4IU6UIQlRcCGT2q1EYM54MeIrmhkYmTY7hHI9iqO3ZdSyAwneFQYix68
	 VAzSI+/1e+oceARXg5aaNvsxJ3gvRsyEeTJpngc9fdPrw7EZbategFCxjSEd6guLlO
	 0hM2r6raGOGKg==
Date: Thu, 30 May 2024 11:46:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org,
	Dan Williams <dan.j.williams@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [core-for-CI PATCH] PCI: Make PCI cfg_access_lock lockdep key a
 singleton
Message-ID: <20240530164626.GA550564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529114901.344655-1-imre.deak@intel.com>

[+cc linux-pci, this is a follow-up to 7e89efc6e9e4, which appeared in
v6.10-rc1 via the PCI tree]

On Wed, May 29, 2024 at 02:49:01PM +0300, Imre Deak wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The new lockdep annotation for cfg_access_lock naively registered a new
> key per device. This is overkill and leads to warnings on hash
> collisions at dynamic registration time:
> 
>  WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1226 lockdep_register_key+0xb0/0x240
>  RIP: 0010:lockdep_register_key+0xb0/0x240
>  [..]
>  Call Trace:
>   <TASK>
>   ? __warn+0x8c/0x190
>   ? lockdep_register_key+0xb0/0x240
>   ? report_bug+0x1f8/0x200
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? lockdep_register_key+0xb0/0x240
>   pci_device_add+0x14b/0x560
>   ? pci_setup_device+0x42e/0x6a0
>   pci_scan_single_device+0xa7/0xd0
>   p2sb_scan_and_cache_devfn+0xc/0x90
>   p2sb_fs_init+0x15f/0x170
> 
> Switch to a shared static key for all instances.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Jani Saarinen <jani.saarinen@intel.com>
> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14834/bat-apl-1/boot0.txt
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/probe.c | 7 ++++---
>  include/linux/pci.h | 1 -
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565c..15168881ec941 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2533,6 +2533,8 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>  	dev_set_msi_domain(&dev->dev, d);
>  }
>  
> +static struct lock_class_key cfg_access_key;
> +
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -2546,9 +2548,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> -	lockdep_register_key(&dev->cfg_access_key);
> -	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
> -			 &dev->cfg_access_key, 0);
> +	lockdep_init_map(&dev->cfg_access_lock, "&dev->cfg_access_lock",
> +			 &cfg_access_key, 0);
>  
>  	dma_set_max_seg_size(&dev->dev, 65536);
>  	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e8890..5bece7fd11f88 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -413,7 +413,6 @@ struct pci_dev {
>  	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
>  
>  	bool		match_driver;		/* Skip attaching driver */
> -	struct lock_class_key cfg_access_key;
>  	struct lockdep_map cfg_access_lock;
>  
>  	unsigned int	transparent:1;		/* Subtractive decode bridge */
> -- 
> 2.43.3
> 

