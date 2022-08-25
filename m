Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC355A156B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiHYPP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiHYPPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5E6564F;
        Thu, 25 Aug 2022 08:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60360B82A18;
        Thu, 25 Aug 2022 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1078C433D7;
        Thu, 25 Aug 2022 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661440544;
        bh=UngkZdFzUgm4+n+1n85c2FXf5joe08toOBXh1ldxmWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8N2eMGdOhh7ENZv9DdL7qFZogCam9mxgAxif9+llXeD5WORcI6rUXbNw7ikE8Ybh
         0udwwNJI6tiILpSpzffzzPIdCMsGOsshCf9E4EfKiZXDG4abPHvZ/uEQmhG2vVKoUT
         DHZxOKiT7lwb/xp8u7Pl41E34NhUixMtLr3wTht/kGf2k3pnNd7zKDDAbCXJCqJpUc
         Ffg6kmuApdhFCvTZzOUqlr4ac4Hqb8bSaucX5XxO+MXzOXiKt03QlNxlOTvdSy/g8e
         kVy4vVdBgz8I4yXAOjvicHBmGIGJ4wbkaX6D8M8aMTbveWP8SyatF6CAJD8OfzmlEw
         Mtu6e+1qY/IBg==
Date:   Thu, 25 Aug 2022 17:15:36 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, kw@linux.com, thomas.petazzoni@bootlin.com,
        pali@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: mvebu: add support for orion5x
Message-ID: <YweSGDN7rei2Ugwp@lpieralisi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-3-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802173423.47230-3-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 08:34:23PM +0300, Mauri Sandberg wrote:
> Add support for orion5x PCIe controller.
> 
> There is Orion-specific errata that config space via CF8/CFC registers
> is broken. Workaround documented in errata documented (linked from above
> documentation) does not work when DMA is used and instead other

Linked to which documentation ?

> undocumented workaround is needed which maps config space to memory
> (and therefore avoids usage of broken CF8/CFC memory mapped registers).
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Cc: Pali Rohár <pali@kernel.org>
> ---
> v1 -> v2:
>  - do pcie related mvebu windows and remaps in pcie_setup()
> ---
>  arch/arm/mach-orion5x/common.c     | 13 -------
>  arch/arm/mach-orion5x/pci.c        | 14 +++++++
>  drivers/pci/controller/Kconfig     |  2 +-
>  drivers/pci/controller/pci-mvebu.c | 59 ++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 7bcb41137bbf..9d8be5ce1266 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -231,19 +231,6 @@ void __init orion5x_init_early(void)
>  
>  void orion5x_setup_wins(void)
>  {
> -	/*
> -	 * The PCIe windows will no longer be statically allocated
> -	 * here once Orion5x is migrated to the pci-mvebu driver.
> -	 */
> -	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
> -					  ORION_MBUS_PCIE_IO_ATTR,
> -					  ORION5X_PCIE_IO_PHYS_BASE,
> -					  ORION5X_PCIE_IO_SIZE,
> -					  ORION5X_PCIE_IO_BUS_BASE);
> -	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
> -				    ORION_MBUS_PCIE_MEM_ATTR,
> -				    ORION5X_PCIE_MEM_PHYS_BASE,
> -				    ORION5X_PCIE_MEM_SIZE);
>  	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
>  					  ORION_MBUS_PCI_IO_ATTR,
>  					  ORION5X_PCI_IO_PHYS_BASE,
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 9574c73f3c03..7c4e2f355cc7 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -150,6 +150,20 @@ static int __init pcie_setup(struct pci_sys_data *sys)
>  	 */
>  	orion_pcie_setup(PCIE_BASE);
>  
> +	/*
> +	 * The PCIe windows will no longer be statically allocated
> +	 * here once Orion5x is migrated to the pci-mvebu driver.
> +	 */

Is this comment still relevant ? And more importantly, may I ask
you why this code move in this hunk ? I think, whatever the reason
is, that deserves a comment.

> +	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
> +					  ORION_MBUS_PCIE_IO_ATTR,
> +					  ORION5X_PCIE_IO_PHYS_BASE,
> +					  ORION5X_PCIE_IO_SIZE,
> +					  ORION5X_PCIE_IO_BUS_BASE);
> +	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
> +				    ORION_MBUS_PCIE_MEM_ATTR,
> +				    ORION5X_PCIE_MEM_PHYS_BASE,
> +				    ORION5X_PCIE_MEM_SIZE);
> +
>  	/*
>  	 * Check whether to apply Orion-1/Orion-NAS PCIe config
>  	 * read transaction workaround.
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index b8d96d38064d..a249375837f0 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -5,7 +5,7 @@ menu "PCI controller drivers"
>  
>  config PCI_MVEBU
>  	tristate "Marvell EBU PCIe controller"
> -	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> +	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_ORION5X || COMPILE_TEST
>  	depends on MVEBU_MBUS
>  	depends on ARM
>  	depends on OF
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c1ffdb06c971..1d3052aa7e49 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1487,6 +1487,54 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  	return 0;
>  }
>  
> +static int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
> +			  u32 devfn, int where, int size, u32 *val)
> +{
> +	*val = readl(wa_base + (PCIE_CONF_BUS(bus->number) |
> +				PCIE_CONF_DEV(PCI_SLOT(devfn)) |
> +				PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
> +				PCIE_CONF_REG(where)));
> +
> +	if (size == 1)
> +		*val = (*val >> (8 * (where & 3))) & 0xff;
> +	else if (size == 2)
> +		*val = (*val >> (8 * (where & 3))) & 0xffff;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +/* Relevant only for Orion-1/Orion-NAS */
> +#define ORION5X_PCIE_WA_PHYS_BASE	0xf0000000
> +#define ORION5X_PCIE_WA_VIRT_BASE	IOMEM(0xfd000000)
> +#define ORION5X_PCIE_WA_SIZE		SZ_16M
> +#define ORION_MBUS_PCIE_WA_TARGET	0x04
> +#define ORION_MBUS_PCIE_WA_ATTR		0x79
> +
> +static int mvebu_pcie_child_rd_conf_wa(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val)
> +{
> +	struct mvebu_pcie *pcie = bus->sysdata;
> +	struct mvebu_pcie_port *port;
> +
> +	port = mvebu_pcie_find_port(pcie, bus, devfn);
> +	if (!port)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (!mvebu_pcie_link_up(port))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	/*
> +	 * We only support access to the non-extended configuration
> +	 * space when using the WA access method (or we would have to
> +	 * sacrifice 256M of CPU virtual address space.)

Please expand the comment - future reviewers and developers may need
this information to understand this choice, me included.

Lorenzo

> +	 */
> +	if (where >= 0x100) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return orion_pcie_rd_conf_wa(ORION5X_PCIE_WA_VIRT_BASE, bus, devfn, where, size, val);
> +}
> +
>  static int mvebu_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1663,6 +1711,16 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	bridge->align_resource = mvebu_pcie_align_resource;
>  	bridge->map_irq = mvebu_pcie_map_irq;
>  
> +	if (of_machine_is_compatible("marvell,orion5x-88f5181")) {
> +		dev_info(dev, "Applying Orion-1/Orion-NAS PCIe config read transaction workaround\n");
> +
> +		mvebu_pcie_child_ops.read = mvebu_pcie_child_rd_conf_wa;
> +		mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_WA_TARGET,
> +					    ORION_MBUS_PCIE_WA_ATTR,
> +					    ORION5X_PCIE_WA_PHYS_BASE,
> +					    ORION5X_PCIE_WA_SIZE);
> +	}
> +
>  	return pci_host_probe(bridge);
>  }
>  
> @@ -1733,6 +1791,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
>  	{ .compatible = "marvell,armada-370-pcie", },
>  	{ .compatible = "marvell,dove-pcie", },
>  	{ .compatible = "marvell,kirkwood-pcie", },
> +	{ .compatible = "marvell,orion5x-pcie", },
>  	{},
>  };
>  
> -- 
> 2.25.1
> 
