Return-Path: <linux-pci+bounces-34517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E94B30DD5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A5A5E7EF0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39628A3EF;
	Fri, 22 Aug 2025 05:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="GGzV5MK2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF0289E08;
	Fri, 22 Aug 2025 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839421; cv=none; b=dccdf5e7QwOBT9BddYi9FKi2ngRJhy8Fj8JB7gKYOBneOfDfHlsL0mPRy8A+Lu8waB0Ej0R0r+4uXcHY0PzY5CphtqEJyl6HAv5T6lJz2L+xMAXqUYQ0BmgY0o3mEb02lX3of8DpQZ1WA2vlbIeEe2D7Xg3C3HpB4e1NTvGN0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839421; c=relaxed/simple;
	bh=u78+GWVaWnaMGY0TMJxjyP+RnBFR/HtfMv9mXJtHIPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSjLdyCVueZKpJbhUz5jH0FPNZfJ4ArDPsmch1zIDHuJIpad0kH/ELvxEfi50g1avUjUtugFZgUTlM7Z/qzbeT6wVbV4YkiT/Qix3iZxvfU/wTDzJ6vmwya1nl2Tl7WDENj4H9/dd7ohNge9zsgfJcJKmgOahqHxwKFI61BOuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=GGzV5MK2; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.55.30] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4c7StZ0PK8z4cdw;
	Fri, 22 Aug 2025 01:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1755839415; bh=u78+GWVaWnaMGY0TMJxjyP+RnBFR/HtfMv9mXJtHIPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GGzV5MK2YYYhiABfNPRq4mkRg7WgQujJRu2i9HqgF8NJxxUjpAz/MO3d0PJnGRxgm
	 L87+NHtR97X701jEtXLK9gbDzR+r/yY5bGQXINtLSZwZmAZMR2HXHbbOMz0+bNpo3e
	 an6Nyrb56E1yTLmWILaQPDjwmpdvCOY29E7M9q8Q=
Message-ID: <202d3647-ecc0-41a5-b481-28de45a5bb33@panix.com>
Date: Thu, 21 Aug 2025 22:10:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
To: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org,
 bhelgaas@google.com, vicamo.yang@canonical.com,
 ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, mani@kernel.org
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Me <kenny@panix.com>
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250822031159.4005529-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-By: Kenneth R. Crudup <kenny@panix.com>

----
Bzy_MHz C1E%    C10%    CPU%c7  PkgTmp  GFX%rc6 GFXMHz  CPUGFX% Pkg%pc8 
Pk%pc10 CPU%LPI SYS%LPI PkgWatt CorWatt GFXWatt
909     1.37    98.28   42.74   45      99.79   300     0.15    21.61 
47.17   47.24   38.78   1.07    0.19    0.00
1788    3.86    95.43   42.24   46      99.84   300     0.14    23.97 
32.84   32.89   26.52   1.80    0.68    0.00
1014    0.01    99.70   42.74   45      99.84   300     0.12    26.23 
59.45   59.54   48.82   0.59    0.12    0.00
1887    0.86    98.41   42.25   45      99.83   300     0.13    24.62 
47.84   47.92   40.02   1.42    0.63    0.00
951     0.01    99.70   42.74   46      99.83   300     0.13    27.87 
56.99   57.08   46.82   0.63    0.12    0.00
Bzy_MHz C1E%    C10%    CPU%c7  PkgTmp  GFX%rc6 GFXMHz  CPUGFX% Pkg%pc8 
Pk%pc10 CPU%LPI SYS%LPI PkgWatt CorWatt GFXWatt
1814    4.11    95.08   42.26   46      99.81   300     0.14    18.76 
37.64   37.70   30.90   1.93    0.77    0.00
1009    0.30    99.41   42.73   45      99.89   300     0.13    27.08 
55.32   55.42   45.56   0.70    0.13    0.00
1896    2.06    97.25   42.25   46      99.82   300     0.13    20.58 
41.54   41.61   35.22   1.66    0.67    0.00
972     0.01    99.69   42.74   45      99.86   300     0.14    28.82 
56.29   56.38   47.29   0.59    0.11    0.00
1859    1.66    97.61   42.24   45      99.86   300     0.12    22.99 
40.33   40.40   33.22   1.69    0.71    0.00
----

(Hope I've done that properly!)

-K

On 8/21/25 20:11, David E. Box wrote:
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
> ---
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
> Changes in V2:
> 
>    -- Host field name changed to aspm_default_link_state.
>    -- Added get/set functions for aspm_default_link_state. Only the
>       setter is exported. Added a kernel-doc describing usage and
>       particulars around meaning of 0.
> 
>   drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
>   include/linux/pci.h     |  9 +++++++++
>   2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b97647..b4f0b4805a35 100644
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
> +static u32 pci_host_get_default_pcie_link_state(struct pci_dev *parent)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(parent->bus);
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


