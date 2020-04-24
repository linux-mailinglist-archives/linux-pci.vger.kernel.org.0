Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4781B7375
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXLyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 07:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXLyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 07:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602ABC14;
        Fri, 24 Apr 2020 04:54:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0EE3F6CF;
        Fri, 24 Apr 2020 04:54:02 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:54:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Message-ID: <20200424115400.GB7197@e121166-lin.cambridge.arm.com>
References: <20200314191232.3122290-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314191232.3122290-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 08:12:32PM +0100, marek.vasut@gmail.com wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> This adds the suspend/resume supports for pcie-rcar. The resume handler
> reprograms the hardware based on the software state kept in specific
> device structures. Also it doesn't need to save any registers.
> 
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Change return type of rcar_pcie_hw_enable() to void
>     - Drop default: case in switch statement in rcar_pcie_hw_enable()
>     - Sort variables in rcar_pcie_resume()
> V3: - Update on top of next-20200313
> ---
>  drivers/pci/controller/pcie-rcar.c | 86 +++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 759c6542c5c8..f86513638b8a 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c


Applied to pci/rcar for v5.18, thanks.

Lorenzo

> @@ -452,6 +452,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
>  		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
>  }
>  
> +static void rcar_pcie_hw_enable(struct rcar_pcie *pci)
> +{
> +	struct resource_entry *win;
> +	LIST_HEAD(res);
> +	int i = 0;
> +
> +	/* Try setting 5 GT/s link speed */
> +	rcar_pcie_force_speedup(pci);
> +
> +	/* Setup PCI resources */
> +	resource_list_for_each_entry(win, &pci->resources) {
> +		struct resource *res = win->res;
> +
> +		if (!res->flags)
> +			continue;
> +
> +		switch (resource_type(res)) {
> +		case IORESOURCE_IO:
> +		case IORESOURCE_MEM:
> +			rcar_pcie_setup_window(i, pci, win);
> +			i++;
> +			break;
> +		}
> +	}
> +}
> +
>  static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> @@ -891,11 +917,25 @@ static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
>  	irq_domain_remove(msi->domain);
>  }
>  
> +static void rcar_pcie_hw_enable_msi(struct rcar_pcie *pcie)
> +{
> +	struct rcar_msi *msi = &pcie->msi;
> +	unsigned long base;
> +
> +	/* setup MSI data target */
> +	base = virt_to_phys((void *)msi->pages);
> +
> +	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
> +	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
> +
> +	/* enable all MSI interrupts */
> +	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> +}
> +
>  static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct rcar_msi *msi = &pcie->msi;
> -	phys_addr_t base;
>  	int err, i;
>  
>  	mutex_init(&msi->lock);
> @@ -934,17 +974,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  
>  	/* setup MSI data target */
>  	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> -	if (!msi->pages) {
> -		err = -ENOMEM;
> -		goto err;
> -	}
> -	base = virt_to_phys((void *)msi->pages);
> -
> -	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
> -	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
> -
> -	/* enable all MSI interrupts */
> -	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> +	rcar_pcie_hw_enable_msi(pcie);
>  
>  	return 0;
>  
> @@ -1219,6 +1249,37 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static int rcar_pcie_resume(struct device *dev)
> +{
> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> +	int (*hw_init_fn)(struct rcar_pcie *);
> +	unsigned int data;
> +	int err;
> +
> +	err = rcar_pcie_parse_map_dma_ranges(pcie);
> +	if (err)
> +		return 0;
> +
> +	/* Failure to get a link might just be that no cards are inserted */
> +	hw_init_fn = of_device_get_match_data(dev);
> +	err = hw_init_fn(pcie);
> +	if (err) {
> +		dev_info(dev, "PCIe link down\n");
> +		return 0;
> +	}
> +
> +	data = rcar_pci_read_reg(pcie, MACSR);
> +	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
> +
> +	/* Enable MSI */
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		rcar_pcie_hw_enable_msi(pcie);
> +
> +	rcar_pcie_hw_enable(pcie);
> +
> +	return 0;
> +}
> +
>  static int rcar_pcie_resume_noirq(struct device *dev)
>  {
>  	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> @@ -1234,6 +1295,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops rcar_pcie_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
>  	.resume_noirq = rcar_pcie_resume_noirq,
>  };
>  
> -- 
> 2.25.0
> 
