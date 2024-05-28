Return-Path: <linux-pci+bounces-7906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670F8D207E
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC211F2418C
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585517083A;
	Tue, 28 May 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1euXU2n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3317107A;
	Tue, 28 May 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910512; cv=none; b=Oh7f9b0PuIUma0vVpYcURzWnzu+5hovOtcbw4jpGMu/DSVe5417OxqYYKPFT9XlIkzrwbFKMOPnko5DiePoZpVE7y+TMsU8iq1cyqUJrwbQK3Y300Gm2mAUwWk/ADm2CqmIXHW+a4npcsTOuCoP0M8Vop7KhHRJXwep/ZZU8YMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910512; c=relaxed/simple;
	bh=tEA7hAUQDhyFEnbCwwjaP6WnZphF2rQRAKuyq9ZxMyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcXQfC8FitoEYA/iKtp9ww1nlgphzKja1G/vxm7hMDe544IMq3+77HDDasNkjzXDTYi6CD/Mz7izkyWblFAX/LEJE0BZ710HK9XgGPnODPfH4wGnCbrQiZL7xLSSEEd6OYy24PAnBsu9sBmfRoO/Casac0ZrpieQwBHl9JwMZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1euXU2n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716910510; x=1748446510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tEA7hAUQDhyFEnbCwwjaP6WnZphF2rQRAKuyq9ZxMyI=;
  b=Y1euXU2n/dt96kKRG1QA6AoOuPGQzpvspy0XR/jsCmGajhlMO580gjaT
   p+KR1UOnFG1lvD2+XlmszxGZZcN+jdVx2ktXQiVQEzTpFgNsuGeGA7g66
   Cl6xmzUpnxZqtF7lofI9FD7LGL+kdK3Q1GIlW0MoiXxAoLMbMM9frRxYL
   tmPY8JAadWCEZqVihDLTN9u8wlhBPsbgX8uz2xnWqog76N2ec+Xbsyx3Q
   /E1b52s5wO31a6ZSUlsUbrmqxMWA4OhTpDc3eiu4FHrWrHM1Y7B15HGk1
   /QRlvMY5gavZOSKFyVGa/ew3U8IIqI3Xuo8yzUPENFqAefvZiZNyDhV5D
   A==;
X-CSE-ConnectionGUID: Poyqw94dS+6WQYp278J3Hg==
X-CSE-MsgGUID: xo3dQ09ER/WFULj8UfKy+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="35781185"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35781185"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:35:09 -0700
X-CSE-ConnectionGUID: 3V6Q+ii3Q0iNb9omPc/5Sw==
X-CSE-MsgGUID: wEIXtmCnTtmBKhPcaPEk6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39934100"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.9]) ([10.125.111.9])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:35:09 -0700
Message-ID: <da90b57e-748a-4311-9f89-531c5b65e937@intel.com>
Date: Tue, 28 May 2024 08:35:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix missing lockdep annotation for
 pci_cfg_access_trylock()
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/24/24 6:19 PM, Dan Williams wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

