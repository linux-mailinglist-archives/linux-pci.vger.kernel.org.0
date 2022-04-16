Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F95036A8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiDPM53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDPM50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 08:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D62CFD;
        Sat, 16 Apr 2022 05:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5D9B82414;
        Sat, 16 Apr 2022 12:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1004AC385A9;
        Sat, 16 Apr 2022 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650113690;
        bh=xCuTqUs63ZsLODIiKALgWLXL62HgRn4l8lLnL2RaPR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrjMf1G9zv/dwRXRnAOje45QlIhPHl9czj0eEdjD8YGB4T22bS8hxO5b/J+AACPgx
         YNmog9tgZFajduve6W6wB2DqT3Q7C+86QH7b8DJeeA0C1Wkw6cOB12YK3w1U8PMspb
         opuD6O+lGB6puqJedic806LtCnznMpmdTT330EcWjRU/8UEbKq1BBC61T8TsIvNlvZ
         a0v3Q+D/X9GvgDwrObgXMY2c8BHoKY/f368EonoHmPvVLKTeKNxe0To9ihg041xQXq
         UKeg/hgOt6W6QAhw+nBrUorKi8ij/EMizTWoTLyNgeC9kUJdTA2XNFzS/KK3W2fSqI
         z0E/rjui8juCA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nfhwt-004kNm-Ql; Sat, 16 Apr 2022 13:54:49 +0100
MIME-Version: 1.0
Date:   Sat, 16 Apr 2022 13:54:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] PCI: dwc: rockchip: add legacy interrupt support
In-Reply-To: <20220416110507.642398-3-pgwipeout@gmail.com>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
 <20220416110507.642398-3-pgwipeout@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pgwipeout@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com, bhelgaas@google.com, heiko@sntech.de, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Peter,

May I suggest that you slow down on the number of versions you send?
This is the 7th in 5 days, the 3rd today.

At this stage, this is entirely counterproductive.

On 2022-04-16 12:05, Peter Geis wrote:
> The legacy interrupts on the rk356x pcie controller are handled by a
> single muxed interrupt. Add irq domain support to the pcie-dw-rockchip
> driver to support the virtual domain.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c9b341e55cbb..863374604fb1 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -10,9 +10,12 @@
> 
>  #include <linux/clk.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -36,10 +39,13 @@
>  #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>  #define PCIE_L0S_ENTRY			0x11
>  #define PCIE_CLIENT_GENERAL_CONTROL	0x0
> +#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> +#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>  #define PCIE_CLIENT_GENERAL_DEBUG	0x104
> -#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> +#define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define PCIE_CLIENT_LTSSM_STATUS	0x300
> -#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> +#define PCIE_LEGACY_INT_ENABLE		GENMASK(3, 0)
> +#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>  #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
> 
>  struct rockchip_pcie {
> @@ -51,6 +57,8 @@ struct rockchip_pcie {
>  	struct reset_control		*rst;
>  	struct gpio_desc		*rst_gpio;
>  	struct regulator                *vpcie3v3;
> +	struct irq_domain		*irq_domain;
> +	raw_spinlock_t			irq_lock;
>  };
> 
>  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> @@ -65,6 +73,94 @@ static void rockchip_pcie_writel_apb(struct
> rockchip_pcie *rockchip,
>  	writel_relaxed(val, rockchip->apb_base + reg);
>  }
> 
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
> +	unsigned long reg, hwirq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	reg = rockchip_pcie_readl_apb(rockchip, 
> PCIE_CLIENT_INTR_STATUS_LEGACY);
> +
> +	for_each_set_bit(hwirq, &reg, 8)

8? And yet:

#define PCI_NUM_INTX        4

So whatever bits are set above bit 3, you are feeding garbage
to the irqdomain code.

> +		generic_handle_domain_irq(rockchip->irq_domain, hwirq);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void rockchip_intx_mask(struct irq_data *data)
> +{
> +	struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 val;
> +
> +	/* disable legacy interrupts */
> +	raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
> +	val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
> +	val |= PCIE_LEGACY_INT_ENABLE;
> +	rockchip_pcie_writel_apb(rockchip, val, 
> PCIE_CLIENT_INTR_MASK_LEGACY);
> +	raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);

This is completely busted. INTx lines must be controlled individually.
If I disable one device's INTx output, I don't want to see the
interrupt firing because another one has had its own enabled.

         M.
-- 
Jazz is not dead. It just smells funny...
