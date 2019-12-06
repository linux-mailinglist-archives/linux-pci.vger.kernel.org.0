Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33AE115462
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFPgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 10:36:42 -0500
Received: from foss.arm.com ([217.140.110.172]:48216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfLFPgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 10:36:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB8D031B;
        Fri,  6 Dec 2019 07:36:41 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D843F718;
        Fri,  6 Dec 2019 07:36:38 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:36:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>, eballetbo@gmail.com
Subject: Re: [PATCH v3 11/25] PCI: rockchip: Drop storing driver private
 outbound resource data
Message-ID: <20191206153633.GA18142@e121166-lin.cambridge.arm.com>
References: <20191028163256.8004-1-robh@kernel.org>
 <20191028163256.8004-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163256.8004-12-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Eric]

On Mon, Oct 28, 2019 at 11:32:42AM -0500, Rob Herring wrote:
> The Rockchip host bridge driver doesn't need to store outboard resources
> in its private struct as they are already stored in struct
> pci_host_bridge.
> 
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 54 +++++++++------------
>  drivers/pci/controller/pcie-rockchip.h      |  5 --
>  2 files changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 8d2e6f2e141e..f375e55ea02e 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -806,19 +806,28 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
>  static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rockchip);
> +	struct resource_entry *entry;
> +	u64 pci_addr, size;
>  	int offset;
>  	int err;
>  	int reg_no;
>  
>  	rockchip_pcie_cfg_configuration_accesses(rockchip,
>  						 AXI_WRAPPER_TYPE0_CFG);
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> +	if (!entry)
> +		return -ENODEV;
> +
> +	size = resource_size(entry->res);
> +	pci_addr = entry->res->start - entry->offset;
> +	rockchip->msg_bus_addr = pci_addr;
>  
> -	for (reg_no = 0; reg_no < (rockchip->mem_size >> 20); reg_no++) {
> +	for (reg_no = 0; reg_no < (size >> 20); reg_no++) {
>  		err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
>  						AXI_WRAPPER_MEM_WRITE,
>  						20 - 1,
> -						rockchip->mem_bus_addr +
> -						(reg_no << 20),
> +						pci_addr + (reg_no << 20),
>  						0);
>  		if (err) {
>  			dev_err(dev, "program RC mem outbound ATU failed\n");
> @@ -832,14 +841,20 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> -	offset = rockchip->mem_size >> 20;
> -	for (reg_no = 0; reg_no < (rockchip->io_size >> 20); reg_no++) {
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
> +	if (!entry)
> +		return -ENODEV;
> +
> +	size = resource_size(entry->res);
> +	pci_addr = entry->res->start - entry->offset;
> +
> +	offset = size >> 20;

Just trying to find what triggers:

https://lore.kernel.org/linux-pci/CAFqH_52BiQJzNEzd_0pB3K+JmzVOVikYQo0xfiC0J-DwiXdtqw@mail.gmail.com/T/#u

I think this offset calculation changed the behaviour:

Before:

> -	offset = rockchip->mem_size >> 20;

Now:

> +	offset = size >> 20;

size must be the IORESOURCE_MEM resource size instead we are using the
IORESOURCE_IO size so IIUC the ATU window setup may be compromised.

Lorenzo

> +	for (reg_no = 0; reg_no < (size >> 20); reg_no++) {
>  		err = rockchip_pcie_prog_ob_atu(rockchip,
>  						reg_no + 1 + offset,
>  						AXI_WRAPPER_IO_WRITE,
>  						20 - 1,
> -						rockchip->io_bus_addr +
> -						(reg_no << 20),
> +						pci_addr + (reg_no << 20),
>  						0);
>  		if (err) {
>  			dev_err(dev, "program RC io outbound ATU failed\n");
> @@ -852,8 +867,7 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
>  				  AXI_WRAPPER_NOR_MSG,
>  				  20 - 1, 0, 0);
>  
> -	rockchip->msg_bus_addr = rockchip->mem_bus_addr +
> -					((reg_no + offset) << 20);
> +	rockchip->msg_bus_addr += ((reg_no + offset) << 20);
>  	return err;
>  }
>  
> @@ -951,7 +965,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	struct pci_bus *bus, *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *bus_res;
> -	struct resource_entry *win;
>  	int err;
>  
>  	if (!dev->of_node)
> @@ -997,27 +1010,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	rockchip->root_bus_nr = bus_res->start;
>  
> -	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry(win, &bridge->windows) {
> -		switch (resource_type(win->res)) {
> -		case IORESOURCE_IO:
> -			io = win->res;
> -			io->name = "I/O";
> -			rockchip->io_size = resource_size(io);
> -			rockchip->io_bus_addr = io->start - win->offset;
> -			rockchip->io = io;
> -			break;
> -		case IORESOURCE_MEM:
> -			mem = win->res;
> -			mem->name = "MEM";
> -			rockchip->mem_size = resource_size(mem);
> -			rockchip->mem_bus_addr = mem->start - win->offset;
> -			break;
> -		default:
> -			continue;
> -		}
> -	}
> -
>  	err = rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
>  		goto err_remove_irq_domain;
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 8e87a059ce73..bef42a803b56 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -304,13 +304,8 @@ struct rockchip_pcie {
>  	struct	irq_domain *irq_domain;
>  	int     offset;
>  	struct pci_bus *root_bus;
> -	struct resource *io;
> -	phys_addr_t io_bus_addr;
> -	u32     io_size;
>  	void    __iomem *msg_region;
> -	u32     mem_size;
>  	phys_addr_t msg_bus_addr;
> -	phys_addr_t mem_bus_addr;
>  	bool is_rc;
>  	struct resource *mem_res;
>  };
> -- 
> 2.20.1
> 
