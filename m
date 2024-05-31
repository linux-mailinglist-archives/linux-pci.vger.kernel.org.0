Return-Path: <linux-pci+bounces-8138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E088D68B8
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 20:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BF51C255CE
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65179158D9C;
	Fri, 31 May 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrBC/8N+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE517CA04;
	Fri, 31 May 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178862; cv=none; b=k8zTNFNj5GXx/nXtQe3IortW7A/IeqW8pdQ3xWHPN2Ial6LmFh7Ww7E2qf6P0uTbpDQhoWS/og0doKmeBQF6BxihuxUPtLzLalQjP67vr38qyXHB52u/hyeg5SIT2rco4OMdn7Asl+rsEnPDYSHcsAiZRwjS49hgKCxuVrSxsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178862; c=relaxed/simple;
	bh=5xBLIokhSdTKQTltXH3IaiwsASfULEXDoz8Q/jlaLrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6ooPASySKobH94X6Dymu+RSraSoYZj2tseCavAe7u+IWbgRz0stQOMWScW2pffsAyKIXT4kOMUGJFSz0RJYANLiT2FgTnyJ6aOpt5Hnufuuf0TJQOQdJafZX/aorVHCfbyjM02mDEykEHnhpo7ObJ41V/KHvl0hfKoHwEMhkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrBC/8N+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717178861; x=1748714861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5xBLIokhSdTKQTltXH3IaiwsASfULEXDoz8Q/jlaLrA=;
  b=PrBC/8N+vunYADKURg77BBdtlovZqjp6LYgDsYCqSDxfVrWcb15XiGCh
   Y22Pmx+DXKHJ0YYzxZKoM1WmXAbfHOqYvMMNM9TId6Z14e/AyuFvj2/WJ
   BeJJYjxzsKA8mSL1R5bww+zV70BKombbZCULVG6hFocVpA7cQzp5kGVCh
   bLrbuTgTRakbI8TjO6WvAV9tLBf7ZDfpD6qiW3V15PMlGhuHZDkYYwLyL
   D3WDeDby+fSUCRjOJe42lN/kiHyENIGtq9aXwCp09TTwEllEc1xXYVFKP
   umMtPJ0yOtoYfQpR5SwDkDufc3U+9gypABh9AIhZ/3TA22JQ+IGW6uOjI
   A==;
X-CSE-ConnectionGUID: HF4s9UbQTg2D/55ROKK+fQ==
X-CSE-MsgGUID: i+p+OBrjSzeqBIkKa1JdiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24310557"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="24310557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:07:40 -0700
X-CSE-ConnectionGUID: ft8fCrh4Sb6tcu2/Ff8bdA==
X-CSE-MsgGUID: ALSPyTDRTuCYtm8kXaYPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67077254"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:07:40 -0700
Message-ID: <b07b57e5-eb7b-4e56-b241-7433616edf11@intel.com>
Date: Fri, 31 May 2024 11:07:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: Add missing bridge lock to pci_bus_lock()
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Imre Deak <imre.deak@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
 <171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 6:04 PM, Dan Williams wrote:
> One of the true positives that the cfg_access_lock lockdep effort
> identified is this sequence:
> 
>  WARNING: CPU: 14 PID: 1 at drivers/pci/pci.c:4886 pci_bridge_secondary_bus_reset+0x5d/0x70
>  RIP: 0010:pci_bridge_secondary_bus_reset+0x5d/0x70
>  Call Trace:
>   <TASK>
>   ? __warn+0x8c/0x190
>   ? pci_bridge_secondary_bus_reset+0x5d/0x70
>   ? report_bug+0x1f8/0x200
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? pci_bridge_secondary_bus_reset+0x5d/0x70
>   pci_reset_bus+0x1d8/0x270
>   vmd_probe+0x778/0xa10
>   pci_device_probe+0x95/0x120
> 
> Where pci_reset_bus() users are triggering unlocked secondary bus
> resets. Ironically pci_bus_reset(), several calls down from
> pci_reset_bus(), uses pci_bus_lock() before issuing the reset which
> locks everything *but* the bridge itself.
> 
> For the same motivation as adding:
> 
>     bridge = pci_upstream_bridge(dev);
>     if (bridge)
>             pci_dev_lock(bridge);
> 
> ...to pci_reset_function() for the "bus" and "cxl_bus" reset cases, add
> pci_dev_lock() for @bus->self to pci_bus_lock().
> 
> Reported-by: Imre Deak <imre.deak@intel.com>
> Closes: http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/pci.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8df32a3a0979..aac5daad3188 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5444,6 +5444,7 @@ static void pci_bus_lock(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> +	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		pci_dev_lock(dev);
>  		if (dev->subordinate)
> @@ -5461,6 +5462,7 @@ static void pci_bus_unlock(struct pci_bus *bus)
>  			pci_bus_unlock(dev->subordinate);
>  		pci_dev_unlock(dev);
>  	}
> +	pci_dev_unlock(bus->self);
>  }
>  
>  /* Return 1 on successful lock, 0 on contention */
> @@ -5468,6 +5470,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> +	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (!pci_dev_trylock(dev))
>  			goto unlock;
> @@ -5486,6 +5489,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  			pci_bus_unlock(dev->subordinate);
>  		pci_dev_unlock(dev);
>  	}
> +	pci_dev_unlock(bus->self);
>  	return 0;
>  }
>  
> 

