Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55B573169
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiGMIpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGMIpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:45:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC86BFAC4
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:44:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBXzI-00051F-1d; Wed, 13 Jul 2022 10:44:52 +0200
Message-ID: <cf3ee1c46da73693a05ecc81ddd3bf81d4d8f185.camel@pengutronix.de>
Subject: Re: [PATCH v14 12/17] PCI: imx6: Mark the link down as non-fatal
 error
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:44:50 +0200
In-Reply-To: <1656645935-1370-13-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-13-git-send-email-hongxing.zhu@nxp.com>
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
> Let the driver probe successfully, return zero in imx6_pcie_start_link()
> when PCIe link is down.
> 
> Link: https://lore.kernel.org/r/1655189942-12678-7-git-send-email-hongxing.zhu@nxp.com
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0b168f0d57b8..e236f824c808 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -836,7 +836,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>  
> -	dw_pcie_wait_for_link(pci);
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_reset_phy;
>  
>  	if (pci->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */
> @@ -872,7 +874,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		}
>  
>  		/* Make sure link training is finished as well! */
> -		dw_pcie_wait_for_link(pci);
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_reset_phy;
>  	} else {
>  		dev_info(dev, "Link: Gen2 disabled\n");
>  	}
> @@ -886,7 +890,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> -	return ret;
> +	return 0;
>  }
>  
>  static int imx6_pcie_host_init(struct pcie_port *pp)


