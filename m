Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189762A47D3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgKCOQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 09:16:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbgKCOQP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 09:16:15 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A3E22226;
        Tue,  3 Nov 2020 14:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604412974;
        bh=7IqFJ+UztWeXNlIZGdKuf7irZOSOPbrDzUyMAVJDILM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SOUvKc2TZZ1d+zHWsbEkIfy8V5eXDfUPpDzeUdombuTBIt+oRfk6wvUqM1lCSI8UH
         ZoXUJ8zEckJGXkwlKL6veag6F4fkrvO2b0HJu0CtWDYNk9KJFsgNuso2dF0ITsgY8O
         u3jHFBvKh/RppEz/K2PtGZwMjmNqqAPy/LGnIsCc=
Received: by mail-oi1-f174.google.com with SMTP id u127so18478443oib.6;
        Tue, 03 Nov 2020 06:16:14 -0800 (PST)
X-Gm-Message-State: AOAM533OZhK5tf601h2fN7mdDKb8Ox61R/eCqEZ0igNgaQQOdvl4L6Dh
        iYfoLsiLJG6vcy/Pytv/VpPIacymQOf50WKLUQ==
X-Google-Smtp-Source: ABdhPJxS0mlMei/AtlKGjFlC2aF4EVUQX0HhsFADKFdSz6oJV3TwDxUeXilu5Nh0RaOEc/Kkw23qYyJNRc1Aj2cMO7w=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr2068154oib.106.1604412973447;
 Tue, 03 Nov 2020 06:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20201103073338.144465-1-miaoqinglang@huawei.com>
In-Reply-To: <20201103073338.144465-1-miaoqinglang@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Nov 2020 08:16:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLy5B+4NVX1DXS9yjgEssLSn2d2Qg8n+YQ9E1G_05=i0A@mail.gmail.com>
Message-ID: <CAL_JsqLy5B+4NVX1DXS9yjgEssLSn2d2Qg8n+YQ9E1G_05=i0A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: v3: fix missing clk_disable_unprepare() on error
 in v3_pci_probe
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 3, 2020 at 1:28 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from v3_pci_probe() in the error handling case.
>
> Moving the clock enable later to avoid some fixes.
>
> Fixes: 6e0832fa432e (" PCI: Collect all native drivers under drivers/pci/controller/")

I don't think this commit caused the problem.

> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/pci-v3-semi.c | 40 ++++++++++++++++------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index 154a53986..90520555b 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -725,18 +725,6 @@ static int v3_pci_probe(struct platform_device *pdev)
>         host->sysdata = v3;
>         v3->dev = dev;
>
> -       /* Get and enable host clock */
> -       clk = devm_clk_get(dev, NULL);
> -       if (IS_ERR(clk)) {
> -               dev_err(dev, "clock not found\n");
> -               return PTR_ERR(clk);
> -       }
> -       ret = clk_prepare_enable(clk);
> -       if (ret) {
> -               dev_err(dev, "unable to enable clock\n");
> -               return ret;
> -       }
> -
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         v3->base = devm_ioremap_resource(dev, regs);
>         if (IS_ERR(v3->base))
> @@ -761,17 +749,31 @@ static int v3_pci_probe(struct platform_device *pdev)
>         if (IS_ERR(v3->config_base))
>                 return PTR_ERR(v3->config_base);
>
> +       /* Get and enable host clock */
> +       clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(dev, "clock not found\n");
> +               return PTR_ERR(clk);
> +       }
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(dev, "unable to enable clock\n");
> +               return ret;
> +       }
> +
>         /* Get and request error IRQ resource */
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> +       if (irq < 0) {
> +               clk_disable_unprepare(clk);
>                 return irq;
> -
> +       }
>         ret = devm_request_irq(dev, irq, v3_irq, 0,
>                         "PCIv3 error", v3);
>         if (ret < 0) {
>                 dev_err(dev,
>                         "unable to request PCIv3 error IRQ %d (%d)\n",
>                         irq, ret);
> +               clk_disable_unprepare(clk);
>                 return ret;
>         }
>
> @@ -814,13 +816,15 @@ static int v3_pci_probe(struct platform_device *pdev)
>                 ret = v3_pci_setup_resource(v3, host, win);
>                 if (ret) {
>                         dev_err(dev, "error setting up resources\n");
> +                       clk_disable_unprepare(clk);
>                         return ret;
>                 }
>         }
>         ret = v3_pci_parse_map_dma_ranges(v3, np);
> -       if (ret)
> +       if (ret) {
> +               clk_disable_unprepare(clk);
>                 return ret;
> -
> +       }
>         /*
>          * Disable PCI to host IO cycles, enable I/O buffers @3.3V,
>          * set AD_LOW0 to 1 if one of the LB_MAP registers choose
> @@ -862,8 +866,10 @@ static int v3_pci_probe(struct platform_device *pdev)
>         /* Special Integrator initialization */
>         if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
>                 ret = v3_integrator_init(v3);
> -               if (ret)
> +               if (ret) {
> +                       clk_disable_unprepare(clk);

You should make all these a goto and just have one clk_disable_unprepare() call.

You are still missing error handling after pci_host_probe().

>                         return ret;
> +               }
>         }
>
>         /* Post-init: enable PCI memory and invalidate (master already on) */
> --
> 2.23.0
>
