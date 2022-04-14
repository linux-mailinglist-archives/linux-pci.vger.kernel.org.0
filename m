Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAE501CEA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiDNUuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiDNUuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:50:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE60EDF05
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 13:48:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nf6O1-000642-Ee; Thu, 14 Apr 2022 22:48:17 +0200
Message-ID: <837af8d131bd0674d7466d89c3df74da08c8c435.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Thu, 14 Apr 2022 22:48:15 +0200
In-Reply-To: <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, dem 07.03.2022 um 17:07 +0800 schrieb Richard Zhu:
> Add the i.MX8MP PCIe PHY PERST support.

As Philipp said: please add some more description on why this is
necessary. As far as I can see the reset is already present on 8MQ, and
is low-active, like this patch claims. We just didn't handle this reset
at all on other SoCs as the power on de-asserted state was okay to get
things working.

Regards,
Lucas

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/reset/reset-imx7.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 185a333df66c..d2408725eb2c 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -329,6 +329,7 @@ static int imx8mp_reset_set(struct reset_controller_dev *rcdev,
>  		break;
>  
>  	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
> +	case IMX8MP_RESET_PCIEPHY_PERST:
>  		value = assert ? 0 : bit;
>  		break;
>  	}


