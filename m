Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709E7669C87
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAMPgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAMPfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 10:35:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D2A1805;
        Fri, 13 Jan 2023 07:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D97FB820D2;
        Fri, 13 Jan 2023 15:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9E2C433EF;
        Fri, 13 Jan 2023 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623741;
        bh=0F5BGpRsAhTyUDS+p9XLf5M6oCxZt8EqZJMiDBtQUDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MekYq8puj8d38lB62dIIhfQ0htdD0Zmrry3w1pLRDZ2Rfd7J5A+r/BQYSEqimbh+e
         ZZtiEOEDIh8YxmzV9bjttoArpqfS0BCGCE1aQQmbWRW9l6h6ykE0SrGk0R47gn0RyK
         oI8WCuSd2toejsUsGC3VP1o1gsmh/XfxTcnB4uMjFkz/+44uqcAqgJ5F6QwxR0/uCZ
         28bGKNMHYxF8CbWb6QAJBAJXMvNb9mr2pDUtWpkYSJRhC4IRS1dQH5Dq8gnotBCKc1
         1dyADUNHIsJfkKPpFJ3yLsRzYpkO3nVeOlZoW/cp/9QGWD4A0PVA/63Ks679Coo1Yt
         OaFr1y6re5UZA==
Date:   Fri, 13 Jan 2023 16:28:54 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 19/21] PCI: tegra194: Free up EP resources during
 remove()
Message-ID: <Y8F4tucf4U7wxaFp@lpieralisi>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-20-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-20-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 12:08:52AM +0530, Vidya Sagar wrote:
> Free up the resources during remove() that were acquired by the DesignWare
> driver for the endpoint mode during proble().

s/proble/probe

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * This is a new patch in this series
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 3baf1a26fe68..c88c36d85ee5 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2383,6 +2383,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  static int tegra_pcie_dw_remove(struct platform_device *pdev)
>  {
>  	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  
>  	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
>  		if (!pcie->link_state && !pcie->slot_pluggable)
> @@ -2396,6 +2397,7 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
>  	} else {
>  		disable_irq(pcie->pex_rst_irq);
>  		pex_ep_event_pex_rst_assert(pcie);
> +		dw_pcie_ep_exit(ep);
>  	}
>  
>  	pm_runtime_disable(pcie->dev);
> -- 
> 2.17.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
