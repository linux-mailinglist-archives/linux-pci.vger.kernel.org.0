Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F734A4AD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCZJk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhCZJk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 05:40:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D85C0613B1
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 02:40:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lPiws-0007SS-Cr; Fri, 26 Mar 2021 10:40:10 +0100
Message-ID: <9a966c24bddbace74365eaea44bd0686e9bd99f9.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-evk: add one regulator used
 to power up pcie phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 26 Mar 2021 10:40:08 +0100
In-Reply-To: <1616661882-26487-3-git-send-email-hongxing.zhu@nxp.com>
References: <1616661882-26487-1-git-send-email-hongxing.zhu@nxp.com>
         <1616661882-26487-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, dem 25.03.2021 um 16:44 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

I guess you need to split this patch out of the series and post it for
Shawn to pick up into the imx DT tree, after the other two patches of
the series have been accepted into the PCIe tree.

Regards,
Lucas

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 85b045253a0e..4d2035e3dd7c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -318,6 +318,7 @@
>  		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
>  		 <&pcie0_refclk>;
>  	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	vph-supply = <&vgen5_reg>;
>  	status = "okay";
>  };
>  
> 
> 
> 


