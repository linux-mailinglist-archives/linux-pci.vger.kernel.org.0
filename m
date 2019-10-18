Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADBDC8F4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404352AbfJRPmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 11:42:09 -0400
Received: from [217.140.110.172] ([217.140.110.172]:43008 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfJRPmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B7FC8F;
        Fri, 18 Oct 2019 08:41:43 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5643F718;
        Fri, 18 Oct 2019 08:41:42 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:41:41 +0100
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
Subject: Re: [PATCH v2 09/25] PCI: mobiveil: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20191018154141.GJ47056@e119886-lin.cambridge.arm.com>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-10-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:31PM -0500, Rob Herring wrote:
> Convert the Mobiveil host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> There's no need to assign the resources to a temporary list first. Just
> use bridge->windows directly and remove all the temporary list handling.
> 
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> v2:
> - New patch
> 
>  drivers/pci/controller/pcie-mobiveil.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a45a6447b01d..4eab8624ce4d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -140,7 +140,6 @@ struct mobiveil_msi {			/* MSI information */
> 
>  struct mobiveil_pcie {
>  	struct platform_device *pdev;
> -	struct list_head resources;
>  	void __iomem *config_axi_slave_base;	/* endpoint config base */
>  	void __iomem *csr_axi_slave_base;	/* root port config base */
>  	void __iomem *apb_csr_base;	/* MSI register base */
> @@ -575,6 +574,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
> 
>  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> 
> @@ -631,7 +631,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> 
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry(win, &pcie->resources) {
> +	resource_list_for_each_entry(win, &bridge->windows) {
>  		if (resource_type(win->res) == IORESOURCE_MEM)
>  			type = MEM_WINDOW_TYPE;
>  		else if (resource_type(win->res) == IORESOURCE_IO)
> @@ -857,7 +857,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct device *dev = &pdev->dev;
> -	resource_size_t iobase;
>  	int ret;
> 
>  	/* allocate the PCIe port */
> @@ -875,11 +874,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> 
> -	INIT_LIST_HEAD(&pcie->resources);
> -
>  	/* parse the host bridge base addresses from the device tree file */
> -	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &pcie->resources, &iobase);
> +	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return ret;
> @@ -892,24 +888,19 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	ret = mobiveil_host_init(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize host\n");
> -		goto error;
> +		return ret;
>  	}
> 
>  	/* initialize the IRQ domains */
>  	ret = mobiveil_pcie_init_irq_domain(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed creating IRQ Domain\n");
> -		goto error;
> +		return ret;
>  	}
> 
>  	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> 
> -	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
> -	if (ret)
> -		goto error;
> -
>  	/* Initialize bridge */
> -	list_splice_init(&pcie->resources, &bridge->windows);
>  	bridge->dev.parent = dev;
>  	bridge->sysdata = pcie;
>  	bridge->busnr = pcie->root_bus_nr;
> @@ -920,13 +911,13 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	ret = mobiveil_bringup_link(pcie);
>  	if (ret) {
>  		dev_info(dev, "link bring-up failed\n");
> -		goto error;
> +		return ret;
>  	}
> 
>  	/* setup the kernel resources for the newly added PCIe root bus */
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret)
> -		goto error;
> +		return ret;
> 
>  	bus = bridge->bus;
> 
> @@ -936,9 +927,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	pci_bus_add_devices(bus);
> 
>  	return 0;
> -error:
> -	pci_free_resource_list(&pcie->resources);
> -	return ret;
>  }
> 
>  static const struct of_device_id mobiveil_pcie_of_match[] = {
> --
> 2.20.1
