Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3C584FF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF0O6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 10:58:06 -0400
Received: from foss.arm.com ([217.140.110.172]:56108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfF0O6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 10:58:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B367360;
        Thu, 27 Jun 2019 07:58:05 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6A5D3F246;
        Thu, 27 Jun 2019 07:58:02 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:58:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V11 03/12] PCI: dwc: Perform dbi regs write lock towards
 the end
Message-ID: <20190627145800.GD3782@e121166-lin.cambridge.arm.com>
References: <20190624091505.1711-1-vidyas@nvidia.com>
 <20190624091505.1711-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624091505.1711-4-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 02:44:56PM +0530, Vidya Sagar wrote:
> Remove multiple write enable and disable sequences of dbi registers as
> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
> register in config space to take place. Hence enabling write permission at
> the start of function and disabling the same only towards the end.

I do not understand what this patch does, I would like to rephrase
the commit log in a way that is easier to parse.

In particular I do not get what you mean in relation to BAR-0, I am
confused, please clarify.

Lorenzo

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> Changes since [v10]:
> * None
> 
> Changes since [v9]:
> * None
> 
> Changes since [v8]:
> * None
> 
> Changes since [v7]:
> * None
> 
> Changes since [v6]:
> * None
> 
> Changes since [v5]:
> * Moved write enable to the beginning of the API and write disable to the end
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * None
> 
> Changes since [v1]:
> * None
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..d3156446ff27 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> +	/*
> +	 * Enable DBI read-only registers for writing/updating configuration.
> +	 * Write permission gets disabled towards the end of this function.
> +	 */
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
>  	dw_pcie_setup(pci);
>  
>  	if (!pp->ops->msi_host_init) {
> @@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>  
>  	/* Setup interrupt pins */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
>  	val &= 0xffff00ff;
>  	val |= 0x00000100;
>  	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	/* Setup bus numbers */
>  	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> @@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>  
> -	/* Enable write permission for the DBI read-only register */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	/* Program correct class for RC */
>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -	/* Better disable write permission right after the update */
> -	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> -- 
> 2.17.1
> 
