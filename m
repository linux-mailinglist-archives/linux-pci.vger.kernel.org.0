Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9BF487ECE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiAGWNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 17:13:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35730 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiAGWNw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 17:13:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7265761F91;
        Fri,  7 Jan 2022 22:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C2C36AE5;
        Fri,  7 Jan 2022 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641593631;
        bh=+3FuxUsrKBUc2IlJq0f1g+eSjV4pqTc2ghBlUEwRFd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtdR6LixBKz2wS7pLPjLqaQxIFFSl36+6Tlr1HPbgQUlY1zjL3M5M6BDbBsydPEwl
         xhXCcOsApI5JiQfZ5+/fWxsslnGFwDxh9pGfE/Auskqkkj04v3I7WIe9KaGvPnDP3Q
         ujsNV/ILO0nHIO8614Lna9Icc11uhE+5HDBtaBLiQq1AuIjLkqeIsp/tHH3JAh626i
         FoVSzBh2Ax9WekMtUZyNM2KKpHhX4NkuA7uFejmiow3+y1jU9OHetoDa/brTtV7zoh
         fhh36FgqCK1da597fbbR9khcsleoA+PBQDOzNRw3xYGYOpCbZFkeF+vjpaLJQNhNfX
         y5+VKlo/ehlyw==
Received: by pali.im (Postfix)
        id 1938CB22; Fri,  7 Jan 2022 23:13:49 +0100 (CET)
Date:   Fri, 7 Jan 2022 23:13:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] PCI: mvebu: Disallow mapping interrupts on
 emulated bridges
Message-ID: <20220107221348.5s4ehqhxunmoacbm@pali>
References: <20211125124605.25915-6-pali@kernel.org>
 <20220107213216.GA403555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107213216.GA403555@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 15:32:16 Bjorn Helgaas wrote:
> On Thu, Nov 25, 2021 at 01:45:55PM +0100, Pali Rohár wrote:
> > Interrupt support on mvebu emulated bridges is not implemented yet.
> 
> Is this mvebu-specific, or is aardvar also affected?

This is pci-mvebu.c driver specific, it does not implement emulation of
neither INTx, nor MSI interrupts for emulated pci bridge (root port). As
we know this HW does not have compliant pci root port, it needs to be
emulated in driver, and emulation for interrupts is missing. (it means
that also AER interrupt is missing).

And pci-aardvark.c driver has same issue and similar patch is required
for pci-aardvark.c too. Marek should take care of it. But for
pci-aardvark we already have implementation which emulates INTx
interrupts and it is waiting for review on the list:
https://lore.kernel.org/linux-pci/20211208061851.31867-1-kabel@kernel.org/

> > So properly indicate return value to callers that they cannot request
> > interrupts from emulated bridge.
> 
> Pet peeve: descriptions that say "do this *properly*".  As though the
> previous authors were just ignorant or intentionally did something
> *improperly* :)
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 19c6ee298442..a3df352d440e 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -705,6 +705,15 @@ static struct pci_ops mvebu_pcie_ops = {
> >  	.write = mvebu_pcie_wr_conf,
> >  };
> >  
> > +static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> > +	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> > +	if (dev->bus->number == 0)
> > +		return 0; /* Proper return code 0 == NO_IRQ */
> > +
> > +	return of_irq_parse_and_map_pci(dev, slot, pin);
> 
> Is this something that could be done with a .read_base() op, e.g.,
> make PCI_INTERRUPT_PIN contain zero (PCI_INTERRUPT_UNKNOWN)?

I'm not sure... maybe. I choose this style as after I implement
emulation of INTx interrupts it allows me just to replace "return 0;" by
"return my_mapping_function_for_root_port(...);". Similarly like it is
in pending pci-aardvark.c patch:
https://lore.kernel.org/linux-pci/20211208061851.31867-15-kabel@kernel.org/

> > +}
> > +
> >  static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
> >  						 const struct resource *res,
> >  						 resource_size_t start,
> > @@ -1119,6 +1128,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  	bridge->sysdata = pcie;
> >  	bridge->ops = &mvebu_pcie_ops;
> >  	bridge->align_resource = mvebu_pcie_align_resource;
> > +	bridge->map_irq = mvebu_pcie_map_irq;
> 
> I assume this means INTx doesn't work for some devices?  Which ones?
> I guess anything on the root bus?  But INTx for devices *below* these
> emulated Root Ports *does* work?

Exactly. All devices except emulated root ports (which are on bus 0)
have working MSI, MSI-X and INTx interrupts.

> >  	return pci_host_probe(bridge);
> >  }
> > -- 
> > 2.20.1
> > 
