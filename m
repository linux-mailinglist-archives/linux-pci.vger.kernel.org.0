Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87F72A2BED
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgKBNsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 08:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKBNsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 08:48:21 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E06D223AB;
        Mon,  2 Nov 2020 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604324900;
        bh=CJTsLQImvQfuFZjjUnGfXg2U2qxElGBVkEH9ynb1egQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PkqwpfNCqhd4uS4Wm9PvCWSPL0/i0x8Q9AooNZNeR+C4BwIvfn9+Ytp7Z6/BbmOO/
         PYFRnJC2+4QAfET4bOUDb4CTgsNF7In9lij+/qwBluiV/HEb7fkkDCWVIz0GvFQU3/
         guv+rzev3rW1p1t37T4ndg/La53J+Lq6IxuWRrDA=
Received: by mail-ot1-f42.google.com with SMTP id i18so7895541ots.0;
        Mon, 02 Nov 2020 05:48:20 -0800 (PST)
X-Gm-Message-State: AOAM533/Cdd+BArgdU2ZZDoOCRUDhAdyJkFrESISNuWN9mo+yQKcFoBc
        jzjgU+n3DxZJ8de0dEh/m8nmjUW1D+wzjIek0A==
X-Google-Smtp-Source: ABdhPJxantw0H+8iycxFV4C0S3O8mBInCbQ+9oEeSWpWGNQn6vdFocJsnsHpYIqRbXCrcMoeZMuiTdO0HlLiLliarfI=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr11240944oti.107.1604324899397;
 Mon, 02 Nov 2020 05:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20201030013427.54086-1-miaoqinglang@huawei.com>
In-Reply-To: <20201030013427.54086-1-miaoqinglang@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Nov 2020 07:48:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKRDBMXjkBLrJo1GGo-tM4s3gO0rASsTtXmO5b2_BO+qg@mail.gmail.com>
Message-ID: <CAL_JsqKRDBMXjkBLrJo1GGo-tM4s3gO0rASsTtXmO5b2_BO+qg@mail.gmail.com>
Subject: Re: [PATCH] PCI: v3: fix missing clk_disable_unprepare() on error in v3_pci_probe
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

On Thu, Oct 29, 2020 at 8:28 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from v3_pci_probe() in the error handling case.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/pci-v3-semi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index 154a53986..e24abc5b4 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -739,8 +739,10 @@ static int v3_pci_probe(struct platform_device *pdev)
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         v3->base = devm_ioremap_resource(dev, regs);
> -       if (IS_ERR(v3->base))
> +       if (IS_ERR(v3->base)) {
> +               clk_disable_unprepare(clk);

You can reorder things moving the clock enable later (after mapping
resources, but before devm_request_irq) and avoid some of these. Also
move this check down:

if (readl(v3->base + V3_LB_IO_BASE) != (regs->start >> 16))


>                 return PTR_ERR(v3->base);
> +       }
>         /*
>          * The hardware has a register with the physical base address
>          * of the V3 controller itself, verify that this is the same
> @@ -754,17 +756,22 @@ static int v3_pci_probe(struct platform_device *pdev)
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         if (resource_size(regs) != SZ_16M) {
>                 dev_err(dev, "config mem is not 16MB!\n");
> +               clk_disable_unprepare(clk);
>                 return -EINVAL;
>         }
>         v3->config_mem = regs->start;
>         v3->config_base = devm_ioremap_resource(dev, regs);
> -       if (IS_ERR(v3->config_base))
> +       if (IS_ERR(v3->config_base)) {
> +               clk_disable_unprepare(clk);
>                 return PTR_ERR(v3->config_base);
> +       }
>
>         /* Get and request error IRQ resource */
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> +       if (irq < 0) {
> +               clk_disable_unprepare(clk);
>                 return irq;
> +       }
>
>         ret = devm_request_irq(dev, irq, v3_irq, 0,
>                         "PCIv3 error", v3);
> @@ -772,6 +779,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>                 dev_err(dev,
>                         "unable to request PCIv3 error IRQ %d (%d)\n",
>                         irq, ret);
> +               clk_disable_unprepare(clk);
>                 return ret;

You still leave the clock enabled if pci_host_probe() fails.

Rob
