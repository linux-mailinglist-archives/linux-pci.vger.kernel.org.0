Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1B5731C6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiGMI7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiGMI7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:59:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D3B9DBF
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:59:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBYDQ-0007UX-8v; Wed, 13 Jul 2022 10:59:28 +0200
Message-ID: <775a3b0f9ceb26297565c5513cf41a5938817e8b.camel@pengutronix.de>
Subject: Re: [PATCH v14 15/17] PCI: imx6: Disable clocks in reverse order of
 enable
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:59:27 +0200
In-Reply-To: <1656645935-1370-16-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-16-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 01.07.2022 um 11:25 +0800 schrieb Richard Zhu:
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
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0b2a5256fb0d..79a05e190016 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -655,10 +655,10 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
> +	imx6_pcie_disable_ref_clk(imx6_pcie);
>  	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -	imx6_pcie_disable_ref_clk(imx6_pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
>  }
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)


