Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2884A1FBF70
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgFPTwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 15:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgFPTwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 15:52:55 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5CB207C4;
        Tue, 16 Jun 2020 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592337174;
        bh=LVepEDTKFDyu8N3O0cjwt3BP/s5kz3X/8GxyUeyVeuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Egb7yPQDH2MOw0vF57HXW52S6jJqm69KMnaYuFmHcYZkb0E4GRHYoxfOG37IWCRpo
         yZLHdYQRJtpFeUR/sB/qd3owrUBcpyGXaH+x3jbxNW9DfjpRO07vr4iSq+cXCptEMX
         SHQUhpeQhLtP1FPRmz4Gj2lmbKGe+oh0Lq0FGeGM=
Date:   Tue, 16 Jun 2020 14:52:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shmuel Hazan <sh@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
Message-ID: <20200616195252.GA1976810@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611054041.1484001-1-sh@tkos.co.il>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No comment on the patch itself, but "git log --oneline
drivers/pci/controller/pci-mvebu.c" tells you that your subject should
start with:

  PCI: mvebu: Set ...

On Thu, Jun 11, 2020 at 08:40:42AM +0300, Shmuel Hazan wrote:
> According to the Armada XP datasheet, section 10.2.6: "in order for
> the device todo a write to the MSI doorbell address, it needs to write
> to a register in the internal registers" space".

s/todo/to do/
There are three " characters above; they need to come in pairs.  If
they're nested, use ' for one pair.

> As a result of the requirement above, without this patch, MSI won't
> function and therefore some devices won't operate properly without
> pci=nomsi.
> 
> Tested on an Armada 385 board with the following PCIe devices:
> 	- Wilocity Wil6200 rev 2 (wil6210)
> 	- Qualcomm Atheros QCA6174 (ath10k_pci)
> 
> Both failed to get a response from the device after loading the
> firmware and seem to operate properly with this patch.
> 
> Signed-off-by: Shmuel Hazan <sh@tkos.co.il>
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
