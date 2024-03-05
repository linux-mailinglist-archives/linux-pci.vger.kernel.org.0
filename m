Return-Path: <linux-pci+bounces-4538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B958729E9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 23:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C777287772
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45E12BEAE;
	Tue,  5 Mar 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXbd7/WB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075E18AE0;
	Tue,  5 Mar 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676225; cv=none; b=DwPVikj2WasPk2ySBDXVrCn5t/5oJi6RZaQW1uTXbwhhekhMfZczgtYoi4JGCZ640qRFZQzLeE2KYR4ss/b9DPW75zBQTrSYwhW/vnmJQ3BNSDK6W2j928QiB4XH8gjtBU/Yb+No8W4nAkA0c+vV7I5mXyEvy+Jq2gLlGGkmo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676225; c=relaxed/simple;
	bh=aEGrZEdlwz/VZZvx0iJsk0GeUTCnfI6+l9Musmyx+vI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zru5CxcrKSXqr/htGKWaDN+zOnMDKGfC/XNv9AdzZuSR9aoSa9rQfFs0Uh4hZoxMPvN1lZA2JxzlohpybAkT/luDwk4jgTY3k8rqsr5IMQF/uUzDZKicQKdKSCsgTrCA56uCbIjhgQVR9FSPH2nxuWsoMN9V7wvNIsaAVb5t73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXbd7/WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63673C433F1;
	Tue,  5 Mar 2024 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709676224;
	bh=aEGrZEdlwz/VZZvx0iJsk0GeUTCnfI6+l9Musmyx+vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jXbd7/WBguQ3opKVrW7GahW9vIP+RRSyU0Mlf2HdySRXpTOyvrjJPzmA/DGoBtkeJ
	 5lKlLufGqyO57GBUcKYe/ZSW3Z8VSVE8c3t4njrZEAIJHTgKqKwmjmUCCveCY0Ry/v
	 aqf9dlfyX14RKjx74YNE5oq/E/LwT/94sHCg9qEqbmSKPLJ2DdJiCtbMAeJ410VUoP
	 Uzg5CMk67y93TOItn3SVSN4y9TCg5UQfCCuNCPreIMusG+gxAI558Ef8Ig1uaR3139
	 Fklmx2IKDlUDuLfHqqO9q9/WT4VSS8HJ16M6jr83d/NPzSO/I7Tj852d/cm+7D01TD
	 GaHGECEFImjiw==
Date: Tue, 5 Mar 2024 16:03:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
	ilpo.jarvinen@linux.intel.com, hkallweit1@gmail.com,
	johan+linaro@kernel.org, xueshuai@linux.alibaba.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Message-ID: <20240305220342.GA552530@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222174436.3565146-1-vidyas@nvidia.com>

[+to Sathy, David in case you want to update your Reviewed-by]

On Thu, Feb 22, 2024 at 11:14:36PM +0530, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery Handler.
> 
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not to
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> 
> Update the saved configuration state of the device with the latest info
> whenever there is a change w.r.t ASPM policy.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

> -void pci_save_aspm_state(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);

I rebased this again on top of my pci/aspm updates to remove the need
for the rename above.

> +static void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);

And I changed this part so it only updates the PCI_EXP_LNKCTL_ASPMC
bits, not the entire LNKCTL.

Updating the entire saved register probably wouldn't *break* anything,
but it could randomly hide other LNKCTL changes depending on whether
or not ASPM configuration was changed in the interim.  For example:

  - driver .probe() saves LNKCTL
  - LNKCTL changes some non-ASPMC thing via setpci or other mechanism
  - save_state updated via pcie_config_aspm_link()

A restore in .slot_reset() would restore different LNKCTL values for
the non-ASPMC change depending on whether pcie_config_aspm_link() was
used.

I applied it on pci/aspm for v6.9.  Please take a look and make sure
it still does what you need:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=aspm&id=a6315434436d587f70e489e6365c5b7e20176a71

Sathy and David, I didn't add your Reviewed-by because I didn't want
to presume that you were OK with my changes.  But I'd be more than
happy to add them if you take a look.

Bjorn

> +}
> +
>  void pci_aspm_get_l1ss(struct pci_dev *pdev)
>  {
>  	/* Read L1 PM substate capabilities */
>  	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
>  }
>  
> -void pci_save_aspm_state(struct pci_dev *pdev)
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	u16 l1ss = pdev->l1ss;
> @@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  	struct pci_bus *linkbus = link->pdev->subordinate;
>  	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
>  
> -	list_for_each_entry(child, &linkbus->devices, bus_list)
> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>  						   val);
> +		pci_save_aspm_state(child);
> +	}
>  	link->clkpm_enabled = !!enable;
>  }
>  
> @@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_l1ss_state(link->downstream);
> +	pci_save_aspm_state(parent);
> +	pci_save_aspm_l1ss_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
> -- 
> 2.25.1
> 

