Return-Path: <linux-pci+bounces-13774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64A98F4AF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 19:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C6A1C212E5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340722747B;
	Thu,  3 Oct 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKZeJ031"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDB1EB31
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974885; cv=none; b=ocPyEiv5nSycKKeBwUIrEnQcNSQXeiIcy0lf8oYqEOZOWbWTdhDIGO3aYN/75LXshqccsVkvBAdSMULd1TZWfMg7yPpvvxI1bB+OFKzHtyMuCisVlhlgaBY24LEvIIqK3lWPaI8vOoVttH2bpw/y7p+jvjNjsEb7EwDCdUu16JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974885; c=relaxed/simple;
	bh=GjkwvnpUjIbZGJC0sau5gvVwBd2ukofbWzM6fPgbWQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JWsj0XCcLLz+A1cnzWstZkzpJZ/7/PhFlpNnxtIVM5V+f5tzEteYiQZQQ8f4kiSh2hTqT24qg9aEbz5WyoGRBb6S5GHkrliPjD4qyY51lDxhoqC5lgMCG1Ncd+E1a9KYnLySEA6rtnaJyFNaMULZaR7+As3wOcJ5MNYBsDv1QVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKZeJ031; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF07C4CECC;
	Thu,  3 Oct 2024 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727974884;
	bh=GjkwvnpUjIbZGJC0sau5gvVwBd2ukofbWzM6fPgbWQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iKZeJ031gcQQJF5yVdHdd/FT0SOxKTHArDWXcD4AYdWMHzdjtCoGP9IZkIwPL9F47
	 04PbpufRWjM66oHXi19v4xLj2rxt3K20Bv4v7piFcFHYdGHvebzTffnrWb+igm2rBB
	 UjT5E8tHPO2/XHDPnjfgFHQUOvweogl8o83mC1pWnHK99D4aPxJb54roP3+ISNr+c4
	 S7lvMyUfPGCB397zAXQOGrVdsi8BJPAiQUM9yDTJMRUJop3dwEmGJBIxrKmo/D2KNz
	 f3qnqayWXHjYmYpEJjeIeCGQ946bfAZz/G9uY/em1HoV+Rox6G1+Hc/apQLiK+ONWB
	 ec2e6V7StLfYQ==
Date: Thu, 3 Oct 2024 12:01:22 -0500
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
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241003170122.GA310049@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003132503.2279433-1-ajayagarwal@google.com>

On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> The current sequence in the driver for L1ss update is as follows.
> 
> Disable L1ss
> Disable L1
> Enable L1ss as required
> Enable L1 if required
> 
> With this sequence, a bus hang is observed during the L1ss
> disable sequence when the RC CPU attempts to clear the RC L1ss
> register after clearing the EP L1ss register.

Thanks for this.  What exactly does the bus hang look like to a user?

I guess the problem happens in pcie_config_aspm_l1ss(), where we do:

  pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
  pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)

where clearing the child (endpoint) PCI_L1SS_CTL1_L1_2_MASK works, but
something goes wrong when clearing the parent (RP) mask?  The
clear_and_set will do a read followed by a write, and one of those
causes some kind of error?

> It looks like the
> RC attempts to enter L1ss again and at the same time, access to
> RC L1ss register fails because aux clk is still not active.

I assume "access to RC L1ss register fails" means something like
"reading the Root Port PCI_L1SS_CTL1 register returns ~0" which I
guess would be the read part of the pci_clear_and_set_config_dword()?

~0 data might be returned because of some PCIe error like Unsupported
Request, Completion Timeout, etc?  Such an error should be logged in
the AER Capability.

This *sounds* like it would be a hardware defect in the Root Port.
This register is on the upstream end of the link, so I would think it
would be readable no matter what state the link is in.

Sec 5.5.4 requires that L1 be disabled in PCI_EXP_LNKCTL while
*setting* either of the ASPM L1 PM Substates enable bits.  I don't see
anything there about requiring that for *clearing* those enable bits.
But maybe it is required, and in any event I guess it's simpler to do
it as you do here and have L1 (indeed *all* ASPM) disabled while
configuring L1 SS.

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
> ---
>  drivers/pci/pcie/aspm.c | 50 ++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..c172886129f3 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -848,17 +848,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
> @@ -871,16 +867,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
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
> @@ -937,21 +923,33 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
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

I think the reason for having pcie_config_aspm_dev(parent) both before
and after configuring the children is because pcie_config_aspm_link()
may be called either to enable L1 or to disable it.

I guess your change always disables ASPM completely (disabling the
downstream (child) component first, then the upstream), and here we
are either leaving L1 disabled or enabling it, and in either case it
should be safe to configure the upstream (parent) component first,
then the downstream one.

Of course, we may also enable L0s here, and AFAICS it should always be
safe to do that in the upstream component first, followed by the
downstream one.

Bottom line, this looks good to me, and I think it's nice that this
removes the "parent then child" or "child then parent" logic here.

>  	link->aspm_enabled = state;
>  
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

