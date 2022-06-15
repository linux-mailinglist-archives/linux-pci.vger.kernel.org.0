Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE554D541
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbiFOX1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbiFOX1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C0EE02;
        Wed, 15 Jun 2022 16:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52BB61A00;
        Wed, 15 Jun 2022 23:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D8EC3411A;
        Wed, 15 Jun 2022 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655335666;
        bh=rNd+ed0/ZgQdjtq0ZRFbmvnuF7uSzZ+V1F5cjnwA7iQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SKS7Q2bNAtb58r+0wzFHVvCiBpPJENbGnzNdyPtVpGcJdG280jgLfsmVl2MRL709R
         E9ts2mjzDdlffZEze7T/nEKRaRFCFimjVOcZDyZ1C7F85Ho+kAfiNJIkeTU7hbe9Fq
         NoUynlaR9NeTII6B5tX3iO/O4RMEC8wvve9UgCnbnQFQt7/EQr+GG49GRnMzHyBKxv
         CZ96jhl89RJgYbdibi8O58QPvtlTBGTcysiugMHkjWcAR/3JWjbEOr8CLuL6x1wo2o
         heWkCTYjlEiOmSU+2u968otODR/iwtrsU4ECpYMzzXCKG+yHYfWUSKbl4xuy4wOglx
         T4EXho0rTxUyg==
Date:   Wed, 15 Jun 2022 18:27:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 13/13] PCI: imx6: Disable clocks in reverse order of
 enable
Message-ID: <20220615232744.GA1055943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615231551.1054753-14-helgaas@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:15:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> imx6_pcie_clk_enable() enables clocks in the order:
> 
>   pcie_phy
>   pcie_bus
>   pcie
>   imx6_pcie_enable_ref_clk
> 
> Change imx6_pcie_clk_disable() to disable them in the reverse order.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bd736aff94a3..738b5a732cef 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -655,10 +655,10 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
>  	imx6_pcie_disable_ref_clk(imx6_pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);

Please comment on this.  I have no actual information that this is the
right thing, but normally we disable things in the reverse order that
we enabled them.

And the error path of imx6_pcie_deassert_core_reset() definitely
disables pcie, pcie_bus, pcie_phy in that order, so it seems
reasonable to do the same here.

>  }
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
