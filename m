Return-Path: <linux-pci+bounces-27166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A28AA96E5
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F205167EDA
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603325C70B;
	Mon,  5 May 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOHEVnfE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32D24E4AA;
	Mon,  5 May 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457516; cv=none; b=UJeUZfTKwnp3YIhjbtd50piOgAU898gzoFZBWwN5Zt0P4bub/Qbuutb8KOCSnekvhOplGV1luA3oGaxQA507Ef5BLXB7nDy3zFjW0OYm43M5iCavnczYoTuAiacP2StIx9ES2jVkChAd4ABJ5mPWcwF81u5Cqm4blE/k0z4GKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457516; c=relaxed/simple;
	bh=5r5Ft/C84qteRJtIQxi4mDS5zxg0pnHRDS6lzVg5xpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqVJBMgXrKLgw9ptmliLQ2PpcOqQYoNVztFh1WgnaYkfvkQGCG1NKq++Fl0bJami6wU1etV6mM71r+W9Mj9Fl65EX5xFt0a8hxckAWnippksVgXmSkcdDg1SGM/UiJOGjA545iEaXO4U3pWuZyNY5sgeKgn3gwVfaDtj6f12PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOHEVnfE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746457515; x=1777993515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5r5Ft/C84qteRJtIQxi4mDS5zxg0pnHRDS6lzVg5xpw=;
  b=JOHEVnfExOEc9yNUcqEOrDm1xn7CvMTk4xmiI0hFdAWkNDjD+t3pwlAh
   KFZ91OrUCSjA3J/+4RJNBYxD1pKjaYKFXxnQ4+X2KHi0gIwrLovg7YehQ
   LizU8Yqs/3rhWPXvuwN6osR/n4DuW1Syj4E9W9F2ahYniKLNsUiiiiGPI
   BGTMnUFGhkHuzTr2jBul/Bs5b6IUL4VUC3LAgAkHYfWqSv1V3IkBsYN/r
   aYOdfrmZbv3DhvgE9O4JmgVgrRsj0Iy8p+yWAXzwyAjR2CyyKiurQZFvG
   PsbCngfi60WOykW/VyTLJJvzrG1ktwtboZuW3t0SHA66L50VGLFxVeP9f
   g==;
X-CSE-ConnectionGUID: s+n3FSa5QYu3KDHLI3bN5Q==
X-CSE-MsgGUID: 9CajUO9lRCWo3QukKZD9bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47333042"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47333042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:05:04 -0700
X-CSE-ConnectionGUID: 7iQvoTw9QJaUQk0dLNvmzw==
X-CSE-MsgGUID: Alh6lKy+RyWqXWE7NyIKBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135255177"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.111.34]) ([10.125.111.34])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:05:03 -0700
Message-ID: <1f315645-4afd-49f1-b259-bac8911dd67a@intel.com>
Date: Mon, 5 May 2025 08:05:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Moshe Shemesh <moshe@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Keith Busch <kbusch@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/5/25 4:54 AM, Ilpo Järvinen wrote:
> The commit a4e772898f8b ("PCI: Add missing bridge lock to
> pci_bus_lock()") made the lock function to call depend on
> dev->subordinate but left pci_slot_unlock() unmodified creating locking
> asymmetry compared with pci_slot_lock().
> 
> Because of the asymmetric lock handling, the same bridge device is
> unlocked twice. First pci_bus_unlock() unlocks bus->self and then
> pci_slot_unlock() will unconditionally unlock the same bridge device.
> 
> Move pci_dev_unlock() inside an else branch to match the logic in
> pci_slot_lock().
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> v2:
> - Improve changelog (Lukas)
> - Added Cc stable
> 
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..26507aa906d7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5542,7 +5542,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
>  			continue;
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  }
>  
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8


