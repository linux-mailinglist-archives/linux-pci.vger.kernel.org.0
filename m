Return-Path: <linux-pci+bounces-35059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB385B3ABD9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FEB3A67AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064C285CB3;
	Thu, 28 Aug 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/+mfYbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302C30CD84;
	Thu, 28 Aug 2025 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413828; cv=none; b=KGK9FCo+lNFZlvKa6am59+RuPBpTfBX4E7noT6KbNA/0U4VWU/2mjU9qGN3ZMBjl2dT7BxTSHX1nJG6t+nzzQLNLGYtRlGGkSRHSpPAk+Wf5EsnBuHEv1OEqC7gPsIPKn7MuUB6rcDl90twUnat45+opw30feOCbclhGSslNhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413828; c=relaxed/simple;
	bh=9OG6MHQINNqki86DnbuxmZ50GZWpKYnNnMkT4UtGkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eMiVnq7zX+so2xAIYS+VuucxdYiKPtG8eWtBSXrf0SfUrKsSqtPgkK6bi+KE5H1GC7D3NzwXPp0u0I1LOVdH/EjnJk0neCrpD5gaDuyEKU9Rw4m6u9p5Xhx2L5XANdl9MKh1R2hOYqURXyOndDv2R8k2gvbVmfRGpG9Db9M3wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/+mfYbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11542C4CEEB;
	Thu, 28 Aug 2025 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756413827;
	bh=9OG6MHQINNqki86DnbuxmZ50GZWpKYnNnMkT4UtGkNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F/+mfYbEVKNaMv6wmv9iOLiW6X1tFo55QGDtGAo/s7L8fkAjhOp2QIwupb7y4rMgq
	 6TzjQBWntE783uyTD60sBXz/ggobniVcOF3mXkV3/gEIG785nvLCIlcndLL16XoWzG
	 nlborw10PnMiV+k2Z83FJkDCTNfhLud6dIVHpYuzdrVkBDV4crFjmYeIChSbG/SbNx
	 +00e3SRq4kEIElZ6iOD/MMXsUh9otC0TPeIl9ULrh7g2pSVfc6HbQa803IZC2mG2A+
	 MAY1mcZ+O0AQXA+WpBfAMfgPVEAAmF+jqoeYmK7PEV72aFeXqsU4ESVHnEI7zIA6Yu
	 aU0HYjd9TC0MQ==
Date: Thu, 28 Aug 2025 15:43:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com,
	kenny@panix.com, ilpo.jarvinen@linux.intel.com,
	nirmal.patel@linux.intel.com, mani@kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <20250828204345.GA958461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825203542.3502368-1-david.e.box@linux.intel.com>

On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> defaults. Devices in such domains may therefore run without the intended
> power management.
> 
> Add a host-bridge mechanism that lets controller drivers supply their own
> defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> set via pci_host_set_default_pcie_link_state(). During link initialization,
> if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> BIOS.
> 
> This enables drivers like VMD to align link power management with platform
> expectations and avoids embedding controller-specific quirks in ASPM core
> logic.

I think this kind of sidesteps the real issue.  Drivers for host
controllers or PCI devices should tell us about *broken* things, but
not about things advertised by the hardware and available for use.

The only documented policy controls I'm aware of for ASPM are:

  - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
    control on this platform")

  - _OSC negotiation for control of the PCIe Capability (OS is only
    allowed to write PCI_EXP_LNKCTL if platform has granted control to
    the OS)

I think what we *should* be doing is enabling ASPM when it's
advertised, subject to those platform policy controls and user choices
like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.

So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
without drivers doing anything at all.  Maybe we have to carve out
exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
on x86 systems before 2026 can't enable more ASPM than BIOS did," or
whatever.  Is there any baby step we can make in that direction?

This feels a little scary, so feel free to convince me it can't be
done :)

> Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140.2639200-1-david.e.box%40linux.intel.com/
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Tested-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
> Changes in V3:
>   -- Changed pci_host_get_default_pcie_link_state() argument name from
>      parent to dev.
>   -- Applied changelog tags
> 
> Changes in V2:
> 
>   -- Host field name changed to aspm_default_link_state.
>   -- Added get/set functions for aspm_default_link_state. Only the
>      setter is exported. Added a kernel-doc describing usage and
>      particulars around meaning of 0.
> 
> Changes in V1 from RFC:
> 
>   -- Rename field to aspm_dflt_link_state since it stores
>      PCIE_LINK_STATE_XXX flags, not a policy enum.
>   -- Move the field to struct pci_host_bridge since it's being applied to
>      the entire host bridge per Mani's suggestion.
>   -- During testing noticed that clkpm remained disabled and this was
>      also handled by the formerly used pci_enable_link_state(). Add a
>      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> 
>  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci.h     |  9 +++++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b97647..851ca3d68e55 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
> +/**
> + * pci_host_set_default_pcie_link_state - set controller-provided default ASPM/CLKPM mask
> + * @host: host bridge on which to apply the defaults
> + * @state: PCIE_LINK_STATE_XXX flags
> + *
> + * Allows a PCIe controller driver to specify the default ASPM and/or
> + * Clock Power Management (CLKPM) link state mask that will be used
> + * for links under this host bridge during ASPM/CLKPM capability init.
> + *
> + * The value is consumed in pcie_aspm_cap_init() and pcie_clkpm_cap_init()
> + * to override the firmware-discovered defaults.
> + *
> + * Interpretation of aspm_default_link_state:
> + *   - Nonzero: bitmask of PCIE_LINK_STATE_* values to be used as defaults
> + *   - Zero:    no override provided; ASPM/CLKPM defaults fall back to
> + *              values discovered in hardware/firmware
> + *
> + * Note: zero is always treated as "unset", not as "force ASPM/CLKPM off".
> + */
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +					  unsigned int state)
> +{
> +	host->aspm_default_link_state = state;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_set_default_pcie_link_state);
> +
> +static u32 pci_host_get_default_pcie_link_state(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return host ? host->aspm_default_link_state : 0;
> +}
> +
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	int capable = 1, enabled = 1;
> @@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  			enabled = 0;
>  	}
>  	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;
> +	if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_STATE_CLKPM)
> +		link->clkpm_default = 1;
> +	else
> +		link->clkpm_default = enabled;
>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> @@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	}
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	link->aspm_default = pci_host_get_default_pcie_link_state(parent);
> +	if (!link->aspm_default)
> +		link->aspm_default = link->aspm_enabled;
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..8947cbaf9fa6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -620,6 +620,10 @@ struct pci_host_bridge {
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
>  
> +#ifdef CONFIG_PCIEASPM
> +	unsigned int	aspm_default_link_state;	/* Controller-provided default */
> +#endif
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> @@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +					  unsigned int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
> +static inline void
> +pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +				     unsigned int state) { }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> 
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> -- 
> 2.43.0
> 

