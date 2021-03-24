Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A56347493
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhCXJ1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhCXJ1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 05:27:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2DC061763
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 02:27:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lOzmw-0001ez-Ls; Wed, 24 Mar 2021 10:26:54 +0100
Message-ID: <ca22113963e9499ec47839c627840d7ffee157b3.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: imx6q-pcie: add one regulator used
 to power up pcie phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 24 Mar 2021 10:26:52 +0100
In-Reply-To: <1616564059-8713-2-git-send-email-hongxing.zhu@nxp.com>
References: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
         <1616564059-8713-2-git-send-email-hongxing.zhu@nxp.com>
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

Hi Richard,

Am Mittwoch, dem 24.03.2021 um 13:34 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..3248b7192ced 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -38,6 +38,12 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- vph-supply: Should specify the regulator in charge of PCIe PHY power.
> +  On i.MX8MQ, both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe
> +  PHY. In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> +  sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design, the
> +  VREG_BYPASS bits of GPR registers should be cleared from default value 1b'1
> +  to 1b'0.

This description of the internal driver behavior does not belong into a
DT binding description.
Instead the binding should describe the function of the regulator
exactly. From the datasheet I can see that there are actually 3
supplies (VPH, VP, VPTX) going into the PCIe PHY, so "regulator in
charge of PCIe PHY power" doesn't seem like a very accurate
description.

Regards,
Lucas

