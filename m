Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401C4CBA81
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiCCJnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCCJnV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 04:43:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2E12ADB
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 01:42:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nPhyV-0005o7-U5; Thu, 03 Mar 2022 10:42:20 +0100
Message-ID: <f33ff1176caa2ad8c6d314e4f766dda40bd575fa.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: imx6q-pcie: Add iMX8MM PCIe compatible
 string
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Date:   Thu, 03 Mar 2022 10:42:18 +0100
In-Reply-To: <1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com>
References: <1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com>
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

Am Donnerstag, dem 03.03.2022 um 15:50 +0800 schrieb Richard Zhu:
> Add the i.MX8MM PCIe compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 643a6333b07b..36c8a06d17a0 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -25,6 +25,7 @@ properties:
>        - fsl,imx6qp-pcie
>        - fsl,imx7d-pcie
>        - fsl,imx8mq-pcie
> +      - fsl,imx8mm-pcie
>  
>    reg:
>      items:


