Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961CD21D4DD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgGML0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 07:26:18 -0400
Received: from foss.arm.com ([217.140.110.172]:56394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGML0R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 07:26:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C3D1FB;
        Mon, 13 Jul 2020 04:26:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A4A3F7D8;
        Mon, 13 Jul 2020 04:26:15 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:26:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200713112613.GB25865@e121166-lin.cambridge.arm.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 09:16:57AM -0600, Rob Herring wrote:
> On Tue, Jun 16, 2020 at 6:57 AM Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com> wrote:
> >
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/Kconfig           |   8 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 617 +++++++++++++++++++++++++++++++
> >  3 files changed, 626 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> 
> [...]
> 
> > +static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
> > +{
> > +       struct xilinx_cpm_pcie_port *port;
> > +       struct device *dev = &pdev->dev;
> > +       struct pci_host_bridge *bridge;
> > +       struct resource *bus_range;
> > +       int err;
> > +
> > +       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> > +       if (!bridge)
> > +               return -ENODEV;
> > +
> > +       port = pci_host_bridge_priv(bridge);
> > +
> > +       port->dev = dev;
> > +
> > +       err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> > +                                             &bridge->dma_ranges, &bus_range);
> > +       if (err) {
> > +               dev_err(dev, "Getting bridge resources failed\n");
> > +               return err;
> > +       }
> > +
> > +       err = xilinx_cpm_pcie_init_irq_domain(port);
> > +       if (err)
> > +               return err;
> > +
> > +       err = xilinx_cpm_pcie_parse_dt(port, bus_range);
> > +       if (err) {
> > +               dev_err(dev, "Parsing DT failed\n");
> > +               goto err_parse_dt;
> > +       }
> > +
> > +       xilinx_cpm_pcie_init_port(port);
> > +
> > +       err = xilinx_cpm_setup_irq(port);
> > +       if (err) {
> > +               dev_err(dev, "Failed to set up interrupts\n");
> > +               goto err_setup_irq;
> > +       }
> 
> All the h/w init here can be moved to an .init() function in ecam ops
> and then use pci_host_common_probe. Given this is v9, that can be a
> follow-up I guess.

I think there is time to get it done, Bharat please let me know if
you can repost it shortly with Rob's requested change implemented.

Thanks,
Lorenzo

> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > +
> > +       bridge->dev.parent = dev;
> > +       bridge->sysdata = port->cfg;
> > +       bridge->busnr = port->cfg->busr.start;
> > +       bridge->ops = &pci_generic_ecam_ops.pci_ops;
> > +       bridge->map_irq = of_irq_parse_and_map_pci;
> > +       bridge->swizzle_irq = pci_common_swizzle;
> > +
> > +       err = pci_host_probe(bridge);
> > +       if (err < 0)
> > +               goto err_host_bridge;
> > +
> > +       return 0;
> > +
> > +err_host_bridge:
> > +       xilinx_cpm_free_interrupts(port);
> > +err_setup_irq:
> > +       pci_ecam_free(port->cfg);
> > +err_parse_dt:
> > +       xilinx_cpm_free_irq_domains(port);
> > +       return err;
> > +}
