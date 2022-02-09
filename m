Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F674AED97
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 10:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiBIJGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 04:06:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiBIJGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 04:06:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB34E071F63
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 01:05:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nHiuc-000491-7t; Wed, 09 Feb 2022 10:05:18 +0100
Message-ID: <936cc917828bfa3c089a33f0af219fecdc2a778a.camel@pengutronix.de>
Subject: Re: [RFC 1/2] ARM: dts: imx6qp-sabresd: Enable pcie support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 09 Feb 2022 10:05:16 +0100
In-Reply-To: <1644390156-5940-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644390156-5940-1-git-send-email-hongxing.zhu@nxp.com>
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

Hi Richard,

Am Mittwoch, dem 09.02.2022 um 15:02 +0800 schrieb Richard Zhu:
> In the i.MX6QP sabresd board(sch-28857) design, one external oscillator
> is used as the PCIe reference clock source by the endpoint device.
> 
> If RC uses this oscillator as reference clock too, PLL6(ENET PLL) would
> has to be in bypass mode, and ENET clocks would be messed up.
> 
> To keep things simple, let RC use the internal PLL as reference clock
> and always enable the external oscillator for endpoint device on
> i.MX6QP sabresd board.
> 
The commit message doesn't really match what's being done in the patch.
Maybe you meant to say that even though the HW design is different you
are enabling the PCIe controller in the same way as on the 6Q sabresd?

Also, is this configuration stable for you? We've had some issues with
this kind of split clocking setup in a customer design, where it was
enabled by accident, due to PLL6 no being bypassed. In this design it
caused the link to randomly drop under load and causing aborts on the
CPU side, due to completion timeouts. I think it at least warrants a
comment somewhere that this isn't a recommended setup.

Regards,
Lucas

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qp-sabresd.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
> index 480e73183f6b..083cf90bcab5 100644
> --- a/arch/arm/boot/dts/imx6qp-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> @@ -50,8 +50,14 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
>  	};
>  };
>  
> +&vgen3_reg {
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-always-on;
> +};
> +
>  &pcie {
> -	status = "disabled";
> +	status = "okay";
>  };
>  
>  &sata {


