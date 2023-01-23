Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF9678114
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjAWQNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 11:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAWQNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 11:13:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928861041A;
        Mon, 23 Jan 2023 08:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B3F60F92;
        Mon, 23 Jan 2023 16:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECD9C4339C;
        Mon, 23 Jan 2023 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674490398;
        bh=y3rlWFzRd5nv0QP6FNJjNaP0em7C2Z0wJEKnu1FpctU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKrh9Ce1WgD0UltABa98QrbBzmAVpPlOzZ4zviLnttb/X2lRuv1cLVc8b2IHbracc
         e5lNuWoM1AJBTfyWg5Oa0G5kqyXK5zHyWsdxpETK083ReHnt43dINpF9rQwQ8LLrkA
         6usuJhBGbTjTkLc6fWEeXLOHvam1TA4erak8GNHKgjMYnXPS3cQScVJLFkS2TbeByC
         bW++SW+HvB/KKJ4z9QARsjszxAubOhH+5GHLSJxOLelkvHH31ylpVFfDV7G0EXiSlZ
         y8yHJ2YRCEqDXbT2XMTbIDDYztDvC7D1BZKbw+au9rFm2XJTd8ZFIf14QOqWPSkoOw
         ovLMohXUDByFA==
Received: by mail-vs1-f48.google.com with SMTP id v127so13386487vsb.12;
        Mon, 23 Jan 2023 08:13:18 -0800 (PST)
X-Gm-Message-State: AFqh2kpsX2Z62Xm7yi4Wik/lLCYtW+27DI35fmr1h5Fmk2M4xLKpRFa0
        ZmARxu9JkXCSumQB+lZ7R428deFiWdV0IBK3zQ==
X-Google-Smtp-Source: AMrXdXs8IozFEOjBRXAonZvI6lE5aKxS6Ril5C6iaDuS9uZbH9ZZdPMTl2C8ezrZ2Am5asQFk6kNYbhWKDyEwX7GI64=
X-Received: by 2002:a67:f441:0:b0:3d3:e619:3c9f with SMTP id
 r1-20020a67f441000000b003d3e6193c9fmr2916176vsn.6.1674490397497; Mon, 23 Jan
 2023 08:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
In-Reply-To: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 10:13:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKJn3iuHu-Q5XTknCbAW1gt1BmF0w4Gzfcq2S5mv0gZw@mail.gmail.com>
Message-ID: <CAL_JsqKKJn3iuHu-Q5XTknCbAW1gt1BmF0w4Gzfcq2S5mv0gZw@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 8:32 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Add a PCI driver which registers all child nodes specified in the
> devicetree.  It will allow platform devices to be used on virtual
> systems which already support PCI and devicetree, such as UML with
> virt-pci.

There's similar work underway for Xilinx/AMD PCIe FPGAs[1]. It's the
same thing really. Non-discoverable things downstream of a PCI device.
There's also a desire for that to work on non-DT (ACPI) based hosts.
While UML supports DT, that's currently only for the unittest AFAIK.
So it's more like a non-DT host. How does the DT get populated for UML
for this to work?

Can you provide details on the actual h/w you want to use. What
problem are you trying to solve?

Really, what I want to see here is everyone interested in this feature
to work together on it. Not just creating a one-off solution for their
1 use case that's a subset of a bigger solution.

> The driver has no id_table by default; user space needs to provide one
> using the new_id mechanism in sysfs.

But your DT will have the id in it already. Wouldn't you rather
everything work without userspace intervention? I can't imagine the
list here would be too long.

>
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
>           sub-devices represented by child nodes in Device Tree will be
>           subsequently registered.
>
> +config MFD_SIMPLE_MFD_PCI
> +       tristate "Simple Multi-Functional Device support (PCI)"
> +       depends on PCI
> +       depends on OF || COMPILE_TEST
> +       help
> +         This enables support for a PCI driver for which any sub-devices
> +         represented by child nodes in the devicetree will be registered.
> +
> +         The driver does not bind to any devices by default; that should
> +         be done via sysfs using new_id.
> +
>  config MFD_SL28CPLD
>         tristate "Kontron sl28cpld Board Management Controller"
>         depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 457471478a93..7ae329039a13 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -268,6 +268,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)       += qcom-pm8008.o
>
>  obj-$(CONFIG_SGI_MFD_IOC3)     += ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)       += simple-mfd-i2c.o
> +obj-$(CONFIG_MFD_SIMPLE_MFD_PCI)       += simple-mfd-pci.o
>  obj-$(CONFIG_MFD_SMPRO)                += smpro-core.o
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
> +                               const struct pci_device_id *id)
> +{
> +       return devm_of_platform_populate(&pdev->dev);

Really, this could be anything in the child DT. Not just what Linux
classifies as an MFD. So maybe drivers/mfd is not the right place.

Rob

[1] https://lore.kernel.org/all/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/
