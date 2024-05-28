Return-Path: <linux-pci+bounces-7944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9E8D27D4
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 00:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C3D1C242D5
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC2C13DDAC;
	Tue, 28 May 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdKTgLKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF028DC7;
	Tue, 28 May 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934725; cv=none; b=CJKHupRZXgfZnsGxXdvNlo2MemLBV9TUD3+JY7z3XtOQjIVaCVrpJ+6KXJldervhK7bzqb4swFMlNHKZaW/WZMog38z7Us3kstWbGb3QmafpDAIRk0+R/Vr3NuCo8GMldxtvhAz8wk2g5XCQTmFZl+bENGL0zNNQFbkpiDSuAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934725; c=relaxed/simple;
	bh=nyzjDAQW+Z92/cn5x7oUg2VlrfmIFMr5x6gsYZG3gH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lz+7wKivvuwwrv18UX/TP5SQ6Hg1injqpHkS898CvR2Z2O32qMLvP9DTeaqQqobMqJnUvQgKyYf5DnNFSXrSZIKirhNuFp6SkODHBTU0jUZb0wnKyEzhLtNbaE+Dc4AOIl/5uOr2FImlb+XBTGP7pUCKLp1WKyDuefZa9jJN+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdKTgLKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D69EC3277B;
	Tue, 28 May 2024 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716934724;
	bh=nyzjDAQW+Z92/cn5x7oUg2VlrfmIFMr5x6gsYZG3gH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sdKTgLKG97YSgirZyw8kqYy9gjg0IMHXJk2jRmg2xVokADDTfAX23TZB7UM+M83tR
	 EDYfk06IqdSkcNSQeoPn6HciO5J2VuZnKA9KOR+MHDyREy00JxxEoM4gk0gzKzfvSR
	 tDIVuDRjbZVKUTPvm2OX3q0ytEKV4P9bUmDoiqNNXyEIqi3/+bcqlBx1VkTxcJMz5X
	 LBC6Kr34Q8nJYq8GkInjqT2xEIa3uzT+Yvts1QWgLVsVNki7ULRuN1/VUDgyJ/MSur
	 CePXdz5DqJTYDrwHZVpI/nf8K5Dxlg7MLVTh521ds790oc3hd3cBntCC9Z0ZAFnkkO
	 2om3CO29iP2zA==
Date: Tue, 28 May 2024 17:18:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix missing lockdep annotation for
 pci_cfg_access_trylock()
Message-ID: <20240528221842.GA472790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com>

On Fri, May 24, 2024 at 06:19:13PM -0700, Dan Williams wrote:
> Alex reports a new vfio-pci lockdep warning resulting from the
> cfg_access_lock lock_map added recently.
> 
> Add the missing annotation to pci_cfg_access_trylock() and adjust the
> lock_map acquisition to be symmetrical relative to pci_lock.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: http://lore.kernel.org/r/20240523131005.5578e3de.alex.williamson@redhat.com
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied with Dave's Reviewed-by to for-linus for v6.10, thanks!

> ---
>  drivers/pci/access.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 30f031de9cfe..3595130ff719 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -289,11 +289,10 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  {
>  	might_sleep();
>  
> -	lock_map_acquire(&dev->cfg_access_lock);
> -
>  	raw_spin_lock_irq(&pci_lock);
>  	if (dev->block_cfg_access)
>  		pci_wait_cfg(dev);
> +	lock_map_acquire(&dev->cfg_access_lock);
>  	dev->block_cfg_access = 1;
>  	raw_spin_unlock_irq(&pci_lock);
>  }
> @@ -315,8 +314,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
>  	raw_spin_lock_irqsave(&pci_lock, flags);
>  	if (dev->block_cfg_access)
>  		locked = false;
> -	else
> +	else {
> +		lock_map_acquire(&dev->cfg_access_lock);
>  		dev->block_cfg_access = 1;
> +	}
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	return locked;
> @@ -342,11 +343,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	WARN_ON(!dev->block_cfg_access);
>  
>  	dev->block_cfg_access = 0;
> +	lock_map_release(&dev->cfg_access_lock);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> -
> -	lock_map_release(&dev->cfg_access_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> 

