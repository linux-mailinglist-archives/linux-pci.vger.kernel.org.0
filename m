Return-Path: <linux-pci+bounces-4351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3186EB52
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088491F253E8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A457322;
	Fri,  1 Mar 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhEo0lgh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3883FE0;
	Fri,  1 Mar 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329279; cv=none; b=HANN4u5+kmDUR28LRJIpfx4vOO8T7kkkxvgq5Hm6X+sKvUqaKLLMS6uXErk0p2R3ypyElgE/GkTEj+Pq7+O2hlx+uRGxaWJ1+8SnALod7qu0mGBQ0cBSIQvHAXqZ8T1IPChVqO+Y2KfJdCvQW0+q94rAcixHmlOnwgimyhqsaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329279; c=relaxed/simple;
	bh=OgjKKH7ljS7iYsOXDvhzd5UPbpv3VXAHAlvt6kfyFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=criCxQMwGOyUsUD8NVnPVSGsUM45mXFZLhWzwbkdp5Sz92Q271tveCuxktu9IH3qWVsQ+kje7w0e+9dZecFLKFIWL73pd9PI8IJIeDbfXXzYsWPkvmoISjHjQ5zVDnu6NjCv9jUFyPIK6wdoAZbc35D8ZNhI+9jyumUAPbqACmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhEo0lgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3040AC433F1;
	Fri,  1 Mar 2024 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709329279;
	bh=OgjKKH7ljS7iYsOXDvhzd5UPbpv3VXAHAlvt6kfyFRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DhEo0lghF6686Aa1BUgUThbu3k7dy0WYOh99ybpM3AnlymRK07eChv05JeJq+2IIe
	 fTEh1jhe2x1Iksn+/OpGxCAkZalxaDpD08mClghp2uDb0j9QYyi107KPJeiH5dhbJl
	 UrMN0gf6WSZXzQfEKL01Sx2Xn9tvWCYmvKn3/7g+6kkboV1zcYSEtYDaFgsOPeOA7x
	 hqMeTD/mMuhfwRByhpbV/8uEM4IlkEgUJswLJFpdINPihzWtGnTBSFDubpGDNHs+z7
	 D085dXKf3mg3eqIRj37b6ypOZ8Olny+T6pmviajDmYHQB8iCN3rNTHEkxmcms/YVA8
	 4aSAiG08L//ZA==
Date: Fri, 1 Mar 2024 15:41:17 -0600
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
Subject: Re: [PATCH v4 3/3] PCI/ASPM: Fix L1.2 parameters when enable link
 state
Message-ID: <20240301214117.GA408641@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216062642.247504-3-jhp@endlessos.org>

In subject:

  PCI/ASPM: Fix L1.2 parameters before enabling L1.2

On Fri, Feb 16, 2024 at 02:26:44PM +0800, Jian-Hong Pan wrote:
> Currently, when enable link's L1.2 features with __pci_enable_link_state(),
> it configs the link directly without ensuring related L1.2 parameters, such
> as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
> programmed.
> 
> This leads VMD enabled systems' L1.2 of the link between VMD remapped PCIe
> Root Port and NVMe gets wrong configs when a caller tries to enabled it.

This is not VMD-specific.

> Here is a failed example on ASUS B1400CEAE with enabled VMD:
> 
> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
>     ...
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>         	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>         	   T_CommonMode=45us LTR1.2_Threshold=101376ns
>         L1SubCtl2: T_PwrOn=50us
> 
> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
>     ...
>     Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> According to PCI Express Base Specification Revision 6.0, Section 5.5.4,
> before enable ASPM L1.2 on the PCIe Root Port and the NVMe, they should be
> programmed with the same LTR1.2_Threshold value. However, they have
> different values in this case.

"PCIe r6.0, sec 5.5.4"
s/before enable/before enabling/

> This patch invokes aspm_calc_l12_info() to program the L1.2 parameters
> properly before enable L1.2 bits of L1 PM Substates Control Register in
> __pci_enable_link_state(). 

s/This patch invokes/Invoke/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.7#n94

> Also, introduces aspm_get_l1ss_cap() shared
> into aspm_l1ss_init() and __pci_enable_link_state() to get the PCIe
> devices' L1SS capability for aspm_calc_l12_info().

"Also" is always a good clue that something should be split to a
separate patch :)

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
> - Prepare the PCIe LTR parameters before enable L1 Substates
> 
> v3:
> - Only enable supported features for the L1 Substates part
> 
> v4:
> - Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS
> 
>  drivers/pci/pcie/aspm.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a39d2ee744cb..42a8c4c194c1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -588,6 +588,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	}
>  }
>  
> +static u32 aspm_get_l1ss_cap(struct pci_dev *pdev)
> +{
> +	u32 l1ss_cap;
> +
> +	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP, &l1ss_cap);
> +
> +	if (!(l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
> +		l1ss_cap = 0;
> +
> +	return l1ss_cap;
> +}

This is nice but should be a separate patch because it just factors
out existing code, and having it in the same patch obscures the real
point of *this* patch.

>  /* Calculate L1.2 PM substate timing parameters */
>  static void aspm_calc_l12_info(struct pcie_link_state *link,
>  				u32 parent_l1ss_cap, u32 child_l1ss_cap)
> @@ -698,15 +710,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>  		return;
>  
>  	/* Setup L1 substate */
> -	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
> -			      &parent_l1ss_cap);
> -	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
> -			      &child_l1ss_cap);
> -
> -	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
> -		parent_l1ss_cap = 0;
> -	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
> -		child_l1ss_cap = 0;
> +	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
> +	child_l1ss_cap = aspm_get_l1ss_cap(child);
>  
>  	/*
>  	 * If we don't have LTR for the entire path from the Root Complex
> @@ -1367,6 +1372,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
>  static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +	struct pci_dev *child = link->downstream, *parent = link->pdev;
> +	u32 parent_l1ss_cap, child_l1ss_cap;
>  
>  	if (!link)
>  		return -EINVAL;
> @@ -1398,6 +1405,16 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
>  		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
> +	/*
> +	 * Ensure L1.2 paramters: Common_Mode_Restore_Times, T_POWER_ON and
> +	 * LTR_L1.2_THRESHOLD are programmed properly before enable bits for
> +	 * L1.2, per PCIe r6.0, sec 5.5.4.

s/paramters/parameters/

> +	if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
> +		parent_l1ss_cap = aspm_get_l1ss_cap(parent);
> +		child_l1ss_cap = aspm_get_l1ss_cap(child);
> +		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);

Why doesn't this happen already via normal enumeration?  It looks like
this path should do it even without this patch:

  pcie_aspm_init_link_state
    pcie_aspm_cap_init
      aspm_l1ss_init

> +	}
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> -- 
> 2.43.2
> 

