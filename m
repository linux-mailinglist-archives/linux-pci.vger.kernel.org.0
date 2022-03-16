Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7B4DAD9E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 10:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiCPJjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354938AbiCPJjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 05:39:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5214029
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 02:37:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nUQ6O-0000vX-Bc; Wed, 16 Mar 2022 10:37:56 +0100
Message-ID: <cf0943a1144e91048fc88fe9b11660bafe1a2d8d.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Invoke the PHY exit function after PHY power
 off
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 16 Mar 2022 10:37:55 +0100
In-Reply-To: <1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com>
References: <1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com>
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

Am Donnerstag, dem 03.03.2022 um 14:34 +0800 schrieb Richard Zhu:
> To balance phy->init_count, invoke the phy_exit() after phy_power_off().
> 
This looks okay as a fix, but overall I don't like that we need to have
special PHY handling in the suspend path and PHY init hidden in
imx6_pcie_assert_core_reset() in the resume path. Maybe we can make
this PHY handling a bit more obvious by splitting it out of the core
reset sequence. I don't see the full implications of such a change yet,
but I think we should at least give it a try.

For now, this patch is:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> Fixes: 178e244cb6e2 ("PCI: imx: Add the imx8mm pcie support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 331490614d55..343fe1429e3c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -973,6 +973,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  	case IMX8MM:
>  		if (phy_power_off(imx6_pcie->phy))
>  			dev_err(dev, "unable to power off PHY\n");
> +		phy_exit(imx6_pcie->phy);
>  		break;
>  	default:
>  		break;


