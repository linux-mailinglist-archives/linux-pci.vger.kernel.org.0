Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB3B388006
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351708AbhERS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 14:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242777AbhERS4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 14:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C3561244;
        Tue, 18 May 2021 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621364120;
        bh=Gq6+G6e3i2Ms24omsDIsJQnK29VyKsn4YPUQlxYxo5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EB3vXGyTe4teZuEMEHABqJACvT+AinqfmoTBJF1FNmwrZC42m36fXHoVg8+zst8bK
         zSwX055pvmXx5DiQsGgEns6MjKFsxcnQPB+J+PQw+PAggIkyZYTeojntxrF54QjrQt
         FWkiRSkI48siWy+7apCe+M81W8l3PSsF+Fo3+FUWXXzhGuRZhPWPRAm9mdVV6vUxWK
         nIfS2xdGW8CHkLtlcVoJ8hm8/uQxQmFZn96+O2s2nYZQVkPzKKlzoo3kSaYbeh8uGs
         /2o4zCsYvNfuobiHeAIVQSqoLUPNwm/XhZS93GqYrxpAlz5iyE8lfORahVkBDeXQZD
         SQMfIPIBffLUg==
Received: by mail-ej1-f44.google.com with SMTP id u21so16157284ejo.13;
        Tue, 18 May 2021 11:55:20 -0700 (PDT)
X-Gm-Message-State: AOAM5315KAQF4G95n/rj1peSU4knjGzkUd5PsLgLt093Z9pO6oHVI3W6
        6zA4Poxx+W/P/6BOmCrgyGwLGUDVIgzLNl2UHA==
X-Google-Smtp-Source: ABdhPJyxajv5UtGMl1EFwIaGvutY3i2/3fsdYjBx8Ewx4abWwLZF/4iBxPP+b1tXggVG4H4bO8GpXBl2kdPOu2SR9PE=
X-Received: by 2002:a17:906:f211:: with SMTP id gt17mr1129660ejb.360.1621364119332;
 Tue, 18 May 2021 11:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210517154122.430544-1-luca@lucaceresoli.net> <20210517154122.430544-3-luca@lucaceresoli.net>
In-Reply-To: <20210517154122.430544-3-luca@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 May 2021 13:55:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcD7iw85X1be20kZxDsHY7F3J0TQTTgeZYiMMX3O3S4w@mail.gmail.com>
Message-ID: <CAL_JsqKcD7iw85X1be20kZxDsHY7F3J0TQTTgeZYiMMX3O3S4w@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: dwc: pci-dra7xx: make it a kernel module
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 10:41 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> This allows to build the driver as a loadable kernel module.

Enable building the driver as a loadable kernel module.

>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 6457695df00c..fe11b96fe9a5 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -15,6 +15,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> @@ -949,4 +950,8 @@ static struct platform_driver dra7xx_pcie_driver = {
>         },
>         .shutdown = dra7xx_pcie_shutdown,
>  };
> -builtin_platform_driver(dra7xx_pcie_driver);
> +module_platform_driver(dra7xx_pcie_driver);

You need MODULE_DEVICE_TABLE() too for autoloading.

> +
> +MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> +MODULE_DESCRIPTION("PCIe controller driver for TI DRA7xx SoCs");
> +MODULE_LICENSE("GPL v2");
> --
> 2.25.1
>
