Return-Path: <linux-pci+bounces-15067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B39AB97B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731F41C22443
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA04198E70;
	Tue, 22 Oct 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI786ddg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0218DF6B
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636220; cv=none; b=sbYbrEjxLxKHIKyS2hBGneimLFrY3Bw59xPx6cjyv2NzlhQo3z5d+1xhsdmJUimZOtAZropgfTpej0jb0SbwLpF9bEgxCWvPXbnJ9vz/u2KAOnyvtSh2jsjEMfXnaffrs09f9OQnF5Ma49QHwXLx0Bam0GIFV5FJS/6PhIrOC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636220; c=relaxed/simple;
	bh=/5lwgxPVYA/hx5f+pZQF0u5+5dmb0rPTDv9dYP889HM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PgqwSCuRSM8W9C9q+JfQ1eLDZ+p/qetkmnsp7SAKT+IYuMIPp9aSXlLs6TfnT8XgOxjJuwM6aUOU/32qWi9T8JibqaixGOzdIRDIfj+htmskQJgo46imqRYNWG5x8pHf9UL2eT/0Q4ex0w82/aXzni734Da0D6V87tItLyoOn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI786ddg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD866C4CEC3;
	Tue, 22 Oct 2024 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729636219;
	bh=/5lwgxPVYA/hx5f+pZQF0u5+5dmb0rPTDv9dYP889HM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mI786ddgabQJ6eMgsz79Ag5/Og6RJHTpa8PBF6iEKUTj3RlHJYVr6yJi7Hv3OzaFO
	 J28ZOErqxYklrBPeFvYZUF/Ud9Tf19hWWLKf+WGZ4XqJQxVpujLRLCqGUs9CU1q37D
	 drdtmtSRynMbG2R1o4FQZ3JXpjTtrD8q+LQo5LK22ZBkpcfIN3FXD0xcLSgOPv0lSq
	 9UdTOa4twNEfx3jMW6dD6InUCgVFov/cNm+eotRLI04EipYrknbK8erXOXcVLs2Npr
	 K7EvkZYJvyD6//unCKF6jCn0Ua3QLXjDwtI35FETxTtK1miMpUo+QDXsDuZFul3+z1
	 UneBFbyHpE5ZQ==
Date: Tue, 22 Oct 2024 17:30:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241022223018.GA893095@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007032917.872262-1-ajayagarwal@google.com>

On Mon, Oct 07, 2024 at 08:59:17AM +0530, Ajay Agarwal wrote:
> The current sequence in the driver for L1ss update is as follows.
> 
> Disable L1ss
> Disable L1
> Enable L1ss as required
> Enable L1 if required
> 
> With this sequence, a bus hang is observed during the L1ss
> disable sequence when the RC CPU attempts to clear the RC L1ss
> register after clearing the EP L1ss register. It looks like the
> RC attempts to enter L1ss again and at the same time, access to
> RC L1ss register fails because aux clk is still not active.
> 
> PCIe spec r6.2, section 5.5.4, recommends that setting either
> or both of the enable bits for ASPM L1 PM Substates must be done
> while ASPM L1 is disabled. My interpretation here is that
> clearing L1ss should also be done when L1 is disabled. Thereby,
> change the sequence as follows.
> 
> Disable L1
> Disable L1ss
> Enable L1ss as required
> Enable L1 if required
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>

Applied to pci/aspm for v6.13, thank you, Ajay!

> ---
> Changelog since v2:
>  - Add the logic in pcie_aspm_cap_init()
> 
> Changelog since v1:
>  - Move the L1 disable/enable logic to pcie_config_aspm_link()
>  - Add detailed comments including spec version and section number
> 
>  drivers/pci/pcie/aspm.c | 66 +++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..50997e378631 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -805,6 +805,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
>  	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
>  
> +	/* Make sure L0s/L1 are disabled before updating L1SS config */
> +	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
> +	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> +		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
> +					   child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
> +					   parent_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
> +	}
> +
>  	/*
>  	 * Setup L0s state
>  	 *
> @@ -829,6 +838,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  
>  	aspm_l1ss_init(link);
>  
> +	/* Restore L0s/L1 if they were enabled */
> +	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
> +	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
> +		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
> +	}
> +
>  	/* Save default state */
>  	link->aspm_default = link->aspm_enabled;
>  
> @@ -848,17 +864,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  /* Configure the ASPM L1 substates */
>  static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  {
> -	u32 val, enable_req;
> +	u32 val;
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  
> -	enable_req = (link->aspm_enabled ^ state) & state;
> -
>  	/*
> -	 * Here are the rules specified in the PCIe spec for enabling L1SS:
> +	 * Spec r6.2, section 5.5.4, mentions the rules for enabling L1SS:
>  	 * - When enabling L1.x, enable bit at parent first, then at child
>  	 * - When disabling L1.x, disable bit at child first, then at parent
> -	 * - When enabling ASPM L1.x, need to disable L1
> -	 *   (at child followed by parent).
>  	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
>  	 *   parameters
>  	 *
> @@ -871,16 +883,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				       PCI_L1SS_CTL1_L1SS_MASK, 0);
>  	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>  				       PCI_L1SS_CTL1_L1SS_MASK, 0);
> -	/*
> -	 * If needed, disable L1, and it gets enabled later
> -	 * in pcie_config_aspm_link().
> -	 */
> -	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
> -		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
> -					   PCI_EXP_LNKCTL_ASPM_L1);
> -		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
> -					   PCI_EXP_LNKCTL_ASPM_L1);
> -	}
>  
>  	val = 0;
>  	if (state & PCIE_LINK_STATE_L1_1)
> @@ -937,21 +939,33 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
>  	}
>  
> +	/*
> +	 * Spec r6.2, section 5.5.4, recommends that setting either or both of
> +	 * the enable bits for ASPM L1 PM Substates must be done while ASPM L1
> +	 * is disabled. So disable L1 here, and it gets enabled later after the
> +	 * L1ss configuration has been completed.
> +	 *
> +	 * Spec r6.2, section 7.5.3.7, mentions that ASPM L1 must be enabled by
> +	 * software in the Upstream component on a Link prior to enabling ASPM
> +	 * L1 in the Downstream component on the Link. When disabling L1,
> +	 * software must disable ASPM L1 in the Downstream component on a Link
> +	 * prior to disabling ASPM L1 in the Upstream component on that Link.
> +	 *
> +	 * Spec doesn't mention L0s.
> +	 *
> +	 * Disable L1 and L0s here, and they get enabled later after the L1ss
> +	 * configuration has been completed.
> +	 */
> +	list_for_each_entry(child, &linkbus->devices, bus_list)
> +		pcie_config_aspm_dev(child, 0);
> +	pcie_config_aspm_dev(parent, 0);
> +
>  	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
>  		pcie_config_aspm_l1ss(link, state);
>  
> -	/*
> -	 * Spec 2.0 suggests all functions should be configured the
> -	 * same setting for ASPM. Enabling ASPM L1 should be done in
> -	 * upstream component first and then downstream, and vice
> -	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
> -	 */
> -	if (state & PCIE_LINK_STATE_L1)
> -		pcie_config_aspm_dev(parent, upstream);
> +	pcie_config_aspm_dev(parent, upstream);
>  	list_for_each_entry(child, &linkbus->devices, bus_list)
>  		pcie_config_aspm_dev(child, dwstream);
> -	if (!(state & PCIE_LINK_STATE_L1))
> -		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
>  
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 

