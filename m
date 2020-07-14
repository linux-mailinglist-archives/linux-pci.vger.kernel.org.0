Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8798C21F3B9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgGNORg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 10:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNORg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 10:17:36 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC9F2250F;
        Tue, 14 Jul 2020 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594736255;
        bh=I3SPnbWvrlqPWcUw8Ly0jOC7pjCtY/t7mW2VHJnhfYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tEXKXZHYMSeUr2w1D0flXG1iPI7kKgnsLloe6dJl3ETNeb8ac8ovqDagLCMUZwgda
         GI1HZ8mR0RevDrYoveCU6YF31GxJAllUFFOMpqAFztvrHG3ZWhqBw+DqBo+g0qy97l
         gG2919JA2DgwTnrxd45dLaORxGEcOGz2OttVGa8k=
Received: by mail-ot1-f45.google.com with SMTP id 72so13142479otc.3;
        Tue, 14 Jul 2020 07:17:35 -0700 (PDT)
X-Gm-Message-State: AOAM531DHlZSZRw/1P9vovI/hit/afpa0KSDX4OvXlIDiFI96Va2LYlX
        8B4uD6xFzPHChE3P24p2DzprC8BAgizK0z6g7g==
X-Google-Smtp-Source: ABdhPJzBKeOhicp1T+MBRIS83XFs/aDGNXS9WOX4DHUx73RyY29KXAjt0Io1QW7gAa9o0+GCeSAanUnQHyEdkpT4Kns=
X-Received: by 2002:a9d:4002:: with SMTP id m2mr4313931ote.129.1594736254805;
 Tue, 14 Jul 2020 07:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
 <20200713112613.GB25865@e121166-lin.cambridge.arm.com> <BYAPR02MB5559FBB8597F3B0CD5EF0F22A5600@BYAPR02MB5559.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5559FBB8597F3B0CD5EF0F22A5600@BYAPR02MB5559.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 08:17:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLqJXPi-V37QgOVBCHkBZoHFfc5U+9C1kbgyN2oG03hMA@mail.gmail.com>
Message-ID: <CAL_JsqLqJXPi-V37QgOVBCHkBZoHFfc5U+9C1kbgyN2oG03hMA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 6:24 AM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
>
> > Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
> >
> > On Fri, Jul 10, 2020 at 09:16:57AM -0600, Rob Herring wrote:
> > > On Tue, Jun 16, 2020 at 6:57 AM Bharat Kumar Gogada
> > > <bharat.kumar.gogada@xilinx.com> wrote:
> > > >
> > > > - Add support for Versal CPM as Root Port.
> > > > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The
> > integrated
> > > >   block for CPM along with the integrated bridge can function
> > > >   as PCIe Root Port.
> > > > - Bridge error and legacy interrupts in Versal CPM are handled using
> > > >   Versal CPM specific interrupt line.
> > > >
> > > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > > ---
> > > >  drivers/pci/controller/Kconfig           |   8 +
> > > >  drivers/pci/controller/Makefile          |   1 +
> > > >  drivers/pci/controller/pcie-xilinx-cpm.c | 617
> > > > +++++++++++++++++++++++++++++++
> > > >  3 files changed, 626 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> > >
> > > [...]
> > >
> > > > +static int xilinx_cpm_pcie_probe(struct platform_device *pdev) {
> > > > +       struct xilinx_cpm_pcie_port *port;
> > > > +       struct device *dev = &pdev->dev;
> > > > +       struct pci_host_bridge *bridge;
> > > > +       struct resource *bus_range;
> > > > +       int err;
> > > > +
> > > > +       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> > > > +       if (!bridge)
> > > > +               return -ENODEV;
> > > > +
> > > > +       port = pci_host_bridge_priv(bridge);
> > > > +
> > > > +       port->dev = dev;
> > > > +
> > > > +       err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> > > > +                                             &bridge->dma_ranges, &bus_range);
> > > > +       if (err) {
> > > > +               dev_err(dev, "Getting bridge resources failed\n");
> > > > +               return err;
> > > > +       }
> > > > +
> > > > +       err = xilinx_cpm_pcie_init_irq_domain(port);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > > +       err = xilinx_cpm_pcie_parse_dt(port, bus_range);
> > > > +       if (err) {
> > > > +               dev_err(dev, "Parsing DT failed\n");
> > > > +               goto err_parse_dt;
> > > > +       }
> > > > +
> > > > +       xilinx_cpm_pcie_init_port(port);
> > > > +
> > > > +       err = xilinx_cpm_setup_irq(port);
> > > > +       if (err) {
> > > > +               dev_err(dev, "Failed to set up interrupts\n");
> > > > +               goto err_setup_irq;
> > > > +       }
> > >
> > > All the h/w init here can be moved to an .init() function in ecam ops
> > > and then use pci_host_common_probe. Given this is v9, that can be a
> > > follow-up I guess.
> >
> > I think there is time to get it done, Bharat please let me know if you can
> > repost it shortly with Rob's requested change implemented.
> >
> Thanks Rob for your time.
> Thanks Lorenzo, the reason I cannot use pci_host_common_probe is,
> I need pci_config_window locally as the we use same ecam space for local bridge register access.
> In xilinx_cpm_pcie_parse_dt funciton
> port->reg_base = port->cfg->win;

The .init() function is passed cfg, so what's the issue? You'll need
to alloc struct xilinx_cpm_pcie_port and then set it to cfg->priv. I'd
expect some fields to also be removed as there's no reason to store
things twice.

Rob
