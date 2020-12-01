Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812402CA67A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbgLAPCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 10:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389434AbgLAPCf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 10:02:35 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850D52084C
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606834913;
        bh=h0iFkY6gtMCItSzRdQKSLFyZewmL4kKYzvZ96ZyBoQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YePSNi8ikkNQoLm4SyaPV9Wbygmp/05L+x4pYqxLolpoT6EZCermfArxmIIM0n3b8
         4FOvEPmJR+QDcvJr+IWkl9ZLbYdjSI0EP5WVz6BhtWnv9NTauP6OGAgL/GaAB5gF13
         BNBbfHyxXjzLaSXBZJhD7U+kGhQGtF27m+6D1Bjo=
Received: by mail-ed1-f52.google.com with SMTP id c7so3663803edv.6
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 07:01:53 -0800 (PST)
X-Gm-Message-State: AOAM532fll8WQwNagy2tpJ0EbsxN01UuYya8lvHE4y7t/6SkZKKhPPRs
        jwr8de0O2vf3eut3q49cuDtvOUhxexog7ywbqg==
X-Google-Smtp-Source: ABdhPJycb1sWWFCJLRTw47hEYMnuLEYWEvq8Dy6vKVbSn65lw7Fw5lgBf0b/lg8thfbz0nu/DJ1lpjIQIGm8Y7FRpuk=
X-Received: by 2002:a50:f404:: with SMTP id r4mr3380114edm.62.1606834911924;
 Tue, 01 Dec 2020 07:01:51 -0800 (PST)
MIME-Version: 1.0
References: <X8YDv+bzaeXONOrt@mwanda>
In-Reply-To: <X8YDv+bzaeXONOrt@mwanda>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Dec 2020 08:01:40 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJzHQ6ZoysEyPm6T3t4sZ-9AUsc+CvTaZhbMHpy=djYmg@mail.gmail.com>
Message-ID: <CAL_JsqJzHQ6ZoysEyPm6T3t4sZ-9AUsc+CvTaZhbMHpy=djYmg@mail.gmail.com>
Subject: Re: [bug report] PCI: dwc: Move "dbi", "dbi2", and "addr_space"
 resource setup into common code
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 1, 2020 at 1:50 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Rob Herring,
>
> The patch a0fd361db8e5: "PCI: dwc: Move "dbi", "dbi2", and
> "addr_space" resource setup into common code" from Nov 5, 2020, leads
> to the following static checker warning:
>
>         drivers/pci/controller/dwc/pcie-designware-host.c:337 dw_pcie_host_init()
>         warn: 'pci->dbi_base' is an error pointer or valid
>
> drivers/pci/controller/dwc/pcie-designware-host.c
>    304          cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>    305          if (cfg_res) {
>    306                  pp->cfg0_size = resource_size(cfg_res);
>    307                  pp->cfg0_base = cfg_res->start;
>    308          } else if (!pp->va_cfg0_base) {
>    309                  dev_err(dev, "Missing *config* reg space\n");
>    310          }
>    311
>    312          if (!pci->dbi_base) {
>    313                  struct resource *dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>    314                  pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We set pci->dbi_base here now.
>
>    315                  if (IS_ERR(pci->dbi_base))
>    316                          return PTR_ERR(pci->dbi_base);
>    317          }
>    318
>    319          bridge = devm_pci_alloc_host_bridge(dev, 0);
>    320          if (!bridge)
>    321                  return -ENOMEM;
>    322
>    323          pp->bridge = bridge;
>    324
>    325          /* Get the I/O and memory ranges from DT */
>    326          resource_list_for_each_entry(win, &bridge->windows) {
>    327                  switch (resource_type(win->res)) {
>    328                  case IORESOURCE_IO:
>    329                          pp->io_size = resource_size(win->res);
>    330                          pp->io_bus_addr = win->res->start - win->offset;
>    331                          pp->io_base = pci_pio_to_address(win->res->start);
>    332                          break;
>    333                  case 0:
>    334                          dev_err(dev, "Missing *config* reg space\n");
>    335                          pp->cfg0_size = resource_size(win->res);
>    336                          pp->cfg0_base = win->res->start;
>    337                          if (!pci->dbi_base) {
>                                     ^^^^^^^^^^^^^^
> So this is dead code because pci->dbi_base is never NULL.

I think this code should not be needed any more. It was for
compatibility with old DTs. I'll check the history.

Rob

>
>    338                                  pci->dbi_base = devm_pci_remap_cfgspace(dev,
>    339                                                                  pp->cfg0_base,
>    340                                                                  pp->cfg0_size);
>    341                                  if (!pci->dbi_base) {
>    342                                          dev_err(dev, "Error with ioremap\n");
>    343                                          return -ENOMEM;
>    344                                  }
>    345                          }
>    346                          break;
>    347                  }
>    348          }
>
> regards,
> dan carpenter
