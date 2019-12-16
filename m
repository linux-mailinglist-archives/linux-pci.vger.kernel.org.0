Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528FC1204DA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLPMGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 07:06:11 -0500
Received: from foss.arm.com ([217.140.110.172]:52540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfLPMGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 227761063;
        Mon, 16 Dec 2019 04:06:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F1CE3F719;
        Mon, 16 Dec 2019 04:06:09 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:07 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: rcar: Fix incorrect programming of OB windows
Message-ID: <20191216120607.GV24359@e119886-lin.cambridge.arm.com>
References: <20191004132941.6660-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004132941.6660-1-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 02:29:41PM +0100, Andrew Murray wrote:
> The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
> a CPU address (which is determined by the window number 'x') and a
> programmed PCI address - Thus allowing the controller to translate CPU
> accesses into PCI accesses.
> 
> However the existing code incorrectly writes the CPU address - lets fix
> this by writing the PCI address instead.
> 
> For memory transactions, existing DT users describe a 1:1 identity mapping
> and thus this change should have no effect. However the same isn't true for
> I/O.
> 
> Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> ---
> This hasn't been tested, so keen for someone to give it a try.
> 
> Also keen for someone to confirm my understanding that the RCar windows
> expect PCI addresses and that res->start refers to CPU addresses. If this
> is correct then it's possible the I/O doesn't work correctly.

Marek/Yoshihiro - any feedback on this?

Thanks,

Andrew Murray

> ---
>  drivers/pci/controller/pcie-rcar.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index f6a669a9af41..b28d726b4aba 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -332,11 +332,12 @@ static struct pci_ops rcar_pcie_ops = {
>  };
>  
>  static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
> -				   struct resource *res)
> +				   struct resource_entry *window)
>  {
>  	/* Setup PCIe address space mappings for each resource */
>  	resource_size_t size;
>  	resource_size_t res_start;
> +	struct resource *res = window->res;
>  	u32 mask;
>  
>  	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> @@ -350,9 +351,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
>  	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
>  
>  	if (res->flags & IORESOURCE_IO)
> -		res_start = pci_pio_to_address(res->start);
> +		res_start = pci_pio_to_address(res->start) - window->offset;
>  	else
> -		res_start = res->start;
> +		res_start = res->start - window->offset;
>  
>  	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
>  	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> @@ -381,7 +382,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
>  		switch (resource_type(res)) {
>  		case IORESOURCE_IO:
>  		case IORESOURCE_MEM:
> -			rcar_pcie_setup_window(i, pci, res);
> +			rcar_pcie_setup_window(i, pci, win);
>  			i++;
>  			break;
>  		case IORESOURCE_BUS:
> -- 
> 2.21.0
> 
