Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9D627D35
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiKNL7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiKNL6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226061EC70;
        Mon, 14 Nov 2022 03:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC3D0B80E76;
        Mon, 14 Nov 2022 11:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20809C433C1;
        Mon, 14 Nov 2022 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426996;
        bh=iEuhISiKu9TyOYC1q42LdxS2ugKsD/1nYpC0/lFEspM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awn9M8Ha3m+1PM+hnLVyJDH9rvb/bfA5YlwPpGee/rTCatnakvBELNt50JNC+xdhZ
         j6Y/0o3+X6qrgMytd1xErEmvQo50hjh8r6J259u9Mcdgz9O60gmucT62xwSjb1gUU1
         eChAnNc0X5XSCnx8dKiT0kIJi/YH5Cmd4FtzpYTFDfWJsnxTRtGRTt5LjbMJgvA5QW
         RJLV+IOEDIMGmGCqIVUiuLeyVkr4Gk0gs9aS9jn2Y6T9WEUeuSLhyUmSBJrtGiE4ln
         n4QPHbc0/nWSDX2Gq2WRNqviw2nFWY7Vr7y185ck/fqgpmpqg9HuXJomIgFOU632be
         m4QfJjU7Dyg1g==
Date:   Mon, 14 Nov 2022 12:56:27 +0100
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
Message-ID: <Y3Is61WPyzLCjlKK@lpieralisi>
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

Please give a clearer explanation of why this is safe and the reasoning
behind this change.

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
