Return-Path: <linux-pci+bounces-8092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BB8D511C
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA041C22EB0
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39A4654D;
	Thu, 30 May 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMrUu6vj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B218757F;
	Thu, 30 May 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090621; cv=none; b=MGSJ6PoON2U+p0c9A6Q0Tdj0u1tWoe2eLzDZvYyh0V1j6K+GD7wHqlzQt3LRXLXedcRhmzDBFjiSeqVX0lygMbgxM2NzZ+3GZHKtKGleCqndrBGnN8SYwqJ8yr6m2cV8N28Jw+19w/zjLvxTMqjKVC/cjJM6Uajr+b+9ImAXEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090621; c=relaxed/simple;
	bh=9buMljHg6Qmc+NqPIB9TuVaIWbL9u2s4lr5fjhfPwIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ikApkVKXkbfFb35GbBqqoSnAUz2A5VcD8Ohv4GOK39FmSN142hbQsTWpuStaXcBGxxVr5+btQuLvneNwpWoXNsH/ePzHmtSa28atvDGP30eqcmeuL/FGaSrJApeb7Dx7HLqPglQcYbusWLMM1BL7WhLiEzFnqrgRyPLLIXXmoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMrUu6vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CFAC2BBFC;
	Thu, 30 May 2024 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717090620;
	bh=9buMljHg6Qmc+NqPIB9TuVaIWbL9u2s4lr5fjhfPwIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dMrUu6vj7i11uoTpdcf6efi9onKMbUwzoy0maDXem35JQdTCIebSRB0VVF53RS9PX
	 nQiaOC3wziFbw/1hZefwb3pcFvVlBNj9Ne8VFXzqETh762aStsKbRDwDzOql3MNoQx
	 Rb534YZThaOkVCJDLBZLD3vEWq5SGa2LUAcTi4kcRSL2EG3uY3dgqzpU7RYLobTAsa
	 0w816ZChwoC4jhf+L9zopmNqmMlGbAdPx5PF5piIP8Rht5/ttd4K7LvkGrWQ2NQAH/
	 vue4E4LuZlAxTtarMWHLynITp0zynt+pXwb3AgE8V9urrOH/XF1epn3NqObpHJ857L
	 JEpLK2O1CeWKQ==
Date: Thu, 30 May 2024 12:36:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Imre Deak <imre.deak@intel.com>, Xinghui Li <korantli@tencent.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
Message-ID: <20240530173659.GA553323@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>

[+cc Alison, Imre, et al.  IIUC this patch didn't help the similar
issue reported by Imre at
https://lore.kernel.org/r/ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com,
but just FYI]

On Tue, May 28, 2024 at 04:22:59PM -0700, Dan Williams wrote:
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

Applied with Alison's reviewed-by and Jani's tested-by to for-linus
for v6.10, thanks!



> ---
> Hi Bjorn,
> 
> One more fallout from the cfg_access_lock lockdep annotation. This one
> still wants a Tested-by from Jani before merging, but wanted to make you
> aware of it in case similar reports make their way to you in the
> meantime.
> 
>  drivers/pci/probe.c |    7 ++++---
>  include/linux/pci.h |    1 -
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..15168881ec94 100644
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
> index fb004fd4e889..5bece7fd11f8 100644
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
> 

