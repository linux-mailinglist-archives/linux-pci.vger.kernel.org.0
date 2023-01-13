Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA1669C18
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjAMP2h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 10:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjAMP2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 10:28:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795080AF8;
        Fri, 13 Jan 2023 07:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F78D6216C;
        Fri, 13 Jan 2023 15:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBBBC433D2;
        Fri, 13 Jan 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623306;
        bh=SY8pBPoQTNbHRLf2rJIor5xp42/a0AI7mV21kU2mDAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tr0kONao44o0PAxUUqzdkC7Xdl9HnbfzeGE0G8LbsgDuEc1wnhtuc/82b4efJZo0H
         DxstI4zxh7FECHxv+PACaJlhSYUDuHnihXxVvzvserY8g+qIpUH8qroR5y7hWCub3E
         VD1JYg+eI8FAVC14bYPo/VJ3yrxJaGvkX0v6WcomuxMM/Q7KxNXAZie88cA8spD4et
         f9AQ1yx0zlXMs1YjGzeQGZktJtA5PlVR45iL1lP3Muqw68Un/KgL634GLaVF6gGeLI
         XY3cvWi3AzzbIxHug7qtdvob4gsVcUUBfRzNijseS/Lfl5nyTLxV4Z7ByvULedAksQ
         HuSM7bBpLqAqg==
Date:   Fri, 13 Jan 2023 16:21:38 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 11/21] PCI: tegra194: Remove IRQF_ONESHOT flag during
 Endpoint interrupt registration
Message-ID: <Y8F3AuEk75TNO4+3@lpieralisi>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-12-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-12-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 12:08:44AM +0530, Vidya Sagar wrote:
> Tegra PCIe endpoint has a common interrupt that notifies hardware events
> like link up, LTR send, etc. DMA completion event is also notified over
> this interrupt. Remove IRQF_ONESHOT flag from interrupt registration and
> allow DMA driver to share this interrupt.

I don't understand the rationale behind this change, please elaborate
on it.

Thanks,
Lorenzo

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * This is a new patch in this series
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 7820bf4b9786..786e5d5f43b9 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2354,7 +2354,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		ret = devm_request_threaded_irq(dev, pp->irq,
>  						tegra_pcie_ep_hard_irq,
>  						tegra_pcie_ep_irq_thread,
> -						IRQF_SHARED | IRQF_ONESHOT,
> +						IRQF_SHARED,
>  						"tegra-pcie-ep-intr", pcie);
>  		if (ret) {
>  			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
> -- 
> 2.17.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
