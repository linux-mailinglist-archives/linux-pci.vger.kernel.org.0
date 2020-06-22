Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E98203DCF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgFVRZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 13:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgFVRZT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 13:25:19 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC9F20716;
        Mon, 22 Jun 2020 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592846718;
        bh=fLnGnL/0MZjsGeC/GIzW5ACgDNJhz8FB/FigdZ5+rDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=juMs6HYH5pvnInbpjgn4gv8X74J+u0rqmUyTcTJRtfEansyp46vokTLf5ch0uUCTz
         ojqvhfDofPovMW8SsaVBLftTQrVi8VFAY5L8+9KNE1UQGxalVMW02sHnOQwFpo+7RI
         aaaXlGPF9v3VpGysu/W3Rh+bBYPTbXzkGGTMLYfo=
Date:   Mon, 22 Jun 2020 12:25:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shmuel Hazan <sh@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: setup BAR0 to internal-regs
Message-ID: <20200622172516.GA2290205@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621053032.5262-1-sh@tkos.co.il>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please capitalize the first letter of your subject ("Setup" in this
case).

It would also be good if the subject included a clue about the reason
for the patch, i.e., apparently this fixes MSIs?

On Sun, Jun 21, 2020 at 08:30:33AM +0300, Shmuel Hazan wrote:
> According to the Armada XP datasheet, section 10.2.6: "in order for
> the device to do a write to the MSI doorbell address, it needs to write
> to a register in the internal registers space".
> 
> As a result of the requirement above, without this patch, MSI won't
> function and therefore some devices won't operate properly without
> pci=nomsi.

Does that mean MSIs never worked at all with mvebu?

Were they broken only for certain Armada controllers?  The patch
doesn't look specific to a particular controller, so, I assume MSIs
just never worked anywhere?  Or did they once work, but got broken and
this fixes the regression?

> Tested on an Armada 385 board with the following PCIe devices:
> 	- Wilocity Wil6200 rev 2 (wil6210)
> 	- Qualcomm Atheros QCA6174 (ath10k_pci)
> 
> Both failed to get a response from the device after loading the
> firmware and seem to operate properly with this patch.
> 
> Signed-off-by: Shmuel Hazan <sh@tkos.co.il>
> ---
> 
> Fixed a few commit message related issues mentioned by Bjorn Helgaas
> <helgaas@kernel.org>. 
>  
> ---
>  drivers/pci/controller/pci-mvebu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 153a64676bc9..101c06602aa1 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -105,6 +105,7 @@ struct mvebu_pcie_port {
>  	struct mvebu_pcie_window memwin;
>  	struct mvebu_pcie_window iowin;
>  	u32 saved_pcie_stat;
> +	struct resource regs;
>  };
>  
>  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> @@ -149,7 +150,9 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
>  
>  /*
>   * Setup PCIE BARs and Address Decode Wins:
> - * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
> + * BAR[0] -> internal registers (needed for MSI)
> + * BAR[1] -> covers all DRAM banks
> + * BAR[2] -> Disabled
>   * WIN[0-3] -> DRAM bank[0-3]
>   */
>  static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> @@ -203,6 +206,12 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
>  	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
>  		     PCIE_BAR_CTRL_OFF(1));
> +
> +	/*
> +	 * Point BAR[0] to the device's internal registers.
> +	 */
> +	mvebu_writel(port, round_down(port->regs.start, SZ_1M), PCIE_BAR_LO_OFF(0));
> +	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
>  }
>  
>  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> @@ -708,14 +717,13 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
>  					      struct device_node *np,
>  					      struct mvebu_pcie_port *port)
>  {
> -	struct resource regs;
>  	int ret = 0;
>  
> -	ret = of_address_to_resource(np, 0, &regs);
> +	ret = of_address_to_resource(np, 0, &port->regs);
>  	if (ret)
>  		return (void __iomem *)ERR_PTR(ret);
>  
> -	return devm_ioremap_resource(&pdev->dev, &regs);
> +	return devm_ioremap_resource(&pdev->dev, &port->regs);
>  }
>  
>  #define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> -- 
> 2.27.0
> 
