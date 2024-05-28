Return-Path: <linux-pci+bounces-7949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EDB8D28B4
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 01:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC16B213BD
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC113EFEC;
	Tue, 28 May 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUBRpwuy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D713E040;
	Tue, 28 May 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938744; cv=none; b=HrnPPCJ2QbbO/na8C2z2VHWque6oOgn5wrMzkB6LDvH/0VDd+NfPBjuwG4zttowKeFeJv43RoZA4bO8EJPSmniaCN9BCmMvtzw4pC8gNRqXi1CKBRkxXd34fO75T3DJebx67thld7e5RAyeQn/SNYfmzXQUfEn6a8bW2KztdwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938744; c=relaxed/simple;
	bh=+OjdnvVxrosNviqcLYcJtOSgzE9VkrFf5aqnXPJI/30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BC4Q7icpWrxitB0rHi9Je30N2pMMxCfV7gHILyM5XAHAhdL93cj1Z/dgqpB5fPU1FCJdpYXtqrUSfDpz4u8BeeXBD+2IGv/s/qeliQRGDYxER4TUFg9gjemEIPnAunWdqsOFuDNpEDjajQnvV5l/67bdQ33l7MQQNuZGlR0RJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUBRpwuy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716938743; x=1748474743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+OjdnvVxrosNviqcLYcJtOSgzE9VkrFf5aqnXPJI/30=;
  b=kUBRpwuyh/tlJqhJ9kGyieE69Xud4i1bRlLOaJawPqBS711pkVgI4OWA
   bUdPKOgoiaTJewiUBmD6G2CC4ppg45biz9mG9qmFf4Fb5LWgw976Hdn88
   3JAJUlghfNT0dWsQDXGr9SpfiYeFCOpUkSCc91ZVWOezL4GHfKLIC3VJC
   VPq+r2yDqHWQsnJcar59C0htSA9+hEu67RejwciSS+M1YJ4RG0qVETBR+
   NoRjYMkLk9Mm6k49zf3HiJ/xubXjs1uu1Qcg/ZGl3My93Y677+q2UKJds
   OHQfcuP2bmvnbsTzzDMjKXFNbXqUL4Soz1NHMlUKt0u25uNY/3TXu3eK0
   A==;
X-CSE-ConnectionGUID: acshq1DQT0egMsyvKkEniw==
X-CSE-MsgGUID: gwYXOzhHTsS36JOYZW0aQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30817050"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30817050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:25:42 -0700
X-CSE-ConnectionGUID: rQWkZPYKQTyPGuNuP3oswQ==
X-CSE-MsgGUID: OH1idUQPRlqvagrys08OUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="66422043"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.9]) ([10.125.111.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:25:41 -0700
Message-ID: <69703e18-5a11-41c9-b8af-25007b4f6c2d@intel.com>
Date: Tue, 28 May 2024 16:25:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Jani Saarinen <jani.saarinen@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 4:22 PM, Dan Williams wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

