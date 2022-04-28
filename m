Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B35512FE0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiD1Jt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347537AbiD1Jc7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:32:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED7647CDD9
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 02:29:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B46AD1474;
        Thu, 28 Apr 2022 02:29:45 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81263F774;
        Thu, 28 Apr 2022 02:29:43 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:29:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     daire.mcnamara@microchip.com
Cc:     helgaas@kernel.org, bhelgaas@google.com,
        conor.dooley@microchip.com, cyril.jean@microchip.com,
        maz@kernel.org, david.abdurachmanov@gmail.com,
        linux-pci@vger.kernel.org, robh@kernel.org
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Message-ID: <20220428092937.GA12804@lpieralisi>
References: <20220405111751.166427-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405111751.166427-1-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 05, 2022 at 12:17:51PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Clear MSI bit in ISTATUS register after reading it before
> handling individual MSI bits

That explains nothing. If you are fixing a bug please describe
the issue and how the patch is fixing it.

> This fixes a potential race condition pointed out by Bjorn Helgaas:
> https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
> 
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
> Adding linux-pci mailing list
>  drivers/pci/controller/pcie-microchip-host.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 29d8e81e4181..da8e3fdc97b3 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -416,6 +416,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  
>  	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
>  	if (status & PM_MSI_INT_MSI_MASK) {
> +		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);

What does ISTATUS_LOCAL contain vs ISTATUS_MSI ? If you explain that
to me I could help you write the commit log.

Thanks,
Lorenzo

>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>  		for_each_set_bit(bit, &status, msi->num_vectors) {
>  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
> @@ -432,13 +433,8 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
>  	void __iomem *bridge_base_addr =
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	u32 bitpos = data->hwirq;
> -	unsigned long status;
>  
>  	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> -	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> -	if (!status)
> -		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT),
> -			       bridge_base_addr + ISTATUS_LOCAL);
>  }
>  
>  static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> -- 
> 2.25.1
> 
