Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F01233BE2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgG3XGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 19:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgG3XGS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 19:06:18 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8259520809;
        Thu, 30 Jul 2020 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596150377;
        bh=XZAB7/fZnfkuIRM5weyfnSOH4dtm24JM37i8kd8fb0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DHbDdVv+1PCE/WJLTW/9fb3yTUFE9kW0cHEGToZto8khqHM/ecQfNJw2QX7JXdaxP
         HJFyN96WLztU5Pf0s5zoPgR/8mqQtXIW7iLFizB0XFahKVj7uBYMWB218OVfObaZlr
         LDwfHJ+EOq8X6dfw+7K1sQBNLgbWmBHsqjKQWjAA=
Date:   Thu, 30 Jul 2020 18:06:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
Message-ID: <20200730230615.GA2083229@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee5e0f76435883d6f5eec9f6483e283e2e652e0.camel@alliedtelesis.co.nz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 10:58:03PM +0000, Mark Tomlinson wrote:
> On Thu, 2020-07-30 at 11:09 -0500, Bjorn Helgaas wrote:
> > I think it would be better to have a warning once per device, so if
> > XYZ device has a problem and we look at the dmesg log, we would find a
> > single message for device XYZ as a hint.  Would that reduce the
> > nuisance level enough?
> 
> We would be OK with that.
> 
> > So I think I did it wrong in fb2659230120 ("PCI: Warn on possible RW1C
> > corruption for sub-32 bit config writes").  Ratelimiting is the wrong
> > concept because what we want is a single warning per device, not a
> > limit on the similar messages for *all* devices, maybe something like
> > this:
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 79c4a2ef269a..e5f956b7e3b7 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
> >  	 * write happen to have any RW1C (write-one-to-clear) bits set, we
> >  	 * just inadvertently cleared something we shouldn't have.
> >  	 */
> > -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> > +	if (!(bus->unsafe_warn & (1 << devfn))) {
> > +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> >  			     size, pci_domain_nr(bus), bus->number,
> >  			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> > +		bus->unsafe_warn |= 1 << devfn;
> > +	}
> 
> As I understand it, devfn is an 8-bit value with five bits of device
> and three bits of function. So (1 << devfn) is not going to fit in an
> 8-bit mask. Am I missing something here? (I do admit that my PCI
> knowledge is not great).

You're not missing anything, I just screwed up.  What I was really
*hoping* to do was just put a bit in the pci_dev, but of course, these
functions don't have a pci_dev.  256 bits in the bus seems like a
little overkill though.  Maybe we just give up on the exact device and
warn only once per *bus* instead of once per device.

Bjorn
