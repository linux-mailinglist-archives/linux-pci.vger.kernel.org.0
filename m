Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D741275C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhITUjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 16:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhITUhF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 16:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A1E604DC;
        Mon, 20 Sep 2021 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632170138;
        bh=voQEBfP9XzUDzXjG0DL0BLZOIItOzN1mK1/I5iKEvUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CavUB91uBNFDnMchx2C9ZotlZ2lp7cLpSEIrhMu8L5ixnwF1So13GBAG2Nh+Q5hbm
         nXyvIb0HsQqjaLzgzCJwLzGBRa8jHrYs7i1JKhHraTi5sLA5fzrgB+ZZ5PaZvExidK
         Dlab+C+lHdvYWm/UxZcjrP1ZCoA+cg/eB3DYLPv9RkaHlbBR0gdxan5awocdBsrhQ2
         wcmiy6UAl8B8IwNhLuZu+CAIZonGpmKxMUIHoIdewx5w9qWgYlYW1xNrKpDL5XAU5l
         fgqo37Am9WDcRCwVm6ujaOoZXvkuRsmRDGscGvldKxM523PV138P8D8eFnygxyGtAp
         yuLscK4aXPOhQ==
Date:   Mon, 20 Sep 2021 15:35:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/portdrv: Do not setup up IRQs if there are no
 users
Message-ID: <20210920203536.GA37479@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9a13ac-8ab1-15ac-06cb-c131b488a36f@siemens.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 10:08:10AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Avoid registering service IRQs if there is no service that offers them
> or no driver to register a handler against them. This saves IRQ vectors
> when they are limited (e.g. on x86) and also avoids that spurious events
> could hit a missing handler. Such spurious events need to be generated
> by the Jailhouse hypervisor for active MSI vectors when enabling or
> disabling itself.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to pci/portdrv for v5.16, thanks!

> ---
> 
> Changes in v2:
>  - move initialization of irqs to address test bot finding
> 
>  drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed6649c41..0e2556269429 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -166,9 +166,6 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  {
>  	int ret, i;
>  
> -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> -		irqs[i] = -1;
> -
>  	/*
>  	 * If we support PME but can't use MSI/MSI-X for it, we have to
>  	 * fall back to INTx or other interrupts, e.g., a system shared
> @@ -312,8 +309,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   */
>  int pcie_port_device_register(struct pci_dev *dev)
>  {
> -	int status, capabilities, i, nr_service;
> -	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> +	int status, capabilities, irq_services, i, nr_service;
> +	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
> +		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
> +	};
>  
>  	/* Enable PCI Express port device */
>  	status = pci_enable_device(dev);
> @@ -326,18 +325,32 @@ int pcie_port_device_register(struct pci_dev *dev)
>  		return 0;
>  
>  	pci_set_master(dev);
> -	/*
> -	 * Initialize service irqs. Don't use service devices that
> -	 * require interrupts if there is no way to generate them.
> -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
> -	 * that can be used in the absence of irqs.  Allow them to determine
> -	 * if that is to be used.
> -	 */
> -	status = pcie_init_service_irqs(dev, irqs, capabilities);
> -	if (status) {
> -		capabilities &= PCIE_PORT_SERVICE_HP;
> -		if (!capabilities)
> -			goto error_disable;
> +
> +	irq_services = 0;
> +	if (IS_ENABLED(CONFIG_PCIE_PME))
> +		irq_services |= PCIE_PORT_SERVICE_PME;
> +	if (IS_ENABLED(CONFIG_PCIEAER))
> +		irq_services |= PCIE_PORT_SERVICE_AER;
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +		irq_services |= PCIE_PORT_SERVICE_HP;
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +		irq_services |= PCIE_PORT_SERVICE_DPC;
> +	irq_services &= capabilities;
> +
> +	if (irq_services) {
> +		/*
> +		 * Initialize service irqs. Don't use service devices that
> +		 * require interrupts if there is no way to generate them.
> +		 * However, some drivers may have a polling mode (e.g.
> +		 * pciehp_poll_mode) that can be used in the absence of irqs.
> +		 * Allow them to determine if that is to be used.
> +		 */
> +		status = pcie_init_service_irqs(dev, irqs, irq_services);
> +		if (status) {
> +			irq_services &= PCIE_PORT_SERVICE_HP;
> +			if (!irq_services)
> +				goto error_disable;
> +		}
>  	}
>  
>  	/* Allocate child services if any */
> -- 
> 2.31.1
