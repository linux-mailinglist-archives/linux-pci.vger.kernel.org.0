Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98DC4BD4B8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 05:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiBUEUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 23:20:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiBUEUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 23:20:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F9E0BB;
        Sun, 20 Feb 2022 20:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71FFCB80CF9;
        Mon, 21 Feb 2022 04:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A015C340E9;
        Mon, 21 Feb 2022 04:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645417214;
        bh=gfKtL3rCxVo8u8AWUM863Dway5lpvp8Eq5EP9JLAgG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWGHpd3E5K8IqQX4jfmrOPLDww/qC2cI7PoFy092zgpoYgAHDh7Ceh3RQz+OLVnbw
         htkXWZ2puo0KPXXBp7RNWm2UzelAoaf9LKk8ywFT5V8rY223a7eON8c2WeTzUK9T89
         sgOFGzPsnXWaVB8xsxJXonhckbSLxAnMGV5wPtUTgR0u/o2MLC2eXzISRsiAKt5Kb4
         VvcZsPh86AzemeK0CQ3aaKe1OvL7NR9XAwly9jbLVUna7wxcEmsCZ3vKyFwhPmMpwC
         tfA7mZjq1sqqu9tAeJpvQujSIq43vJGAb/0Cc/E3PZNURM/rzVzc/no8z9w40mBw/P
         tc9QV+DvpVmeQ==
Date:   Mon, 21 Feb 2022 12:20:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v3 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Message-ID: <20220221042008.GL2249@dragon>
References: <1644902192-12957-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644902192-12957-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 01:16:31PM +0800, Richard Zhu wrote:
> In the i.MX6QP sabresd board(sch-28857) design, one external oscillator
> is powered up by vgen3 and used as the PCIe reference clock source by
> the endpoint device.
> 
> If RC uses this oscillator as reference clock too, PLL6(ENET PLL) would
> has to be in bypass mode, and ENET clocks would be messed up.
> 
> To keep things simple, let RC use the internal PLL as reference clock
> and set vgen3 always on to enable the external oscillator for endpoint
> device on i.MX6QP sabresd board.
> 
> NOTE: This reference clock setup is used to pass the GEN2 TX compliance
> tests, and isn't recommended as a setup in the end-user design.
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

These can be saved, as they are unchanged?

Shawn

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
