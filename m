Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1574F1213
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354100AbiDDJg0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 4 Apr 2022 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348083AbiDDJgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 05:36:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C92611A
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 02:34:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJ6D-000624-TH; Mon, 04 Apr 2022 11:34:13 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJ6D-00101n-4r; Mon, 04 Apr 2022 11:34:11 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJ6B-0004fp-0u; Mon, 04 Apr 2022 11:34:11 +0200
Message-ID: <c967e6bdb586c273c187e4892b03aa82064af4ab.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Mon, 04 Apr 2022 11:34:10 +0200
In-Reply-To: <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
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

Hi Richard,

On Mo, 2022-03-07 at 17:07 +0800, Richard Zhu wrote:
> Add the i.MX8MP PCIe PHY PERST support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/reset/reset-imx7.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 185a333df66c..d2408725eb2c 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -329,6 +329,7 @@ static int imx8mp_reset_set(struct
> reset_controller_dev *rcdev,
>                 break;
>  
>         case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
> +       case IMX8MP_RESET_PCIEPHY_PERST:
>                 value = assert ? 0 : bit;
>                 break;
>         }

This doesn't do what the commit description says.

The PCIEPHY_PERST bit is already supported by the driver (albeit
incorrectly?) - this patch just inverts the bit.

Since this bit is not inverted on the other platforms, and the i.MX8MP
reference manual says nothing about this, please explicitly state why
this needs to be inverted and call it a fix in the commit description.

regards
Philipp
