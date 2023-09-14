Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45F7A0F09
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjINUcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjINUb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 16:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C8271C;
        Thu, 14 Sep 2023 13:31:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BACC433C7;
        Thu, 14 Sep 2023 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694723508;
        bh=89k015Gz7Ucfa7Gt/0hyjJ/9BQs4PGxPaTPa/kgHOS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E+YofmZcXE0gNWkZ+7cHh1uL2cmTO+OXsR/gPC2Vf7IIbQ1qtlYtv65NFq+GwLfeP
         pZtoTJ4oCVBoo4aPXjjL/2fnW4iGhh29WccaG2lGZOskJHlyJgYHvxUMq4xgZstrVp
         xIJ9P0iTqPq+h68UbGt1YqwdWh7a7tGlgwIAx0NznoSwSHme6VKdFbtzjTZEltU8w9
         IlL1yFx6ul2W/rI+tZyUdNLxA8FAQLd1Q9ZqFUHLasBvxuMEw4H9e277d3Q+f8PKgJ
         EcTl7Lx1ryd6T6tr6Lo+rm7/BfMcR+lSbQubtWVL/+A8aJ8T6L6ZYgdd04OqoQbkBx
         nledCokN4sPfQ==
Date:   Thu, 14 Sep 2023 15:31:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] PCI: mediatek: Correct type for virt_to_phys()
Message-ID: <20230914203146.GA77870@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914192324.672997-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 10:23:24PM +0300, Andy Shevchenko wrote:
> virt_to_phys() takes a regular pointer, while driver supplies __iomem
> annotated one. Force type to void to make sparse happy, otherwise
> 
>    pcie-mediatek.c:400:40: sparse:     expected void volatile *address
>    pcie-mediatek.c:400:40: sparse:     got void [noderef] __iomem *
> 
>    pcie-mediatek.c:523:44: sparse:     expected void volatile *address
>    pcie-mediatek.c:523:44: sparse:     got void [noderef] __iomem *
> 
> Reported-by: Huacai Chen <chenhuacai@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 66a8f73296fc..5e795afd1cee 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	phys_addr_t addr;
>  
>  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +	addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);

Lots of these drivers use either virt_to_phys() or
platform_get_resource_byname() to get a physical address that they
then use as the MSI target.

But I don't think that's quite right -- the MSI is a DMA transaction
on PCI, and in general there's no guarantee that bus addresses are
identical to CPU physical addresses, so shouldn't we use a dma_addr_t
obtained from the DMA API?

dw_pcie_msi_host_init() has a complicated version of this that uses
dmam_alloc_coherent().

>  	msg->address_hi = 0;
>  	msg->address_lo = lower_32_bits(addr);
>  
> @@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>  	u32 val;
>  	phys_addr_t msg_addr;
>  
> -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +	msg_addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);
>  	val = lower_32_bits(msg_addr);
>  	writel(val, port->base + PCIE_IMSI_ADDR);
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
