Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEF277BD9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIXWvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 18:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgIXWvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:20 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4608E23600;
        Thu, 24 Sep 2020 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600987879;
        bh=KU0yd/VLieG6GJxjOPFnRu7n5ebGm+dBqSkNJe0Twck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hMK9CSeqLjaO5vsBJbZfzJAe3wkvwDbB8pWYn4C91x16Tf2eBir9XvuIIlPimXsvi
         6lvH+1+edDbM5NpdJdIynKzjHbDBnP/UxvEONPqsK/xbXctHPrFCydBi6dBBEEdctJ
         RTmuwJaM3R7X7H6oOf4IDnx77K4DONILIGP4U5No=
Date:   Thu, 24 Sep 2020 17:51:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/7] PCI/ASPM: Remove struct aspm_register_info and
 pcie_get_aspm_reg()
Message-ID: <20200924225117.GA2366896@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142443.260861-7-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:24:42PM +0200, Saheed O. Bolarinwa wrote:
>  - Create get_aspm_enable() to compute aspm_register_info.enable directly
>  - Replace all aspm_register_info.enable references with get_aspm_enable()
>  - Remove pcie_get_aspm_reg() and all calls to it. All the values are now
>    calculated elsewhere.
>  - Remove struct aspm_register_info and its references
> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cec8acad6363..f4fc2d65240c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -382,19 +382,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  	}
>  }
>  
> -struct aspm_register_info {
> -	u32 enabled:2;
> -};
> -
> -static void pcie_get_aspm_reg(struct pci_dev *pdev,
> -			      struct aspm_register_info *info)
> -{
> -	u16 ctl;
> -
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
> -	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
> -}
> -
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
>  	u32 latency, l1_switch_latency = 0;
> @@ -511,11 +498,18 @@ static void aspm_support(struct pci_dev *pdev)
>  	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;
>  }
>  
> +static u32 get_aspm_enable(struct pci_dev *pdev)

Shouldn't this return u16?

> +{
> +	u16 ctl;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
> +	return (ctl & PCI_EXP_LNKCTL_ASPMC);
> +}
> +
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	struct pci_bus *linkbus = parent->subordinate;
> -	struct aspm_register_info upreg, dwreg;
>  	u32 up_l1ss_ctl1, dw_l1ss_ctl1;
>  
>  	if (blacklist) {
> @@ -525,10 +519,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  		return;
>  	}
>  
> -	/* Get upstream/downstream components' register state */
> -	pcie_get_aspm_reg(parent, &upreg);
> -	pcie_get_aspm_reg(child, &dwreg);
> -
>  	/*
>  	 * If ASPM not supported, don't mess with the clocks and link,
>  	 * bail out now.
> @@ -544,13 +534,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	pci_read_config_dword(child, child->l1ss_cap_ptr + PCI_L1SS_CTL1,
>  				&dw_l1ss_ctl1);
>  
> -	/*
> -	 * Re-read upstream/downstream components' register state
> -	 * after clock configuration
> -	 */
> -	pcie_get_aspm_reg(parent, &upreg);
> -	pcie_get_aspm_reg(child, &dwreg);
> -
>  	/*
>  	 * Setup L0s state
>  	 *
> @@ -561,9 +544,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
>  		link->aspm_support |= ASPM_STATE_L0S;
>  
> -	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
> +	if (get_aspm_enable(child) & PCIE_LINK_STATE_L0S)
>  		link->aspm_enabled |= ASPM_STATE_L0S_UP;
> -	if (upreg.enabled & PCIE_LINK_STATE_L0S)
> +	if (get_aspm_enable(parent) & PCIE_LINK_STATE_L0S)
>  		link->aspm_enabled |= ASPM_STATE_L0S_DW;
>  	link->latency_up.l0s = calc_l0s_latency(parent);
>  	link->latency_dw.l0s = calc_l0s_latency(child);
> @@ -572,7 +555,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
>  		link->aspm_support |= ASPM_STATE_L1;
>  
> -	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
> +	if (get_aspm_enable(parent) & get_aspm_enable(child)
> +				    & PCIE_LINK_STATE_L1)

We just read these enable bits above, and I don't think they've
changed.  Can we just read them once?

>  		link->aspm_enabled |= ASPM_STATE_L1;
>  	link->latency_up.l1 = calc_l1_latency(parent);
>  	link->latency_dw.l1 = calc_l1_latency(child);
> -- 
> 2.18.4
> 
