Return-Path: <linux-pci+bounces-8136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B5C8D68AC
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8301C22E32
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B178C88;
	Fri, 31 May 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggKSRH3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12E7711B;
	Fri, 31 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178722; cv=none; b=ozP+UgoHxb6EkBdGqwiQ1xLPuFxcoearX+3Hac7wuYQpk14um3VbYzGxtiJL93cLZfD0lI6kXh+yMzTSe0xpprg0t/7WlcU/hJVSC5gxCQihq8NVFMkAEdABvfGID9a2O7XKHGYcIi4/as3KLaeFSz55LNNOD4V5dfRgowo4s8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178722; c=relaxed/simple;
	bh=PavM7pnI74JJIrRS+Fp3OiHrscpvsm7T39ur/PI6HgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW54Nq7232OALVTCS0FFABAxNGk3iese5J2ibBMJCkt4d2ZCP9ik7cfXETPVDnkt3GOTXMxmN30/7UJFzCu3ZoA74c2O128xgTe/r7Zi4mRc7RF4e93BEX18/bHwdzFV6cMR7pgP9GNDeZJC45m8BKTyS8E6dMRpRMx4XBJWH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggKSRH3f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717178721; x=1748714721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PavM7pnI74JJIrRS+Fp3OiHrscpvsm7T39ur/PI6HgU=;
  b=ggKSRH3faxaAsoUMr9UCYO7imk/YYLjX0T1n0TPD/o+2qxENZLMoprZY
   GKy1YVPMYO14mTDBGY5Gvd73JgSKgMWqtiB20X9W4FlEiEaH6c3hfp45w
   Mm+fN2sTLT7CVZZNa2cN1L1nRcg+6lPhOzsr7KpRjOxFE2Q6nTU55FsE+
   skozCljsTTM71O1FsIPZfzIIg+I+kq91bolyv6U1ZWJDhCQgu4SyKxaL6
   jnYDRTKA8EIKgt2fhkt2149ULwz9BT0d+5O7ZUYKJ9uvlHsW2uCnuqRje
   1QDi0qh+aPHTP+MwOUzXFupvB4g408Htvzh12b4df9RKe3aj7YaAIbF5S
   g==;
X-CSE-ConnectionGUID: 7RIhQqvNRVyXY8a1GpElDQ==
X-CSE-MsgGUID: zAH3kqBPRl+mRL089dfOKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13603218"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13603218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:05:20 -0700
X-CSE-ConnectionGUID: QoZEaMWDShiDy5l+uFKC+A==
X-CSE-MsgGUID: XbPLvvFsRVSC+E6PXFHX0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36181410"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:05:20 -0700
Message-ID: <a5cf826c-1a7c-44b3-9ae0-9aa64b55964b@intel.com>
Date: Fri, 31 May 2024 11:05:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: Revert the cfg_access_lock lockdep mechanism
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Imre Deak <imre.deak@intel.com>, Jani Saarinen <jani.saarinen@intel.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
 <171711746402.1628941.14575335981264103013.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <171711746402.1628941.14575335981264103013.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 6:04 PM, Dan Williams wrote:
> While the experiment did reveal that there are additional places that
> are missing the lock during secondary bus reset, one of the places that
> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> lockdep annotation.
> 
> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> currently dependent on the fact that the device_lock() is marked
> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> annotation, pci_bus_lock() would need to use something like a new
> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> the topology, and a hope that the depth of a PCI tree never exceeds the
> max value for a lockdep subclass.
> 
> The alternative to ripping out the lockdep coverage would be to deploy a
> dynamic lock key for every PCI device. Unfortunately, there is evidence
> that increasing the number of keys that lockdep needs to track to be
> per-PCI-device is prohibitively expensive for something like the
> cfg_access_lock.
> 
> The main motivation for adding the annotation in the first place was to
> catch unlocked secondary bus resets, not necessarily catch lock ordering
> problems between cfg_access_lock and other locks. Solve that narrower
> problem with follow-on patches, and just due to targeted revert for now.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Imre Deak <imre.deak@intel.com>
> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> Cc: Jani Saarinen <jani.saarinen@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/access.c    |    4 ----
>  drivers/pci/pci.c       |    1 -
>  drivers/pci/probe.c     |    3 ---
>  include/linux/lockdep.h |    5 -----
>  include/linux/pci.h     |    2 --
>  5 files changed, 15 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 30f031de9cfe..b123da16b63b 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -289,8 +289,6 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  {
>  	might_sleep();
>  
> -	lock_map_acquire(&dev->cfg_access_lock);
> -
>  	raw_spin_lock_irq(&pci_lock);
>  	if (dev->block_cfg_access)
>  		pci_wait_cfg(dev);
> @@ -345,8 +343,6 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> -
> -	lock_map_release(&dev->cfg_access_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59e0949fb079..35fb1f17a589 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4883,7 +4883,6 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>   */
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
> -	lock_map_assert_held(&dev->cfg_access_lock);
>  	pcibios_reset_secondary_bus(dev);
>  
>  	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..5fbabb4e3425 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2546,9 +2546,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> -	lockdep_register_key(&dev->cfg_access_key);
> -	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
> -			 &dev->cfg_access_key, 0);
>  
>  	dma_set_max_seg_size(&dev->dev, 65536);
>  	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 5e51b0de4c4b..08b0d1d9d78b 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -297,9 +297,6 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
>  		.wait_type_inner = _wait_type,		\
>  		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
>  
> -#define lock_map_assert_held(l)		\
> -	lockdep_assert(lock_is_held(l) != LOCK_STATE_NOT_HELD)
> -
>  #else /* !CONFIG_LOCKDEP */
>  
>  static inline void lockdep_init_task(struct task_struct *task)
> @@ -391,8 +388,6 @@ extern int lockdep_is_held(const void *);
>  #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
>  	struct lockdep_map __maybe_unused _name = {}
>  
> -#define lock_map_assert_held(l)			do { (void)(l); } while (0)
> -
>  #endif /* !LOCKDEP */
>  
>  #ifdef CONFIG_PROVE_LOCKING
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..cafc5ab1cbcb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -413,8 +413,6 @@ struct pci_dev {
>  	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
>  
>  	bool		match_driver;		/* Skip attaching driver */
> -	struct lock_class_key cfg_access_key;
> -	struct lockdep_map cfg_access_lock;
>  
>  	unsigned int	transparent:1;		/* Subtractive decode bridge */
>  	unsigned int	io_window:1;		/* Bridge has I/O window */
> 

