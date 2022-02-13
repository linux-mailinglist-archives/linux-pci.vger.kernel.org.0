Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09514B3955
	for <lists+linux-pci@lfdr.de>; Sun, 13 Feb 2022 05:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiBMEcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Feb 2022 23:32:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMEcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Feb 2022 23:32:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561D5E175;
        Sat, 12 Feb 2022 20:32:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A210560F5B;
        Sun, 13 Feb 2022 04:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AA5C004E1;
        Sun, 13 Feb 2022 04:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644726732;
        bh=LPol4nPqZtrOO+sfiPMZFln5Tubfn7yPMUx7KoowyX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgQIyMNJLW7nujCI266qdAbQmNHm5yGdxe7LVfzYZR6hqYl9LtN8h+XtneX6IC6ow
         1uAfTU+ksvZsJFIcqHzslbT5D23F4flyAviYTYnleASQzcxFzowe5nvoHVWNpTDZrY
         FddXiVKHa45cQQyI83I04uadHtjPa1vmZH/pHwz+UEkDcoch5w3Eg+MhRPlqckUQyP
         P+MYAUAjYW1ZwxCPe5OQgsBa4ikg4nJG5OEDiwBbdew5AzWKFXpzMOLNapM/zCyyV2
         ultzB2kIJ/EqvIFIfmpTJTY1BmrlpZOaEWiPxo8YFte19gpZu4vuoxfYqJnOsPDZZl
         +eReWvsTvpj0g==
Date:   Sun, 13 Feb 2022 12:32:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Message-ID: <20220213043143.GN4909@dragon>
References: <1644564779-8448-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644564779-8448-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 03:32:58PM +0800, Richard Zhu wrote:
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
> NOTE: This reference clock setup is used to pass the GEN2 TX compliance
> tests, and isn't recommended as a setup in the end-user design.

I do not quite follow.  The commit log is all talking about external
oscillator reference clock, while code is playing 'vgen3' regulator.

Shawn

> 
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
> -- 
> 2.25.1
> 
