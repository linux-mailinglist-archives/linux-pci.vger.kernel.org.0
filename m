Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2429A138F2A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgAMKeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 05:34:36 -0500
Received: from foss.arm.com ([217.140.110.172]:37386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgAMKeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 05:34:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802DD13D5;
        Mon, 13 Jan 2020 02:34:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926413F534;
        Mon, 13 Jan 2020 02:34:34 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:34:32 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 03/12] PCI: mobiveil: Collect the interrupt related
 operations into a routine
Message-ID: <20200113103431.GI42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-4-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:45:37AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Collect the interrupt initialization related operations into
> a new routine to make it more readable.

I prefer the word 'function' instead of routine. Also indicate why, not only
is it nicer but it is in preparation for EP support.

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V9:
>  - New patch splited from the #1 of V8 patches to make it easy to review.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 65 +++++++++++++++++---------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 97f682ca7c7a..512b27a0536e 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -454,12 +454,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  		return PTR_ERR(pcie->csr_axi_slave_base);
>  	pcie->pcie_reg_base = res->start;
>  
> -	/* map MSI config resource */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> -	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pcie->apb_csr_base))
> -		return PTR_ERR(pcie->apb_csr_base);
> -
>  	/* read the number of windows requested */
>  	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
>  		pcie->apio_wins = MAX_PIO_WINDOWS;
> @@ -467,12 +461,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
>  		pcie->ppio_wins = MAX_PIO_WINDOWS;
>  
> -	rp->irq = platform_get_irq(pdev, 0);
> -	if (rp->irq <= 0) {
> -		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
> -		return -ENODEV;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -618,9 +606,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
>  	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
>  
> -	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> -			    PAB_INTP_AMBA_MISC_ENB);
> -
>  	/*
>  	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
>  	 * PAB_AXI_PIO_CTRL Register
> @@ -670,9 +655,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	value |= (PCI_CLASS_BRIDGE_PCI << 16);
>  	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
>  
> -	/* setup MSI hardware registers */
> -	mobiveil_pcie_enable_msi(pcie);
> -
>  	return 0;
>  }
>  
> @@ -873,6 +855,46 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> +static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
> +{
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct root_port *rp = &pcie->rp;
> +	struct resource *res;
> +	int ret;
> +
> +	/* map MSI config resource */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> +	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(pcie->apb_csr_base))
> +		return PTR_ERR(pcie->apb_csr_base);
> +
> +	/* setup MSI hardware registers */
> +	mobiveil_pcie_enable_msi(pcie);

Does this need to come after mobiveil_pcie_init_irq_domain - given that
this function sets up the irq domain for MSI?

Thanks,

Andrew Murray

> +
> +	rp->irq = platform_get_irq(pdev, 0);
> +	if (rp->irq <= 0) {
> +		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
> +		return -ENODEV;
> +	}
> +
> +	/* initialize the IRQ domains */
> +	ret = mobiveil_pcie_init_irq_domain(pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed creating IRQ Domain\n");
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
> +
> +	/* Enable interrupts */
> +	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> +			    PAB_INTP_AMBA_MISC_ENB);
> +
> +
> +	return 0;
> +}
> +
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
>  	struct root_port *rp = &pcie->rp;
> @@ -906,15 +928,12 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  		return ret;
>  	}
>  
> -	/* initialize the IRQ domains */
> -	ret = mobiveil_pcie_init_irq_domain(pcie);
> +	ret = mobiveil_pcie_interrupt_init(pcie);
>  	if (ret) {
> -		dev_err(dev, "Failed creating IRQ Domain\n");
> +		dev_err(dev, "Interrupt init failed\n");
>  		return ret;
>  	}
>  
> -	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
> -
>  	/* Initialize bridge */
>  	bridge->dev.parent = dev;
>  	bridge->sysdata = pcie;
> -- 
> 2.17.1
> 
