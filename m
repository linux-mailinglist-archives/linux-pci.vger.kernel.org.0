Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E18C2755
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 22:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfI3UxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 16:53:08 -0400
Received: from foss.arm.com ([217.140.110.172]:34228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfI3UxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 16:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DD828;
        Mon, 30 Sep 2019 12:36:59 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50BB3F534;
        Mon, 30 Sep 2019 12:36:58 -0700 (PDT)
Date:   Mon, 30 Sep 2019 20:36:57 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, Robin.Murphy@arm.com
Subject: Re: [PATCH 05/11] PCI: versatile: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190930193655.GH42880@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-6-robh@kernel.org>
 <20190925103752.GS9720@e119886-lin.cambridge.arm.com>
 <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
 <CAFEAcA_Lu73n9z-fyWNLvnxXyk-JcUbONHE5x06Uh9Upk4MVbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Lu73n9z-fyWNLvnxXyk-JcUbONHE5x06Uh9Upk4MVbw@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 05:56:51PM +0100, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 22:45, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Sep 25, 2019 at 5:37 AM Andrew Murray <andrew.murray@arm.com> wrote:
> > >
> > > On Tue, Sep 24, 2019 at 04:46:24PM -0500, Rob Herring wrote:
> > > > Convert ARM Versatile host bridge to use the common
> > > > pci_parse_request_of_pci_ranges().
> > > >
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> 
> > > >  static int versatile_pci_probe(struct platform_device *pdev)
> > > >  {
> > > >       struct device *dev = &pdev->dev;
> > > >       struct resource *res;
> > > > -     int ret, i, myslot = -1;
> > > > +     struct resource_entry *entry;
> > > > +     int ret, i, myslot = -1, mem = 0;
> > >
> > > I think 'mem' should be initialised to 1, at least that's what the original
> > > code did. However I'm not sure why it should start from 1.
> >
> > The original code I moved from arch/arm had 32MB @ 0x0c000000 called
> > "PCI unused" which was requested with request_resource(), but never
> > provided to the PCI core. Otherwise, I kept the setup the same. No one
> > has complained in 4 years, though I'm not sure anyone would have
> > noticed if I just deleted PCI support...
> 
> Yes, QEMU users will notice if you drop or break PCI support :-)
> I don't think anybody is using real hardware PCI though.
> 
> Anyway, the 'mem' indexes here matter because you're passing
> them to PCI_IMAP() and PCI_SMAP(), which are writing to
> hardware registers. If you write to PCI_IMAP0 when we
> were previously writing to PCI_IMAP1 then suddenly you're
> not configuring the behaviour for accesses to the PCI
> window that's at CPU physaddr 0x50000000, you're configuring
> the window that's at CPU physaddr 0x44000000, which is
> entirely different (and notably is smaller, being only
> 0x0c000000 in size rather than 0x10000000).
> 
> If this is supposed to be a no-behaviour-change refactor
> then it would probably be a good test to check that we're
> writing exactly the same values to the hardware registers
> on the device as we were before the change.

As far as I understand...

According to the device tree arch/arm/boot/dts/versatile-pb.dts we describe
a 1:1 mapping between CPU and PCI addresses for the IORESOURCE_MEM resources:

 ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
           0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
           0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */

The existing code achieves this by shifting the CPU address and writing 0x5 to
PCI_IMAP(1) and 0x6 >> 28 to PCI_IMAP(2). This value represents the top 4 bits of
the outgoing PCI address, with the remainder of the bits as written to the AHB
window. The hardware has three windows at 0x44000000, 0x50000000 and 0x60000000
which relate to PCI_IMAP0, 1 and 2 respectively.

Therefore the existing code creates an effective 1:1 mapping as follows:

CPU 0x50000000 => PCI 0x50000000
CPU 0x60000000 => PCI 0x60000000

If we were to instead write 0x5 to PCI_IMAP(0) and 0x6 to PCI_IMAP(1), as per
this patch - then we end up with an effective broken mapping of:

CPU 0x50000000 => PCI 0x60000000
CPU 0x60000000 => PCI unset

Therefore I'd suggest we preserve the existing numbering and change mem back to
1.

More information about the hardware can be foud here:

http://arminfo.emea.arm.com/help/index.jsp?topic=/com.arm.doc.dui0224i/Bbajjbce.html

Thanks,

Andrew Murray

> 
> thanks
> -- PMM
