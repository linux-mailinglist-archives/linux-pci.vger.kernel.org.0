Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04CD1C1E5
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 07:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfENFfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 01:35:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43819 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfENFfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 01:35:17 -0400
Received: by mail-io1-f68.google.com with SMTP id v7so12014893iob.10;
        Mon, 13 May 2019 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUOydJOYKqfw1vGDoYoy/mQ+7TBt6hmzNJDpw1eO9Yc=;
        b=a2cBsCTVrgJJ6cLQ137IbO1f9p0YKaVA25kngwav0+++ixE/mtgJVYepJQmMK1OM9F
         fMNdfmsG9hTQwosk4jm36dp7KWKwusa8CHzZ9h2WJz91liJLKd7iIsXnEZ3ztUDls8Nw
         kj69obXgXvYFqJeoFqdvjkipitqp0HJFuvJzDisDKCwHx8IHj0Cqub2twXE3GMpvuhrD
         nTEYCp0c4A5+yraginrF0vv+up/me39UpGh8Atngi96Nvz6VcTlWFPzeSAZD28pvUkSf
         WVm6Fh6IqPu6c4PLri8creybLmLMs1f6Cerwifn7CChiXH/oiaNwdJ+4wVNQEw+oEN5h
         xliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUOydJOYKqfw1vGDoYoy/mQ+7TBt6hmzNJDpw1eO9Yc=;
        b=UeIhbnNyUkRm8Mtl5qJen54Mu5dL6HH8CU4ByErrSRZfhWzFKD+brT7X3LlNw/ULnp
         rjfPL2qVa2e0peezSQIIUsBn8xafnwkVZfBAfI+a3YFi+lPO+e+zTWzPSKFMKU4hGJ2e
         ITDJd6cRBtSO23/4UC7GSw6kI5KIQVKW2/dKnmleRAfC5zndTACYS1rAVV63nRdtE+b5
         Wo3g/xdGz4VM/WlDY39Rjki4K+zP0ukL/ck6Av1FM0RQUg5adE20ZUnUl7jJyxGtltth
         0ytXTrXzJGwHVtCwn3Pyqp/4y/4hgpAWEE88ASKk0ECawcLi6iR2hLRB6g9bGJGvJtcD
         TxPg==
X-Gm-Message-State: APjAAAUPJAeKRskTQYvFy/Uf0kXjlamh8Enuv7cx6JCvj8NVyecZhaMO
        WapYjqTplD1BvWmoAU3cNIk8YjRlmHls9Pa9kdQ=
X-Google-Smtp-Source: APXvYqyHn+m4/xZ2S0LEWr5O8zaD/17JTlmgQUuknIjDU4KdlgAjVV5WFsK/3Wau/abLjGcTEo3lTL+BzjRounSYhYc=
X-Received: by 2002:a5e:a51a:: with SMTP id 26mr11296309iog.171.1557812116707;
 Mon, 13 May 2019 22:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
In-Reply-To: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 14 May 2019 13:35:05 +0800
Message-ID: <CAFiDJ5-4vquVtrqpjgk8D6yhng3RFHN6dF4Kh_PGYe_doZtvqw@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: Allow building as module
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 12:57 PM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
>
> Altera PCIe Rootport IP is a soft IP and is only available after
> FPGA image is programmed.
>
> Make driver modulable to support use case FPGA image is programmed
> after kernel is booted. User proram FPGA image in kernel then only load
> PCIe driver module.
>
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/controller/Kconfig       |  2 +-
>  drivers/pci/controller/pcie-altera.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 6012f3059acd..4b550f9cdd56 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -174,7 +174,7 @@ config PCIE_IPROC_MSI
>           PCIe controller
>
>  config PCIE_ALTERA
> -       bool "Altera PCIe controller"
> +       tristate "Altera PCIe controller"
>         depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
>         help
>           Say Y here if you want to enable PCIe controller support on Altera
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 27edcebd1726..6c86bc69ace8 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -10,6 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> @@ -705,6 +706,13 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>         return 0;
>  }
>
> +static int altera_pcie_irq_teardown(struct altera_pcie *pcie)
> +{
> +       irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> +       irq_domain_remove(pcie->irq_domain);
> +       irq_dispose_mapping(pcie->irq);
> +}
> +
>  static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  {
>         struct device *dev = &pcie->pdev->dev;
> @@ -798,6 +806,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
>
>         pcie = pci_host_bridge_priv(bridge);
>         pcie->pdev = pdev;
> +       platform_set_drvdata(pdev, pcie);
>
>         match = of_match_device(altera_pcie_of_match, &pdev->dev);
>         if (!match)
> @@ -855,13 +864,28 @@ static int altera_pcie_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int altera_pcie_remove(struct platform_device *pdev)
> +{
> +       struct altera_pcie *pcie = platform_get_drvdata(pdev);
> +       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +
> +       pci_stop_root_bus(bridge->bus);
> +       pci_remove_root_bus(bridge->bus);
> +       pci_free_resource_list(&pcie->resources);
> +       altera_pcie_irq_teardown(pcie);
> +
> +       return 0;
> +}
> +
>  static struct platform_driver altera_pcie_driver = {
>         .probe          = altera_pcie_probe,
> +       .remove         = altera_pcie_remove,
>         .driver = {
>                 .name   = "altera-pcie",
>                 .of_match_table = altera_pcie_of_match,
> -               .suppress_bind_attrs = true,
>         },
>  };
>
> -builtin_platform_driver(altera_pcie_driver);
> +MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
> +module_platform_driver(altera_pcie_driver);
> +MODULE_LICENSE("GPL v2");
> --
> 2.19.0
>
Hi

Any comment for this patch?

Regards
Ley Foon
