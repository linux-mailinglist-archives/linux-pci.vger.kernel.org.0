Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9FC2408
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfI3PNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 11:13:50 -0400
Received: from foss.arm.com ([217.140.110.172]:56632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbfI3PNu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 11:13:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C996E1000;
        Mon, 30 Sep 2019 08:13:49 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F823F706;
        Mon, 30 Sep 2019 08:13:49 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:13:47 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
Message-ID: <20190930151346.GD42880@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-3-robh@kernel.org>
 <20190925102423.GR9720@e119886-lin.cambridge.arm.com>
 <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 07:33:35AM -0500, Rob Herring wrote:
> On Wed, Sep 25, 2019 at 5:24 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 04:46:21PM -0500, Rob Herring wrote:
> > > Convert altera host bridge to use the common
> > > pci_parse_request_of_pci_ranges().
> > >
> > > Cc: Ley Foon Tan <lftan@altera.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: rfi@lists.rocketboards.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> 
> > > @@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
> > >               return ret;
> > >       }
> > >
> > > -     INIT_LIST_HEAD(&pcie->resources);
> > > -
> > > -     ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > > +     ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> >
> > Does it matter that we now map any given IO ranges whereas we didn't
> > previously?
> >
> > As far as I can tell there are no users that pass an IO range, if they
> > did then with the existing code the probe would fail and they'd get
> > a "I/O range found for %pOF. Please provide an io_base pointer...".
> > However with the new code if any IO range was given (which would
> > probably represent a misconfiguration), then we'd proceed to map the
> > IO range. When that IO is used, who knows what would happen.
> 
> Yeah, I'm assuming that the DT doesn't have an IO range if IO is not
> supported. IMO, it is not the kernel's job to validate the DT.

Sure. Is it worth mentioning in the commit message this subtle change
in behaviour?

> 
> > I wonder if there is a better way for a host driver to indicate that
> > it doesn't support IO?
> 
> We can probably test for this in the schema.
> 
> ranges:
>   items:
>     minItems: 7
>     items:
>       - not: { const: 0x01000000 }
> 
> Or "- enum: [ 0x42000000, 0x02000000 ]"
> 
> Of course, in theory, the bus, dev, fn fields could be non-zero and we
> could use minium/maximum to handle those, but in practice I think they
> are rarely used for FDT.

Many controllers also appear to set the top bit (relocatable), e.g.
0x82000000...

At present there are no PCI bindings that use the YAML schema, if I've
understood correctly.

Thanks,

Andrew Murray

> 
> Rob
