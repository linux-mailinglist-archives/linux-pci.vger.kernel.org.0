Return-Path: <linux-pci+bounces-35479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9434B4482E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 23:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D37546876
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51829B8D0;
	Thu,  4 Sep 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="OoJuMGG+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC328D8FD;
	Thu,  4 Sep 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020319; cv=none; b=QpwObaeWX5cEfIWS4G9zWFnwRvcFL865p1rhBjWAATrz00PhO4rRJjip6+1vF+kzcp+uNGeTN6kKGNzp8vp50+K1518qaMFN2hdeeaL6RGug0ehMTph66DfDalDp/K18T5Nbxj1u8z1bzmjQFoAFRXLlNJ/JXQiqLd9R7xgjstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020319; c=relaxed/simple;
	bh=bVpTdvqZQwctg8yn5l2gjB3RXA0ZvRDSr4BwQH5FB5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iri9pdj/LtCuOhB/M8EktltlsRkERW7cVnVHJ+Yn13LskjJbKgg/xpYgA9t7Z1dZ+jCvKtywtrmP7c7DsCxplsYQkFsLP1VN705m+rNvObTOmNMa2u+bykEnSMBsIRDPkTPQRC51XP615Gc2vm1/pk5EnsW8CLW9/uKM7XQ+ODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=OoJuMGG+; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.212] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHsc96tgSz1CL8;
	Thu,  4 Sep 2025 17:11:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757020314; bh=bVpTdvqZQwctg8yn5l2gjB3RXA0ZvRDSr4BwQH5FB5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OoJuMGG+k846EenbEViB6+3Sg86TppjTSiaBpBTtHC2BTe5/Vg9ZqN3zCwRK5L+45
	 Iy2nSSwCrVKiVqGSitORI9M0AWd4OqnplWyHzM6IF6/zglXprqbiez7IFL0kR4qj1b
	 LMOszSGyafZQrvWtY52OjgMJlarVpopw+SuCbZLA=
Message-ID: <603984dc-f29b-498d-9723-1d6aa27bc7fd@panix.com>
Date: Thu, 4 Sep 2025 14:11:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org,
 bhelgaas@google.com, vicamo.yang@canonical.com,
 ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, mani@kernel.org
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825203542.3502368-1-david.e.box@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250825203542.3502368-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-by: Kenneth R. Crudup <kenny@panix.com>

On 8/25/25 13:35, David E. Box wrote:
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
> 
> Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140.2639200-1-david.e.box%40linux.intel.com/
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Tested-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
> Changes in V3:
>    -- Changed pci_host_get_default_pcie_link_state() argument name from
>       parent to dev.
>    -- Applied changelog tags
> 
> Changes in V2:
> 
>    -- Host field name changed to aspm_default_link_state.
>    -- Added get/set functions for aspm_default_link_state. Only the
>       setter is exported. Added a kernel-doc describing usage and
>       particulars around meaning of 0.
> 
> Changes in V1 from RFC:
> 
>    -- Rename field to aspm_dflt_link_state since it stores
>       PCIE_LINK_STATE_XXX flags, not a policy enum.
>    -- Move the field to struct pci_host_bridge since it's being applied to
>       the entire host bridge per Mani's suggestion.
>    -- During testing noticed that clkpm remained disabled and this was
>       also handled by the formerly used pci_enable_link_state(). Add a
>       check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> 
>   drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
>   include/linux/pci.h     |  9 +++++++++
>   2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b97647..851ca3d68e55 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>   	pcie_set_clkpm_nocheck(link, enable);
>   }
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
>   static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>   {
>   	int capable = 1, enabled = 1;
> @@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>   			enabled = 0;
>   	}
>   	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;
> +	if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_STATE_CLKPM)
> +		link->clkpm_default = 1;
> +	else
> +		link->clkpm_default = enabled;
>   	link->clkpm_capable = capable;
>   	link->clkpm_disable = blacklist ? 1 : 0;
>   }
> @@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>   	}
>   
>   	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	link->aspm_default = pci_host_get_default_pcie_link_state(parent);
> +	if (!link->aspm_default)
> +		link->aspm_default = link->aspm_enabled;
>   
>   	/* Setup initial capable state. Will be updated later */
>   	link->aspm_capable = link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..8947cbaf9fa6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -620,6 +620,10 @@ struct pci_host_bridge {
>   	unsigned int	size_windows:1;		/* Enable root bus sizing */
>   	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
>   
> +#ifdef CONFIG_PCIEASPM
> +	unsigned int	aspm_default_link_state;	/* Controller-provided default */
> +#endif
> +
>   	/* Resource alignment requirements */
>   	resource_size_t (*align_resource)(struct pci_dev *dev,
>   			const struct resource *res,
> @@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
>   int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>   int pci_enable_link_state(struct pci_dev *pdev, int state);
>   int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +					  unsigned int state);
>   void pcie_no_aspm(void);
>   bool pcie_aspm_support_enabled(void);
>   bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
>   { return 0; }
>   static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>   { return 0; }
> +static inline void
> +pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +				     unsigned int state) { }
>   static inline void pcie_no_aspm(void) { }
>   static inline bool pcie_aspm_support_enabled(void) { return false; }
>   static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> 
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


