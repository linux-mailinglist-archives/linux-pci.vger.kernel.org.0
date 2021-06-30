Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713543B88DA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhF3TBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 15:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhF3TBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jun 2021 15:01:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25CFF613DF;
        Wed, 30 Jun 2021 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625079564;
        bh=+Qoi6zaLjN1sx/hHLl2ILKRfVIWSzyopQklvN1Izyu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sw9/2/1gN72JQ0kM1tTNHVuDPXymLqQ65jUUva/SL4uRF4yovOUUAzz4MwF/ljksR
         O2Sb3P6Z4xg+KXbamWozGCqigXjTFa9QpMisIwSzyrNXyDO7o/l8TXDAlWeR3riihy
         AYdHn29UotCsQ6qXOtYLd070CWeCYLicc8Q+1pUJdQYgZMvPyAvavzAMiHOoAObOSk
         v3z6olvK+j2UVAzYLWfgqi3qonfnIurxMkvIDs+BrFnLPajetU8Jx91uA8kOHBpJDH
         1SaEh73Apjs61DGAmi+b7qESo6w8fE9E/mx3pgbQBAH5geEMnxm2sET/7dWqRiQiae
         nheBUdcbkhu8A==
Date:   Wed, 30 Jun 2021 13:59:22 -0500
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
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210630185922.GA4170992@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608080409.1729276-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Michal, Jingoo, Thierry, Jonathan]

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
> 
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
> 
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

I think the above commit log is perfectly accurate, but all the
details might suggest that this is something specific to rockchip or
CONFIG_DEBUG_SHIRQ, which it isn't, and they might obscure the
fundamental problem, which is actually very simple: we registered IRQ
handlers before we were ready for them to be called.

I propose the following commit log in the hope that it would help
other driver authors to make similar fixes:

    PCI: rockchip: Register IRQ handlers after device and data are ready

    An IRQ handler may be called at any time after it is registered, so
    anything it relies on must be ready before registration.

    rockchip_pcie_subsys_irq_handler() and rockchip_pcie_client_irq_handler()
    read registers in the PCIe controller, but we registered them before
    turning on clocks to the controller.  If either is called before the clocks
    are turned on, the register reads fail and the machine hangs.

    Similarly, rockchip_pcie_legacy_int_handler() uses rockchip->irq_domain,
    but we installed it before initializing irq_domain.

    Register IRQ handlers after their data structures are initialized and
    clocks are enabled.

If this is inaccurate or omits something important, let me know.  I
can make any updates locally.

Bjorn

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
