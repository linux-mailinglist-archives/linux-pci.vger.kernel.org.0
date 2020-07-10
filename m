Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEED21B940
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJPSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 11:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgGJPRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 11:17:33 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050F22065D;
        Fri, 10 Jul 2020 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594394230;
        bh=vby8T28Zhsl7qDBYQZOZlfnWOqlS6FqV3/U4aqAHwfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G8UF7jm/7Yy6MTG60kiv3FaSOhzrW9E2hKByIHWg7PY+naOKMMkKyxvJQCQG3zSpU
         EHLfsan0j8gi6a/j50zOrREv9c/aE102NUgnvEesyBJCtOxv0nbJ0ZmRNmtre87x/t
         UyfmFZN3VaMLqX8vmFOjTOnjq425a3F6cVMn+8jE=
Received: by mail-ot1-f54.google.com with SMTP id 95so4424605otw.10;
        Fri, 10 Jul 2020 08:17:09 -0700 (PDT)
X-Gm-Message-State: AOAM532tnJuqNeRhCHFPqEOVKXbeTAa9OQ5vgqiQuOUS/MB4ZuIGRHQq
        70sge2WZLo09IoNF6R9P9FMM37c++J4hiD/Uvg==
X-Google-Smtp-Source: ABdhPJxZk1EF5sd2MNgTb5L8u1KvVR6QeY8YIQeDuM4HdEwDtdmx29dRwXbBaEwnBV7tWkgFm1gHZDWiIFzbsBYuOoY=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr59467283ots.192.1594394229410;
 Fri, 10 Jul 2020 08:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com> <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Jul 2020 09:16:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
Message-ID: <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 6:57 AM Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.
>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 617 +++++++++++++++++++++++++++++++
>  3 files changed, 626 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

[...]

> +static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
> +{
> +       struct xilinx_cpm_pcie_port *port;
> +       struct device *dev = &pdev->dev;
> +       struct pci_host_bridge *bridge;
> +       struct resource *bus_range;
> +       int err;
> +
> +       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +       if (!bridge)
> +               return -ENODEV;
> +
> +       port = pci_host_bridge_priv(bridge);
> +
> +       port->dev = dev;
> +
> +       err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +                                             &bridge->dma_ranges, &bus_range);
> +       if (err) {
> +               dev_err(dev, "Getting bridge resources failed\n");
> +               return err;
> +       }
> +
> +       err = xilinx_cpm_pcie_init_irq_domain(port);
> +       if (err)
> +               return err;
> +
> +       err = xilinx_cpm_pcie_parse_dt(port, bus_range);
> +       if (err) {
> +               dev_err(dev, "Parsing DT failed\n");
> +               goto err_parse_dt;
> +       }
> +
> +       xilinx_cpm_pcie_init_port(port);
> +
> +       err = xilinx_cpm_setup_irq(port);
> +       if (err) {
> +               dev_err(dev, "Failed to set up interrupts\n");
> +               goto err_setup_irq;
> +       }

All the h/w init here can be moved to an .init() function in ecam ops
and then use pci_host_common_probe. Given this is v9, that can be a
follow-up I guess.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +       bridge->dev.parent = dev;
> +       bridge->sysdata = port->cfg;
> +       bridge->busnr = port->cfg->busr.start;
> +       bridge->ops = &pci_generic_ecam_ops.pci_ops;
> +       bridge->map_irq = of_irq_parse_and_map_pci;
> +       bridge->swizzle_irq = pci_common_swizzle;
> +
> +       err = pci_host_probe(bridge);
> +       if (err < 0)
> +               goto err_host_bridge;
> +
> +       return 0;
> +
> +err_host_bridge:
> +       xilinx_cpm_free_interrupts(port);
> +err_setup_irq:
> +       pci_ecam_free(port->cfg);
> +err_parse_dt:
> +       xilinx_cpm_free_irq_domains(port);
> +       return err;
> +}
