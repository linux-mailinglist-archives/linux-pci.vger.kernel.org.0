Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25582461C0C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 17:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbhK2Qsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 11:48:47 -0500
Received: from foss.arm.com ([217.140.110.172]:43420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346120AbhK2Qqr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 11:46:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B1C1063;
        Mon, 29 Nov 2021 08:43:29 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F8C3F5A1;
        Mon, 29 Nov 2021 08:43:29 -0800 (PST)
Date:   Mon, 29 Nov 2021 16:43:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 5/7] PCI: aardvark: Disable bus mastering and mask all
 interrupts when unbinding driver
Message-ID: <20211129164326.GB26244@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
 <20211031181233.9976-6-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211031181233.9976-6-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 31, 2021 at 07:12:31PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Ensure that after driver unbinding PCIe cards are not be able to forward
> memory and I/O requests in the upstream direction and that no interrupt can
> be triggered.

Two actions - likely to require two patches.

> Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org

You keep adding stable tags, I suppose because you have fixes on top
that will need to go to stable, as said multiple times please let's
not jump the gun, let's fix (if this is fixing anything) mainline
first.

Lorenzo

>  drivers/pci/controller/pci-aardvark.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 71ce9f02d596..08b34accfe2f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1695,13 +1695,42 @@ static int advk_pcie_remove(struct platform_device *pdev)
>  {
>  	struct advk_pcie *pcie = platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	u32 val;
>  	int i;
>  
> +	/* Remove PCI bus with all devices */
>  	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
>  	pci_unlock_rescan_remove();
>  
> +	/* Disable Root Bridge I/O space, memory space and bus mastering */
> +	val = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> +	val &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> +	advk_writel(pcie, val, PCIE_CORE_CMD_STATUS_REG);
> +
> +	/* Disable MSI */
> +	val = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
> +	val &= ~PCIE_CORE_CTRL2_MSI_ENABLE;
> +	advk_writel(pcie, val, PCIE_CORE_CTRL2_REG);
> +
> +	/* Clear MSI address */
> +	advk_writel(pcie, 0, PCIE_MSI_ADDR_LOW_REG);
> +	advk_writel(pcie, 0, PCIE_MSI_ADDR_HIGH_REG);
> +
> +	/* Mask all interrupts */
> +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
> +	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
> +	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
> +	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_MASK_REG);
> +
> +	/* Clear all interrupts */
> +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
> +	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
> +	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
> +	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
> +
> +	/* Remove IRQ domains */
>  	advk_pcie_remove_msi_irq_domain(pcie);
>  	advk_pcie_remove_irq_domain(pcie);
>  
> -- 
> 2.32.0
> 
