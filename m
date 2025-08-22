Return-Path: <linux-pci+bounces-34611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749FB320D4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B781895F5B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA31F2FDC5D;
	Fri, 22 Aug 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpQVvFD+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72E23D7D4;
	Fri, 22 Aug 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881628; cv=none; b=GzoCIUYUV2XBJ41eWh3+k3XO6Pr3k7fhYPh66ORdm3Iy2OvmGMa5ncLbqE8qUCTdeOyrvQRTNiwWkx1qwRrAWSSEBIS9WRBalks3aocsIvDgc8cGXoIFhar+foyd/qh3p4cUK6rj0sAcJdfmUxH0Fssn6F0Wwc16DahMVIZfR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881628; c=relaxed/simple;
	bh=fSKpZxrAUH5S2jh0u5H0ibv22kQo0WxF3PYjMwb966Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk66NVUHlgdwXFkqTNqouA4pl5NSxB/E0WJ2RkWceiT2dgDvJANABWhLSdzMvYTm5svGC+zU/JDGnmpFH1cDZbATj102VWb6gMJUupFMCCnu9SNUATmOy9hcy/8nXQA+e2XdPG1z9pFB9BXI2AM34HxW+mAMg7aAoGAda4K/MHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpQVvFD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880D3C4CEED;
	Fri, 22 Aug 2025 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881628;
	bh=fSKpZxrAUH5S2jh0u5H0ibv22kQo0WxF3PYjMwb966Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpQVvFD+F6E0UKrJ6ehkMxp4IyY7XatD9wAQHe/unogmeRQKwFGJ1XE5lKLeY6+Bl
	 jb2txgiMTJVzdVU7FTUaJD32l3P/x35LOariGdk7mG+gPzgMYsL1NTD434l1M4LD2O
	 Sn6ruuo8QX0E16I3+dEtmmU/sngRRmpxGU6LuPwLkAlUarSdso6mCwqFcjjfC7gx61
	 NMgYIy7BQotwkmzw4PS+8KLZFRhUJX1HEwlwoimAyoboCPt84wO/zPOQGFs7JlqELx
	 lihtsoVgOoSoxLbx0jItfUTXFqjB88C0qkZdD79CDeOIHaVpKLVop7RO+8tHZL5Ai8
	 6rIpwy60DdI5g==
Date: Fri, 22 Aug 2025 22:23:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] PCI: vmd: Use
 pci_host_set_default_pcie_link_state() to set ASPM defaults
Message-ID: <rwcoocpr4t47pxvuly7qsiszycf2nwl25vaabyb4ntrwfeofdv@qoc2knuv253c>
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
 <20250822031159.4005529-2-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822031159.4005529-2-david.e.box@linux.intel.com>

On Thu, Aug 21, 2025 at 08:11:58PM GMT, David E. Box wrote:
> Now that pci_host_set_default_pcie_link_state() exists, set the VMD child
> domain with PCIE_LINK_STATE_ALL at bridge creation so core ASPM uses those
> defaults during ASPM and CLKPM capability init.
> 
> Also remove the unneeded pci_set_power_state_locked(pdev, PCI_D0) and
> pci_enable_link_state_locked() calls now that the links are configured
> during enumeration.
> 
> This aligns VMD behavior with platform expectations without per-controller
> ASPM tweaks at runtime.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>


Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani


> ---
> Changes in V2:
> 
>   -- Separated VMD changes into new patch.
>   -- Changed comment for VMD_FEAT_BIOS_PM_QUIRK to remove ASPM
>   -- Removed pci_set_power_state() and pci_enable_link_state_locked()
>      calls in vmd_pm_enable_quirk()
>   -- Use pci_host_set_default_pcie_link_state()
> 
>  drivers/pci/controller/vmd.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index b679c7f28f51..b99e01a57ddb 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -71,10 +71,9 @@ enum vmd_features {
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>  
>  	/*
> -	 * Enable ASPM on the PCIE root ports and set the default LTR of the
> -	 * storage devices on platforms where these values are not configured by
> -	 * BIOS. This is needed for laptops, which require these settings for
> -	 * proper power management of the SoC.
> +	 * Program default LTR values for storage devices on platforms where
> +	 * firmware did not. Required on many laptops for proper SoC power
> +	 * management.
>  	 */
>  	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
>  };
> @@ -733,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  }
>  
>  /*
> - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> + * Enable LTR settings on devices that aren't configured by BIOS.
>   */
>  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  {
> @@ -747,7 +746,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
>  	if (!pos)
> -		goto out_state_change;
> +		return 0;
>  
>  	/*
>  	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> @@ -755,7 +754,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	 */
>  	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
>  	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> -		goto out_state_change;
> +		return 0;
>  
>  	/*
>  	 * Set the default values to the maximum required by the platform to
> @@ -767,13 +766,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
>  	pci_info(pdev, "VMD: Default LTR value set by driver\n");
>  
> -out_state_change:
> -	/*
> -	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> -	 * PCIe r6.0, sec 5.5.4.
> -	 */
> -	pci_set_power_state_locked(pdev, PCI_D0);
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  	return 0;
>  }
>  
> @@ -921,6 +913,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  
> +	pci_host_set_default_pcie_link_state(to_pci_host_bridge(vmd->bus->bridge),
> +					     PCIE_LINK_STATE_ALL);
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

