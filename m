Return-Path: <linux-pci+bounces-3993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E1866A2F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A559B2826FC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 06:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE300175BE;
	Mon, 26 Feb 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM1PCc2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC414267;
	Mon, 26 Feb 2024 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929857; cv=none; b=YoVjDspOO68XEKN8xXkWhKS7ap+d0kQXenZxqjqkYHaihqc0vRzTN0JAdB7F7cft8nktFIkCZxIgk3Y/g6N55dHgQy5UYeD5ArlNiea6IwawvvjTB7kMFU4vtqsywuHkhooxSQWgDIGZEBxIQUW8+pj15rCZ/C3JNRc+XaaaZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929857; c=relaxed/simple;
	bh=vsFafeCbwcDL7yhjwGb9jr8hq1fqF5uEqzU7YI85HPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjEvQo2vKqgQ/9xEDDa7clMSMZDLXrJ9DSQ17xORO+dxYxJxqz5/js8vX7SUoOPJejN+kAOQsRR4amrlFRqReEurZ/FcPNfFTRU3V1HkK8sm4goRC6kNVGxnRqZrXTVZQ8v6jM+FyTIabYTaghow7KnHtPhycyoHM3Y5WxyPIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM1PCc2h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708929856; x=1740465856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsFafeCbwcDL7yhjwGb9jr8hq1fqF5uEqzU7YI85HPM=;
  b=LM1PCc2h+CYpAZbhq1X2AB5Y8xMkP/N/TM75ipOwZWZLP11ZCVe1AP48
   iboT3CNmx8F+fL76m+0T9Zks2nAkiEiDoizVu6fUK+TsK4HlouuuVHC0S
   x4voQhdDLh9EaFjOcFqrDsfeLGnEP1oTowLpwvs+CZlANYJkSi987W55k
   0OJoomP+wADh2ZMfzVrRKHu/gFfqpBszPnfOZfQe3WGWyhTLPTkTCzAMi
   zmW7luQUP8IVzVh07uPzpTpvOuB+YpQdzPUHixmGBIzCWty95G+LUAoke
   XwyLPTnamCkEWalCcu36Qv/MAIM7IZG/cjDz3OQ1L4A9lu3VfUt+IVAcY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7014240"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7014240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6992085"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:44:15 -0800
Message-ID: <d1ff16a1-bf7e-4704-93b8-4122b739583f@linux.intel.com>
Date: Sun, 25 Feb 2024 22:44:14 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] PCI/ASPM: Always build aspm.c
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "David E . Box" <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Tasev Nikola <tasev.stefanoska@skynet.be>,
 Mark Enriquez <enriquezmark36@gmail.com>, Thomas Witt <kernel@witt.link>,
 Werner Sembach <wse@tuxedocomputers.com>, Vidya Sagar <vidyas@nvidia.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Ricky Wu
 <ricky_wu@realtek.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240223205851.114931-1-helgaas@kernel.org>
 <20240223205851.114931-3-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240223205851.114931-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/23/24 12:58 PM, Bjorn Helgaas wrote:
> From: "David E. Box" <david.e.box@linux.intel.com>
>
> Some ASPM-related tasks, such as save and restore of LTR and L1SS
> capabilities, still need to be performed when CONFIG_PCIEASPM is not
> enabled. To prepare for these changes, wrap the current code in aspm.c
> with an #ifdef and always build the file.

Since save/restore needs to be called even if CONFIG_PCIEASPM is
not set, why not just leave it in pci.c?

>
> Link: https://lore.kernel.org/r/20240128233212.1139663-2-david.e.box@linux.intel.com
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> [bhelgaas: split build change from function moves]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/Makefile | 2 +-
>  drivers/pci/pcie/aspm.c   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 8de4ed5f98f1..6461aa93fe76 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -6,7 +6,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> -obj-$(CONFIG_PCIEASPM)		+= aspm.o
> +obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index d1538f73f2f9..d50c0f83430f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -24,6 +24,8 @@
>  
>  #include "../pci.h"
>  
> +#ifdef CONFIG_PCIEASPM
> +
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
>  #endif
> @@ -1517,3 +1519,5 @@ bool pcie_aspm_support_enabled(void)
>  {
>  	return aspm_support_enabled;
>  }
> +
> +#endif /* CONFIG_PCIEASPM */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


