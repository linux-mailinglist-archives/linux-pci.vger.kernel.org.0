Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B88294B15
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438552AbgJUKJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 06:09:00 -0400
Received: from foss.arm.com ([217.140.110.172]:32974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405124AbgJUKI7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 06:08:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 984181FB;
        Wed, 21 Oct 2020 03:08:58 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3023F66E;
        Wed, 21 Oct 2020 03:08:56 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:08:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     bhelgaas@google.com, amurray@thegoodpenguin.co.uk, robh@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: dwc: Add support to handle prefetchable memory
 mapping
Message-ID: <20201021100850.GA7893@e121166-lin.cambridge.arm.com>
References: <20201005121351.32516-1-vidyas@nvidia.com>
 <20201020195931.12470-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020195931.12470-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jingoo, Gustavo,

please review this patch, thanks.

Lorenzo

On Wed, Oct 21, 2020 at 01:29:31AM +0530, Vidya Sagar wrote:
> DWC sub-system currently doesn't differentiate between prefetchable and
> non-prefetchable memory aperture entries in the 'ranges' property and
> provides ATU mapping only for the first memory aperture entry out of all
> the entries present. This was introduced by the
> commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources").
> Mapping for a memory apreture is required if its CPU address and the bus
> address are different and the current mechanism works only if the memory
> aperture which needs mapping happens to be the first entry. It doesn't
> work either if the memory aperture that needs mapping is not the first
> entry or if both prefetchable and non-prefetchable apertures need mapping.
> 
> This patch fixes this issue by differentiating between prefetchable and
> non-prefetchable apertures in the 'ranges' property there by removing the
> dependency on the order in which they are specified and adds support for
> mapping prefetchable aperture using ATU region-3 if required.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Rewrote commit subject and description
> * Addressed review comments from Lorenzo
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>  3 files changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index db547ee6ff3a..dae6da39bb90 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -521,9 +521,42 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> +				  struct resource_entry *win)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/* Check for prefetchable memory aperture */
> +	if (win->res->flags & IORESOURCE_PREFETCH && win->offset) {
> +		/* Number of view ports must at least be 4 to enable mapping */
> +		if (pci->num_viewport < 4) {
> +			dev_warn(pci->dev,
> +				 "Insufficient ATU regions to map Prefetchable memory\n");
> +		} else {
> +			dw_pcie_prog_outbound_atu(pci,
> +						  PCIE_ATU_REGION_INDEX3,
> +						  PCIE_ATU_TYPE_MEM,
> +						  win->res->start,
> +						  win->res->start - win->offset,
> +						  resource_size(win->res));
> +		}
> +	} else if (win->offset) { /* Non-prefetchable memory aperture */
> +		if (upper_32_bits(resource_size(win->res)))
> +			dev_warn(pci->dev,
> +				 "Memory resource size exceeds max for 32 bits\n");
> +		dw_pcie_prog_outbound_atu(pci,
> +					  PCIE_ATU_REGION_INDEX0,
> +					  PCIE_ATU_TYPE_MEM,
> +					  win->res->start,
> +					  win->res->start - win->offset,
> +					  resource_size(win->res));
> +	}
> +}
> +
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val, ctrl, num_ctrls;
> +	struct resource_entry *win;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
>  	/*
> @@ -578,13 +611,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		struct resource_entry *entry =
> -			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +		resource_list_for_each_entry(win, &pp->bridge->windows)
> +			if (resource_type(win->res) == IORESOURCE_MEM)
> +				dw_pcie_setup_mem_atu(pp, win);
>  
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> -					  PCIE_ATU_TYPE_MEM, entry->res->start,
> -					  entry->res->start - entry->offset,
> -					  resource_size(entry->res));
>  		if (pci->num_viewport > 2)
>  			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
>  						  PCIE_ATU_TYPE_IO, pp->io_base,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c2dea8fc97c8..b5e438b70cd5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  					     int index, int type,
>  					     u64 cpu_addr, u64 pci_addr,
> -					     u32 size)
> +					     u64 size)
>  {
>  	u32 retries, val;
>  	u64 limit_addr = cpu_addr + size - 1;
> @@ -245,8 +245,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -				 type | PCIE_ATU_FUNC_NUM(func_no));
> +	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	val = upper_32_bits(size - 1) ?
> +		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>  				 PCIE_ATU_ENABLE);
>  
> @@ -267,7 +269,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  
>  static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  					int index, int type, u64 cpu_addr,
> -					u64 pci_addr, u32 size)
> +					u64 pci_addr, u64 size)
>  {
>  	u32 retries, val;
>  
> @@ -311,7 +313,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  }
>  
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			       u64 cpu_addr, u64 pci_addr, u32 size)
> +			       u64 cpu_addr, u64 pci_addr, u64 size)
>  {
>  	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
>  				    cpu_addr, pci_addr, size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9d2f511f13fa..21dd06831b50 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -80,10 +80,12 @@
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> +#define PCIE_ATU_REGION_INDEX3		0x3
>  #define PCIE_ATU_REGION_INDEX2		0x2
>  #define PCIE_ATU_REGION_INDEX1		0x1
>  #define PCIE_ATU_REGION_INDEX0		0x0
>  #define PCIE_ATU_CR1			0x904
> +#define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
>  #define PCIE_ATU_TYPE_MEM		0x0
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
> @@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       int type, u64 cpu_addr, u64 pci_addr,
> -			       u32 size);
> +			       u64 size);
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
>  				  u32 size);
> -- 
> 2.17.1
> 
