Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD0DC59C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410166AbfJRNAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 09:00:37 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38636 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2410136AbfJRNAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 09:00:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE6A3BB;
        Fri, 18 Oct 2019 06:00:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DEC13F6C4;
        Fri, 18 Oct 2019 06:00:15 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:00:13 +0100
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
Subject: Re: [PATCH v2 07/25] PCI: iproc: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20191018130013.GI47056@e119886-lin.cambridge.arm.com>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-8-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:29PM -0500, Rob Herring wrote:
> Convert the iProc host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> There's no need to assign the resources to a temporary list, so just use
> bridge->windows directly.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - New patch

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
>  drivers/pci/controller/pcie-iproc-platform.c | 8 ++------
>  drivers/pci/controller/pcie-iproc.c          | 5 -----
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index 9ee6200a66f4..375d815f7301 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -43,8 +43,6 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	struct iproc_pcie *pcie;
>  	struct device_node *np = dev->of_node;
>  	struct resource reg;
> -	resource_size_t iobase = 0;
> -	LIST_HEAD(resources);
>  	struct pci_host_bridge *bridge;
>  	int ret;
> 
> @@ -97,8 +95,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->phy))
>  		return PTR_ERR(pcie->phy);
> 
> -	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
> -						    &iobase);
> +	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
>  	if (ret) {
>  		dev_err(dev, "unable to get PCI host bridge resources\n");
>  		return ret;
> @@ -113,10 +110,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		pcie->map_irq = of_irq_parse_and_map_pci;
>  	}
> 
> -	ret = iproc_pcie_setup(pcie, &resources);
> +	ret = iproc_pcie_setup(pcie, &bridge->windows);
>  	if (ret) {
>  		dev_err(dev, "PCIe controller setup failed\n");
> -		pci_free_resource_list(&resources);
>  		return ret;
>  	}
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 2d457bfdaf66..223335ee791a 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1498,10 +1498,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  		return ret;
>  	}
> 
> -	ret = devm_request_pci_bus_resources(dev, res);
> -	if (ret)
> -		return ret;
> -
>  	ret = phy_init(pcie->phy);
>  	if (ret) {
>  		dev_err(dev, "unable to initialize PCIe PHY\n");
> @@ -1543,7 +1539,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  		if (iproc_pcie_msi_enable(pcie))
>  			dev_info(dev, "not using iProc MSI\n");
> 
> -	list_splice_init(res, &host->windows);
>  	host->busnr = 0;
>  	host->dev.parent = dev;
>  	host->ops = &iproc_pcie_ops;
> --
> 2.20.1
