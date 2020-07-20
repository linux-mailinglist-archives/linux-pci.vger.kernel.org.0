Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13AE225B54
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGTJXC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 20 Jul 2020 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGTJW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 05:22:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F071C061794
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2020 02:22:59 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxS0B-00035o-7c; Mon, 20 Jul 2020 11:22:27 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxS06-0004dK-6S; Mon, 20 Jul 2020 11:22:22 +0200
Message-ID: <9c2d6c888817880974f850622b14905a9338b60e.camel@pengutronix.de>
Subject: Re: [PATCH V2 1/3] reset: imx7: Support module build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, treding@nvidia.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        vidyas@nvidia.com, xiaowei.bao@nxp.com, jonnyc@amazon.com,
        hayashi.kunihiko@socionext.com, eswara.kota@linux.intel.com,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Mon, 20 Jul 2020 11:22:22 +0200
In-Reply-To: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
References: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-06-29 at 23:05 +0800, Anson Huang wrote:
> Add module device table, author, description and license to support
> module build, and CONFIG_RESET_IMX7 is changed to default 'y' ONLY
> for i.MX7D, other platforms need to select it in defconfig.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- make it default 'y' for SOC_IMX7D;
> 	- add module author, description;
> 	- use device_initcall instead of builtin_platform_driver() to support
> 	  module unload.
> ---
>  drivers/reset/Kconfig      |  5 +++--
>  drivers/reset/reset-imx7.c | 14 ++++++++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d9efbfd..19f9773 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -65,9 +65,10 @@ config RESET_HSDK
>  	  This enables the reset controller driver for HSDK board.
>  
>  config RESET_IMX7
> -	bool "i.MX7/8 Reset Driver" if COMPILE_TEST
> +	tristate "i.MX7/8 Reset Driver"
>  	depends on HAS_IOMEM
> -	default SOC_IMX7D || (ARM64 && ARCH_MXC)
> +	depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> +	default y if SOC_IMX7D
>  	select MFD_SYSCON
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index d170fe6..c710f789 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include <linux/mfd/syscon.h>
> -#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
> @@ -386,6 +386,7 @@ static const struct of_device_id imx7_reset_dt_ids[] = {
>  	{ .compatible = "fsl,imx8mp-src", .data = &variant_imx8mp },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, imx7_reset_dt_ids);
>  
>  static struct platform_driver imx7_reset_driver = {
>  	.probe	= imx7_reset_probe,
> @@ -394,4 +395,13 @@ static struct platform_driver imx7_reset_driver = {
>  		.of_match_table	= imx7_reset_dt_ids,
>  	},
>  };
> -builtin_platform_driver(imx7_reset_driver);
> +
> +static int __init imx7_reset_init(void)
> +{
> +	return platform_driver_register(&imx7_reset_driver);
> +}
> +device_initcall(imx7_reset_init);

Shouldn't this use module_platform_driver instead?

regards
Philipp
