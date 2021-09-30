Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD241E51D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbhI3XyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 19:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350449AbhI3XyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 19:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C87876124D;
        Thu, 30 Sep 2021 23:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633045939;
        bh=OLll2I34s+GJblJ/EknxqjbF2vBQhG9L9rum++osrXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dpeR/32gdT9egDViUVPwMvi7X2hl5x3hz1ATeZoRuxRt2+/1KQyR/wU9a74lef0+n
         49WG3kBElEj+qf5Q/MaVhVLj/YpNZgNvI4Dam0Dztxrh4UEpQ81iRgWRPH81q7oKcE
         2Z5KOTaXfBHe/+zOdn1kZIvgFykW/FQ8WVeSGGYoHzi0aMfmMDCYSaRP0y+2F1NXHS
         rhqrFVOTK2jmU61Kj/teeek1LEG9g4WoWCSSSmTbkOXWKmNiNYfUQAhBVNxjUGNo3T
         39zDFwS0uIU/CKIM5+T7yFDn3epvQiilDxJaxLV2rZdltP2kQvqJA5p9zo0TIDE6FK
         6hB1fp9gckS/Q==
Date:   Thu, 30 Sep 2021 18:52:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: Re: [RFC PATCH 2/3 v2] PCI/ASPM: Remove struct
 pcie_link_state.acceptable
Message-ID: <20210930235217.GA925639@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916084926.32614-3-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 10:49:25AM +0200, Saheed O. Bolarinwa wrote:
> The acceptable latencies for each device on the bus are calculated within
> pcie_aspm_cap_init() and cached in struct pcie_link_state.acceptable. They
> are only used in pcie_aspm_check_latency() to validate actual latencies.
> Thus, it is possible to avoid caching these values.
> 
> This patch:
>   - removes `acceptable` from struct pcie_link_state
>   - calculates the acceptable latency for each device directly
>   - removes the calculations done within pcie_aspm_cap_init()
> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 9e85dfc56657..0c0c055823f1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -65,12 +65,6 @@ struct pcie_link_state {
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
>  	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
> -
> -	/*
> -	 * Endpoint acceptable latencies. A pcie downstream port only
> -	 * has one slot under it, so at most there are 8 functions.
> -	 */
> -	struct aspm_latency acceptable[8];
>  };
>  
>  static int aspm_disabled, aspm_force;
> @@ -389,7 +383,7 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
>  
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
> +	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
>  	struct pci_dev *downstream;
>  	struct aspm_latency latency_up, latency_dw;
>  	struct aspm_latency *acceptable;
> @@ -402,7 +396,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  
>  	link = endpoint->bus->self->link_state;
>  	downstream = pci_function_0(link->pdev->subordinate);
> -	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
> +	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);

I think you can use endpoint->devcap here, can't you?

> +	/* Calculate endpoint L0s acceptable latency */
> +	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
> +	acceptable->l0s = calc_l0s_acceptable(encoding);
> +	/* Calculate endpoint L1 acceptable latency */
> +	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
> +	acceptable->l1 = calc_l1_acceptable(encoding);

I think it's a little weird that we call pcie_aspm_check_latency() for
all the functions in a multi-function device.  It's true that they can
all have different acceptable latencies, but they're all on the
downstream end of the same link, so they will all see the same exit
latencies.

I would think we could compute the minimum latency across all the
functions and do a single check to see whether the link can meet that.
But that would be material for a future patch, not this one.

>  	while (link) {
>  		/* Read direction exit latencies */
> @@ -664,22 +664,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  
>  	/* Get and check endpoint acceptable latencies */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
> -		u32 reg32, encoding;
> -		struct aspm_latency *acceptable =
> -			&link->acceptable[PCI_FUNC(child->devfn)];
>  
>  		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
>  		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
>  			continue;
>  
> -		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
> -		/* Calculate endpoint L0s acceptable latency */
> -		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
> -		acceptable->l0s = calc_l0s_acceptable(encoding);
> -		/* Calculate endpoint L1 acceptable latency */
> -		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
> -		acceptable->l1 = calc_l1_acceptable(encoding);
> -
>  		pcie_aspm_check_latency(child);
>  	}
>  }
> -- 
> 2.20.1
> 
