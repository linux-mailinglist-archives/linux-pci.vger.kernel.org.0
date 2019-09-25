Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B184BDD32
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404689AbfIYLea (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 07:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:47304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732353AbfIYLea (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 07:34:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C871597;
        Wed, 25 Sep 2019 04:34:30 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752F83F694;
        Wed, 25 Sep 2019 04:34:29 -0700 (PDT)
Date:   Wed, 25 Sep 2019 12:34:27 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] PCI: mediatek: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190925113427.GT9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924214630.12817-4-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 04:46:22PM -0500, Rob Herring wrote:
> Convert Mediatek host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 47 ++++++++++----------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 80601e1b939e..cea4112b5309 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -211,7 +211,6 @@ struct mtk_pcie {
>  	void __iomem *base;
>  	struct clk *free_ck;
>  
> -	struct resource mem;
>  	struct list_head ports;
>  	const struct mtk_pcie_soc *soc;
>  	unsigned int busnr;
> @@ -658,11 +657,23 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  {
>  	struct mtk_pcie *pcie = port->pcie;
> -	struct resource *mem = &pcie->mem;
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct resource *mem = NULL;
> +	struct resource_entry *entry;
>  	const struct mtk_pcie_soc *soc = port->pcie->soc;
>  	u32 val;
>  	int err;
>  
> +	resource_list_for_each_entry(entry, &host->windows) {
> +		if (resource_type(entry->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		mem = entry->res;
> +		break;
> +	}
> +	if (!mem)
> +		return -EINVAL;
> +
>  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
>  	if (pcie->base) {
>  		val = readl(pcie->base + PCIE_SYS_CFG_V2);
> @@ -1017,39 +1028,15 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  	struct mtk_pcie_port *port, *tmp;
>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>  	struct list_head *windows = &host->windows;
> -	struct resource_entry *win, *tmp_win;
> -	resource_size_t io_base;
> +	struct resource *bus;
>  	int err;
>  
> -	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    windows, &io_base);
> +	err = pci_parse_request_of_pci_ranges(dev, windows,
> +					      &bus);
>  	if (err)
>  		return err;
>  
> -	err = devm_request_pci_bus_resources(dev, windows);
> -	if (err < 0)
> -		return err;
> -
> -	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry_safe(win, tmp_win, windows) {
> -		switch (resource_type(win->res)) {
> -		case IORESOURCE_IO:
> -			err = devm_pci_remap_iospace(dev, win->res, io_base);
> -			if (err) {
> -				dev_warn(dev, "error %d: failed to map resource %pR\n",
> -					 err, win->res);
> -				resource_list_destroy_entry(win);
> -			}
> -			break;
> -		case IORESOURCE_MEM:
> -			memcpy(&pcie->mem, win->res, sizeof(*win->res));
> -			pcie->mem.name = "non-prefetchable";

Using pci_parse_request_of_pci_ranges will now guard against using only
prefetchable memory ranges, whereas the existing code didn't do that. Given
that the current DT users all provide a non-prefetchable range I think this is
OK.

Reviewed-by: Andrew murray <andrew.murray@arm.com>

> -			break;
> -		case IORESOURCE_BUS:
> -			pcie->busnr = win->res->start;
> -			break;
> -		}
> -	}
> +	pcie->busnr = bus->start;
>  
>  	for_each_available_child_of_node(node, child) {
>  		int slot;
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
