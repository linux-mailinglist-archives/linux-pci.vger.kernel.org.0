Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1C487F2F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiAGXCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 18:02:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37276 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiAGXB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 18:01:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 888D2B80B50;
        Fri,  7 Jan 2022 23:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6867C36AE9;
        Fri,  7 Jan 2022 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641596517;
        bh=B0v7iGUci7GVYDzdLRx77A6fKfqdb4qSSCogIqDJ8Ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PpsUtqiQCt8YbFCwFZYodxNP6vINYMVpPjhATJ7rYrs4f2Pb02CYJSS8h9BEdDv9+
         8Vx9ey3K0YfnP3JUpt962jGDFz66TfUix2SYLQGx9sP+tWbsd4RJLZfUCmLEzA/Avj
         HseUDM8G3JHkZxORXrpAzkWmyoizld66HY1+Sug0EnulHI7MN6ixQxG/uvsCxjVs+V
         f80Z4rWTylYcehWWN2hhomoR4+Xe5wg1BEGITEbn5wO89A/ZQk6ZxuxaoIZaJRX1vl
         TQH2Ej6/KuQQQRxlbxE64V7HYN04mhqaM/ehreiIPFSx4n4izb0IJWiIrORyYSmOHe
         zpQs6rLzoZP4Q==
Date:   Fri, 7 Jan 2022 17:01:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] PCI: mvebu: Disallow mapping interrupts on
 emulated bridges
Message-ID: <20220107230155.GA425110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107221348.5s4ehqhxunmoacbm@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 11:13:48PM +0100, Pali Rohár wrote:
> On Friday 07 January 2022 15:32:16 Bjorn Helgaas wrote:
> > On Thu, Nov 25, 2021 at 01:45:55PM +0100, Pali Rohár wrote:
> > > Interrupt support on mvebu emulated bridges is not implemented yet.
> > 
> > Is this mvebu-specific, or is aardvar also affected?
> 
> This is pci-mvebu.c driver specific, it does not implement emulation of
> neither INTx, nor MSI interrupts for emulated pci bridge (root port). As
> we know this HW does not have compliant pci root port, it needs to be
> emulated in driver, and emulation for interrupts is missing. (it means
> that also AER interrupt is missing).
> 
> And pci-aardvark.c driver has same issue and similar patch is required
> for pci-aardvark.c too. Marek should take care of it. But for
> pci-aardvark we already have implementation which emulates INTx
> interrupts and it is waiting for review on the list:
> https://lore.kernel.org/linux-pci/20211208061851.31867-1-kabel@kernel.org/
> 
> > > So properly indicate return value to callers that they cannot request
> > > interrupts from emulated bridge.
> > 
> > Pet peeve: descriptions that say "do this *properly*".  As though the
> > previous authors were just ignorant or intentionally did something
> > *improperly* :)
> > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > index 19c6ee298442..a3df352d440e 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -705,6 +705,15 @@ static struct pci_ops mvebu_pcie_ops = {
> > >  	.write = mvebu_pcie_wr_conf,
> > >  };
> > >  
> > > +static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > > +{
> > > +	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> > > +	if (dev->bus->number == 0)
> > > +		return 0; /* Proper return code 0 == NO_IRQ */
> > > +
> > > +	return of_irq_parse_and_map_pci(dev, slot, pin);
> > 
> > Is this something that could be done with a .read_base() op, e.g.,
> > make PCI_INTERRUPT_PIN contain zero (PCI_INTERRUPT_UNKNOWN)?
> 
> I'm not sure... maybe. I choose this style as after I implement
> emulation of INTx interrupts it allows me just to replace "return 0;" by
> "return my_mapping_function_for_root_port(...);". 

OK, so even after you implement INTx for the emulated Root Ports, the
default of_irq_parse_and_map_pci() is insufficient, and you will
require an mvebu .map_irq() function.  That's reasonable.

"PCI_INTERRUPT_PIN == 0" is the way software learns that a device
doesn't use INTx, of course, and I suppose PCI_INTERRUPT_PIN already
reads as zero, since mvebu_pci_bridge_emul_init() doesn't set
bridge->conf.intpin, and I assume the default value would be zero?

Bjorn
