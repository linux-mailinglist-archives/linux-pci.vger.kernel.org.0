Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A075E34C94C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 10:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhC2I3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhC2I2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 04:28:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98CC05BD10
        for <linux-pci@vger.kernel.org>; Mon, 29 Mar 2021 01:26:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lQnEU-0008N3-MN; Mon, 29 Mar 2021 10:26:46 +0200
Message-ID: <560c6da29baab628abeae5d27c31893e5247dd16.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: imx6q-pcie: add one regulator used
 to power up pcie phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Mon, 29 Mar 2021 10:26:41 +0200
In-Reply-To: <1617004993-29728-2-git-send-email-hongxing.zhu@nxp.com>
References: <1617004993-29728-1-git-send-email-hongxing.zhu@nxp.com>
         <1617004993-29728-2-git-send-email-hongxing.zhu@nxp.com>
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

Am Montag, dem 29.03.2021 um 16:03 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..d8971ab99274 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -38,6 +38,9 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- vph-supply: Should specify the regulator in charge of VPH one of the three
> +  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
> +  supplies.
>  
> 
> 
> 
>  Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:


