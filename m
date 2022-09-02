Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3F5AAA24
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiIBIdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiIBIdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 04:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685CC228E
        for <linux-pci@vger.kernel.org>; Fri,  2 Sep 2022 01:32:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oU26J-0001LT-Jw; Fri, 02 Sep 2022 10:32:31 +0200
Message-ID: <ef4b87af234375994b8efd34c6ac0e64a4a0400d.camel@pengutronix.de>
Subject: Re: [PATCH v6 1/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Fri, 02 Sep 2022 10:32:28 +0200
In-Reply-To: <1662004960-14071-2-git-send-email-hongxing.zhu@nxp.com>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
         <1662004960-14071-2-git-send-email-hongxing.zhu@nxp.com>
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

Am Donnerstag, dem 01.09.2022 um 12:02 +0800 schrieb Richard Zhu:
> Add i.MX8MP PCIe PHY binding.
> On iMX8MM, the initialized default value of PERST bit(BIT3) of
> SRC_PCIEPHY_RCR is 1b'1.
> But i.MX8MP has one inversed default value 1b'0 of PERST bit.
> 
> And the PERST bit should be kept 1b'1 after power and clocks are stable.
> So add one more PERST explicitly for i.MX8MP PCIe PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml          | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> index b6421eedece3..692783c7fd69 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - fsl,imx8mm-pcie-phy
> +      - fsl,imx8mp-pcie-phy
>  
>    reg:
>      maxItems: 1
> @@ -28,11 +29,16 @@ properties:
>        - const: ref
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    reset-names:
> -    items:
> -      - const: pciephy
> +    oneOf:
> +      - items:          # for iMX8MM
> +          - const: pciephy
> +      - items:          # for IMX8MP
> +          - const: pciephy
> +          - const: perst
>  
>    fsl,refclk-pad-mode:
>      description: |
> @@ -60,6 +66,10 @@ properties:
>      description: A boolean property indicating the CLKREQ# signal is
>        not supported in the board design (optional)
>  
> +  power-domains:
> +    description: PCIe PHY  power domain (optional).
> +    maxItems: 1
> +
>  required:
>    - "#phy-cells"
>    - compatible


