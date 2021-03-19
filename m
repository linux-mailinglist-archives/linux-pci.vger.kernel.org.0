Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11123418C4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCSJuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCSJto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 05:49:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED235C06174A
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 02:49:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lNBl6-0005lz-WD; Fri, 19 Mar 2021 10:49:33 +0100
Message-ID: <f501f7da736e6dce90df722033381a0dc0821ad7.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: specify the imx8mq pcie
 phy voltage
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 19 Mar 2021 10:49:29 +0100
In-Reply-To: <1616142247-13789-1-git-send-email-hongxing.zhu@nxp.com>
References: <1616142247-13789-1-git-send-email-hongxing.zhu@nxp.com>
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

Am Freitag, dem 19.03.2021 um 16:24 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be feeded to i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..23efbad9e804 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -59,6 +59,10 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
>  Additional required properties for imx8mq-pcie:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_aux"
> +- pcie-vph-3v3: If present then PCIE_VPH is feeded by 3.3v in the HW
> +  schematic design. The PCIE_VPH is suggested to be 1.8v refer to the
> +  data sheet. If the PCIE_VPH is supplied by 3.3V, the VREG_BYPASS
> +  should be cleared to zero accordingly.

Uhm, no. Please don't add boolean DT properties for random parts of the
board design.

If we need to know the voltage of PCIE_VPH, we should really add the
VPH regulator as a supply to the PCIe controller node, then work out
the voltage the usual way by using the Linux regulator API.

Regards,
Lucas

