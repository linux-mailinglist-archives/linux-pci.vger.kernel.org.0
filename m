Return-Path: <linux-pci+bounces-3135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86284B10C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DE9B248E3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1112D17B;
	Tue,  6 Feb 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jl0XwONF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C91EEE7;
	Tue,  6 Feb 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211380; cv=none; b=rl4vTy1nnwYll/0x6jxWVlDOxZggIcG3G7TT6dU/QRQ6P6cTk3oi+IvUAgPqwsghEcEH+SLDxjNzCrlMzYZaGvTndQvA0ONpGZ/PbnzZ66QHWghfeXsWq+Wt8/xJv4qVX7Wbmm1bQr7trKizBtmLgIGqN1VRSjkM6f12ph5WW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211380; c=relaxed/simple;
	bh=wGhd/unf0fYU1o8LjNIAvtzdEgbDXJYKG7LEIgeuTi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp8B543xRQUYqITXBsS+hnVWH97eku8SlpKKWfYOhayi1Y4e9yg1y26k0byGRiH8G+L4/VK2NCaUX53O6Zv1ESTaskkTi77A3lV64AHn8+sUXcjPDmdDVZmehkBLP5iAU6pBFnQF9emgnblKzGAzA3/I9EAMhlsMUPlmv4qkmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jl0XwONF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707211379; x=1738747379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wGhd/unf0fYU1o8LjNIAvtzdEgbDXJYKG7LEIgeuTi0=;
  b=Jl0XwONFzeOUnxigKARBY/1MH0OmpnmWtmJSkCswAb341v2gTAtLZf7u
   /1aamBpvZn/ZxUagZt6w1uv4eJUzzZVMY4ZAEMfoHk6PJH+bdUbdGnPzI
   hKAKM1H3vn7X8947+eJjcfVgEPCJgbVxEBvugaEMac4qVSfIKVe20IMHe
   QjW5R4kg8e/cqsPX42nS8BQlZ1Ry2K8nfXORaSplLAvTElSbVOdhaO3R8
   CbEFjA9A+wgjfpUPZ64Y/k0KKk/cde2kiECNDbaqAtM09PoqSHHyyHNZU
   gR9tSL0QVsTpc7r4dvACsyfZX2nRGfEeKRpb0ETW5B0bUI9nkX0zoIfOH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4586589"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="4586589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5584122"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:22:51 -0800
Date: Tue, 6 Feb 2024 10:22:49 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com
Subject: Re: [PATCH 1/2] drivers: acpi: use %pe for better readability of
 errors while printing
Message-ID: <ZcH6aTx4Nf3s5a9n@linux.intel.com>
References: <CGME20240206051218epcas5p3fddd971ec73f6ee6a2b0a5ec2709c0f7@epcas5p3.samsung.com>
 <20240206051120.4173475-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051120.4173475-1-onkarnath.1@samsung.com>

On Tue, Feb 06, 2024 at 10:41:19AM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> As %pe is already introduced, its better to use it inplace of (%ld) for
> printing errors in logs. It would enhance redability of logs.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  drivers/acpi/acpi_watchdog.c  | 2 +-
>  drivers/acpi/pci_slot.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 4fe2ef54088c..2ddd36a21850 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -161,7 +161,7 @@ static void cpufreq_add_device(const char *name)
>  
>  	pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL, 0);
>  	if (IS_ERR(pdev))
> -		pr_info("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
> +		pr_info("%s device creation failed: %pe\n", name, pdev);
>  }
>  
>  #ifdef CONFIG_X86
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 8e9e001da38f..14b24157799c 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -179,7 +179,7 @@ void __init acpi_watchdog_init(void)
>  	pdev = platform_device_register_simple("wdat_wdt", PLATFORM_DEVID_NONE,
>  					       resources, nresources);
>  	if (IS_ERR(pdev))
> -		pr_err("Device creation failed: %ld\n", PTR_ERR(pdev));
> +		pr_err("Device creation failed: %pe\n", pdev);
>  
>  	kfree(resources);
>  
> diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
> index d6cb2c27a23b..741bcc9d6d6a 100644
> --- a/drivers/acpi/pci_slot.c
> +++ b/drivers/acpi/pci_slot.c
> @@ -111,7 +111,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
>  	snprintf(name, sizeof(name), "%llu", sun);
>  	pci_slot = pci_create_slot(pci_bus, device, name, NULL);
>  	if (IS_ERR(pci_slot)) {
> -		pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
> +		pr_err("pci_create_slot returned %pe\n", pci_slot);
>  		kfree(slot);
>  		return AE_OK;
>  	}
> -- 
> 2.25.1
> 
> 

