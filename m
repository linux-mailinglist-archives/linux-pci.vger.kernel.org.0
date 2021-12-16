Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA7476A6F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 07:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhLPGfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 01:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhLPGfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 01:35:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3922DC061574;
        Wed, 15 Dec 2021 22:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C860161B8D;
        Thu, 16 Dec 2021 06:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DDC36AE4;
        Thu, 16 Dec 2021 06:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636521;
        bh=KJuum97Hub0BzEm0OYxF3VjGxMjXXc97FgYjBn39Nv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=al8pxAXCzCx9oGA+v82lh/H9mV6riLIxaYtCMSYjLWL5marAVf0KqEG6LT8sNKVcN
         Yd0ibsTntrfFO5C6iQQ2+deG0dDyMRz1CHBm5l65l/PKh2F6FBY596XWgEbdXVTN1a
         +XTLF9WM/iKceYwxwIDoiCC3RiGuyo0MZ6O5sEjX7qoN6vpl4PBs//HpY48W2QmzvK
         CgHUj5WtNQbSlbsRD88UZbK2dUKGsMSdAzzdTesTsg9/CUmUeAQXhJEGc3yMj0Dj4j
         FuFhv/tVMKJRJEL6eBdk1/LYEUhIU3i9c8IFtNAg4txVfzp0ng2f3R/hPAfuQPMyiR
         BjsLphv4djlhg==
Date:   Thu, 16 Dec 2021 12:05:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-phy@lists.infradead.org, linux-imx@nxp.com,
        linux-next@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] phy: freescale: pcie: fix building for x86_64 as a module
Message-ID: <YbreJSy+3YG9ix8+@matsya>
References: <20211215153037.688885-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215153037.688885-1-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15-12-21, 16:30, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> x86_64 allmodconfig build failed like this:
> 
> /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c: In function
>  'imx8_pcie_phy_init':
> /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37:
>  error: implicit declaration of function 'FIELD_PREP'
>  [-Werror=implicit-function-declaration]
>    41 | #define IMX8MM_GPR_PCIE_REF_CLK_EXT FIELD_PREP(IMX8MM_GPR_PCIE_
> REF_CLK_SEL, 0x2)
>       |                                     ^~~~~~~~~~
> /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:85:7: note:
>  in expansion of macro 'IMX8MM_GPR_PCIE_REF_CLK_EXT'
>    85 |       IMX8MM_GPR_PCIE_REF_CLK_EXT :
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Fix this by explicitly including linux/bitfield.h.

I have already pushed a patch for this
lore.kernel.org/r/20211215060834.921617-1-vkoul@kernel.org

> 
> While at it sort includes alphabethically and add a new line before the
> dt-bindings one as usually done.

Pls do send a patch for this..

> 
> Fixes: 1aa97b002258a190d77
> ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index f6502463d49a..f1eb03ba25d6 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -3,10 +3,11 @@
>   * Copyright 2021 NXP
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
> @@ -14,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +
>  #include <dt-bindings/phy/phy-imx8-pcie.h>
>  
>  #define IMX8MM_PCIE_PHY_CMN_REG061	0x184
> -- 
> 2.33.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
~Vinod
