Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D031CBA7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBPORT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 09:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBPORS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Feb 2021 09:17:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782E664D9F;
        Tue, 16 Feb 2021 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613484997;
        bh=TBPqpnUqDioTSDkHJrAsQrWH6tFfXLDdDLnLtyI64lI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PNi4bBUGEEUao/WyabXMwTTxBbpX9Dfp0SpevABA9NU6aCO3WwWi7UeiziJHPQLi7
         SNXlMvJUlLXOBDpgWtiiFs2rJx6Rdgl8dHdqJnzcYIFPhJIo3u2UACnrFnE+xPXMSP
         VSw7q4J2ew4RWjoU0rUSfW6HFtSBnzCMeLtMn4e55+bJoHaIy22QjKhfofeqjKpUlp
         Xvqo/LH1hXfB2cxfS1+Oaoa8PdntiLb9tYYOaHivQs/3o5ugF0DKsxJpLQsHftJ3I4
         J3VT+7ncRC9HvZ5wf2RHpB/KVYKmSXBZBFCzmOvKF30t5iQJB49YSbi7r6qdPoxvCX
         LrnjeRLH3mrDg==
Date:   Tue, 16 Feb 2021 08:16:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wasim Khan <wasim.khan@nxp.com>
Cc:     "Wasim Khan (OSS)" <wasim.khan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI : check if type 0 devices have all BARs of size zero
Message-ID: <20210216141634.GA803078@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6702EE8C0FBAFDFD3B35199090879@VE1PR04MB6702.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 16, 2021 at 07:52:08AM +0000, Wasim Khan wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, February 16, 2021 2:43 AM
> > To: Wasim Khan (OSS) <wasim.khan@oss.nxp.com>
> > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Wasim Khan <wasim.khan@nxp.com>
> > Subject: Re: [PATCH] PCI : check if type 0 devices have all BARs of size zero
> > 
> > On Fri, Feb 12, 2021 at 11:08:56AM +0100, Wasim Khan wrote:
> > > From: Wasim Khan <wasim.khan@nxp.com>
> > >
> > > Log a message if all BARs of type 0 devices are of size zero. This can
> > > help detecting type 0 devices not reporting BAR size correctly.
> > 
> > I could be missing something, but I don't think we can do this.  I
> > would think the simplest possible presilicon testing would find
> > errors like this, and the first attempt to have a driver claim the
> > device would fail if required BARs were missing, so I'm not sure
> > what this would add.
> 
> Thank you for the review.
> I observed this issue with an under development EP. Due to some
> logic problem in EP's firmware, the BAR sizes were reported zero and
> crash was observed sometime later in PCIe code. 

I'm interested in this crash.  The PCI core should not crash just
because a BAR size is zero, i.e., the BAR looks like it's
unimplemented.

> I agree with you that such issues should have been caught in
> pre-silicon testing, but not sure of pre-si testing details and if
> the issue was specifically observed with real OS. Also, because the
> EP is in early stage of development, device driver of EP is not
> available as of now. 

> So, I though it will be a good idea to print an information message
> only for *type 0* devices to give a quick hint if the zero BAR size
> is expected for the given EP or not. So that SW can contribute to
> identify HW problem.

> > While the subject line says "type 0 devices," this code path is
> > also used for type 1 devices (bridges), and it's quite common for
> > bridges to have no BARs, which means they would all be hardwired
> > to zero.
> 
> Yes, for type 1 devices, it is common to have zero BAR size, so I
> added log msg for type 0 devices only , which are in-general
> expected to have valid BARs.

Oh, right, I missed your check of dev->hdr_type.

> > It is also legal for even type 0 devices to implement no BARs.
> > They may be operated entirely via config space or via
> > device-specific BARs that are unknown to the PCI core.
> 
> OK, I did not know this . Thank you for sharing this.

This is actually quite common.  On my garden-variet laptop, this:

  $ lspci -v | grep -E "^(\S|        (Memory|I/O))"

finds two type 0 devices that have no BARs:

  00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
  00:1f.0 ISA bridge: Intel Corporation CM238 Chipset LPC/eSPI Controller

I don't really want to add more dmesg logging for things like this
that are working correctly.  In this case, I think the best solution
is to either keep this patch in your private branch for testing or to
manually inspect the dmesg log, where we already log every BAR we
discover, for devices that should have BARs but don't.

> > > Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> > > ---
> > >  drivers/pci/probe.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > 953f15abc850..6438d6d56777 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -321,6 +321,7 @@ int __pci_read_base(struct pci_dev *dev, enum
> > > pci_bar_type type,  static void pci_read_bases(struct pci_dev *dev,
> > > unsigned int howmany, int rom)  {
> > >  	unsigned int pos, reg;
> > > +	bool found = false;
> > >
> > >  	if (dev->non_compliant_bars)
> > >  		return;
> > > @@ -333,8 +334,12 @@ static void pci_read_bases(struct pci_dev *dev,
> > unsigned int howmany, int rom)
> > >  		struct resource *res = &dev->resource[pos];
> > >  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> > >  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
> > > +		found |= res->flags ? 1 : 0;
> > >  	}
> > >
> > > +	if (!dev->hdr_type && !found)
> > > +		pci_info(dev, "BAR size is 0 for BAR[0..%d]\n", howmany - 1);
> > > +
> > >  	if (rom) {
> > >  		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
> > >  		dev->rom_base_reg = rom;
> > > --
> > > 2.25.1
> > >
