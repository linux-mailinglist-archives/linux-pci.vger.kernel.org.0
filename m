Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4615B375838
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhEFQJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhEFQJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 12:09:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F01C061574
        for <linux-pci@vger.kernel.org>; Thu,  6 May 2021 09:08:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1legY7-0002z8-8C; Thu, 06 May 2021 18:08:27 +0200
Message-ID: <7900502879b346e18727f956965ace34a146c0f1.camel@pengutronix.de>
Subject: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator used
 to power up pcie phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>,
        andrew.smirnov@gmail.com, shawnguo@kernel.org, kw@linux.com,
        bhelgaas@google.com, stefan@agner.ch
Date:   Thu, 06 May 2021 18:08:24 +0200
In-Reply-To: <1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com>
References: <1617091701-6444-1-git-send-email-hongxing.zhu@nxp.com>
         <1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com>
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

Hi Lorenzo,

have those two patches fallen through some crack? AFAICS they are gone
from patchwork, but I also can't find them in any branch in the usual
git repos.

Regards,
Lucas

Am Dienstag, dem 30.03.2021 um 16:08 +0800 schrieb Richard Zhu:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
>  Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:


