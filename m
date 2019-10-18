Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091C3DC9CC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406258AbfJRPwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 11:52:17 -0400
Received: from [217.140.110.172] ([217.140.110.172]:43722 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390809AbfJRPwR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 11:52:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED99C8F;
        Fri, 18 Oct 2019 08:51:54 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B437C3F718;
        Fri, 18 Oct 2019 08:51:53 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:51:52 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
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
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 10/25] PCI: rockchip: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20191018155152.GK47056@e119886-lin.cambridge.arm.com>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-11-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:32PM -0500, Rob Herring wrote:
> Convert the Rockchip host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> There's no need to assign the resources to a temporary list first. Just
> use bridge->windows directly and remove all the temporary list handling.
> 
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - New patch
> 
>  drivers/pci/controller/pcie-rockchip-host.c | 36 ++++-----------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ef8e677ce9d1..8d2e6f2e141e 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_bus *bus, *child;
>  	struct pci_host_bridge *bridge;
> +	struct resource *bus_res;
>  	struct resource_entry *win;
> -	resource_size_t io_base;
> -	struct resource	*mem;
> -	struct resource	*io;
>  	int err;
> 
> -	LIST_HEAD(res);
> -
>  	if (!dev->of_node)
>  		return -ENODEV;
> 
> @@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		goto err_deinit_port;
> 
> -	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &res, &io_base);
> +	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, &bus_res);
>  	if (err)
>  		goto err_remove_irq_domain;
> 
> -	err = devm_request_pci_bus_resources(dev, &res);
> -	if (err)
> -		goto err_free_res;
> +	rockchip->root_bus_nr = bus_res->start;
> 
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry(win, &res) {
> +	resource_list_for_each_entry(win, &bridge->windows) {
>  		switch (resource_type(win->res)) {
>  		case IORESOURCE_IO:
>  			io = win->res;
>  			io->name = "I/O";

In some patches of this series we drop the custom naming of memory resources,
yet in others, like this one, we preserve the custom naming.

Should we be consistent in preserving the existing naming?

Thanks,

Andrew Murray

>  			rockchip->io_size = resource_size(io);
>  			rockchip->io_bus_addr = io->start - win->offset;
> -			err = pci_remap_iospace(io, io_base);
> -			if (err) {
> -				dev_warn(dev, "error %d: failed to map resource %pR\n",
> -					 err, io);
> -				continue;
> -			}
>  			rockchip->io = io;
>  			break;
>  		case IORESOURCE_MEM:
> @@ -1026,9 +1013,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  			rockchip->mem_size = resource_size(mem);
>  			rockchip->mem_bus_addr = mem->start - win->offset;
>  			break;
> -		case IORESOURCE_BUS:
> -			rockchip->root_bus_nr = win->res->start;
> -			break;
>  		default:
>  			continue;
>  		}
> @@ -1036,15 +1020,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> 
>  	err = rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
> -		goto err_unmap_iospace;
> +		goto err_remove_irq_domain;
> 
>  	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
>  	if (!rockchip->msg_region) {
>  		err = -ENOMEM;
> -		goto err_unmap_iospace;
> +		goto err_remove_irq_domain;
>  	}
> 
> -	list_splice_init(&res, &bridge->windows);
>  	bridge->dev.parent = dev;
>  	bridge->sysdata = rockchip;
>  	bridge->busnr = 0;
> @@ -1054,7 +1037,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> 
>  	err = pci_scan_root_bus_bridge(bridge);
>  	if (err < 0)
> -		goto err_unmap_iospace;
> +		goto err_remove_irq_domain;
> 
>  	bus = bridge->bus;
> 
> @@ -1068,10 +1051,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	pci_bus_add_devices(bus);
>  	return 0;
> 
> -err_unmap_iospace:
> -	pci_unmap_iospace(rockchip->io);
> -err_free_res:
> -	pci_free_resource_list(&res);
>  err_remove_irq_domain:
>  	irq_domain_remove(rockchip->irq_domain);
>  err_deinit_port:
> @@ -1097,7 +1076,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
> 
>  	pci_stop_root_bus(rockchip->root_bus);
>  	pci_remove_root_bus(rockchip->root_bus);
> -	pci_unmap_iospace(rockchip->io);
>  	irq_domain_remove(rockchip->irq_domain);
> 
>  	rockchip_pcie_deinit_phys(rockchip);
> --
> 2.20.1
