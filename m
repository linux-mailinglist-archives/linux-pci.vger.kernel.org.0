Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A373277BAA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgIXWgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 18:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgIXWgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 18:36:38 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969DE2137B;
        Thu, 24 Sep 2020 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600986997;
        bh=8FhTslLpaMFd/js/+ONqtT6N6BaNUcy9XEbO0WOOhTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NJLkDLmcfmaKZ3Cxo04JMmtUG3jHHq2XBae3DvpaNl4HmmH0NSi+ViWNaClFVqmkS
         llzMa1mZKkzSdo4s2SB7ND5fwT9B+lFwP1plI8nK9XctDpNd47VdiBe/T6d/vwPw1Y
         c/vRL871DO0KCa+IWIW2e0E1VN9I3UWC74TQ9afI=
Date:   Thu, 24 Sep 2020 17:36:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/7] PCI/ASPM: Compute the value of
 aspm_register_info.support directly
Message-ID: <20200924223636.GA2366261@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142443.260861-4-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:24:39PM +0200, Saheed O. Bolarinwa wrote:
>  - Calculate aspm_register_info.support inside aspm_support()
>  - Replace references to aspm_register_info.support with aspm_support().
>  - In pcie_get_aspm_reg() remove assignment to aspm_register_info.support
>  - Remove aspm_register_info.support
> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5f7cf47b6a40..321b328347c1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -383,7 +383,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  }
>  
>  struct aspm_register_info {
> -	u32 support:2;
>  	u32 enabled:2;
>  
>  	/* L1 substates */
> @@ -396,12 +395,10 @@ struct aspm_register_info {
>  static void pcie_get_aspm_reg(struct pci_dev *pdev,
>  			      struct aspm_register_info *info)
>  {
> -	u16 reg16;
> -	u32 reg32 = pdev->lnkcap;
> +	u16 ctl;

Don't include unrelated changes.  The change from "reg16" to "ctl" is
gratuitous, and it makes this patch harder to read.  I think you
remove it later anyway.

> -	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
> -	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
> +	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
>  
>  	/* Read L1 PM substate capabilities */
>  	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
> @@ -540,6 +537,11 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>  }
>  
> +static void aspm_support(struct pci_dev *pdev)
> +{
> +	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;

Oops, this doesn't build!  Should return a u32.

> +}
> +
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> @@ -561,7 +563,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	 * If ASPM not supported, don't mess with the clocks and link,
>  	 * bail out now.
>  	 */
> -	if (!(upreg.support & dwreg.support))
> +	if (!(aspm_support(parent) & aspm_support(child)))
>  		return;
>  
>  	/* Configure common clock before checking latencies */
> @@ -581,8 +583,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	 * given link unless components on both sides of the link each
>  	 * support L0s.
>  	 */
> -	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
> +	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
>  		link->aspm_support |= ASPM_STATE_L0S;
> +
>  	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
>  		link->aspm_enabled |= ASPM_STATE_L0S_UP;
>  	if (upreg.enabled & PCIE_LINK_STATE_L0S)
> @@ -591,8 +594,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->latency_dw.l0s = calc_l0s_latency(child);
>  
>  	/* Setup L1 state */
> -	if (upreg.support & dwreg.support & PCIE_LINK_STATE_L1)
> +	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
>  		link->aspm_support |= ASPM_STATE_L1;
> +
>  	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
>  		link->aspm_enabled |= ASPM_STATE_L1;
>  	link->latency_up.l1 = calc_l1_latency(parent);
> -- 
> 2.18.4
> 
