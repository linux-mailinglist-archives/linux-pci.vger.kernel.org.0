Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4458FDC512
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 14:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633900AbfJRMgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 08:36:03 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37814 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2633893AbfJRMgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 08:36:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BDF3BB;
        Fri, 18 Oct 2019 05:35:40 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FE553F6C4;
        Fri, 18 Oct 2019 05:35:39 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:35:38 +0100
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
Subject: Re: [PATCH v2 05/25] PCI: dwc: Use pci_parse_request_of_pci_ranges()
Message-ID: <20191018123537.GG47056@e119886-lin.cambridge.arm.com>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-6-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:27PM -0500, Rob Herring wrote:
> Convert the Designware host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - New patch
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 28 ++++++-------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0f36a926059a..aeec8b65eb97 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -319,7 +319,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource_entry *win, *tmp;
> +	struct resource_entry *win;
>  	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *cfg_res;
> @@ -342,31 +342,19 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (!bridge)
>  		return -ENOMEM;
> 
> -	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -					&bridge->windows, &pp->io_base);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
> +	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
>  	if (ret)
>  		return ret;
> 
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
> +	resource_list_for_each_entry(win, &bridge->windows) {
>  		switch (resource_type(win->res)) {
>  		case IORESOURCE_IO:
> -			ret = devm_pci_remap_iospace(dev, win->res,
> -						     pp->io_base);
> -			if (ret) {
> -				dev_warn(dev, "Error %d: failed to map resource %pR\n",
> -					 ret, win->res);
> -				resource_list_destroy_entry(win);
> -			} else {
> -				pp->io = win->res;
> -				pp->io->name = "I/O";
> -				pp->io_size = resource_size(pp->io);
> -				pp->io_bus_addr = pp->io->start - win->offset;
> -			}
> +			pp->io = win->res;
> +			pp->io->name = "I/O";
> +			pp->io_size = resource_size(pp->io);
> +			pp->io_bus_addr = pp->io->start - win->offset;
> +			pp->io_base = pci_pio_to_address(pp->io->start);

Where did io_base come from? This wasn't here before, so why are we setting it
now?

Does this fix any issue?

Thanks,

Andrew Murray

>  			break;
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;
> --
> 2.20.1
