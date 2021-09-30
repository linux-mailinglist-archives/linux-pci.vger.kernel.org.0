Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A084241E508
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhI3XfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 19:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347868AbhI3XfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 19:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6BCA61ABB;
        Thu, 30 Sep 2021 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633044821;
        bh=h8eyjgc6eB3CZ+xV2FfGSxIwDMyg6Eu7LxyxMugrUe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a94pZllIvaQOTvZaQAkEDh83rPSpo/P6XM/KIA8j0oMhfbNPhGTXfpSgBpMv9buqr
         6nUgd6+clA211lfTdeacM+zWSQ1ypRbw5pgmCfmXzlXbly8A2IrPtUo9/F6TBf0zev
         FcwGAxq0B5kzMsOCKcfnPa52/Pa9JGEak/j+vCF+aB05XaXOUA64RmisiuQZvXKxgW
         QLFlTHgneMrQ/jnk+qmf60G6scyrGCM5SvgBCK3V3PZgg8ml1AguRxguN5qhQuLqK7
         HpBo0qJIA7YYOJx+XJ6+rfvJBtKL0dZn7balx5AvFPjrJxPrfy/wFiM49G+dfqOdx9
         BKRVM5h12pC4Q==
Date:   Thu, 30 Sep 2021 18:33:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] PCI/ASPM: Do not cache link latencies
Message-ID: <20210930233339.GA924309@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004116.20650-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:41:14AM +0200, Saheed O. Bolarinwa wrote:
> The latencies of the upstream and downstream are calculated within
> pcie_aspm_cap_init() and cached in struct pcie_link_state.latency_*
> These values are only used in pcie_aspm_check_latency() where they are
> compared with the acceptable latencies on the link.
> 
> This patch:
> - removes `latency_*` entries from struct pcie_link_state.
> - calculates the latencies directly where they are needed.
> - moves pci_function_0() upward, so that the downstream device can be
>   obtained by calling it directly.

Ideally I would put the move in its own preliminary patch so the
important parts of this patch are more visible.

> - further removes dependencies on struct pcie_link_state.
> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 54 ++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 013a47f587ce..9e85dfc56657 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -66,9 +66,6 @@ struct pcie_link_state {
>  	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  
> -	/* Exit latencies */
> -	struct aspm_latency latency_up;	/* Upstream direction exit latency */
> -	struct aspm_latency latency_dw;	/* Downstream direction exit latency */
>  	/*
>  	 * Endpoint acceptable latencies. A pcie downstream port only
>  	 * has one slot under it, so at most there are 8 functions.
> @@ -376,9 +373,25 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  	}
>  }
>  
> +/*
> + * The L1 PM substate capability is only implemented in function 0 in a
> + * multi function device.
> + */
> +static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
> +{
> +	struct pci_dev *child;
> +
> +	list_for_each_entry(child, &linkbus->devices, bus_list)
> +		if (PCI_FUNC(child->devfn) == 0)
> +			return child;
> +	return NULL;
> +}
> +
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -	u32 latency, l1_switch_latency = 0;
> +	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
> +	struct pci_dev *downstream;
> +	struct aspm_latency latency_up, latency_dw;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -388,17 +401,26 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  		return;
>  
>  	link = endpoint->bus->self->link_state;
> +	downstream = pci_function_0(link->pdev->subordinate);

This looks like it's in the wrong patch.  Isn't "downstream" still the
same as link->downstream?  I think you have another patch that removes
pcie_link_state.downstream, and this hunk should go in that patch.

>  	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
>  
>  	while (link) {
> +		/* Read direction exit latencies */
> +		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
> +		pcie_capability_read_dword(downstream, PCI_EXP_LNKCAP, &lnkcap_dw);
> +		latency_up.l0s = calc_l0s_latency(lnkcap_up);
> +		latency_up.l1 = calc_l1_latency(lnkcap_up);
> +		latency_dw.l0s = calc_l0s_latency(lnkcap_dw);
> +		latency_dw.l1 = calc_l1_latency(lnkcap_dw);

I like this a lot.

>  		/* Check upstream direction L0s latency */
>  		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -		    (link->latency_up.l0s > acceptable->l0s))
> +		    (latency_up.l0s > acceptable->l0s))
>  			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
>  
>  		/* Check downstream direction L0s latency */
>  		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -		    (link->latency_dw.l0s > acceptable->l0s))
> +		    (latency_dw.l0s > acceptable->l0s))
>  			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
>  		/*
>  		 * Check L1 latency.
> @@ -413,7 +435,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  		 * L1 exit latencies advertised by a device include L1
>  		 * substate latencies (and hence do not do any check).
>  		 */
> -		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +		latency = max_t(u32, latency_up.l1, latency_dw.l1);
>  		if ((link->aspm_capable & ASPM_STATE_L1) &&
>  		    (latency + l1_switch_latency > acceptable->l1))
>  			link->aspm_capable &= ~ASPM_STATE_L1;
> @@ -423,20 +445,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	}
>  }
>  
> -/*
> - * The L1 PM substate capability is only implemented in function 0 in a
> - * multi function device.
> - */
> -static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
> -{
> -	struct pci_dev *child;
> -
> -	list_for_each_entry(child, &linkbus->devices, bus_list)
> -		if (PCI_FUNC(child->devfn) == 0)
> -			return child;
> -	return NULL;
> -}
> -
>  static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
>  				    u32 clear, u32 set)
>  {
> @@ -593,8 +601,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  		link->aspm_enabled |= ASPM_STATE_L0S_UP;
>  	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
>  		link->aspm_enabled |= ASPM_STATE_L0S_DW;
> -	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
> -	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
>  
>  	/* Setup L1 state */
>  	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
> @@ -602,8 +608,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  
>  	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
>  		link->aspm_enabled |= ASPM_STATE_L1;
> -	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
> -	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
>  
>  	/* Setup L1 substate */
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
> -- 
> 2.20.1
> 
