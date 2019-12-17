Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3A122C09
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 13:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfLQMkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 07:40:55 -0500
Received: from foss.arm.com ([217.140.110.172]:35756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfLQMky (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C0C31B;
        Tue, 17 Dec 2019 04:40:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7057C3F718;
        Tue, 17 Dec 2019 04:40:53 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:40:51 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 07/13] PCI: cadence: Add new *ops* for CPU addr fixup
Message-ID: <20191217124050.GD24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-8-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-8-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:41PM +0530, Kishon Vijay Abraham I wrote:
> Cadence driver uses "mem" memory resource to obtain the offset of
> configuration space address region, memory space address region and
> message space address region. The obtained offset is used to program
> the Address Translation Unit (ATU). However certain platforms like TI's
> J721E SoC require the absolute address to be programmed in the ATU and not
> just the offset.
> 
> The same problem was solved in designware driver using a platform specific
> ops for CPU addr fixup in commit a660083eb06c5bb0 ("PCI: dwc: designware:

Thanks for this reference, though this doesn't need to be in the commit
log, please put such comments underneath a ---.

> Add new *ops* for CPU addr fixup"). Follow a similar mechanism in
> Cadence too instead of directly using "mem" memory resource in Cadence
> PCIe core.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-host.c    | 15 ++++-----------
>  drivers/pci/controller/cadence/pcie-cadence.c     |  8 ++++++--
>  drivers/pci/controller/cadence/pcie-cadence.h     |  1 +
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 2efc33b1cade..cf817be237af 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -105,15 +105,14 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
> -	struct resource *mem_res = pcie->mem_res;
>  	struct resource *bus_range = rc->bus_range;
>  	struct resource *cfg_res = rc->cfg_res;
>  	struct device *dev = pcie->dev;
>  	struct device_node *np = dev->of_node;
>  	struct of_pci_range_parser parser;
> +	u64 cpu_addr = cfg_res->start;
>  	struct of_pci_range range;
>  	u32 addr0, addr1, desc1;
> -	u64 cpu_addr;
>  	int r, err;
>  
>  	/*
> @@ -126,7 +125,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>  
> -	cpu_addr = cfg_res->start - mem_res->start;
> +	if (pcie->ops->cpu_addr_fixup)
> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> +

Won't this patch cause a breakage for existing users that won't have defined a
cpu_addr_fixup? The offset isn't being calculated and so cpu_addr will be wrong?

Thanks,

Andrew Murray

>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
>  		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
>  	addr1 = upper_32_bits(cpu_addr);
> @@ -264,14 +265,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	}
>  	rc->cfg_res = res;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
> -	if (!res) {
> -		dev_err(dev, "missing \"mem\"\n");
> -		return -EINVAL;
> -	}
> -
> -	pcie->mem_res = res;
> -
>  	ret = cdns_pcie_start_link(pcie, true);
>  	if (ret) {
>  		dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index de5b3b06f2d0..bd93d0f92f55 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -113,7 +113,9 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>  
>  	/* Set the CPU address */
> -	cpu_addr -= pcie->mem_res->start;
> +	if (pcie->ops->cpu_addr_fixup)
> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> +
>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
>  		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
>  	addr1 = upper_32_bits(cpu_addr);
> @@ -140,7 +142,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
>  	}
>  
>  	/* Set the CPU address */
> -	cpu_addr -= pcie->mem_res->start;
> +	if (pcie->ops->cpu_addr_fixup)
> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> +
>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
>  		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
>  	addr1 = upper_32_bits(cpu_addr);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index c879dd3d2893..ffa8b9f78ff8 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -233,6 +233,7 @@ struct cdns_pcie_ops {
>  	void	(*write)(void __iomem *addr, int size, u32 value);
>  	int	(*start_link)(struct cdns_pcie *pcie, bool start);
>  	bool	(*is_link_up)(struct cdns_pcie *pcie);
> +	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
>  };
>  
>  /**
> -- 
> 2.17.1
> 
