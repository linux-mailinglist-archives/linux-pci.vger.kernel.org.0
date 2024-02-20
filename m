Return-Path: <linux-pci+bounces-3790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9F85C284
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E108CB22B36
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09876C74;
	Tue, 20 Feb 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8su+0gu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1B2599;
	Tue, 20 Feb 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449813; cv=none; b=hNp+gRuO85/crxGnooHtvpNOvzmZzXop+o8x7bhlIZeggFTExFCVEeQfXa/itXMww3RBWswybwjwgbdr0cjh1vOGDqV2lAC4vXYUT9vNOyzXhw1nWiItVg2Ea3P6znqDvOmV/1WYro0x9CHZUukOoeAj0jlwxmq3wXOU3EAl8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449813; c=relaxed/simple;
	bh=dmMWWCPUJrt43ZgfiKC2edIWPknjOvRFAVs6CZ9C13g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hl7SEURC5H3BpywXiIGNXnjHrfsMEMvaEj29/XCLFJDuUTddi92J5zIPl8U2pb14dwR41oSZ5Tm6NNrr2ITyPYz7TusIitrRefLTodotUHHR2lvoUBzZqoev2q3o10nwyANgmsGjwgAMyeFgOnH4HkWLA8sTnoptDD/W1zoMJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8su+0gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DCAC433C7;
	Tue, 20 Feb 2024 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708449813;
	bh=dmMWWCPUJrt43ZgfiKC2edIWPknjOvRFAVs6CZ9C13g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q8su+0gueaLh5W/I5BSWsIJUm433FvHhhf5wJ7T0cSL1w2yEb7cnZhOY9AMBFepCX
	 KB9EZ+9km9AoPGWz8wcNlSO5ZsRndsX8+Jti+Jtt6ekVR+FK3Vn6C9i69gKld1n3N2
	 PwIDvnecraaCIBXYD/QXr2XCmBvg6RMIyGKRe9q82+qLwRfzAvgnrkQ5UJR43ilSIv
	 wIK7x3f3AfcfXaaGs4PenJFim1oCy/xXkh5+GpLj1y9C82n8ns04Tg4XRMLVse+3us
	 wmBq94FO85R7LumuCDqiEh6aR0YJy36WSxxnGB5eyszXvZ/tqgwyT6+yLxfkBXYoit
	 AvU0Kr0jpNKnQ==
Date: Tue, 20 Feb 2024 11:23:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
	ilpo.jarvinen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH V3] PCI/ASPM: Update saved buffers with latest ASPM
Message-ID: <20240220172331.GA1495757@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108124248.1552420-1-vidyas@nvidia.com>

[+cc David]

On Mon, Jan 08, 2024 at 06:12:48PM +0530, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery Handler.
> 
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> 
> Update the saved configuration state of the device with the latest info
> whenever there is a change w.r.t ASPM policy.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

This overlaps with David's patches that are currently queued for v6.9:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=be00f078ad2a

Can you rebase this to apply on top of those (this is the pci/aspm
branch)?

> ---
> V3:
> * Addressed sathyanarayanan.kuppuswamy's review comments
> 
> V2:
> * Rebased on top of the tree code
> * Addressed Bjorn's review comments
> 
>  drivers/pci/pcie/aspm.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 67b13f26ba7c..1b4f03044ce2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -138,16 +138,34 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>  	return 0;
>  }
>  
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
> +}
> +
>  static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  {
>  	struct pci_dev *child;
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
> @@ -767,6 +785,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
> -- 
> 2.25.1
> 

