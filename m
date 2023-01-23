Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8C677FCF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 16:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAWPdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 10:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjAWPdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 10:33:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB231421A;
        Mon, 23 Jan 2023 07:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBFA60F47;
        Mon, 23 Jan 2023 15:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB2C433D2;
        Mon, 23 Jan 2023 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674487981;
        bh=hvcrYunBwqGCWHnDZJ1K6YUEyZYNwCftEeZkd05r1WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AryCn7roOHZ4if4w86h13cJIh+yHGX48AN4XPYQ82oY0Q9NmVg2FS8FdEkQcd4hcz
         KUMXB5fx9EZjlxjmDPFO3DZPKKuxQYO+W3hv5mo4QpYezXf1ZR4Le5R0GdnpLOHTFv
         vw49BYBY0/LVMbyW01qOHCwV8QiFK0sjEfVVf1iMBw8q4S6+ofnqK/E2lpFySFnu46
         DhCbFWKj5nt8FOPW5IA912z3l3A4OTOF98uyUGAWZKlW3MtQ11Dq2sfNYFqqmOmABT
         BD84pUSTB8GKoBv/g8bL7UadwVT3VvzoDeXFVqJCML8rR+ie13SsvUvwcY9yhP73YB
         y8kaMVERQCGRQ==
Date:   Mon, 23 Jan 2023 15:32:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y86op9oh5ldrZQyG@google.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 23 Jan 2023, Vincent Whitchurch wrote:

> Add a PCI driver which registers all child nodes specified in the
> devicetree.  It will allow platform devices to be used on virtual
> systems which already support PCI and devicetree, such as UML with
> virt-pci.
> 
> The driver has no id_table by default; user space needs to provide one
> using the new_id mechanism in sysfs.

This feels wrong for several reasons.

Firstly, I think Greg (Cc:ed) will have something to say about this.

Secondly, this driver does literally nothing.  Why can't you use of of
the other, pre-existing "also register my children" compatibles?

See: drivers/bus/simple-pm-bus.c
     drivers/of/platform.c

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/mfd/Kconfig          | 11 +++++++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-pci.c | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 30db49f31866..1e325334e9ae 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1277,6 +1277,17 @@ config MFD_SIMPLE_MFD_I2C
>  	  sub-devices represented by child nodes in Device Tree will be
>  	  subsequently registered.
>  
> +config MFD_SIMPLE_MFD_PCI
> +	tristate "Simple Multi-Functional Device support (PCI)"
> +	depends on PCI
> +	depends on OF || COMPILE_TEST
> +	help
> +	  This enables support for a PCI driver for which any sub-devices
> +	  represented by child nodes in the devicetree will be registered.
> +
> +	  The driver does not bind to any devices by default; that should
> +	  be done via sysfs using new_id.
> +
>  config MFD_SL28CPLD
>  	tristate "Kontron sl28cpld Board Management Controller"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 457471478a93..7ae329039a13 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -268,6 +268,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> +obj-$(CONFIG_MFD_SIMPLE_MFD_PCI)	+= simple-mfd-pci.o
>  obj-$(CONFIG_MFD_SMPRO)		+= smpro-core.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>  
> diff --git a/drivers/mfd/simple-mfd-pci.c b/drivers/mfd/simple-mfd-pci.c
> new file mode 100644
> index 000000000000..c5b2540e924a
> --- /dev/null
> +++ b/drivers/mfd/simple-mfd-pci.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +
> +static int simple_mfd_pci_probe(struct pci_dev *pdev,
> +				const struct pci_device_id *id)
> +{
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static struct pci_driver simple_mfd_pci_driver = {
> +	/* No id_table, use new_id in sysfs */
> +	.name = "simple-mfd-pci",
> +	.probe = simple_mfd_pci_probe,
> +};
> +
> +module_pci_driver(simple_mfd_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230120-simple-mfd-pci-54f0d9b90dfc
> 
> Best regards,
> -- 
> Vincent Whitchurch <vincent.whitchurch@axis.com>

-- 
Lee Jones [李琼斯]
