Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD6573176
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiGMIsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiGMIsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:48:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6DECAF32
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:48:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBY2F-0005W2-6u; Wed, 13 Jul 2022 10:47:55 +0200
Message-ID: <26d5e056c4b4779293b79012468f2ac821f4c06c.camel@pengutronix.de>
Subject: Re: [PATCH v14 13/17] PCI: imx6: Reduce resume time by only
 starting link if it was up before suspend
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:47:54 +0200
In-Reply-To: <1656645935-1370-14-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-14-git-send-email-hongxing.zhu@nxp.com>
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
> Because i.MX PCIe doesn't support hot-plug feature.  In the link down
> scenario, only start the PCIe link training in resume when the link is up
> before system suspend to avoid the long latency in the link training
> period.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e236f824c808..5a06fbca82d6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -67,6 +67,7 @@ struct imx6_pcie {
>  	struct dw_pcie		*pci;
>  	int			reset_gpio;
>  	bool			gpio_active_high;
> +	bool			link_is_up;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie_inbound_axi;
> @@ -881,11 +882,13 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dev_info(dev, "Link: Gen2 disabled\n");
>  	}
>  
> +	imx6_pcie->link_is_up = true;
>  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
>  
>  err_reset_phy:
> +	imx6_pcie->link_is_up = false;
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> @@ -1032,9 +1035,8 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  		return ret;
>  	dw_pcie_setup_rc(pp);
>  
> -	ret = imx6_pcie_start_link(imx6_pcie->pci);
> -	if (ret < 0)
> -		dev_info(dev, "pcie link is down after resume.\n");
> +	if (imx6_pcie->link_is_up)
> +		imx6_pcie_start_link(imx6_pcie->pci);

While the change itself is correct, the removal of the return value
check should be added to the previous patch, as that's the point where
you change this function to always return 0, rendering this check
pointless.

Regards,
Lucas

>  
>  	return 0;
>  }


