Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861311BB8E1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD1Icg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 04:32:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgD1Icg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 04:32:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30EC830E;
        Tue, 28 Apr 2020 01:32:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301763F305;
        Tue, 28 Apr 2020 01:32:34 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:32:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Message-ID: <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
References: <20200426123148.56051-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426123148.56051-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The PHY initialization function pointer does not change during the
> lifetime of the driver instance, it is therefore sufficient to get
> the pointer in .probe(), cache it in driver private data, and just
> call the function through the cached pointer in .resume().
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>       branch pci/rcar
> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> ---
>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Squashed in https://patchwork.kernel.org/patch/11438665

Do you want me to rename the $SUBJECT (and the branch name while at it)
in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
the commit subject tag renaming from this cycle (and in the interim you
send a rename for the drivers files ?)

Lorenzo

> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 1a0e74cad9bb..59e55f56e386 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -153,6 +153,7 @@ struct rcar_pcie {
>  	int			root_bus_nr;
>  	struct clk		*bus_clk;
>  	struct			rcar_msi msi;
> +	int			(*phy_init_fn)(struct rcar_pcie *pcie);
>  };
>  
>  static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
> @@ -1147,7 +1148,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	struct rcar_pcie *pcie;
>  	u32 data;
>  	int err;
> -	int (*phy_init_fn)(struct rcar_pcie *);
>  	struct pci_host_bridge *bridge;
>  
>  	bridge = pci_alloc_host_bridge(sizeof(*pcie));
> @@ -1187,8 +1187,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_clk_disable;
>  
> -	phy_init_fn = of_device_get_match_data(dev);
> -	err = phy_init_fn(pcie);
> +	pcie->phy_init_fn = of_device_get_match_data(dev);
> +	err = pcie->phy_init_fn(pcie);
>  	if (err) {
>  		dev_err(dev, "failed to init PCIe PHY\n");
>  		goto err_clk_disable;
> @@ -1253,7 +1253,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  static int __maybe_unused rcar_pcie_resume(struct device *dev)
>  {
>  	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> -	int (*hw_init_fn)(struct rcar_pcie *);
>  	unsigned int data;
>  	int err;
>  
> @@ -1262,8 +1261,7 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
>  		return 0;
>  
>  	/* Failure to get a link might just be that no cards are inserted */
> -	hw_init_fn = of_device_get_match_data(dev);
> -	err = hw_init_fn(pcie);
> +	err = pcie->phy_init_fn(pcie);
>  	if (err) {
>  		dev_info(dev, "PCIe link down\n");
>  		return 0;
> -- 
> 2.25.1
> 
