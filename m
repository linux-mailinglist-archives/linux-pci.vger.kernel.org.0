Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356E4DAD7F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbiCPJaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354895AbiCPJat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 05:30:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22665421
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 02:29:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nUPyG-00087P-5w; Wed, 16 Mar 2022 10:29:32 +0100
Message-ID: <2e4f1fa1add244b12954970b3c02cbe503176a26.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device
 present
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 16 Mar 2022 10:29:29 +0100
In-Reply-To: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
References: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
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

Am Donnerstag, dem 24.02.2022 um 11:06 +0800 schrieb Richard Zhu:
> The CLKREQ# signal is an open drain, active low signal that is driven
> low by the remote Endpoint device. But it might not be driven low if no
> Endpoint device is connected.
> 
> On i.MX8MM PCIe, phy_init() may fail and system boot may hang if no
> Endpoint is connected to assert CLKREQ#.
> 
> Handle this as on i.MX8MQ, where we explicitly assert CLKREQ# so the
> PHY can be initialized.
> 
> Fixes: 178e244cb6e2 ("PCI: imx: Add the imx8mm pcie support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 78e32a539060..168cb1287ba9 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -447,10 +447,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX7D:
>  		break;
>  	case IMX8MM:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> -		if (ret)
> -			dev_err(dev, "unable to enable pcie_aux clock\n");
> -		break;
>  	case IMX8MQ:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
>  		if (ret) {


