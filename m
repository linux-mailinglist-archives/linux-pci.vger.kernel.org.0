Return-Path: <linux-pci+bounces-3983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE548862CB5
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE6281C9C
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DD17997;
	Sun, 25 Feb 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4XWjAC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0641B597;
	Sun, 25 Feb 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891520; cv=none; b=DPPoSxEzayZjLiuv8PMrC/W1aKjmQ5g6rP8DwaW2/yDNiyeflW9w+Xeu3zrZODnxaiebCjTx//0ix13skYGYava2jY6o1T265qdQ2/zehNCbZ8NoASOQUqfiKFxCj1upJih1c7OsUYm2unKfdQDusT11VnJPtLsAENZGu/OWl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891520; c=relaxed/simple;
	bh=mtw/2VKkEd9hkpLcOoUplSmiseLh50n7k0eGQOVMFO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDY6vSilgcBEJJCypVa/6aYpcZ87UdueYAAZMkC6e8wXo6nkCdQWq1ehYmybEk3U3irVrLkbngQZGpYve1JVaE99F160+r8K/gf7/2ofXqSgcZe2/yMyTYjzUzXMWvCZmP2BweP1XP4TaRKODDyhjuuoi6OepX/mAKaqk4PvpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4XWjAC0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891519; x=1740427519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtw/2VKkEd9hkpLcOoUplSmiseLh50n7k0eGQOVMFO0=;
  b=W4XWjAC0VI0/+1ohP34HzVUdqt0335mcustB/D68/ShmHo1a9h0CAcHX
   xpIDCzpv5roxeJi4rnppELGYnxMUcifoxhgDw25/ylN6crOA9tc8n3vWP
   TAj+9QnaqYNtCtjqMcgfbs/odSE4tDU5VTQtZcU0VWrIakxkex7vS7DC4
   Er3XeWSFjlB+VPENd17Phvu+yvmwYxikWCZ7yQTMvgu6foTqt75wS2AEe
   MQCrFSuuMm1EOlXxg0K0AK5R3RH5LheRAFgL0nc+8EEoWVcIGDHMpPLix
   6I+nDOI/PxRtIKjPRGAw0ySccFBWRyBolVRQE09OgIYuOQ7gXx4nwX3gJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3011882"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3011882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6589896"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:05:12 -0800
Message-ID: <35cafc72-89d2-48d3-ab73-0af4ed2bcac1@linux.intel.com>
Date: Sun, 25 Feb 2024 12:05:12 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/DPC: Remove CONFIG_PCIE_EDR
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240222221521.32159-1-helgaas@kernel.org>
 <20240222221521.32159-3-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222221521.32159-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previous Kconfig allowed the possibility of enabling CONFIG_PCIE_DPC
> without CONFIG_PCIE_EDR.  The PCI Firmware Spec, r3.3, sec 4.5.1,
> table 4-5, says an ACPI OS that requests control of DPC must also
> advertise support for EDR.
>
> Remove CONFIG_PCIE_EDR and enable the EDR code with CONFIG_PCIE_DPC so that
> enabling DPC also enables EDR for ACPI systems.  Since EDR is an ACPI
> feature, build edr.o only when CONFIG_ACPI is enabled.  Stubs cover the
> case when DPC is enabled without ACPI.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_root.c   |  2 +-
>  drivers/pci/pcie/Kconfig  | 14 ++++----------
>  drivers/pci/pcie/Makefile |  5 ++++-
>  drivers/pci/pcie/dpc.c    | 10 ----------
>  include/linux/pci-acpi.h  |  4 ++--
>  5 files changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index efc292b6214e..bcaf3d3a5e05 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -448,7 +448,7 @@ static u32 calculate_support(void)
>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>  	if (pci_msi_enabled())
>  		support |= OSC_PCI_MSI_SUPPORT;
> -	if (IS_ENABLED(CONFIG_PCIE_EDR))
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))	/* DPC => EDR support */
>  		support |= OSC_PCI_EDR_SUPPORT;

Since EDR internally touches AER registers, I still think we should make sure
OS enables AER support before advertising the EDR support.

>  
>  	return support;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 8999fcebde6a..21e98289fbe9 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -137,6 +137,10 @@ config PCIE_DPC
>  	  have this capability or you do not want to use this feature,
>  	  it is safe to answer N.
>  
> +	  On ACPI systems, this includes Error Disconnect Recover support,
> +	  the hybrid model that uses both firmware and OS to implement DPC,
> +	  as specified in the PCI Firmware Specification r3.3.

Nit: Include some section reference?

> +
>  config PCIE_PTM
>  	bool "PCI Express Precision Time Measurement support"
>  	help
> @@ -145,13 +149,3 @@ config PCIE_PTM
>  
>  	  This is only useful if you have devices that support PTM, but it
>  	  is safe to enable even if you don't.
> -
> -config PCIE_EDR
> -	bool "PCI Express Error Disconnect Recover support"
> -	depends on PCIE_DPC && ACPI
> -	help
> -	  This option adds Error Disconnect Recover support as specified
> -	  in the Downstream Port Containment Related Enhancements ECN to
> -	  the PCI Firmware Specification r3.2.  Enable this if you want to
> -	  support hybrid DPC model which uses both firmware and OS to
> -	  implement DPC.
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 8de4ed5f98f1..72657f780c33 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -12,4 +12,7 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>  obj-$(CONFIG_PCIE_PTM)		+= ptm.o
> -obj-$(CONFIG_PCIE_EDR)		+= edr.o
> +
> +ifdef CONFIG_ACPI
> +obj-$(CONFIG_PCIE_DPC)		+= edr.o
> +endif
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..0aa79581250b 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -102,19 +102,9 @@ static bool dpc_completed(struct pci_dev *pdev)
>   */
>  bool pci_dpc_recovered(struct pci_dev *pdev)
>  {
> -	struct pci_host_bridge *host;
> -
>  	if (!pdev->dpc_cap)
>  		return false;
>  
> -	/*
> -	 * Synchronization between hotplug and DPC is not supported
> -	 * if DPC is owned by firmware and EDR is not enabled.
> -	 */
> -	host = pci_find_host_bridge(pdev->bus);
> -	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> -		return false;
> -
>  	/*
>  	 * Need a timeout in case DPC never completes due to failure of
>  	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..92e196ba0249 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -122,13 +122,13 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>  
> -#ifdef CONFIG_PCIE_EDR
> +#ifdef CONFIG_PCIE_DPC
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>  void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
>  #else
>  static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
>  static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
> -#endif /* CONFIG_PCIE_EDR */
> +#endif /* CONFIG_PCIE_DPC */
>  
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


