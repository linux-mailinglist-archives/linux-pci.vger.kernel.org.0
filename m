Return-Path: <linux-pci+bounces-7784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B98CD663
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C971C209DD
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A86FBE;
	Thu, 23 May 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB/WMy7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4AAD27;
	Thu, 23 May 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476379; cv=none; b=hhNu2nm6RZw7aznj7QoFlRK/64Y+cN6BB977xr38jo8fWA2b4GSSRbRSh53B8J30lw9cMxea9brYKxT7lSinkYJdUrjQMvCk4VGZOBM8LoerHB4olmlkS1Ec6X02+DlDKzp3TTUkQ7hhLgpoZWnulL6/kRKr3QxM0ebelHM82tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476379; c=relaxed/simple;
	bh=AByCXbZWFXkxLRVPN8yk5rxjf2TdytKFei9+qkOPvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TWjzkwX/fQNlkdGvWNMXoTyX1mJ3kNN+9J3+HFQLdCxG7AQ9+WuY5T0ndenUUA/GCd8T3flXayzwnrrG83j05N+Pw4nkFq5ImxRKfGf9QBuvnv88KuQKDB3x5Krxqd53q2HhkrT75RmyBd2RFH7uo9pKACswL3nO+zmLNHQJxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB/WMy7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5469BC32781;
	Thu, 23 May 2024 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716476378;
	bh=AByCXbZWFXkxLRVPN8yk5rxjf2TdytKFei9+qkOPvcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KB/WMy7awBiH/hsZmt97sBLmrKxGXj9DRZIwl/TRSh99kSGafbvAYEW0iygRkZn4S
	 BkhvRxQBT+2yd2WpjCxVxYLwoeH+rvigzC38IQ4d9WZsDVec9ZkdlXDqQsJqRc4pAK
	 vMK5MMUnqIggSmzpC0hwyOJ+8QI0iJ3laDP+1AEYC0XGi5XHwEXgR+8gNhi13B2hSl
	 8EJhUg37sGYJ136HI2eOBVDeAsgfDHokivhedZrkWQ8Kc7UVshaBxZxSoEH6czTlRS
	 6JbH9UlT5W73callIPuynNf8ljnC26QhtcI1H4M50V+KoFCAtitfWgTinpLGaEafsO
	 e17hWKZ4wjkLw==
Date: Thu, 23 May 2024 09:59:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240523145936.GA118272@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523063528.199908-1-vidyas@nvidia.com>

[+cc iommu folks]

On Thu, May 23, 2024 at 12:05:28PM +0530, Vidya Sagar wrote:
> For iommu_groups to form correctly, the ACS settings in the PCIe fabric
> need to be setup early in the boot process, either via the BIOS or via
> the kernel disable_acs_redir parameter.

Can you point to the iommu code that is involved here?  It sounds like
the iommu_groups are built at boot time and are immutable after that?

If we need per-device ACS config that depends on the workload, it
seems kind of problematic to only be able to specify this at boot
time.  I guess we would need to reboot if we want to run a workload
that needs a different config?

Is this the iommu usage model we want in the long term?

> disable_acs_redir allows clearing the RR|CR|EC ACS flags, but the PCIe
> spec Rev3.0 already defines 7 different ACS related flags with many more
> useful combinations depending on the fabric design.

If we need a spec citation, I'd rather use r6.x since r3.0 is from
2010.

> For backward compatibility, leave the 'disable_acs_redir' as is and add
> a new parameter 'config_acs'so that the user can directly specify the ACS
> flags to set on a per-device basis. Use a similar syntax to the existing
> 'resource_alignment'  parameter by using the @ character and have the user
> specify the ACS flags using a bit encoding. If both 'disable_acs_redir' and
> 'config_acs' are specified for a particular device, configuration specified
> through 'config_acs' takes precedence over the other.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v3:
> * Fixed a documentation issue reported by kernel test bot
> 
> v2:
> * Refactored the code as per Jason's suggestion
> 
>  .../admin-guide/kernel-parameters.txt         |  22 +++
>  drivers/pci/pci.c                             | 148 +++++++++++-------
>  2 files changed, 112 insertions(+), 58 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 41644336e..b4a8207eb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4456,6 +4456,28 @@
>  				bridges without forcing it upstream. Note:
>  				this removes isolation between devices and
>  				may put more devices in an IOMMU group.
> +		config_acs=
> +				Format:
> +				=<ACS flags>@<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) optionally prepended with flags
> +				and separated by semicolons. The respective
> +				capabilities will be enabled, disabled or unchanged
> +				based on what is specified in flags.
> +				ACS Flags is defined as follows
> +				bit-0 : ACS Source Validation
> +				bit-1 : ACS Translation Blocking
> +				bit-2 : ACS P2P Request Redirect
> +				bit-3 : ACS P2P Completion Redirect
> +				bit-4 : ACS Upstream Forwarding
> +				bit-5 : ACS P2P Egress Control
> +				bit-6 : ACS Direct Translated P2P
> +				Each bit can be marked as
> +				‘0‘ – force disabled
> +				‘1’ – force enabled
> +				‘x’ – unchanged.
> +				Note: this may remove isolation between devices
> +				and may put more devices in an IOMMU group.
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a607f277c..a46264f83 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -887,30 +887,67 @@ void pci_request_acs(void)
>  }
>  
>  static const char *disable_acs_redir_param;
> +static const char *config_acs_param;
>  
> -/**
> - * pci_disable_acs_redir - disable ACS redirect capabilities
> - * @dev: the PCI device
> - *
> - * For only devices specified in the disable_acs_redir parameter.
> - */
> -static void pci_disable_acs_redir(struct pci_dev *dev)
> +struct pci_acs {
> +	u16 cap;
> +	u16 ctrl;
> +	u16 fw_ctrl;
> +};
> +
> +static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> +			     const char *p, u16 mask, u16 flags)
>  {
> +	char *delimit;
>  	int ret = 0;
> -	const char *p;
> -	int pos;
> -	u16 ctrl;
>  
> -	if (!disable_acs_redir_param)
> +	if (!p)
>  		return;
>  
> -	p = disable_acs_redir_param;
>  	while (*p) {
> +		if (!mask) {
> +			/* Check for ACS flags */
> +			delimit = strstr(p, "@");
> +			if (delimit) {
> +				int end;
> +				u32 shift = 0;
> +
> +				end = delimit - p - 1;
> +
> +				while (end > -1) {
> +					if (*(p + end) == '0') {
> +						mask |= 1 << shift;
> +						shift++;
> +						end--;
> +					} else if (*(p + end) == '1') {
> +						mask |= 1 << shift;
> +						flags |= 1 << shift;
> +						shift++;
> +						end--;
> +					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
> +						shift++;
> +						end--;
> +					} else {
> +						pci_err(dev, "Invalid ACS flags... Ignoring\n");
> +						return;
> +					}
> +				}
> +				p = delimit + 1;
> +			} else {
> +				pci_err(dev, "ACS Flags missing\n");
> +				return;
> +			}
> +		}
> +
> +		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> +			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
> +			pci_err(dev, "Invalid ACS flags specified\n");
> +			return;
> +		}
> +
>  		ret = pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> -				     disable_acs_redir_param);
> -
> +			pr_info_once("PCI: Can't parse acs command line parameter\n");
>  			break;
>  		} else if (ret == 1) {
>  			/* Found a match */
> @@ -930,56 +967,38 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
>  	if (!pci_dev_specific_disable_acs_redir(dev))
>  		return;
>  
> -	pos = dev->acs_cap;
> -	if (!pos) {
> -		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> -		return;
> -	}
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
> +	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
>  
> -	/* P2P Request & Completion Redirect */
> -	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +	/* If mask is 0 then we copy the bit from the firmware setting. */
> +	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> +	caps->ctrl |= flags;
>  
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -
> -	pci_info(dev, "disabled ACS redirect\n");
> +	pci_info(dev, "Configured ACS to 0x%x\n", caps->ctrl);
>  }
>  
>  /**
>   * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
>   * @dev: the PCI device
> + * @caps: default ACS controls
>   */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> +static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>  {
> -	int pos;
> -	u16 cap;
> -	u16 ctrl;
> -
> -	pos = dev->acs_cap;
> -	if (!pos)
> -		return;
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
>  	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> +	caps->ctrl |= (caps->cap & PCI_ACS_SV);
>  
>  	/* P2P Request Redirect */
> -	ctrl |= (cap & PCI_ACS_RR);
> +	caps->ctrl |= (caps->cap & PCI_ACS_RR);
>  
>  	/* P2P Completion Redirect */
> -	ctrl |= (cap & PCI_ACS_CR);
> +	caps->ctrl |= (caps->cap & PCI_ACS_CR);
>  
>  	/* Upstream Forwarding */
> -	ctrl |= (cap & PCI_ACS_UF);
> +	caps->ctrl |= (caps->cap & PCI_ACS_UF);
>  
>  	/* Enable Translation Blocking for external devices and noats */
>  	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> -		ctrl |= (cap & PCI_ACS_TB);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +		caps->ctrl |= (caps->cap & PCI_ACS_TB);
>  }
>  
>  /**
> @@ -988,23 +1007,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>   */
>  static void pci_enable_acs(struct pci_dev *dev)
>  {
> -	if (!pci_acs_enable)
> -		goto disable_acs_redir;
> +	struct pci_acs caps;
> +	int pos;
> +
> +	pos = dev->acs_cap;
> +	if (!pos)
> +		return;
>  
> -	if (!pci_dev_specific_enable_acs(dev))
> -		goto disable_acs_redir;
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
> +	caps.fw_ctrl = caps.ctrl;
>  
> -	pci_std_enable_acs(dev);
> +	/* If an iommu is present we start with kernel default caps */
> +	if (pci_acs_enable) {
> +		if (pci_dev_specific_enable_acs(dev))
> +			pci_std_enable_acs(dev, &caps);
> +	}
>  
> -disable_acs_redir:
>  	/*
> -	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> -	 * enabled by the kernel because it may have been enabled by
> -	 * platform firmware.  So if we are told to disable it, we should
> -	 * always disable it after setting the kernel's default
> -	 * preferences.
> +	 * Always apply caps from the command line, even if there is no iommu.
> +	 * Trust that the admin has a reason to change the ACS settings.
>  	 */
> -	pci_disable_acs_redir(dev);
> +	__pci_config_acs(dev, &caps, disable_acs_redir_param,
> +			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
> +			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
> +	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
>  }
>  
>  /**
> @@ -7023,6 +7052,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "config_acs=", 11)) {
> +				config_acs_param = str + 11;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> @@ -7047,6 +7078,7 @@ static int __init pci_realloc_setup_params(void)
>  	resource_alignment_param = kstrdup(resource_alignment_param,
>  					   GFP_KERNEL);
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
> +	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

