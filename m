Return-Path: <linux-pci+bounces-32627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F05B0BEC1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4327A72E3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010F288C8F;
	Mon, 21 Jul 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVGB4HYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55026288C87;
	Mon, 21 Jul 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086246; cv=none; b=PFUnULNpM7ApKIv6LRk25aJnfrlrupJ2sBEmqyct8KPldf70bhYprfr4vt1xotizHVSp/vfAS08zEGJaDUSmmk0c+qYTUxMCXOyJ0B6e+U9HgHItPTioxyyw2cDOeYOaOsJdF40TkA8rZCGieDV71axoqJwrpdKLU5fbLzf3CPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086246; c=relaxed/simple;
	bh=/x9+cA7gjtERQEBbad6KnzYh4lPoWOvw8tMYWZ737U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrBxt+FCMS4CIFjhJn0Furb75aAqTkn4O6a1UiTujsq9IxEMAdR+fnVIt4lCdMgCgQ40rPbuCqQzZjfIKedQrwSsP77x2v+lcu/sU7FnXa+NLhP5zAK7JDYGj74TBFMRNhDOPIvIs596/W7WgQGy2tlEcoWPx/muUVgm7JyB+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVGB4HYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CA5C4CEF4;
	Mon, 21 Jul 2025 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753086245;
	bh=/x9+cA7gjtERQEBbad6KnzYh4lPoWOvw8tMYWZ737U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVGB4HYKFd7gGc08LDamFTjWYPKAMcpXkyMD4kwcsbyWfePbLFOEblU3/KE/gcRfq
	 SmwScMJDtY7ZJo/lyVsUjF6IdbAdEDYBhijQ+EkXXw5cyV3/WXawRXp3y1vLVHekJ3
	 rbpJK3m/wUdJ1O1sGyyxi8QlKD/186KMsrfeTlnQCnBYzt3kRRK9NX+M4+/s2cCnjI
	 1vioP4t3XGeqm0CuHQq2YQOv8aS9LZI6/AJBY8c25dCy3FyePG+9I0zh4CjBUi92IR
	 ccwNelI3sWmC5Z5vhi9pBCHR9UrthGUiIHtnHQ824mL7YTK4+HiP+BaBB6xYx+besj
	 Bjeq8S14vicjA==
Date: Mon, 21 Jul 2025 13:53:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
Message-ID: <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250720190140.2639200-1-david.e.box@linux.intel.com>

On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> visible to firmware and do not receive BIOS-provided default ASPM and CLKPM
> configuration. As a result, devices behind such domains operate without
> proper power management, regardless of platform intent.
> 
> To address this, allow controller drivers to supply an override for the
> default link state by setting aspm_dflt_link_state for their associated
> pci_host_bridge. During link initialization, if this field is non-zero,
> ASPM and CLKPM defaults are derived from its value instead of being taken
> from BIOS.
> 
> This mechanism enables drivers like VMD to achieve platform-aligned power
> savings by statically defining the expected link configuration at
> enumeration time, without relying on runtime calls such as
> pci_enable_link_state(), which are ineffective when ASPM is disabled
> globally.
> 
> This approach avoids per-controller hacks in ASPM core logic and provides a
> general mechanism for domains that require explicit control over link power
> state defaults.
> 
> Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> Changes from RFC:
> 
>   -- Rename field to aspm_dflt_link_state since it stores
>      PCIE_LINK_STATE_XXX flags, not a policy enum.
>   -- Move the field to struct pci_host_bridge since it's being applied to
>      the entire host bridge per Mani's suggestion.
>   -- During testing noticed that clkpm remained disabled and this was
>      also handled by the formerly used pci_enable_link_state(). Add a
>      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> 
>  drivers/pci/controller/vmd.c | 12 +++++++++---
>  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
>  include/linux/pci.h          |  4 ++++
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 8df064b62a2f..6f0de95c87fd 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  }
>  
>  /*
> - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> + * Enable LTR settings on devices that aren't configured by BIOS.
>   */
>  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  {
> @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	 * PCIe r6.0, sec 5.5.4.
>  	 */
>  	pci_set_power_state_locked(pdev, PCI_D0);

This call becomes useless now.

> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  	return 0;
>  }
>  
> @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	struct pci_host_bridge *vmd_host_bridge;
>  	int ret;
>  
>  	/*
> @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return -ENODEV;
>  	}
>  
> +	vmd_host_bridge = to_pci_host_bridge(vmd->bus->bridge);
> +
> +#ifdef CONFIG_PCIEASPM
> +	vmd_host_bridge->aspm_dflt_link_state = PCIE_LINK_STATE_ALL;
> +#endif

I think it is better to provide an API that accepts the link state. We can
provide a stub if CONFIG_PCIEASPM is not selected. This will avoid the ifdef
clutter in the callers. Like:

void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
				unsigned int state)
{
#ifdef CONFIG_PCIEASPM
	 host_bridge->aspm_default_link_state = state;
#endif	
}

Or you can stub the entire function to align with other ASPM APIs.

One more thought: Since this API is only going to be called by the host bridge
drivers, we can place it in drivers/pci/controller/pci-host-common.c and name it
as pci_host_common_set_default_link_state().

> +
>  	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +				   vmd_host_bridge);
>  
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..6f5b34b172f9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -380,6 +380,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	u16 reg16;
>  	struct pci_dev *child;
>  	struct pci_bus *linkbus = link->pdev->subordinate;
> +	struct pci_host_bridge *host = pci_find_host_bridge(link->pdev->bus);
>  
>  	/* All functions should have the same cap and state, take the worst */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
> @@ -394,7 +395,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  			enabled = 0;
>  	}
>  	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;
> +	if (host && host->aspm_dflt_link_state & PCIE_LINK_STATE_CLKPM)
> +		link->clkpm_default = 1;
> +	else
> +		link->clkpm_default = enabled;
>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> @@ -794,6 +798,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	u32 parent_lnkcap, child_lnkcap;
>  	u16 parent_lnkctl, child_lnkctl;
>  	struct pci_bus *linkbus = parent->subordinate;
> +	struct pci_host_bridge *host;
>  
>  	if (blacklist) {
>  		/* Set enabled/disable so that we will disable ASPM later */
> @@ -866,7 +871,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	}
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	host = pci_find_host_bridge(parent->bus);

You can initialize 'host' while defining it.

Also, please add a comment on why we are doing this. The inline comment for the
member is not elaborate enough:

	/*
	 * Use the default link state provided by the Host Bridge driver if
	 * available. If the BIOS is not able to provide default ASPM link
	 * state for some reason, the Host Bridge driver could do.
	 */

> +	if (host && host->aspm_dflt_link_state)
> +		link->aspm_default = host->aspm_dflt_link_state;
> +	else
> +		link->aspm_default = link->aspm_enabled;
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..930028bf52b4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -614,6 +614,10 @@ struct pci_host_bridge {
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
>  
> +#ifdef CONFIG_PCIEASPM
> +	unsigned int    aspm_dflt_link_state;	/* Controller provided link state */

	/* Controller provided default link state */


Nit: Please expand 'default' as 'dflt' is not a commonly used acronym for
'default'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

