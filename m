Return-Path: <linux-pci+bounces-22869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE4A4E5CC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A519C6A92
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F607205AC3;
	Tue,  4 Mar 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4MzjvZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E828F94C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104078; cv=none; b=Aj48jbWSbBUylnsVI9B1qNzunBbrILGArFQ2tZ/DtJOA8MxitvpRwW1zDD+cgFV6Y9OKeo9Lyq0O7bk0qAe1FvWAESTn2LzKTHn/aoR+GuOJTwZJJU3U9nfFjTK69NvHKIl+5ahEh+WWPga9Ju5Z3CaZXEd8MTliwYJ7z0OA+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104078; c=relaxed/simple;
	bh=mWR/S7YerMP8FxBqywlmct9PTwBjenZFCCi+3vhNtSk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uQcW6k7ibyHksoKV9siAUtoNyWIemjXE2Kr8nQGihsHNJJnLzs8NxQ/iDW/YVELucSBBUaPN47MABKbhB1Vha6HFV9w3jeLmnaojRdBi9hfKqH0rhnU7cqUxSFkTVY/cxjsjZXtNBOaFTNL/ltpvZ+MDI4jvSFMj+UvCSAjxQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4MzjvZT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741104076; x=1772640076;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mWR/S7YerMP8FxBqywlmct9PTwBjenZFCCi+3vhNtSk=;
  b=U4MzjvZTO+Fjmor/G2gIpU0/hHt/j/8oETcZvTfeTUkanCMQ3E9FvyY8
   qJepQKNnnVLtJQuLha7qL+dy2fCUB2lnz9g0Xms/85Cxr8iRkOODFGN41
   ZgEk0rg2EZFcIhSOCpzljC1HzdpEVnbCVgRKheN2knllEBlMJ1u5kxvpJ
   O4sYyOcxeo2z00b6YwE8JunUBJRW8RGWXDnrsb4taAyNc617+rhsSmMNR
   gvuWDdWtwepYUuaVoEHYLqstFvvlLOMo4VUk3dkuuJ5nyPXdMdbcnbZWa
   NDmEQeUwO8MiNI1gjoBa+X+AEV6351A2TlkoS1CTEUF6fjuJLkY9M8aP2
   w==;
X-CSE-ConnectionGUID: 6/88td0kRTygW9X8WUyVyQ==
X-CSE-MsgGUID: EzRJla2sQ4uWF8ZtK/ex/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42158760"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42158760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:01:15 -0800
X-CSE-ConnectionGUID: ZFhZIUokRPi0XaCurk/50A==
X-CSE-MsgGUID: OGExcn9/Q/KcbSwCk/qAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118930788"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:01:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 18:01:10 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
In-Reply-To: <20250303211119.200365-1-helgaas@kernel.org>
Message-ID: <56112b8d-69e3-9938-b238-fc6a0f43b408@linux.intel.com>
References: <20250303211119.200365-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Mar 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos and whitespace errors.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  8 +--
>  drivers/pci/controller/pci-thunder-ecam.c     |  2 +-
>  drivers/pci/controller/pcie-altera.c          |  2 +-
>  drivers/pci/controller/pcie-rcar-host.c       | 10 +--
>  drivers/pci/endpoint/Kconfig                  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
>  drivers/pci/hotplug/Kconfig                   |  2 +-
>  drivers/pci/msi/api.c                         |  2 +-
>  drivers/pci/of.c                              |  2 +-
>  drivers/pci/pci.c                             |  2 +-
>  drivers/pci/pcie/aer.c                        | 64 +++++++++----------
>  drivers/pci/setup-bus.c                       |  2 +-
>  include/linux/pci-epf.h                       | 17 ++---
>  13 files changed, 60 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index e0cc4560dfde..a4f7ed04d38b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -301,12 +301,12 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
>  	val |= interrupts;
>  	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
>  
> -	/* Set MSIX BAR and offset */
> +	/* Set MSI-X BAR and offset */
>  	reg = cap + PCI_MSIX_TABLE;
>  	val = offset | bir;
>  	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
>  
> -	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
> +	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
>  	reg = cap + PCI_MSIX_PBA;
>  	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
>  	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> @@ -573,8 +573,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  
>  	/*
>  	 * Next function field in ARI_CAP_AND_CTR register for last function
> -	 * should be 0.
> -	 * Clearing Next Function Number field for the last function used.
> +	 * should be 0.  Clear Next Function Number field for the last
> +	 * function used.
>  	 */
>  	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
>  	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
> diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
> index b5bd10a62adb..08161065a89c 100644
> --- a/drivers/pci/controller/pci-thunder-ecam.c
> +++ b/drivers/pci/controller/pci-thunder-ecam.c
> @@ -204,7 +204,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  			v = readl(addr);
>  			if (v & 0xff00)
> -				pr_err("Bad MSIX cap header: %08x\n", v);
> +				pr_err("Bad MSI-X cap header: %08x\n", v);
>  			v |= 0xbc00; /* next capability is EA at 0xbc */
>  			set_val(v, where, size, val);
>  			return PCIBIOS_SUCCESSFUL;
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index eb55a7f8573a..e5b3d5dad4bc 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -149,7 +149,7 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
>   * Altera PCIe port uses BAR0 of RC's configuration space as the translation
>   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
>   * using these registers, so it can be reached by DMA from EP devices.
> - * This BAR0 will also access to MSI vector when receiving MSI/MSIX interrupt
> + * This BAR0 will also access to MSI vector when receiving MSI/MSI-X interrupt
>   * from EP devices, eventually trigger interrupt to GIC.  The BAR0 of bridge
>   * should be hidden during enumeration to avoid the sizing and resource
>   * allocation by PCIe core.
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 7c92eada04af..c32b803a47c7 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -178,8 +178,8 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  	 * space, it's generally only accessible when in endpoint mode.
>  	 * When in root complex mode, the controller is unable to target
>  	 * itself with either type 0 or type 1 accesses, and indeed, any
> -	 * controller initiated target transfer to its own config space
> -	 * result in a completer abort.
> +	 * controller-initiated target transfer to its own config space
> +	 * results in a completer abort.
>  	 *
>  	 * Each channel effectively only supports a single device, but as
>  	 * the same channel <-> device access works for any PCI_SLOT()
> @@ -775,7 +775,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  	if (err)
>  		return err;
>  
> -	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
> +	/* Two IRQs are for MSI, but they are also used for non-MSI IRQs */
>  	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       rcar_msi_bottom_chip.name, host);
> @@ -792,7 +792,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  		goto err;
>  	}
>  
> -	/* disable all MSIs */
> +	/* Disable all MSIs */
>  	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
>  
>  	/*
> @@ -892,6 +892,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  			dev_err(pcie->dev, "Failed to map inbound regions!\n");
>  			return -EINVAL;
>  		}
> +
>  		/*
>  		 * If the size of the range is larger than the alignment of
>  		 * the start address, we have to use multiple entries to
> @@ -903,6 +904,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  
>  			size = min(size, alignment);
>  		}
> +
>  		/* Hardware supports max 4GiB inbound region */
>  		size = min(size, 1ULL << 32);
>  
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index 17bbdc9bbde0..1c5d82eb57d4 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -26,7 +26,7 @@ config PCI_ENDPOINT_CONFIGFS
>  	help
>  	   This will enable the configfs entry that can be used to
>  	   configure the endpoint function and used to bind the
> -	   function with a endpoint controller.
> +	   function with an endpoint controller.
>  
>  source "drivers/pci/endpoint/functions/Kconfig"
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index b94e205ae10b..ee1416c43f03 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -632,7 +632,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	case IRQ_TYPE_MSIX:
>  		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
>  		if (reg->irq_number > count || count <= 0) {
> -			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
> +			dev_err(dev, "Invalid MSI-X IRQ number %d / %d\n",
>  				reg->irq_number, count);
>  			return;
>  		}
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 123c4c7c2ab5..3207860b52e4 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -97,7 +97,7 @@ config HOTPLUG_PCI_CPCI_ZT5550
>  	tristate "Ziatech ZT5550 CompactPCI Hotplug driver"
>  	depends on HOTPLUG_PCI_CPCI && X86
>  	help
> -	  Say Y here if you have an Performance Technologies (formerly Intel,
> +	  Say Y here if you have a Performance Technologies (formerly Intel,
>  	  formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index b956ce591f96..17ec6332cb1d 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -162,7 +162,7 @@ struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>  EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
>  
>  /**
> - * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
> + * pci_msix_free_irq - Free an interrupt on a PCI/MSI-X interrupt domain
>   *
>   * @dev:	The PCI device to operate on
>   * @map:	A struct msi_map describing the interrupt to free
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7a806f5c0d20..a0dc15f9dc31 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -457,7 +457,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>   * This function resolves the PCI interrupt for a given PCI device. If a
>   * device-node exists for a given pci_dev, it will use normal OF tree
>   * walking. If not, it will implement standard swizzling and walk up the
> - * PCI tree until an device-node is found, at which point it will finish
> + * PCI tree until a device-node is found, at which point it will finish
>   * resolving using the OF tree walking.
>   */
>  static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..2fcd1e583966 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4766,7 +4766,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  
>  	/*
>  	 * PCIe r4.0 sec 6.6.1, a component must enter LTSSM Detect within 20ms,
> -	 * after which we should expect an link active if the reset was
> +	 * after which we should expect the link to be active if the reset was
>  	 * successful. If so, software must wait a minimum 100ms before sending
>  	 * configuration requests to devices downstream this port.
>  	 *
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..fdec7829436a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -2,7 +2,7 @@
>  /*
>   * Implement the AER root port service driver. The driver registers an IRQ
>   * handler. When a root port triggers an AER interrupt, the IRQ handler
> - * collects root port status and schedules work.
> + * collects Root Port status and schedules work.
>   *
>   * Copyright (C) 2006 Intel Corp.
>   *	Tom Long Nguyen (tom.l.nguyen@intel.com)
> @@ -56,9 +56,9 @@ struct aer_stats {
>  	/*
>  	 * Fields for all AER capable devices. They indicate the errors
>  	 * "as seen by this device". Note that this may mean that if an
> -	 * end point is causing problems, the AER counters may increment
> -	 * at its link partner (e.g. root port) because the errors will be
> -	 * "seen" by the link partner and not the problematic end point
> +	 * Endpoint is causing problems, the AER counters may increment
> +	 * at its link partner (e.g. Root Port) because the errors will be
> +	 * "seen" by the link partner and not the problematic Endpoint
>  	 * itself (which may report all counters as 0 as it never saw any
>  	 * problems).
>  	 */
> @@ -76,10 +76,10 @@ struct aer_stats {
>  	u64 dev_total_nonfatal_errs;
>  
>  	/*
> -	 * Fields for Root ports & root complex event collectors only, these
> +	 * Fields for Root Ports & Root Complex Event Collectors only; these
>  	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
> -	 * messages received by the root port / event collector, INCLUDING the
> -	 * ones that are generated internally (by the rootport itself)
> +	 * messages received by the Root Port / Event Collector, INCLUDING the
> +	 * ones that are generated internally (by the Root Port itself)
>  	 */
>  	u64 rootport_total_cor_errs;
>  	u64 rootport_total_fatal_errs;
> @@ -138,7 +138,7 @@ static const char * const ecrc_policy_str[] = {
>   * enable_ecrc_checking - enable PCIe ECRC checking for a device
>   * @dev: the PCI device
>   *
> - * Returns 0 on success, or negative on failure.
> + * Return 0 on success, or negative on failure.
>   */
>  static int enable_ecrc_checking(struct pci_dev *dev)
>  {
> @@ -159,10 +159,10 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>  }
>  
>  /**
> - * disable_ecrc_checking - disables PCIe ECRC checking for a device
> + * disable_ecrc_checking - disable PCIe ECRC checking for a device
>   * @dev: the PCI device
>   *
> - * Returns 0 on success, or negative on failure.
> + * Return 0 on success, or negative on failure.

The proper kerneldoc formatting for return line is with :, so:

Return: ...

>   */
>  static int disable_ecrc_checking(struct pci_dev *dev)
>  {
> @@ -283,10 +283,10 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>   * pci_aer_raw_clear_status - Clear AER error registers.
>   * @dev: the PCI device
>   *
> - * Clearing AER error status registers unconditionally, regardless of
> + * Clear AER error status registers unconditionally, regardless of
>   * whether they're owned by firmware or the OS.
>   *
> - * Returns 0 on success, or negative on failure.
> + * Return 0 on success, or negative on failure.
>   */
>  int pci_aer_raw_clear_status(struct pci_dev *dev)
>  {
> @@ -378,8 +378,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	/*
>  	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>  	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> -	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r5.0, sec
> -	 * 7.8.4).
> +	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r6.0, sec
> +	 * 7.8.4.9).
>  	 */
>  	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
> @@ -825,8 +825,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	u16 reg16;
>  
>  	/*
> -	 * When bus id is equal to 0, it might be a bad id
> -	 * reported by root port.
> +	 * When bus ID is equal to 0, it might be a bad ID
> +	 * reported by Root Port.
>  	 */
>  	if ((PCI_BUS_NUM(e_info->id) != 0) &&
>  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
> @@ -834,15 +834,15 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  		if (e_info->id == pci_dev_id(dev))
>  			return true;
>  
> -		/* Continue id comparing if there is no multiple error */
> +		/* Continue ID comparing if there is no multiple error */
>  		if (!e_info->multi_error_valid)
>  			return false;
>  	}
>  
>  	/*
>  	 * When either
> -	 *      1) bus id is equal to 0. Some ports might lose the bus
> -	 *              id of error source id;
> +	 *      1) bus ID is equal to 0. Some ports might lose the bus
> +	 *              ID of error source id;
>  	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
>  	 *      3) There are multiple errors and prior ID comparing fails;
>  	 * We check AER status registers to find possible reporter.
> @@ -894,7 +894,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>  /**
>   * find_source_device - search through device hierarchy for source device
>   * @parent: pointer to Root Port pci_dev data structure
> - * @e_info: including detailed error information such like id
> + * @e_info: including detailed error information such as ID
>   *
>   * Return true if found.
>   *
> @@ -938,9 +938,9 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
> - * @dev: pointer to the pcie_dev data structure
> + * @dev: pointer to the pci_dev data structure
>   *
> - * Unmasks internal errors in the Uncorrectable and Correctable Error
> + * Unmask internal errors in the Uncorrectable and Correctable Error
>   * Mask registers.
>   *
>   * Note: AER must be enabled and supported by the device which must be
> @@ -1003,7 +1003,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	/* protect dev->driver */
> +	/* Protect dev->driver */
>  	device_lock(&dev->dev);
>  
>  	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> @@ -1195,7 +1195,7 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>  
>  /**
>   * aer_get_device_error_info - read error status from dev and store it to info
> - * @dev: pointer to the device expected to have a error record
> + * @dev: pointer to the device expected to have an error record
>   * @info: pointer to structure to store the error record
>   *
>   * Return 1 on success, 0 on error.
> @@ -1256,7 +1256,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  {
>  	int i;
>  
> -	/* Report all before handle them, not to lost records by reset etc. */
> +	/* Report all before handling them, to not lose records by reset etc. */
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info))
>  			aer_print_error(e_info->dev[i], e_info);
> @@ -1268,8 +1268,8 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  }
>  
>  /**
> - * aer_isr_one_error - consume an error detected by root port
> - * @rpc: pointer to the root port which holds an error
> + * aer_isr_one_error - consume an error detected by Root Port
> + * @rpc: pointer to the Root Port which holds an error
>   * @e_src: pointer to an error source
>   */
>  static void aer_isr_one_error(struct aer_rpc *rpc,
> @@ -1319,11 +1319,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  }
>  
>  /**
> - * aer_isr - consume errors detected by root port
> + * aer_isr - consume errors detected by Root Port
>   * @irq: IRQ assigned to Root Port
>   * @context: pointer to Root Port data structure
>   *
> - * Invoked, as DPC, when root port records new detected error
> + * Invoked, as DPC, when Root Port records new detected error
>   */
>  static irqreturn_t aer_isr(int irq, void *context)
>  {
> @@ -1383,7 +1383,7 @@ static void aer_disable_irq(struct pci_dev *pdev)
>  	int aer = pdev->aer_cap;
>  	u32 reg32;
>  
> -	/* Disable Root's interrupt in response to error messages */
> +	/* Disable Root Port's interrupt in response to error messages */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> @@ -1583,9 +1583,9 @@ static struct pcie_port_service_driver aerdriver = {
>  };
>  
>  /**
> - * pcie_aer_init - register AER root service driver
> + * pcie_aer_init - register AER service driver
>   *
> - * Invoked when AER root service driver is loaded.
> + * Invoked when AER service driver is loaded.
>   */
>  int __init pcie_aer_init(void)
>  {
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 5e00cecf1f1a..5b847f7b1f68 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1880,7 +1880,7 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
>  			 * Make sure prefetchable memory is reduced from
>  			 * the correct resource. Specifically we put 32-bit
>  			 * prefetchable memory in non-prefetchable window
> -			 * if there is an 64-bit prefetchable window.
> +			 * if there is a 64-bit prefetchable window.
>  			 *
>  			 * See comments in __pci_bus_size_bridges() for
>  			 * more information.
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index ee6156bcbbd0..879d19cebd4f 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -38,7 +38,7 @@ enum pci_barno {
>   * @baseclass_code: broadly classifies the type of function the device performs
>   * @cache_line_size: specifies the system cacheline size in units of DWORDs
>   * @subsys_vendor_id: vendor of the add-in card or subsystem
> - * @subsys_id: id specific to vendor
> + * @subsys_id: ID specific to vendor
>   * @interrupt_pin: interrupt pin the device (or device function) uses
>   */
>  struct pci_epf_header {
> @@ -59,7 +59,7 @@ struct pci_epf_header {
>   * @bind: ops to perform when a EPC device has been bound to EPF device
>   * @unbind: ops to perform when a binding has been lost between a EPC device
>   *	    and EPF device
> - * @add_cfs: ops to initialize function specific configfs attributes
> + * @add_cfs: ops to initialize function-specific configfs attributes
>   */
>  struct pci_epf_ops {
>  	int	(*bind)(struct pci_epf *epf);
> @@ -138,7 +138,7 @@ struct pci_epf_bar {
>   * @epc: the EPC device to which this EPF device is bound
>   * @epf_pf: the physical EPF device to which this virtual EPF device is bound
>   * @driver: the EPF driver to which this EPF device is bound
> - * @id: Pointer to the EPF device ID
> + * @id: pointer to the EPF device ID
>   * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
>   * @lock: mutex to protect pci_epf_ops
>   * @sec_epc: the secondary EPC device to which this EPF device is bound
> @@ -151,7 +151,7 @@ struct pci_epf_bar {
>   * @is_vf: true - virtual function, false - physical function
>   * @vfunction_num_map: bitmap to manage virtual function number
>   * @pci_vepf: list of virtual endpoint functions associated with this function
> - * @event_ops: Callbacks for capturing the EPC events
> + * @event_ops: callbacks for capturing the EPC events
>   */
>  struct pci_epf {
>  	struct device		dev;
> @@ -185,11 +185,12 @@ struct pci_epf {
>  };
>  
>  /**
> - * struct pci_epf_msix_tbl - represents the MSIX table entry structure
> - * @msg_addr: Writes to this address will trigger MSIX interrupt in host
> - * @msg_data: Data that should be written to @msg_addr to trigger MSIX interrupt
> + * struct pci_epf_msix_tbl - represents the MSI-X table entry structure
> + * @msg_addr: Writes to this address will trigger MSI-X interrupt in host
> + * @msg_data: Data that should be written to @msg_addr to trigger MSI-X
> + *   interrupt
>   * @vector_ctrl: Identifies if the function is prohibited from sending a message
> - * using this MSIX table entry
> + *   using this MSI-X table entry
>   */
>  struct pci_epf_msix_tbl {
>  	u64 msg_addr;
> 

-- 
 i.


