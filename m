Return-Path: <linux-pci+bounces-13725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B198E21C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725181C2367E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F421D0F4E;
	Wed,  2 Oct 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4NWQlsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE991CF7C0
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892745; cv=none; b=qjKesHe8arqKKQLryDC+U3y5OQvDQAQEBe5EtdQmxGNdy3e5yBYr5heShKJvJxYyZShNAGquTMONrbK7C1+re/YJav2Nug/5jOyBbZjt3fHZWghfKYjH/uovbhvjpjnacIf4TQPaUHwAHsDSzOgSEoloozWjsN1ecs8Z1GA559U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892745; c=relaxed/simple;
	bh=cNgg+CXxM2+slP0xcP6RVYWt4PIwLhPNAa320cQ4Lyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=il06qUeX1Stv2wcbB7EskzpJI2+Hx2+hoQ4/v0hnoOh9QfNaHirjw6AxWSU+z6fL/7h2x8u0aNDLtZqtaQBlJzUi87+X503Tn3Ryr8i0vW+trxXM6dW+MXnBLAnVKVVenu02j29E/VlKoEQoVLzm/dJDEnzMvB1oQzlgLJ2SGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4NWQlsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E535CC4CEC2;
	Wed,  2 Oct 2024 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727892745;
	bh=cNgg+CXxM2+slP0xcP6RVYWt4PIwLhPNAa320cQ4Lyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o4NWQlsEGXp2lr93mxtSCz9qHUQwwbvRpx7l1PhScuAX4UQ+5hldJHC4HW15vyGEW
	 5IKeVSpCDFlG2D91zpkJ5/KSvesha0XMG/jv3yg5t/fy59AS35pvTNQ7jhJIC2L1T/
	 JpELDkRvKnk5qxBhMmg0lS74pwrZ0FGUczZIJBfLtZVNkAA7WtN2e54BWWGI5nfwzO
	 lE1CuntU3tRH8zoysQEFgOLdriYAnnU5z9upvdj4Xb9wnLcjZEQQACu21oLGHKnt+Z
	 oDVFw6/dxL+wpVNT+3SYmf49soPSOAhC7siNOy519ZBLAUTULKiyF6mOyhThCEmQ7Q
	 hvKJFGipzY6qQ==
Date: Wed, 2 Oct 2024 13:12:23 -0500
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
Subject: Re: [PATCH] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241002181223.GA231923@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001133519.2743673-1-ajayagarwal@google.com>

On Tue, Oct 01, 2024 at 07:05:18PM +0530, Ajay Agarwal wrote:
> The current sequence in the driver for L1ss update is as follows.
> 
> Disable L1ss
> Disable L1
> Enable L1ss as required
> Enable L1 if required
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

This seems reasonable to me.  If you have seen a failure that is fixed
by this change, please include some details here.

> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..d37f66f9e9c8 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -848,16 +848,14 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
>  	 * Here are the rules specified in the PCIe spec for enabling L1SS:
>  	 * - When enabling L1.x, enable bit at parent first, then at child
>  	 * - When disabling L1.x, disable bit at child first, then at parent
> -	 * - When enabling ASPM L1.x, need to disable L1
> +	 * - When enabling/disabling ASPM L1.x, need to disable L1
>  	 *   (at child followed by parent).
>  	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
>  	 *   parameters

Since you're updating this comment already, can you add the spec
citation here, e.g., "PCIe r6.2, sec 5.5.4"?

> @@ -866,21 +864,17 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  	 * what is needed.
>  	 */
>  
> +	/* Disable L1, and it gets enabled later in pcie_config_aspm_link() */
> +	pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
> +				   PCI_EXP_LNKCTL_ASPM_L1);
> +	pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
> +				   PCI_EXP_LNKCTL_ASPM_L1);

I think it would be nice to have the disable and enable in the same
place.  Could we move this to pcie_config_aspm_link()?  I'm not sure
the pcie_config_aspm_dev() wrapper adds a lot of value, but we could
at least do both ends using the same wrapper.

pcie_config_aspm_link() configures all children; here we only do one
child.  I suspect we should do disable L1 for all of them here, and
doing both in pcie_config_aspm_link() would make that clearer.

pcie_config_aspm_link() has a comment ("Spec 2.0 ...") about the
configuration order, but I'd like to update that, add a section
reference, and make sure we do the disable in the right order.

>  	/* Disable all L1 substates */
>  	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
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
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

