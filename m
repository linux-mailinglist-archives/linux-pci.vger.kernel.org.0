Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DF67C48B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjAZGrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 01:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjAZGrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 01:47:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EC4FC2B;
        Wed, 25 Jan 2023 22:47:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81B19CE213B;
        Thu, 26 Jan 2023 06:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1C9C433EF;
        Thu, 26 Jan 2023 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674715657;
        bh=U/Lr21J7uETR5Skm9OfM4ZqCMCq4HQhi2ibbyNKSkjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kaafE+jQbTnGxuLXUHXU31+JU6kuVUhkafuGhIeymDGK5C16crV2eGVuoY1VBI4ev
         KPXMicohRm+pjemlIz4i+WO77VOO7XFFBU8yyMQE7G0fj6tQPvcp1dlTVzHJpKkX7h
         i8Fe1cqCd/WQGg7E7YkUXY3WVTl0e4A0ztIxoXlVJLT1DxErgEmeVt/bFSo1gQ0898
         GLy0XgbgivS/a66BcqPhMUMLirkOPT9orb7DNcFd6SiGS4jNnselL5fwzvarMJ/YEF
         6tomUg1qd1epL1GXphDTaPXYyb3criFtRwpdgig0ZxBk2O9VmFejG9ls1bzd7Yj9ME
         tnKaStt8LsrQw==
Date:   Thu, 26 Jan 2023 14:47:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, kishon@ti.com, kw@linux.com,
        frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v5 04/14] arm64: dts: Add i.MX8MM PCIe EP support
Message-ID: <20230126064728.GQ20713@T480>
References: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
 <1673847684-31893-5-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673847684-31893-5-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 16, 2023 at 01:41:14PM +0800, Richard Zhu wrote:
> Add i.MX8MM PCIe EP support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 4ee89fdcf59b..8124761f629c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1293,6 +1293,26 @@ pcie0: pcie@33800000 {
>  			status = "disabled";
>  		};
>  
> +		pcie0_ep: pcie_ep@33800000 {

Hyphen is more preferable than underscore in name node.

I fixed it (and the other two patches) up, and applied all DTS patches.

Shawn

> +			compatible = "fsl,imx8mm-pcie-ep";
> +			reg = <0x33800000 0x400000>,
> +			      <0x18000000 0x8000000>;
> +			reg-names = "regs", "addr_space";
> +			num-lanes = <1>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "dma";
> +			fsl,max-link-speed = <2>;
> +			power-domains = <&pgc_pcie>;
> +			resets = <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
> +				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
> +			reset-names = "apps", "turnoff";
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie-phy";
> +			num-ib-windows = <4>;
> +			num-ob-windows = <4>;
> +			status = "disabled";
> +		};
> +
>  		gpu_3d: gpu@38000000 {
>  			compatible = "vivante,gc";
>  			reg = <0x38000000 0x8000>;
> -- 
> 2.25.1
> 
