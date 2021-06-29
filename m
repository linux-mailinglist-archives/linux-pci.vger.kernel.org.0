Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99E3B6BC4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 02:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhF2Ak5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 20:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhF2Ak5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 20:40:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DE9061CDC;
        Tue, 29 Jun 2021 00:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624927110;
        bh=WZivHehj0fn2zKFGoJRQXv8BLeKMtv+80LunaiEbIWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J1YEvvYJz8zqaFhsLjQqpLSF32fSg8EVWaPWDmNeDM59GEdo2i/8BDcz9EpIFVSCo
         3yvEZc1PA3yJF+uTYog0vVSprT51/Q07l2wkuhnh3WaFGQoR1nHd980Jz+O7EYZPwq
         QeurrrGQPohqwS8DaCgRZT6R+g8O/slmEq4popLssCB3q/VGC9B1C6lQLyXIY1IayC
         4MSXCiS2RRAV/kW4sr2eJXv+IycAui1dukFIBfTh9HbJ0WnlioejbQNfIU/iiwFZpD
         fnWoD7SLZ4z/gyfw3PH4wTebBOJmXO1q9gsWqNMBiI0FySzwSMpOv4+ZFr8ULcs65z
         S9ujiOiO3McFA==
Date:   Mon, 28 Jun 2021 19:38:29 -0500
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
Message-ID: <20210629003829.GA3978248@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624224040.GA3567297@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 05:40:40PM -0500, Bjorn Helgaas wrote:
> [+cc Michal, Ley Foon, Jingoo, Thierry, Jonathan]
> 
> On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
> > IRQ handlers that are registered for shared interrupts can be called at
> > any time after have been registered using the request_irq() function.
> > 
> > It's up to drivers to ensure that's always safe for these to be called.
> > 
> > Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> > their handlers are registered very early in the probe function, an error
> > later can lead to these handlers being executed before all the required
> > resources have been properly setup.
> > 
> > For example, the rockchip_pcie_read() function used by these IRQ handlers
> > expects that some PCIe clocks will already be enabled, otherwise trying
> > to access the PCIe registers causes the read to hang and never return.
> > 
> > The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
> > shared interrupt handlers being called, by generating a spurious interrupt
> > just before a shared interrupt handler is unregistered.
> > 
> > But this means that if the option is enabled, any error in the probe path
> > of this driver could lead to one of the IRQ handlers to be executed.
> 
> I'm not an IRQ expert, but I think this is an issue regardless of
> CONFIG_DEBUG_SHIRQ, isn't it?  Anything used by an IRQ handler should
> be initialized before the handler is registered.  CONFIG_DEBUG_SHIRQ
> is just a way to help find latent problems.
> 
> > In a rockpro64 board, the following sequence of events happens:
> > 
> >   1) "pcie-sys" IRQ is requested and its handler registered.
> >   2) "pcie-client" IRQ is requested and its handler registered.
> >   3) probe later fails due readl_poll_timeout() returning a timeout.
> >   4) the "pcie-sys" IRQ is unregistered.
> >   5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
> >   6) "pcie-client" IRQ handler is called for this spurious interrupt.
> >   7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
> >   8) the machine hangs because rockchip_pcie_read() call never returns.
> > 
> > To avoid cases like this, the handlers don't have to be registered until
> > very late in the probe function, once all the resources have been setup.
> > 
> > So let's just move all the IRQ init before the pci_host_probe() call, that
> > will prevent issues like this and seems to be the correct thing to do too.
> 
> Previously we registered rockchip_pcie_subsys_irq_handler() and
> rockchip_pcie_client_irq_handler() before the PCIe clocks were
> enabled.  That's a problem because they depend on those clocks being
> enabled, and your patch fixes that.
> 
> rockchip_pcie_legacy_int_handler() depends on rockchip->irq_domain,
> which isn't initialized until rockchip_pcie_init_irq_domain().
> Previously we registered rockchip_pcie_legacy_int_handler() as the
> handler for the "legacy" IRQ before rockchip_pcie_init_irq_domain().
> 
> I think your patch *also* fixes that problem, right?

The lack of consistency in how we use
irq_set_chained_handler_and_data() really bugs me.

Your patch fixes the ordering issue where we installed
rockchip_pcie_legacy_int_handler() before initializing data
(rockchip->irq_domain) that it depends on.

But AFAICT, rockchip still has the problem that we don't *unregister*
rockchip_pcie_legacy_int_handler() when the rockchip-pcie module is
removed.  Doesn't this mean that if we unload the module, then receive 
an interrupt from the device, we'll try to call a function that is no
longer present?

> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index f1d08a1b159..78d04ac29cd 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -592,10 +592,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
> >  	if (err)
> >  		return err;
> >  
> > -	err = rockchip_pcie_setup_irq(rockchip);
> > -	if (err)
> > -		return err;
> > -
> >  	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
> >  	if (IS_ERR(rockchip->vpcie12v)) {
> >  		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> > @@ -973,8 +969,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >  	if (err)
> >  		goto err_vpcie;
> >  
> > -	rockchip_pcie_enable_interrupts(rockchip);
> > -
> >  	err = rockchip_pcie_init_irq_domain(rockchip);
> >  	if (err < 0)
> >  		goto err_deinit_port;
> > @@ -992,6 +986,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >  	bridge->sysdata = rockchip;
> >  	bridge->ops = &rockchip_pcie_ops;
> >  
> > +	err = rockchip_pcie_setup_irq(rockchip);
> > +	if (err)
> > +		goto err_remove_irq_domain;
> > +
> > +	rockchip_pcie_enable_interrupts(rockchip);
> > +
> >  	err = pci_host_probe(bridge);
> >  	if (err < 0)
> >  		goto err_remove_irq_domain;
> > -- 
> > 2.31.1
> > 
