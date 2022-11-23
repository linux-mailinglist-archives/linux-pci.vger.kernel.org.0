Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C71636CA6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiKWV6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiKWV6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F765E44;
        Wed, 23 Nov 2022 13:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4571B82503;
        Wed, 23 Nov 2022 21:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF829C433C1;
        Wed, 23 Nov 2022 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669240711;
        bh=/4n+Spc+ltblmwtJHhvxBgY8u1GVTKc0G55iQgfMppE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP++qYrUtKfpPY16ErGKEilq8Mh5rSyLoG2hoX+Ex5QUAvNeKzYF2E/0kemchntJy
         NTNxJwEM82TonQJnp7wgLYDln6Zb3U/85dWtE7moUbtcpk+rWa90kvw90HPpHLIVYB
         1MrjEY+Ctpz3tuDfhdX7SCLA29fdBn+RTjulxSCPC3WnbznkaTZJs/ELs47sC6DUfT
         we2R0RApfTCZ3sSIuse8XnBbwHq96/nmJQe9eu8m7ScLD0RRuVmZqbxNHsNAoJNrhy
         DFEG5xUR1TaTBDHtYkJO/Mn6oEE6FVe/gEIjsENem1Y1MUiV6VaSR0gP/ECmndBmrl
         jK+h81MRbvonA==
Date:   Wed, 23 Nov 2022 21:58:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 4/9] PCI: microchip: Clean up initialisation of
 interrupts
Message-ID: <Y36Xgr7NobqA2BCh@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-5-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-5-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:54:59PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Refactor interrupt handling in _init() function into
> disable_interrupts(), init_interrupts(), clear_sec_errors() and clear
> ded_errors().  It was unwieldy and prone to bugs. Then clearly disable
> interrupts as soon as possible and only enable interrupts after address
> translation errors are setup to prevent spurious axi2pcie and pcie2axi
              ^^^^^^
Is that meant to read "after address translation is" or "after address
translation handling is"?

> translation errors being reported
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 148 ++++++++++++-------
>  1 file changed, 92 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index a81e6d25e347..ecd4d3f3e3d4 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -986,39 +986,65 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static int mc_platform_init(struct pci_config_window *cfg)
> +static inline void mc_clear_secs(struct mc_pcie *port)
>  {
> -	struct device *dev = cfg->parent;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct mc_pcie *port;
> -	void __iomem *bridge_base_addr;
> -	void __iomem *ctrl_base_addr;
> -	int ret;
> -	int irq;
> -	int i, intx_irq, msi_irq, event_irq;
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +
> +	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + SEC_ERROR_INT);

I think it'd be nice if the GENMASK()s in this function and below were
#defined above somewhere.

> +	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
> +}
> +
> +static inline void mc_clear_deds(struct mc_pcie *port)
> +{
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +
> +	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + DED_ERROR_INT);
> +	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
> +}
> +
> +static void mc_disable_interrupts(struct mc_pcie *port)
> +{
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
>  	u32 val;
> -	int err;
>  
> -	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> -	if (!port)
> -		return -ENOMEM;
> -	port->dev = dev;
> +	/* ensure ecc bypass is enabled */
> +	val = ECC_CONTROL_TX_RAM_ECC_BYPASS | ECC_CONTROL_RX_RAM_ECC_BYPASS |
> +		ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS | ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;

Pedantic maybe, but could we format this as:
		ECC_CONTROL_TX_RAM_ECC_BYPASS |
		ECC_CONTROL_RX_RAM_ECC_BYPASS |
		ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
		ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;
And the same below for the PCIE_EVENT_FOO stuff, I think it'd make
things a bit easier on the eye.

Anyways, SEC and DED stuff that I usually see on startup are gone - at
least on the setup I have :)
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
>  
> -	ret = mc_pcie_init_clks(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> -		return -ENODEV;
> -	}
> +	/* disable sec errors and clear any outstanding */
> +	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + SEC_ERROR_INT_MASK);
> +	mc_clear_secs(port);
>  
> -	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(port->axi_base_addr))
> -		return PTR_ERR(port->axi_base_addr);
> +	/* disable ded errors and clear any outstanding */
> +	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + DED_ERROR_INT_MASK);
> +	mc_clear_deds(port);
>  
> -	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +	/* disable local interrupts and clear any outstanding */
> +	writel_relaxed(0, bridge_base_addr + IMASK_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_MSI);
> +
> +	/* disable PCIe events and clear any outstanding */
> +	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
> +	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
> +
> +	/* disable host interrupts and clear any outstanding */
> +	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
> +	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
> +}
> +
> +static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port)
> +{
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int i, intx_irq, msi_irq, event_irq;
> +	int ret;
>  
> -	port->msi.vector_phy = MSI_ADDR;
> -	port->msi.num_vectors = MC_NUM_MSI_IRQS;
>  	ret = mc_pcie_init_irq_domains(port);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
> @@ -1036,11 +1062,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  			return -ENXIO;
>  		}
>  
> -		err = devm_request_irq(dev, event_irq, mc_event_handler,
> +		ret = devm_request_irq(dev, event_irq, mc_event_handler,
>  				       0, event_cause[i].sym, port);
> -		if (err) {
> +		if (ret) {
>  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
> -			return err;
> +			return ret;
>  		}
>  	}
>  
> @@ -1065,44 +1091,54 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	/* Plug the main event chained handler */
>  	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
>  
> -	/* Hardware doesn't setup MSI by default */
> -	mc_pcie_enable_msi(port, cfg->win);
> +	return 0;
> +}
>  
> -	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> -	val |= PM_MSI_INT_INTX_MASK;
> -	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> +static int mc_platform_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mc_pcie *port;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	int ret;
>  
> -	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +	port->dev = dev;
>  
> -	val = PCIE_EVENT_INT_L2_EXIT_INT |
> -	      PCIE_EVENT_INT_HOTRST_EXIT_INT |
> -	      PCIE_EVENT_INT_DLUP_EXIT_INT;
> -	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
> +	ret = mc_pcie_init_clks(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> +		return -ENODEV;
> +	}
>  
> -	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT |
> -	      SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
> -	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT |
> -	      SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> -	writel_relaxed(val, ctrl_base_addr + SEC_ERROR_INT);
> -	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_INT_MASK);
> -	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
> +	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(port->axi_base_addr))
> +		return PTR_ERR(port->axi_base_addr);
>  
> -	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT |
> -	      DED_ERROR_INT_RX_RAM_DED_ERR_INT |
> -	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT |
> -	      DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> -	writel_relaxed(val, ctrl_base_addr + DED_ERROR_INT);
> -	writel_relaxed(0, ctrl_base_addr + DED_ERROR_INT_MASK);
> -	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
> +	mc_disable_interrupts(port);
>  
> -	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
> -	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
> +	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> +
> +	port->msi.vector_phy = MSI_ADDR;
> +	port->msi.num_vectors = MC_NUM_MSI_IRQS;
> +
> +	/* Hardware doesn't setup MSI by default */
> +	mc_pcie_enable_msi(port, cfg->win);
>  
>  	/* Configure Address Translation Table 0 for PCIe config space */
>  	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
>  			     cfg->res.start, resource_size(&cfg->res));
>  
> -	return mc_pcie_setup_windows(pdev, port);
> +	ret = mc_pcie_setup_windows(pdev, port);
> +	if (ret)
> +		return ret;
> +
> +	/* address translation is up; safe to enable interrupts */
> +	return mc_init_interrupts(pdev, port);
>  }
>  
>  static const struct pci_ecam_ops mc_ecam_ops = {
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
