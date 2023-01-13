Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A30669C99
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjAMPkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 10:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjAMPjy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 10:39:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2B81439;
        Fri, 13 Jan 2023 07:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1133B82176;
        Fri, 13 Jan 2023 15:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC1C433D2;
        Fri, 13 Jan 2023 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623895;
        bh=ld/JC3MDX643nDYZTH91vPHFhEqhIDAmDfqRY+zkWLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7OJf/XvFInmNZK2gZ7Ja7rD+MD1VA5g35Kf/Zl0h02zAVvvvgGTCKWTj30NF0Uqo
         yJfqXP6cE/mA4ddrrJpSh+Ybyu+rJKgxmlio1nLh4tz45UMWFoHuE0Adp/BxdMEHh4
         J1mktqIXkRgd78zMQ3UsxrwZn8IyAi31/GO1JWb21MTEijPkUTEdF+Bvvp3tcji5OV
         5BE8BYyVe/Pxgl5gEDwm3LlApp7Y6Ey78zzB5uX5tRpHIJ3beiZ7I39yPnf3k481Gp
         vv+yrZpr/y8hqFVyOtTUoTRVWL8DCdplz83nQFSq09Dbmyt3JzSEnxxhSRr0njBkFh
         9XBTT+gRWNwDA==
Date:   Fri, 13 Jan 2023 16:31:26 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 17/21] PCI: tegra194: Reduce AXI slave timeout value
Message-ID: <Y8F5TmgRwItQrRLW@lpieralisi>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-18-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-18-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 12:08:50AM +0530, Vidya Sagar wrote:
> Reduce the AXI slave timeout value to 7ms to be in line with the CBB

It would be good to understand where this 7ms delay comes from.

Please spell out what CBB is.

> logic's timeout value and to avoid CBB reporting errors because of no
> response from the PCIe IPs AXI slave logic for configuration space accesses
> through ECAM when the PCIe link is down. Also, set the Completion Timeout
> value to Range-A: 1ms~10ms to be inline with the AXI timeout value.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * This is a new patch in this series
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 23ca97401339..7890e0c0c0d2 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -198,6 +198,12 @@
>  #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFFFFFF	1
>  #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001	2
>  
> +#define PORT_LOGIC_AMBA_LINK_TIMEOUT		0x8D4
> +#define AMBA_LINK_TIMEOUT_PERIOD_MASK		GENMASK(7, 0)
> +#define AMBA_LINK_TIMEOUT_PERIOD_VAL		0x7
> +
> +#define PCI_EXP_DEVCTL2_CPL_TO_VAL		0x2 /* Range-A: 1ms to 10ms */
> +
>  #define MSIX_ADDR_MATCH_LOW_OFF			0x940
>  #define MSIX_ADDR_MATCH_LOW_OFF_EN		BIT(0)
>  #define MSIX_ADDR_MATCH_LOW_OFF_MASK		GENMASK(31, 2)
> @@ -922,6 +928,18 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  		AMBA_ERROR_RESPONSE_CRS_SHIFT);
>  	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
>  
> +	/* Reduce the AXI slave Timeout value to 7ms */
> +	val  = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_LINK_TIMEOUT);
> +	val &= ~AMBA_LINK_TIMEOUT_PERIOD_MASK;
> +	val |= AMBA_LINK_TIMEOUT_PERIOD_VAL;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_LINK_TIMEOUT, val);
> +
> +	/* Set the Completion Timeout value in 1ms~10ms range */
> +	val_16  = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2);
> +	val_16 &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
> +	val_16 |= PCI_EXP_DEVCTL2_CPL_TO_VAL;
> +	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2, val_16);
> +
>  	/* Configure Max lane width from DT */
>  	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
>  	val &= ~PCI_EXP_LNKCAP_MLW;
> @@ -1988,6 +2006,12 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>  	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>  
> +	/* Set the Completion Timeout value in 1ms~10ms range */
> +	val_16  = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2);
> +	val_16 &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
> +	val_16 |= PCI_EXP_DEVCTL2_CPL_TO_VAL;
> +	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2, val_16);
> +
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
>  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> -- 
> 2.17.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
