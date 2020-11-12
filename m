Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC92B0A1D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgKLQhb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgKLQha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 11:37:30 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B73922249;
        Thu, 12 Nov 2020 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605199049;
        bh=yND8k4s+hFD4/3y6HwBUi/t7seijznnEvJcPu9dB1Bk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CbUsvZltzY36P3h97UnTDcNUL261L4stXjIHjE4HynxSoh3v532bXKDJVABXViL05
         nDe0c7M935/dITkWRxPthR9NR79cXTSuQEZSrrEM8pFdMIQX39EdjicuZs1OVxd5py
         cupHMaGjRcfmgwKn4PQg0PRgT0DDL7+lT2IbDEkY=
Received: by mail-qv1-f52.google.com with SMTP id ec16so3064900qvb.0;
        Thu, 12 Nov 2020 08:37:29 -0800 (PST)
X-Gm-Message-State: AOAM531MRUv4EBBu/+HEhYVh5OPQrwy4iJgQK1AR2qWAJZSH8D8I7u9k
        BXUheiJMQg5oiTtt5uwxx2ZCLWGEcxsphlWXfQ==
X-Google-Smtp-Source: ABdhPJwHE1wdX0Dl9X4V0XJ3FOQYVJNlxFocV/dg95YBHaFOAmgTlSnSY9EzKWonUlG4KyHTUuCOxNo17TIjdqGqokE=
X-Received: by 2002:a0c:aed2:: with SMTP id n18mr638707qvd.4.1605199048564;
 Thu, 12 Nov 2020 08:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20200528161510.31935-1-zhengdejin5@gmail.com> <CAMuHMdWXf-AB4ZKHkvpEKwTVj-qjV9TDk67QV2F+8X8dU8X5rA@mail.gmail.com>
In-Reply-To: <CAMuHMdWXf-AB4ZKHkvpEKwTVj-qjV9TDk67QV2F+8X8dU8X5rA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Nov 2020 10:37:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYGFP1zLH539=agLsJ6kmSMD4HCKs_p3U7ZZhhZcQ_xA@mail.gmail.com>
Message-ID: <CAL_JsqLYGFP1zLH539=agLsJ6kmSMD4HCKs_p3U7ZZhhZcQ_xA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dwc: convert to devm_platform_ioremap_resource_byname()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 8:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Dejin,
>
> On Thu, May 28, 2020 at 6:18 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> > Use devm_platform_ioremap_resource_byname() to simplify codes.
> > it contains platform_get_resource_byname() and devm_ioremap_resource().
> >
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
>
> Thanks for your patch, which is now commit 936fa5cd7b8e3e2a ("PCI: dwc:
> Convert to devm_platform_ioremap_resource_byname()") in v5.9.

This is all changing again in my latest cleanups[1].

> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -593,13 +593,12 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> >         ep = &pci->ep;
> >         ep->ops = &pcie_ep_ops;
> >
> > -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> > -       pci->dbi_base = devm_ioremap_resource(dev, res);
> > +       pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "ep_dbics");
> >         if (IS_ERR(pci->dbi_base))
> >                 return PTR_ERR(pci->dbi_base);
> >
> > -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> > -       pci->dbi_base2 = devm_ioremap_resource(dev, res);
> > +       pci->dbi_base2 =
> > +               devm_platform_ioremap_resource_byname(pdev, "ep_dbics2");
> >         if (IS_ERR(pci->dbi_base2))
> >                 return PTR_ERR(pci->dbi_base2);
>
> The part above looks fine.
>
> > @@ -626,7 +625,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> >         struct dw_pcie *pci = dra7xx->pci;
> >         struct pcie_port *pp = &pci->pp;
> >         struct device *dev = pci->dev;
> > -       struct resource *res;
> >
> >         pp->irq = platform_get_irq(pdev, 1);
> >         if (pp->irq < 0) {
> > @@ -638,8 +636,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> >         if (ret < 0)
> >                 return ret;
> >
> > -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> > -       pci->dbi_base = devm_ioremap_resource(dev, res);
> > +       pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "rc_dbics");
>
> Are you sure this is equivalent?
> Before, devm_ioremap_resource() was called on "dev" (= pci->dev),
> after it is called on "&pdev->dev" .

pci->dev is set to &pdev->dev in probe, so yes it's equivalent.

Rob

[1] https://lore.kernel.org/linux-pci/20201105211159.1814485-4-robh@kernel.org/
