Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922BD4AED99
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 10:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiBIJIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 04:08:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBIJIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 04:08:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C10AE01975A
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 01:08:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nHixF-0004bN-Dv; Wed, 09 Feb 2022 10:08:01 +0100
Message-ID: <48735d86d0685a0c94e74481ed5fdf6fe66da8be.camel@pengutronix.de>
Subject: Re: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 09 Feb 2022 10:07:59 +0100
In-Reply-To: <1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com>
References: <1644390156-5940-1-git-send-email-hongxing.zhu@nxp.com>
         <1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com>
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

s/pcie/PCIe/ and maybe s/imx6qp/i.MX6QP/ in the subject.

Am Mittwoch, dem 09.02.2022 um 15:02 +0800 schrieb Richard Zhu:
> i.MX6QP PCIe supports the RESET logic, thus it can support
> the L2 exit by the reset mechanism.
> Enable the i.MX6QP PCIe suspend/resume operations support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Other than the nitpick:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
 
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 784801f2f9e6..62262483470a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -995,6 +995,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	/* Others poke directly at IOMUXC registers */
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
> +	case IMX6QP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
>  				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> @@ -1307,7 +1308,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> -			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> +			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> +			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  	},
>  	[IMX7D] = {


