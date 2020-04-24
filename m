Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023101B7F70
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDXT52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgDXT51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:57:27 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CF220781;
        Fri, 24 Apr 2020 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587758246;
        bh=2e+1YrAFgpfUJYO8UuSZsSQ5b3htHAFAlNHQ7491n/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=y5RqUNDbkDBs0BRj+rcpDfQSpGRDB9KLKwgtLnnwP/FZ4qj36n6ZXYZN0g8Y9HDgp
         R5S6XRWvL+VkZmcwUV3pktFiRIVRV0N2ohcew1ztonEbgaRV0RBxnIXmtUZ0E10axP
         W5NT+QcDa0nkmdqK5eyt6h3hYXag7i3MKW7Lnwe8=
Date:   Fri, 24 Apr 2020 14:57:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Message-ID: <20200424195724.GA187563@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200314191232.3122290-1-marek.vasut@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vaibhav]

Alternate less redundant subject:

  PCI: rcar: Add suspend/resume support

On Sat, Mar 14, 2020 at 08:12:32PM +0100, marek.vasut@gmail.com wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> This adds the suspend/resume supports for pcie-rcar. The resume handler
> reprograms the hardware based on the software state kept in specific
> device structures. Also it doesn't need to save any registers.

s/This adds the/Add/
s/supports/support/

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

This causes the following warning when CONFIG_PM_SLEEP is not set:

  drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
   1253 | static int rcar_pcie_resume(struct device *dev)
	|            ^~~~~~~~~~~~~~~~

Most people seem to be using __maybe_unused on the suspend/resume
functions to avoid this, e.g., 226e6b866d74 ("gpio: pch: Convert to
dev_pm_ops").

>  	.resume_noirq = rcar_pcie_resume_noirq,
>  };
>  
> -- 
> 2.25.0
> 
