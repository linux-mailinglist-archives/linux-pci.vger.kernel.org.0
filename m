Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE754E9EC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 21:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiFPTTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiFPTTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 15:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57318B3C;
        Thu, 16 Jun 2022 12:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A0B661D27;
        Thu, 16 Jun 2022 19:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2B0C34114;
        Thu, 16 Jun 2022 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655407186;
        bh=0oI584spUy6KbItThEajQaOi6DeQhyouguYy6HKNLas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h+gkzZwjbdyAZUUYeibcOTJ66aaXewoe+/NgBx8b9tz4VrCN1M9Z7oZIUsMlnYkUR
         xCKCWNNk1udphrNMraCj9P+bik29lW7BON4nWa6TW9ZIUzWQ8IMrNlDhPMhjeuKdwN
         C2CIp3tgs+0PbxuFHDL2QOVoFeQSTmcVuX7vPVY3kLbesnFHUIXMeN4c2/a8lrdZlm
         PKTjQFmIA3aIeMUsdc/mZqths2GxfTNCUOqRvezX9w59+gnOmJBD0/b+VGK+6y/zFI
         yf0IVAYOEEB71OQwut09Q0td/0JfvdEWOmS6aiNp0ZRhb6uv2nyYm7Qi2HChCPagJY
         dHJ4GtrAKeU1g==
Date:   Thu, 16 Jun 2022 14:19:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, michals@xilinx.com, robh@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Message-ID: <20220616191944.GA1102555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616124429.12917-3-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 06:14:29PM +0530, Bharat Kumar Gogada wrote:
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
>  drivers/pci/controller/pcie-xilinx-cpm.c | 62 ++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index c7cd44ed4dfc..0bcd11d27eeb 100644
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
> @@ -98,6 +102,16 @@
>  /* Phy Status/Control Register definitions */
>  #define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
>  
> +/**
> + * struct xilinx_cpm_variant - CPM variant information
> + * @cpm_version: CPM5 has few changes compared to CPM block.
> + *      CPM5 has dedicated register space for control and status registers.
> + *

Superfluous blank line.

> + */
> +struct xilinx_cpm_variant {
> +	bool cpm_version;

This is not really a bool, unless you want to preclude the possibility
of ever having a CPM6 or other future variants.

> +};
> +
>  /**
>   * struct xilinx_cpm_pcie - PCIe port information
>   * @dev: Device pointer
> @@ -109,6 +123,7 @@
>   * @intx_irq: legacy interrupt number
>   * @irq: Error interrupt number
>   * @lock: lock protecting shared register access
> + * @is_cpm5: value to check cpm version
>   */
>  struct xilinx_cpm_pcie {
>  	struct device			*dev;
> @@ -120,6 +135,7 @@ struct xilinx_cpm_pcie {
>  	int				intx_irq;
>  	int				irq;
>  	raw_spinlock_t			lock;
> +	bool                            is_cpm5;
>  };
>  
>  static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
> @@ -285,6 +301,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
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
> @@ -484,6 +508,12 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
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
> @@ -503,6 +533,10 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>  	struct device *dev = port->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource *res;
> +	const struct xilinx_cpm_variant *variant =
> +		of_device_get_match_data(dev);
> +
> +	port->is_cpm5 = variant->cpm_version;

It's a little clunky to use booleans for a potentially multi-valued
version and to copy them around.  Something like this might leave room
for future variants that need more knobs:

  enum xilinx_cpm_version {
    CPM,
    CPM5,
  };

  struct xilinx_cpm_variant {
    enum xilinx_cpm_version version;
  };

  struct xilinx_cpm_pcie {
    ...
    const struct xilinx_cpm_variant   *variant;

  static const struct xilinx_cpm_variant cpm5 = {
    .version = CPM5,
  };

  xilinx_cpm_pcie_event_flow()
  {
    ...
    if (port->variant->version == CPM5)

  xilinx_cpm_pcie_probe()
  {
    ...
    port->variant = of_device_get_match_data(dev);


>  	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
>  							       "cpm_slcr");
> @@ -518,7 +552,14 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>  	if (IS_ERR(port->cfg))
>  		return PTR_ERR(port->cfg);
>  
> -	port->reg_base = port->cfg->win;
> +	if (port->is_cpm5) {
> +		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
> +								       "cpm_csr");
> +		if (IS_ERR(port->reg_base))
> +			return PTR_ERR(port->reg_base);
> +	} else {
> +		port->reg_base = port->cfg->win;
> +	}
>  
>  	return 0;
>  }
> @@ -591,9 +632,24 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static const struct xilinx_cpm_variant cpm_host = {
> +	.cpm_version = false,
> +};
> +
> +static const struct xilinx_cpm_variant cpm5_host = {
> +	.cpm_version = true,
> +};
> +
>  static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
> -	{ .compatible = "xlnx,versal-cpm-host-1.00", },
> -	{}
> +	{
> +		.compatible = "xlnx,versal-cpm-host-1.00",
> +		.data = &cpm_host,
> +	},
> +	{
> +		.compatible = "xlnx,versal-cpm5-host",
> +		.data = &cpm5_host,
> +	},
> +	{},
>  };
>  
>  static struct platform_driver xilinx_cpm_pcie_driver = {
> -- 
> 2.17.1
> 
