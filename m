Return-Path: <linux-pci+bounces-4349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945386EB12
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AEA1C228EB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFCD57321;
	Fri,  1 Mar 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NohjE9Q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F33A1D1;
	Fri,  1 Mar 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328071; cv=none; b=oxTgWKIlH94Yckz0V+NRQTVFuG8J8InK//97omaV2Bu+MXic0PZOeqDD4ZldZwReFbY1mrNS5V7Tq/dGnVqQ5fwTYdgXmLTYdi4ueUm/kvt9gI35m6ltBUMCUzWjEMROJSmXLNBYKefeeKXbFJ/CA5wPGV+cRQQ3kk2AONtCviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328071; c=relaxed/simple;
	bh=7sWNY+BwPBuNHKndKJkDxUbx4tHA6bF9AZxlwis92Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lhtSovIbScBxbkFv27nsHXosV8ZYUFJW16f1MWTEA/r/VJKn8giuRAlL4NEWKDyiMPo8v8nCfA8GEc5X45605CzNf309Q0uIFZHExr9NSl0ohVf/UcSkJg6pzm4aV2xRcVbyyf9PIFGlyCK95yIIcA1OFO0E26cwLXCP+yVDIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NohjE9Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABD9C433F1;
	Fri,  1 Mar 2024 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328070;
	bh=7sWNY+BwPBuNHKndKJkDxUbx4tHA6bF9AZxlwis92Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NohjE9Q3iYbnnUibWl2H2l8i4HT/9bECgFm97bgAc+1/Gn2f3r9IUu7shyj75qz7d
	 RnyQQHwhLTer45kvXT8d0c3ywQZ+9CBUAQlZXoMqh7iSTAh2Y6MLe/QBBfbFmAyTmZ
	 uQYdwhnUQoE9Gq26szs8saKenjiCf09hahH3aRkUG/KSsJiWYU0kNYmTDuooslzrhL
	 QXUrCQeIj/W2kydjIOhs22/hSKMTS6zsSnmiGFQhAxHIU2ehLLKpnYRlXSU+Yd1uf8
	 t7QeqkQBSJc88kCWke2sYIyrrBU2R4ricesYkRViluYAFYgdJKxTRwKLBnXa2RZ/vp
	 UiJQJ0i6AWwZg==
Date: Fri, 1 Mar 2024 15:21:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v4 1/3] PCI: vmd: Enable PCI PM's L1 substates of
 remapped PCIe Root Port and NVMe
Message-ID: <20240301212108.GA407707@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216062412.247052-3-jhp@endlessos.org>

On Fri, Feb 16, 2024 at 02:24:14PM +0800, Jian-Hong Pan wrote:
> The remapped PCIe Root Port and NVMe have PCI PM L1 substates capability,
> but they are disabled originally.

AFAIK there's nothing specific to NVMe here, so I think the subject
and commit log should be more generic.

I think the important piece of this is to make sure the device is in
D0 before configuring L1 substates, so that should be the primary
motivation.  And "D0" should be part of the subject line, because
vmd_pm_enable_quirk() already *has* code to enable all ASPM states; it
just doesn't work correctly.

> Here is a failed example on ASUS B1400CEAE:
> 
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following PCI Express Base Specification Revision 6.0, section
> 5.5.4.

"PCIe r6.0, sec 5.5.4", as you have in the comment, is enough.

If you send future patches with a [0/n] cover letter and the patches
as responses to the cover letter, "b4" will be able to grab them all
easily:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.7#n349

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
> - Power on the VMD remapped devices with pci_set_power_state_locked()
> - Prepare the PCIe LTR parameters before enable L1 Substates
> - Add note into the comments of both pci_enable_link_state() and
>   pci_enable_link_state_locked() for kernel-doc.
> - The original patch set can be split as individual patches.
> 
> v3:
> - Re-send for the missed version information.
> - Split drivers/pci/pcie/aspm.c modification into following patches.
> - Fix the comment for enasuring the PCI devices in D0.
> 
> v4:
> - The same
> 
>  drivers/pci/controller/vmd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..6aca3f77724c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
>  		return 0;
>  
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> -
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
>  	if (!pos)
> -		return 0;
> +		goto out_enable_link_state;
>  
>  	/*
>  	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> @@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	 */
>  	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
>  	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> -		return 0;
> +		goto out_enable_link_state;
>  
>  	/*
>  	 * Set the default values to the maximum required by the platform to
> @@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
>  	pci_info(pdev, "VMD: Default LTR value set by driver\n");
>  
> +out_enable_link_state:
> +	/*
> +	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> +	 * PCIe r6.0, sec 5.5.4.
> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  	return 0;
>  }
>  
> -- 
> 2.43.2
> 

