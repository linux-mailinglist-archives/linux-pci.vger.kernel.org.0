Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CE33B394E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 00:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhFXWnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhFXWnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45373613A9;
        Thu, 24 Jun 2021 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574442;
        bh=2RVF0pPWJN9bsOvwEQ1wuKz8hUlipUgiYt0DkqZHZtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C07/XAF2fa67lKOB++qXyN0IRjAQX8HJ2L0BsJLlxgNNyjMCsl3m0tSFsLFA5xvqs
         RuJA/oxtWcJjtIhCFOGLQ0blYbayFGWQ5i0aotk9lcH/REAfA35SSMGLuGNwDYgkHU
         L0vY+sXoGTmF22zybs787DZkfceg+CGDn/Z4jQe2NjdWipqh0uaOHQzDcCTwmYXtiZ
         tOXfqBi7Sk/rL2iEDA+IVSOY7dzCq7RtxERD8QvQHfiaoF3XwlzucUapiVpKCGqc0G
         nS1JnsB7pu9yK+lEoi/5OS/OwRCuxUSc51hLyCBnXzi4JKdZjWPRoPV9btzF2rYi1e
         hxt46bcoGnE3g==
Date:   Thu, 24 Jun 2021 17:40:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210624224040.GA3567297@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608080409.1729276-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Michal, Ley Foon, Jingoo, Thierry, Jonathan]

On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
> IRQ handlers that are registered for shared interrupts can be called at
> any time after have been registered using the request_irq() function.
> 
> It's up to drivers to ensure that's always safe for these to be called.
> 
> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> their handlers are registered very early in the probe function, an error
> later can lead to these handlers being executed before all the required
> resources have been properly setup.
> 
> For example, the rockchip_pcie_read() function used by these IRQ handlers
> expects that some PCIe clocks will already be enabled, otherwise trying
> to access the PCIe registers causes the read to hang and never return.
> 
> The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
> shared interrupt handlers being called, by generating a spurious interrupt
> just before a shared interrupt handler is unregistered.
> 
> But this means that if the option is enabled, any error in the probe path
> of this driver could lead to one of the IRQ handlers to be executed.

I'm not an IRQ expert, but I think this is an issue regardless of
CONFIG_DEBUG_SHIRQ, isn't it?  Anything used by an IRQ handler should
be initialized before the handler is registered.  CONFIG_DEBUG_SHIRQ
is just a way to help find latent problems.

> In a rockpro64 board, the following sequence of events happens:
> 
>   1) "pcie-sys" IRQ is requested and its handler registered.
>   2) "pcie-client" IRQ is requested and its handler registered.
>   3) probe later fails due readl_poll_timeout() returning a timeout.
>   4) the "pcie-sys" IRQ is unregistered.
>   5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
>   6) "pcie-client" IRQ handler is called for this spurious interrupt.
>   7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
>   8) the machine hangs because rockchip_pcie_read() call never returns.
> 
> To avoid cases like this, the handlers don't have to be registered until
> very late in the probe function, once all the resources have been setup.
> 
> So let's just move all the IRQ init before the pci_host_probe() call, that
> will prevent issues like this and seems to be the correct thing to do too.

Previously we registered rockchip_pcie_subsys_irq_handler() and
rockchip_pcie_client_irq_handler() before the PCIe clocks were
enabled.  That's a problem because they depend on those clocks being
enabled, and your patch fixes that.

rockchip_pcie_legacy_int_handler() depends on rockchip->irq_domain,
which isn't initialized until rockchip_pcie_init_irq_domain().
Previously we registered rockchip_pcie_legacy_int_handler() as the
handler for the "legacy" IRQ before rockchip_pcie_init_irq_domain().

I think you patch *also* fixes that problem, right?

I think this is also an issue with the following other drivers.  They all
set the handler to something that uses an IRQ domain before they
actually initialize the domain:

  # nwl --------------------------------------------------------------
  nwl_pcie_probe
    nwl_pcie_parse_dt
      pcie->irq_intx = platform_get_irq_byname(pdev, "intx")
      irq_set_chained_handler_and_data(pcie->irq_intx, nwl_pcie_leg_handler)
    nwl_pcie_bridge_init
      devm_request_irq
    nwl_pcie_init_irq_domain
      pcie->legacy_irq_domain = irq_domain_add_linear()

  nwl_pcie_leg_handler
    irq_find_mapping(pcie->legacy_irq_domain)


  # altera --------------------------------------------------------------
  altera_pcie_probe
    altera_pcie_parse_dt
      irq_set_chained_handler_and_data(altera_pcie_isr)
    altera_pcie_init_irq_domain
      pcie->irq_domain = irq_domain_add_linear()

  altera_pcie_isr
    irq_find_mapping(pcie->irq_domain)


  # ks --------------------------------------------------------------
  ks_pcie_config_legacy_irq
    irq_set_chained_handler_and_data(ks_pcie_legacy_irq_handler)
    ks_pcie->legacy_irq_domain = irq_domain_add_linear()

  ks_pcie_legacy_irq_handler
    ks_pcie_handle_legacy_irqirq_linear_revmap(ks_pcie->legacy_irq_domain)


  # tegra --------------------------------------------------------------
  tegra_pcie_msi_setup
    if (IS_ENABLED(CONFIG_PCI_MSI)) {
      tegra_allocate_domains
	parent = irq_domain_create_linear()
	msi->domain = pci_msi_create_irq_domain(parent)
    }
    irq_set_chained_handler_and_data(tegra_pcie_msi_irq)

  tegra_pcie_msi_irq
    irq_find_mapping(msi->domain->parent)


Tegra is a little wierd because the IS_ENABLED(CONFIG_PCI_MSI) only
covers the IRQ domain alloc; it doesn't cover setting the handler.  So
if CONFIG_PCI_MSI is not set, we don't alloc the IRQ domain, but we
still set a handler that *uses* the IRQ domain.  That seems somewhat
broken.

> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2:
> - Add missing word in the commit message.
> - Include Shawn Lin's Acked-by tag.
> 
>  drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b159..78d04ac29cd 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -592,10 +592,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>  	if (err)
>  		return err;
>  
> -	err = rockchip_pcie_setup_irq(rockchip);
> -	if (err)
> -		return err;
> -
>  	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>  	if (IS_ERR(rockchip->vpcie12v)) {
>  		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> @@ -973,8 +969,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_vpcie;
>  
> -	rockchip_pcie_enable_interrupts(rockchip);
> -
>  	err = rockchip_pcie_init_irq_domain(rockchip);
>  	if (err < 0)
>  		goto err_deinit_port;
> @@ -992,6 +986,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = rockchip;
>  	bridge->ops = &rockchip_pcie_ops;
>  
> +	err = rockchip_pcie_setup_irq(rockchip);
> +	if (err)
> +		goto err_remove_irq_domain;
> +
> +	rockchip_pcie_enable_interrupts(rockchip);
> +
>  	err = pci_host_probe(bridge);
>  	if (err < 0)
>  		goto err_remove_irq_domain;
> -- 
> 2.31.1
> 
