Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F404CA91A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiCBPe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 10:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiCBPe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 10:34:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FFB754BD4;
        Wed,  2 Mar 2022 07:33:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559D913D5;
        Wed,  2 Mar 2022 07:33:44 -0800 (PST)
Received: from lpieralisi (unknown [10.57.37.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B4EC3F73D;
        Wed,  2 Mar 2022 07:33:43 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:33:38 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Message-ID: <Yh+OUvLi56/H4l2z@lpieralisi>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
 <20220215124606.28627-3-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215124606.28627-3-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 06:16:06PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additional register bit
>   to enable and handle legacy interrupts.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 33 +++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Only a couple of very minor suggestions below.

> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index c7cd44ed4dfc..eb69f494571a 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -35,6 +35,10 @@
>  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
>  #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
>  
> +#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> +#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> +#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> +
>  /* Interrupt registers definitions */
>  #define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
>  #define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> @@ -109,6 +113,7 @@
>   * @intx_irq: legacy interrupt number
>   * @irq: Error interrupt number
>   * @lock: lock protecting shared register access
> + * @is_cpm5: value to check cpm version
>   */
>  struct xilinx_cpm_pcie {
>  	struct device			*dev;
> @@ -120,6 +125,7 @@ struct xilinx_cpm_pcie {
>  	int				intx_irq;
>  	int				irq;
>  	raw_spinlock_t			lock;
> +	bool                            is_cpm5;
>  };
>  
>  static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
> @@ -285,6 +291,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>  		generic_handle_domain_irq(port->cpm_domain, i);
>  	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
>  
> +	if (port->is_cpm5) {
> +		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
> +		if (val)
> +			writel_relaxed(val,
> +				       port->cpm_base +
> +				       XILINX_CPM_PCIE_IR_STATUS);
> +	}
> +
>  	/*
>  	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
>  	 * CPM SLCR block.
> @@ -484,6 +498,12 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	 */
>  	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
>  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +
> +	if (port->is_cpm5) {
> +		writel(XILINX_CPM_PCIE_IR_LOCAL,
> +		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> +	}
> +
>  	/* Enable the Bridge enable bit */
>  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> @@ -504,6 +524,9 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource *res;
>  
> +	if (of_device_is_compatible(dev->of_node, "xlnx,versal-cpm5-host-1.00"))
> +		port->is_cpm5 = true;

port->is_cpm5 = of_device_is_compatible(dev->of_node,
					"xlnx,versal-cpm5-host-1.00");

?

> +		port->is_cpm5 = true;
> +
>  	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
>  							       "cpm_slcr");
>  	if (IS_ERR(port->cpm_base))
> @@ -518,7 +541,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>  	if (IS_ERR(port->cfg))
>  		return PTR_ERR(port->cfg);
>  
> -	port->reg_base = port->cfg->win;
> +	if (!port->is_cpm5) {

Nit: I'd keep the check as above for consistency but it is not really
important:

if (port->is_cpm5)
	...
else
	...

> +		port->reg_base = port->cfg->win;
> +	} else {
> +		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
> +								       "cpm_csr");
> +		if (IS_ERR(port->reg_base))
> +			return PTR_ERR(port->reg_base);
> +	}
>  
>  	return 0;
>  }
> @@ -593,6 +623,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
>  	{ .compatible = "xlnx,versal-cpm-host-1.00", },
> +	{ .compatible = "xlnx,versal-cpm5-host-1.00", },
>  	{}
>  };
>  
> -- 
> 2.17.1
> 
