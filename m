Return-Path: <linux-pci+bounces-27906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10BABA819
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 06:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8EB7A8B6C
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90B16EB7C;
	Sat, 17 May 2025 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V27hXb6G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7DB667;
	Sat, 17 May 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747454872; cv=none; b=ryhPiL+LMk6h3K7EpeWHL4BzGU7QeDc2hgrAOeWwi4Te3Hl79Q6dDEb3XQRGAOVUAfwbpKh//fh7HcR5ukDqEgeJD38Cy9PJDuOMWNwxwfuYSofIxZnm1UPv8HRgHEre9GuF26vMm8kiwVLEHdBAwMwVq52/p93gIDw1C/kQUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747454872; c=relaxed/simple;
	bh=W77C6inCM1GhXjW9NEVyDcxLiPphMZW3DuLr/4gjI4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZT57ayEDm3FE0jkFd4NjrKACH/ezK10r+2DdG4sQ/IFKnKVUFDK8aapflEueBoBt9r/e0kXXE/bSEviNTL0f4IqXYFN60UZEtm63RPBsJexveKSjqlsasugOS3OFwESTJffpaSQOBuCXD8RrP+s5Yxf6U7JEABK/E0NMbIXu54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V27hXb6G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747454870; x=1778990870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W77C6inCM1GhXjW9NEVyDcxLiPphMZW3DuLr/4gjI4o=;
  b=V27hXb6GyC4MsumfAE+FiX4bapyuT/aHAiZvVYZIRfWcheiD21YRvizT
   SrZCGTlUoComXeCMmTZhCl5420yg6+1rak6hZZ03RgpdQ5xogAOSzecXi
   5qQCdd4SQ4bn0/iYx6GfydM7frfQAR9ZoWa5Cd4kvzedITh3+T4o4D8Es
   aWIDuCUGuDLiT2vi9MEX1jqQIWp0a4D7HYpkocuQ789xFWiJo89dTQ6hQ
   3SeMd5xkkuGlp2Sl9GyRUhB5iCmZBx/Ykum7kQNGWTPwQ2jfI9r/8bP0g
   8sa9jfO2X5ggqNPcCLYFwC4yPFLMJwUg38G3L7A+gAk/W7+fkYJPLppqA
   Q==;
X-CSE-ConnectionGUID: xB5D9xYzSeSSjaFhQXmaOg==
X-CSE-MsgGUID: DJT/q2nTQ9K8fnIcVPWEQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66983839"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="66983839"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 21:07:50 -0700
X-CSE-ConnectionGUID: xspjS1dxSqyEjIEnsuE9wQ==
X-CSE-MsgGUID: nTXEVbBdRa+4hJZ3fPYxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="142857282"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.220.144]) ([10.124.220.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 21:07:49 -0700
Message-ID: <6d946767-aa61-441d-965b-115e415bfd4f@linux.intel.com>
Date: Fri, 16 May 2025 21:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI/AER: Expose AER panic state via
 pci_aer_panic_enabled()
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 tglx@linutronix.de, kw@linux.com, manivannan.sadhasivam@linaro.org,
 mahesh@linux.ibm.com
Cc: oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Hans Zhang <hans.zhang@cixtech.com>
References: <20250516165518.125495-1-18255117159@163.com>
 <20250516165518.125495-4-18255117159@163.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250516165518.125495-4-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/16/25 9:55 AM, Hans Zhang wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
>
> Add pci_aer_panic_enabled() to check if aer_panic is enabled system-wide.
> Export the function for use in error recovery logic.
>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>   drivers/pci/pci.h      |  2 ++
>   drivers/pci/pcie/aer.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 8ddfc1677eeb..f92928dadc6a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -959,6 +959,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
>   #ifdef CONFIG_PCIEAER
>   void pci_no_aer(void);
>   void pci_aer_panic(void);
> +bool pci_aer_panic_enabled(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
>   extern const struct attribute_group aer_stats_attr_group;
> @@ -970,6 +971,7 @@ void pci_restore_aer_state(struct pci_dev *dev);
>   #else
>   static inline void pci_no_aer(void) { }
>   static inline void pci_aer_panic(void) { }
> +static inline bool pci_aer_panic_enabled(void) { return false; }
>   static inline void pci_aer_init(struct pci_dev *d) { }
>   static inline void pci_aer_exit(struct pci_dev *d) { }
>   static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index fa51fb8a5fe7..4fd7db90b77c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -125,6 +125,18 @@ void pci_aer_panic(void)
>   	pcie_aer_panic = true;
>   }
>   
> +/**
> + * pci_aer_panic_enabled() - Are AER panic enabled system-wide?
> + *
> + * Return: true if AER panic has not been globally disabled through ACPI FADT,
> + * PCI bridge quirks, or the "pci=aer_panic" kernel command-line option.

I don't think we have code to disable it via ACPI FADT or PCI bridge quirks
currently, right? If yes, just list what is currently supported.

> + */
> +bool pci_aer_panic_enabled(void)
> +{
> +	return pcie_aer_panic;
> +}
> +EXPORT_SYMBOL(pci_aer_panic_enabled);
> +
>   bool pci_aer_available(void)
>   {
>   	return !pcie_aer_disable && pci_msi_enabled();

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


