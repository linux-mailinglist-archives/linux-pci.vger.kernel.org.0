Return-Path: <linux-pci+bounces-3059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42577847D6D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 01:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93B51F27986
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317B196;
	Sat,  3 Feb 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI7IupAl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57704625;
	Sat,  3 Feb 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918712; cv=none; b=JzGlOPoKnvs65fnGg0wc2uo7BPCezIdfu4B2AwCSnkmC3KNNoAgVjlWFpoCcVZMRp9rLu4hXjHG1yMzudf/ozAP8THsouuRTzN+pdg4ofiqpYitmMZIWcp5KJz0PnCChKUNDTM1ENl1AUx/g21mC87W7StndN8z/3cMRK+i4cFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918712; c=relaxed/simple;
	bh=30NXHrEg3FK6BQ39cfSMRrxz2GANhbrY1bn8h8hUjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R7lFbIgE8QfwPwhktQlRr0CXR+yO5UM91S5JPsXYWhEOrF/Kh5U2EcC0CdSM/GJ9G2lHxeAs4g0iJRa/UzajZ5cCU4CqkO0Mtk6GSVQ3M/qZKDsYBppwPlZvbLXbPjg1x63XE/TCCRvfg8lhELiUpzPHyK7jD+vdpwkzyltg4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI7IupAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8798CC433C7;
	Sat,  3 Feb 2024 00:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918711;
	bh=30NXHrEg3FK6BQ39cfSMRrxz2GANhbrY1bn8h8hUjSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BI7IupAlZJxxwlTraPZPHgUy2G+wNxm5B1zNLy8MRGv7jZDkYu9xRGsQHTpGfmALz
	 ULNMvrkuprFyvMQzzuzIeiGGQ8Hrikj3ICvDgPmtQRFhdmSUwQBGW5nMnALJHswHc6
	 vNAhhT+92v0nEiuz7EMPobJD3Lu/QDcLRzrMJlvJ2+IoRaPqiyfRXc+/jSxr3e5rFN
	 R2Zqx/JTgsBLrYBfFoiZUppdT8er49HM/mSCFCQrhineuoxr2nBhMR3VnfDHUeSOgh
	 1tb38ieCQg5U5zhrB2rAhHV+y7HkrGnmffx92pRtFrguQfXyh46m6shU4hqu6W2T6L
	 qkANSMwAn2O9g==
Date: Fri, 2 Feb 2024 18:05:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
Message-ID: <20240203000510.GA738687@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202071110.8515-3-jhp@endlessos.org>

On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> The remapped PCIe Root Port and NVMe have PCI PM L1 substates
> capability, but they are disabled originally:
> 
> Here is an example on ASUS B1400CEAE:
> 
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> Power on all of the VMD remapped PCI devices and quirk max snoop LTR
> before enable PCI-PM L1 PM Substates by following "Section 5.5.4 of PCIe
> Base Spec Revision 6.0". Then, PCI PM's L1 substates control are
> initialized & enabled accordingly.

> Also, update the comments of
> pci_enable_link_state() and pci_enable_link_state_locked() for
> kernel-doc, too.

The aspm.c changes should be in a separate patch.  Presumably the
aspm.c code change fixes a defect, and that defect can be described in
that patch.  That fix may be needed for non-VMD situations, and having
it in this vmd patch means it won't be as easy to find and backport.

Nit: rewrap commit log to fill 75 columns.

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
> @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
>  	pci_info(pdev, "VMD: Default LTR value set by driver\n");

You're not changing this part, and I don't understand exactly how LTR
works, but it makes me a little bit queasy to read "set the LTR value
to the maximum required to allow the deepest power management
savings" and then we set the max snoop values to a fixed constant.

I don't think the goal is to "allow the deepest power savings"; I
think it's to enable L1.2 *when the device has enough buffering to
absorb L1.2 entry/exit latencies*.

The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
the platform's maximum supported latency or less," so it seems like
that value must be platform-dependent, not fixed.

And I assume the "_DSM for Latency Tolerance Reporting" is part of the
way to get those platform-dependent values, but Linux doesn't actually
use that yet.

I assume that setting the max values incorrectly may lead to either
being too conservative, so we don't use L1.2 when we could, or too
aggressive, so we use L1.2 when we shouldn't, and the device loses
data because it doesn't have enough internal buffering to absorb the
entry/exit delays.

This paper has a lot of background and might help answer some of my
questions:
https://www.intel.co.za/content/dam/doc/white-paper/energy-efficient-platforms-white-paper.pdf

> +out_enable_link_state:
> +	/*
> +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> +	 * Section 5.5.4 of PCIe Base Spec Revision 6.0
> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);

Hmmm.  PCIE_LINK_STATE_ALL includes ASPM L1.2.  We may do this even if
the device doesn't have an LTR Capability.  ASPM L1.2 cannot work
without LTR.

I only took a quick look but was not convinced that
pci_enable_link_state() does the right thing when we enable
PCIE_LINK_STATE_ALL (including ASPM L1.2) on a device that doesn't
have LTR.  I think it *should* decline to set PCI_L1SS_CTL1_ASPM_L1_2,
but I'm not sure it does.  Can you double check that path?  Maybe
that's another defect in aspm.c.

> @@ -1164,6 +1164,8 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
>  		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
> +	if (state & ASPM_STATE_L1_2_MASK)
> +		aspm_l1ss_init(link);
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

