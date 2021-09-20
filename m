Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38A411857
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhITPhi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 11:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhITPhi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D12CE61107;
        Mon, 20 Sep 2021 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632152171;
        bh=7gpCDVHbFlDhjKgjg3VRtjQhJQtAQVDqmvOL7mQ8P+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OhzaTpqbchrKuWCie9W6GaHsOtfTyp5nAEO5riLV7MA2p47H38ighQ7VSvI/wFHrZ
         p81HpKfF5wuOR6h8G4pBiDP0h3+7/1lfx3ixbiF+SbvOAMWgeEcUeDLWyhsJ7Y9DJa
         mzXYBgy/4W45M3CR4txz2ZZx27ugHkwj31WvLf6K91A5gmZ7Cx8VLm0yOkV5H3+0XO
         PyJcSxSwVxo+CpzSqMl/FSPoKQpdHRSCcyGoMduIN2n+d1b2KjUjry5ZsR00rP0TX0
         0S1bTN8N1Zx09q0xb6uOnGWEtSxs1qPVAZXHpr+vgxtM1I1sExgoI7bpyzmwTJhS+7
         e7RF/SRIQi8Yw==
Date:   Mon, 20 Sep 2021 10:36:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     bjorn.helgaas@gmail.com, toan@os.amperecomputing.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Adjust struct name to convention
Message-ID: <20210920153609.GA11746@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915004432.19788-1-ffclaire1224@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please just send these to me first, without including all the mailing
lists.  Then we can work out the initial quirks without bothering
everybody else.

Make the subject more specific, e.g.,

  PCI: xgene: Rename struct xgene_pcie_port to xgene_pcie

On Wed, Sep 15, 2021 at 02:44:32AM +0200, Fan Fei wrote:
> struct pci-xgene does not match the convention struct of other pci driver,
> namely <dirver>_pcie. Adjust xgene_pcie_port to xgene_pcie.

s/dirver/driver/
s/pci/PCI/ (capitalize acronyms/initialisms in English text)

Looks reasonable to me.  Please check across the entire
drivers/pci/controller/ directory for any other similar things.

Looks like struct intel_pcie_port, struct tegra_pcie_dw, 
struct uniphier_pcie_priv, etc might be candidates.

Keep these as separate patches for now.  After we have a meaningful
set of tweaks like this, we can talk about how to package them so we
don't overwhelm reviewers with onesy-twosy stuff.

> Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
> ---
>  drivers/pci/controller/pci-xgene.c | 46 +++++++++++++++---------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index e64536047b65..e2b93ccab901 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -61,7 +61,7 @@
>  #define XGENE_PCIE_IP_VER_2		2
>  
>  #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
> -struct xgene_pcie_port {
> +struct xgene_pcie {
>  	struct device_node	*node;
>  	struct device		*dev;
>  	struct clk		*clk;
> @@ -72,12 +72,12 @@ struct xgene_pcie_port {
>  	u32			version;
>  };
>  
> -static u32 xgene_pcie_readl(struct xgene_pcie_port *port, u32 reg)
> +static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
>  {
>  	return readl(port->csr_base + reg);
>  }
>  
> -static void xgene_pcie_writel(struct xgene_pcie_port *port, u32 reg, u32 val)
> +static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
>  {
>  	writel(val, port->csr_base + reg);
>  }
> @@ -87,15 +87,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
>  	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
>  }
>  
> -static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
> +static inline struct xgene_pcie *pcie_bus_to_port(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
>  
>  	if (acpi_disabled)
> -		return (struct xgene_pcie_port *)(bus->sysdata);
> +		return (struct xgene_pcie *)(bus->sysdata);
>  
>  	cfg = bus->sysdata;
> -	return (struct xgene_pcie_port *)(cfg->priv);
> +	return (struct xgene_pcie *)(cfg->priv);
>  }
>  
>  /*
> @@ -104,7 +104,7 @@ static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
>   */
>  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>  {
> -	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
> +	struct xgene_pcie *port = pcie_bus_to_port(bus);
>  
>  	if (bus->number >= (bus->primary + 1))
>  		return port->cfg_base + AXI_EP_CFG_ACCESS;
> @@ -118,7 +118,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>   */
>  static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
>  {
> -	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
> +	struct xgene_pcie *port = pcie_bus_to_port(bus);
>  	unsigned int b, d, f;
>  	u32 rtdid_val = 0;
>  
> @@ -165,7 +165,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  				    int where, int size, u32 *val)
>  {
> -	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
> +	struct xgene_pcie *port = pcie_bus_to_port(bus);
>  
>  	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
>  	    PCIBIOS_SUCCESSFUL)
> @@ -228,7 +228,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
>  {
>  	struct device *dev = cfg->parent;
>  	struct acpi_device *adev = to_acpi_device(dev);
> -	struct xgene_pcie_port *port;
> +	struct xgene_pcie *port;
>  	struct resource csr;
>  	int ret;
>  
> @@ -282,7 +282,7 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
>  #endif
>  
>  #if defined(CONFIG_PCI_XGENE)
> -static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
> +static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
>  				  u32 flags, u64 size)
>  {
>  	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
> @@ -308,7 +308,7 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
>  	return mask;
>  }
>  
> -static void xgene_pcie_linkup(struct xgene_pcie_port *port,
> +static void xgene_pcie_linkup(struct xgene_pcie *port,
>  			      u32 *lanes, u32 *speed)
>  {
>  	u32 val32;
> @@ -323,7 +323,7 @@ static void xgene_pcie_linkup(struct xgene_pcie_port *port,
>  	}
>  }
>  
> -static int xgene_pcie_init_port(struct xgene_pcie_port *port)
> +static int xgene_pcie_init_port(struct xgene_pcie *port)
>  {
>  	struct device *dev = port->dev;
>  	int rc;
> @@ -343,7 +343,7 @@ static int xgene_pcie_init_port(struct xgene_pcie_port *port)
>  	return 0;
>  }
>  
> -static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
> +static int xgene_pcie_map_reg(struct xgene_pcie *port,
>  			      struct platform_device *pdev)
>  {
>  	struct device *dev = port->dev;
> @@ -363,7 +363,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
>  	return 0;
>  }
>  
> -static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
> +static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
>  				    struct resource *res, u32 offset,
>  				    u64 cpu_addr, u64 pci_addr)
>  {
> @@ -395,7 +395,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
>  	xgene_pcie_writel(port, offset + 0x14, upper_32_bits(pci_addr));
>  }
>  
> -static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
> +static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *port)
>  {
>  	u64 addr = port->cfg_addr;
>  
> @@ -404,7 +404,7 @@ static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
>  	xgene_pcie_writel(port, CFGCTL, EN_REG);
>  }
>  
> -static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
> +static int xgene_pcie_map_ranges(struct xgene_pcie *port)
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
>  	struct resource_entry *window;
> @@ -445,7 +445,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
>  	return 0;
>  }
>  
> -static void xgene_pcie_setup_pims(struct xgene_pcie_port *port, u32 pim_reg,
> +static void xgene_pcie_setup_pims(struct xgene_pcie *port, u32 pim_reg,
>  				  u64 pim, u64 size)
>  {
>  	xgene_pcie_writel(port, pim_reg, lower_32_bits(pim));
> @@ -479,7 +479,7 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
>  	return -EINVAL;
>  }
>  
> -static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
> +static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
>  				    struct resource_entry *entry,
>  				    u8 *ib_reg_mask)
>  {
> @@ -530,7 +530,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
>  	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
>  }
>  
> -static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
> +static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
>  	struct resource_entry *entry;
> @@ -543,7 +543,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
>  }
>  
>  /* clear BAR configuration which was done by firmware */
> -static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
> +static void xgene_pcie_clear_config(struct xgene_pcie *port)
>  {
>  	int i;
>  
> @@ -551,7 +551,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
>  		xgene_pcie_writel(port, i, 0);
>  }
>  
> -static int xgene_pcie_setup(struct xgene_pcie_port *port)
> +static int xgene_pcie_setup(struct xgene_pcie *port)
>  {
>  	struct device *dev = port->dev;
>  	u32 val, lanes = 0, speed = 0;
> @@ -589,7 +589,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *dn = dev->of_node;
> -	struct xgene_pcie_port *port;
> +	struct xgene_pcie *port;
>  	struct pci_host_bridge *bridge;
>  	int ret;
>  
> -- 
> 2.25.1
> 
