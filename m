Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A54C1D2E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfI3Ibh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 04:31:37 -0400
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfI3Ibh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 04:31:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9228C1000;
        Mon, 30 Sep 2019 01:31:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04DB43F739;
        Mon, 30 Sep 2019 01:31:35 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:31:34 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] PCI: mobiveil: Fix csr_read/write build issue
Message-ID: <20190930083116.GA38576@e119886-lin.cambridge.arm.com>
References: <20190927231504.GA13714@infradead.org>
 <20190929013505.131396-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929013505.131396-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 29, 2019 at 09:35:05AM +0800, Kefeng Wang wrote:
> The riscv has csr_read/write macro, see arch/riscv/include/asm/csr.h,
> the same function naming will cause build error, using such generic names
> in a driver is bad, rename csr_[read,write][l,] to mobiveil_csr_read/write
> to fix it.
> 
> drivers/pci/controller/pcie-mobiveil.c:238:69: error: macro "csr_read" passed 3 arguments, but takes just 1
>  static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> 
> drivers/pci/controller/pcie-mobiveil.c:253:80: error: macro "csr_write" passed 4 arguments, but takes just 2
>  static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> 
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Minghuan Lian <Minghuan.Lian@nxp.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Murray <andrew.murray@arm.com> 
> Fixes: bcbe0d9a8d93 ("PCI: mobiveil: Unify register accessors")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> 
> v2:
> - using mobiveil prefix suggested by Andrew and Christoph 
> 
>  drivers/pci/controller/pcie-mobiveil.c | 115 +++++++++++++------------
>  1 file changed, 58 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a45a6447b01d..5e6144b0fb95 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -235,7 +235,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> +static u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  {
>  	void *addr;
>  	u32 val;
> @@ -250,7 +250,8 @@ static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
>  	return val;
>  }
>  
> -static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> +static void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
> +			       size_t size)
>  {
>  	void *addr;
>  	int ret;
> @@ -262,19 +263,19 @@ static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
>  		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
>  }
>  
> -static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
> +static u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
>  {
> -	return csr_read(pcie, off, 0x4);
> +	return mobiveil_csr_read(pcie, off, 0x4);
>  }
>  
> -static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +static void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
> -	csr_write(pcie, val, off, 0x4);
> +	mobiveil_csr_write(pcie, val, off, 0x4);
>  }
>  
>  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
>  {
> -	return (csr_readl(pcie, LTSSM_STATUS) &
> +	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
>  		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
>  }
>  
> @@ -323,7 +324,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
>  		PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
>  		PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT;
>  
> -	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
> +	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
>  
>  	return pcie->config_axi_slave_base + where;
>  }
> @@ -353,13 +354,13 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	chained_irq_enter(chip, desc);
>  
>  	/* read INTx status */
> -	val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> -	mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> +	val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +	mask = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>  	intr_status = val & mask;
>  
>  	/* Handle INTx */
>  	if (intr_status & PAB_INTP_INTX_MASK) {
> -		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +		shifted_status = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
>  		shifted_status &= PAB_INTP_INTX_MASK;
>  		shifted_status >>= PAB_INTX_START;
>  		do {
> @@ -373,12 +374,12 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  							    bit);
>  
>  				/* clear interrupt handled */
> -				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> -					   PAB_INTP_AMBA_MISC_STAT);
> +				mobiveil_csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> +						    PAB_INTP_AMBA_MISC_STAT);
>  			}
>  
> -			shifted_status = csr_readl(pcie,
> -						   PAB_INTP_AMBA_MISC_STAT);
> +			shifted_status = mobiveil_csr_readl(pcie,
> +							    PAB_INTP_AMBA_MISC_STAT);
>  			shifted_status &= PAB_INTP_INTX_MASK;
>  			shifted_status >>= PAB_INTX_START;
>  		} while (shifted_status != 0);
> @@ -413,7 +414,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	}
>  
>  	/* Clear the interrupt status */
> -	csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
> +	mobiveil_csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
>  	chained_irq_exit(chip, desc);
>  }
>  
> @@ -474,24 +475,24 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
>  		return;
>  	}
>  
> -	value = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> +	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
>  	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
>  	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
>  		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> -	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
> +	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
>  
> -	csr_writel(pcie, upper_32_bits(size64),
> -		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(size64),
> +			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
>  
> -	csr_writel(pcie, lower_32_bits(cpu_addr),
> -		   PAB_PEX_AMAP_AXI_WIN(win_num));
> -	csr_writel(pcie, upper_32_bits(cpu_addr),
> -		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
> +			    PAB_PEX_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> +			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
>  
> -	csr_writel(pcie, lower_32_bits(pci_addr),
> -		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -	csr_writel(pcie, upper_32_bits(pci_addr),
> -		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> +			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> +			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
>  
>  	pcie->ib_wins_configured++;
>  }
> @@ -515,27 +516,27 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>  	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
>  	 * to 4 KB in PAB_AXI_AMAP_CTRL register
>  	 */
> -	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> +	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
>  	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
>  	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
>  		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> -	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
> +	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
>  
> -	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));

Thanks for the respin, this looks much better.

However some of the line lengths, such as this one, are now too long. Can
you move them to multiple lines where needed?

Thanks,

Andrew Murray

>  
>  	/*
>  	 * program AXI window base with appropriate value in
>  	 * PAB_AXI_AMAP_AXI_WIN0 register
>  	 */
> -	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
> -		   PAB_AXI_AMAP_AXI_WIN(win_num));
> -	csr_writel(pcie, upper_32_bits(cpu_addr),
> -		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
> +			    PAB_AXI_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> +			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
>  
> -	csr_writel(pcie, lower_32_bits(pci_addr),
> -		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
> -	csr_writel(pcie, upper_32_bits(pci_addr),
> -		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> +			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> +			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
>  
>  	pcie->ob_wins_configured++;
>  }
> @@ -579,42 +580,42 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	struct resource_entry *win;
>  
>  	/* setup bus numbers */
> -	value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +	value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
>  	value &= 0xff000000;
>  	value |= 0x00ff0100;
> -	csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
>  
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
>  	 * Space
>  	 */
> -	value = csr_readl(pcie, PCI_COMMAND);
> +	value = mobiveil_csr_readl(pcie, PCI_COMMAND);
>  	value |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> -	csr_writel(pcie, value, PCI_COMMAND);
> +	mobiveil_csr_writel(pcie, value, PCI_COMMAND);
>  
>  	/*
>  	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
>  	 * register
>  	 */
> -	pab_ctrl = csr_readl(pcie, PAB_CTRL);
> +	pab_ctrl = mobiveil_csr_readl(pcie, PAB_CTRL);
>  	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
> -	csr_writel(pcie, pab_ctrl, PAB_CTRL);
> +	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
>  
> -	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> -		   PAB_INTP_AMBA_MISC_ENB);
> +	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> +			    PAB_INTP_AMBA_MISC_ENB);
>  
>  	/*
>  	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
>  	 * PAB_AXI_PIO_CTRL Register
>  	 */
> -	value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
> +	value = mobiveil_csr_readl(pcie, PAB_AXI_PIO_CTRL);
>  	value |= APIO_EN_MASK;
> -	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
> +	mobiveil_csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
>  
>  	/* Enable PCIe PIO master */
> -	value = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> +	value = mobiveil_csr_readl(pcie, PAB_PEX_PIO_CTRL);
>  	value |= 1 << PIO_ENABLE_SHIFT;
> -	csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
> +	mobiveil_csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
>  
>  	/*
>  	 * we'll program one outbound window for config reads and
> @@ -647,10 +648,10 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	}
>  
>  	/* fixup for PCIe class register */
> -	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
> +	value = mobiveil_csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
>  	value &= 0xff;
>  	value |= (PCI_CLASS_BRIDGE_PCI << 16);
> -	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
> +	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
>  
>  	/* setup MSI hardware registers */
>  	mobiveil_pcie_enable_msi(pcie);
> @@ -668,9 +669,9 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
>  	pcie = irq_desc_get_chip_data(desc);
>  	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
>  	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> -	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> +	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>  	shifted_val &= ~mask;
> -	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
> +	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
>  	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>  }
>  
> @@ -684,9 +685,9 @@ static void mobiveil_unmask_intx_irq(struct irq_data *data)
>  	pcie = irq_desc_get_chip_data(desc);
>  	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
>  	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> -	shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> +	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>  	shifted_val |= mask;
> -	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
> +	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
>  	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>  }
>  
> -- 
> 2.20.1
> 
