Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4345E32E7C5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEMTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 07:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCEMTg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 07:19:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D733064F23;
        Fri,  5 Mar 2021 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614946776;
        bh=GBl51kueNYD0/cSM2pjdnOh+zc+HvLIDgj3UGRTVzyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ih2PqElWDEWswVfujhjf/JWrSgkIcOglXY+6CPjZfgHD73y6n98zeoAup6L1vi4SU
         NJ6qkuaONdPcqbxRY8xOd3iubIBNlyMUY3jRDBa1klFTeOxX6m25AE5vSIwOKWbLxN
         Ww9kgVqqLN98XkxxiUOsjiFjQP0itFUAq10CdID6fu/i58h2Bp20918aVoBNfAP2Y7
         mhwNgkt+sPMA/ObYIfC0K9u9v8y1rQ4RbWwZl4YvCIr6En+693E2jmh185B/afMiXS
         Vleac7IzFnV/BsyissTpTFVEWsteWRQOhRvRuo3HF0j9HGFQdRGl80+CYdPcCm5M5M
         3FCNDi2WIuYiA==
Date:   Fri, 5 Mar 2021 06:19:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com, kishon@ti.com,
        thierry.reding@gmail.com, Jisheng.Zhang@synaptics.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, oop.singh@gmail.com
Subject: Re: [PATCH] PCI: tegra: Disable PTM capabilities for EP mode
Message-ID: <20210305121934.GA1067436@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614931954-11741-1-git-send-email-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 05, 2021 at 01:42:34PM +0530, Om Prakash Singh wrote:
> PCIe EP compliance expect PTM capabilities (ROOT_CAPABLE, RES_CAPABLE,
> CLK_GRAN) to be disabled.

I guess this is just enforcing the PCIe spec requirements that only
Root Ports, RCRBs, and Switches are allowed to set the PTM Responder
Capable bit, and that the Local Clock Granularity is RsvdP if PTM Root
Capable is zero?  (PCIe r5.0, sec 7.9.16.2)

Should this be done more generally somewhere in the dwc code as
opposed to in the tegra code?

> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 17 ++++++++++++++++-
>  include/uapi/linux/pci_regs.h              |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6fa216e..a588312 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1639,7 +1639,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	struct dw_pcie *pci = &pcie->pci;
>  	struct dw_pcie_ep *ep = &pci->ep;
>  	struct device *dev = pcie->dev;
> -	u32 val;
> +	u32 val, ptm_cap_base = 0;

Unnecessary init.

>  	int ret;
>  
>  	if (pcie->ep_state == EP_STATE_ENABLED)
> @@ -1760,6 +1760,21 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  						      PCI_CAP_ID_EXP);
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>  
> +	/* Disable PTM root and responder capability */
> +	ptm_cap_base = dw_pcie_find_ext_capability(&pcie->pci,
> +						   PCI_EXT_CAP_ID_PTM);
> +	if (ptm_cap_base) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		val &= ~PCI_PTM_CAP_ROOT;
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
> +
> +		val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		val &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +
>  	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>  	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
>  	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8..9dd6f8d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1050,6 +1050,7 @@
>  /* Precision Time Measurement */
>  #define PCI_PTM_CAP			0x04	    /* PTM Capability */
>  #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
> +#define  PCI_PTM_CAP_RES		0x00000002  /* Responder capable */
>  #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
>  #define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
>  #define PCI_PTM_CTRL			0x08	    /* PTM Control */
> -- 
> 2.7.4
> 
