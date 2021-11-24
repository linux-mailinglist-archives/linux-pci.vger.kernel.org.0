Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE045C9E9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbhKXQ1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:27:18 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46781 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348524AbhKXQ1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 11:27:17 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6438924000B;
        Wed, 24 Nov 2021 16:24:02 +0000 (UTC)
Date:   Wed, 24 Nov 2021 17:24:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm: ioremap: Replace pci_ioremap_io() usage by
 pci_remap_iospace()
Message-ID: <YZ5nIhtFVgPdNxAj@piout.net>
References: <20211124154116.916-1-pali@kernel.org>
 <20211124154116.916-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124154116.916-5-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/11/2021 16:41:15+0100, Pali Rohár wrote:
> Replace all usage of ARM specific pci_ioremap_io() function by standard PCI
> core API function pci_remap_iospace() in all drivers and arm march code.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/arm/mach-dove/pcie.c    |  9 +++++----
>  arch/arm/mach-iop32x/pci.c   |  5 ++++-
>  arch/arm/mach-mv78xx0/pcie.c |  5 ++++-
>  arch/arm/mach-orion5x/pci.c  | 10 ++++++++--
>  drivers/pcmcia/at91_cf.c     |  6 +++++-
>  5 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> index ee91ac6b5ebf..2a493bdfffc6 100644
> --- a/arch/arm/mach-dove/pcie.c
> +++ b/arch/arm/mach-dove/pcie.c
> @@ -38,6 +38,7 @@ static int num_pcie_ports;
>  static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct pcie_port *pp;
> +	struct resource realio;
>  
>  	if (nr >= num_pcie_ports)
>  		return 0;
> @@ -53,10 +54,10 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
>  
>  	orion_pcie_setup(pp->base);
>  
> -	if (pp->index == 0)
> -		pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE0_IO_PHYS_BASE);
> -	else
> -		pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE1_IO_PHYS_BASE);
> +	realio.start = sys->busnr * SZ_64K;
> +	realio.end = realio.start + SZ_64K - 1;
> +	pci_remap_iospace(&realio, pp->index == 0 ? DOVE_PCIE0_IO_PHYS_BASE :
> +						    DOVE_PCIE1_IO_PHYS_BASE);
>  
>  	/*
>  	 * IORESOURCE_MEM
> diff --git a/arch/arm/mach-iop32x/pci.c b/arch/arm/mach-iop32x/pci.c
> index ab0010dc3145..7a215d2ee7e2 100644
> --- a/arch/arm/mach-iop32x/pci.c
> +++ b/arch/arm/mach-iop32x/pci.c
> @@ -185,6 +185,7 @@ iop3xx_pci_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  int iop3xx_pci_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct resource *res;
> +	struct resource realio;
>  
>  	if (nr != 0)
>  		return 0;
> @@ -206,7 +207,9 @@ int iop3xx_pci_setup(int nr, struct pci_sys_data *sys)
>  
>  	pci_add_resource_offset(&sys->resources, res, sys->mem_offset);
>  
> -	pci_ioremap_io(0, IOP3XX_PCI_LOWER_IO_PA);
> +	realio.start = 0;
> +	realio.end = realio.start + SZ_64K - 1;
> +	pci_remap_iospace(&realio, IOP3XX_PCI_LOWER_IO_PA);
>  
>  	return 1;
>  }
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index 636d84b40466..e15646af7f26 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -101,6 +101,7 @@ static void __init mv78xx0_pcie_preinit(void)
>  static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct pcie_port *pp;
> +	struct resource realio;
>  
>  	if (nr >= num_pcie_ports)
>  		return 0;
> @@ -115,7 +116,9 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
>  	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
>  	orion_pcie_setup(pp->base);
>  
> -	pci_ioremap_io(nr * SZ_64K, MV78XX0_PCIE_IO_PHYS_BASE(nr));
> +	realio.start = nr * SZ_64K;
> +	realio.end = realio.start + SZ_64K - 1;
> +	pci_remap_iospace(&realio, MV78XX0_PCIE_IO_PHYS_BASE(nr));
>  
>  	pci_add_resource_offset(&sys->resources, &pp->res, sys->mem_offset);
>  
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 76951bfbacf5..92e938bba20d 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -142,6 +142,7 @@ static struct pci_ops pcie_ops = {
>  static int __init pcie_setup(struct pci_sys_data *sys)
>  {
>  	struct resource *res;
> +	struct resource realio;
>  	int dev;
>  
>  	/*
> @@ -164,7 +165,9 @@ static int __init pcie_setup(struct pci_sys_data *sys)
>  		pcie_ops.read = pcie_rd_conf_wa;
>  	}
>  
> -	pci_ioremap_io(sys->busnr * SZ_64K, ORION5X_PCIE_IO_PHYS_BASE);
> +	realio.start = sys->busnr * SZ_64K;
> +	realio.end = realio.start + SZ_64K - 1;
> +	pci_remap_iospace(&realio, ORION5X_PCIE_IO_PHYS_BASE);
>  
>  	/*
>  	 * Request resources.
> @@ -466,6 +469,7 @@ static void __init orion5x_setup_pci_wins(void)
>  static int __init pci_setup(struct pci_sys_data *sys)
>  {
>  	struct resource *res;
> +	struct resource realio;
>  
>  	/*
>  	 * Point PCI unit MBUS decode windows to DRAM space.
> @@ -482,7 +486,9 @@ static int __init pci_setup(struct pci_sys_data *sys)
>  	 */
>  	orion5x_setbits(PCI_CMD, PCI_CMD_HOST_REORDER);
>  
> -	pci_ioremap_io(sys->busnr * SZ_64K, ORION5X_PCI_IO_PHYS_BASE);
> +	realio.start = sys->busnr * SZ_64K;
> +	realio.end = realio.start + SZ_64K - 1;
> +	pci_remap_iospace(&realio, ORION5X_PCI_IO_PHYS_BASE);
>  
>  	/*
>  	 * Request resources
> diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
> index 6b1edfc890a3..92df2c2c5d07 100644
> --- a/drivers/pcmcia/at91_cf.c
> +++ b/drivers/pcmcia/at91_cf.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pci.h>
>  #include <linux/regmap.h>
>  
>  #include <pcmcia/ss.h>
> @@ -230,6 +231,7 @@ static int at91_cf_probe(struct platform_device *pdev)
>  	struct at91_cf_socket	*cf;
>  	struct at91_cf_data	*board;
>  	struct resource		*io;
> +	struct resource		realio;
>  	int			status;
>  
>  	board = devm_kzalloc(&pdev->dev, sizeof(*board), GFP_KERNEL);
> @@ -307,7 +309,9 @@ static int at91_cf_probe(struct platform_device *pdev)
>  	 * io_offset is set to 0x10000 to avoid the check in static_find_io().
>  	 * */
>  	cf->socket.io_offset = 0x10000;
> -	status = pci_ioremap_io(0x10000, cf->phys_baseaddr + CF_IO_PHYS);
> +	realio.start = cf->socket.io_offset;
> +	realio.end = realio.start + SZ_64K - 1;
> +	status = pci_remap_iospace(&realio, cf->phys_baseaddr + CF_IO_PHYS);
>  	if (status)
>  		goto fail0a;
>  
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
