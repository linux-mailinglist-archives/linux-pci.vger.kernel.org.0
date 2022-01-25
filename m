Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0244A49B97D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbiAYQ7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 11:59:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38048 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587075AbiAYQ55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 11:57:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00110B81910;
        Tue, 25 Jan 2022 16:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D488C340E0;
        Tue, 25 Jan 2022 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643129869;
        bh=6XkwXgsw19qj7USLrufn0h/tjB7gak8V19SNDIbm7V8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LJ678dooB3UE1J+39GaMMyngBcQRH9jk6vt/5V1WPObw1WTcNf87X/MvOI02+KCsk
         ZSGZbwVHwrnXd5ybU5Caxd0VIqT6wHtu7sshlroYRQHKp1zinrqKA6QIUZMONlsOrH
         jxPNE1B1lqteRYJ0ePeUInqCQs0p0uuITFc37fJlRN87P+q8s1W2GGk3UN8SgYxxkI
         S/f4p1PTvgTGq/tpMhI6MHdjFZi5QsIq3xkZKXNJ+B+yFExbGB1F3PC+AL+jJO0Nl8
         QGkStm965gjNBUgErdUUe00An9cLRjJYjawdvvi79/WnvnMXB+in8AV0A9yVPGpsVR
         hCtO/WYvAK7DQ==
Date:   Tue, 25 Jan 2022 10:57:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com
Subject: Re: [PATCH] PCI: mediatek: Change MSI interrupt processing sequence
Message-ID: <20220125165748.GA1458116@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123033306.29799-1-qizhong.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All patches change *something*.  Can you update the subject line so it
says something specific about the change?

Maybe something like "Clear MSI status before dispatching handler"?

On Sun, Jan 23, 2022 at 11:33:06AM +0800, qizhong cheng wrote:
> As an edge-triggered interrupts, its interrupt status should be cleared
> before dispatch to the handler of device.

I'm not an IRQ expert, but the reasoning that "we should clear the MSI
interrupt status before dispatching the handler because MSI is an
edge-triggered interrupt" doesn't seem completely convincing because
your code will now look like this:

  /* Clear the INTx */
  writel(1 << bit, port->base + PCIE_INT_STATUS);
  generic_handle_domain_irq(port->irq_domain, bit - INTX_SHIFT);
  ...

  /* Clear MSI interrupt status */
  writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
  generic_handle_domain_irq(port->inner_domain, bit);

You clear interrupt status before dispatching the handler for *both*
level-triggered INTx interrupts and edge-triggered MSI interrupts.

So it doesn't seem that simply being edge-triggered is the critical
factor here.

> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2f3f974977a3..705ea33758b1 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -624,12 +624,12 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>  		if (status & MSI_STATUS){
>  			unsigned long imsi_status;
>  
> +			/* Clear MSI interrupt status */
> +			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM)
>  					generic_handle_domain_irq(port->inner_domain, bit);
>  			}
> -			/* Clear MSI interrupt status */
> -			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  		}
>  	}
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
