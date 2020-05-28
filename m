Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0F1E67C3
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405081AbgE1Qtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 12:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405212AbgE1Qtk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 12:49:40 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F0D2075A;
        Thu, 28 May 2020 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590684580;
        bh=ZvL1zlVb0aD8FKJBrJFoJZtl2vsqUfSH5YS12c2w2SM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sYevLuoNVsyrmYY7rW9ivvtRaYn2l5/dFD1SMhThUEUwgqBgx2xM4JoAwMmw4YZWx
         Dzr1IMGNmQgl34snFo+oKIZ/ITX3HRABJ3tIplUBnyQwrZh9dOib2KXIhkt229uyWJ
         3AXVQZOyeR0LWXJLEqlaQiw+AJ+d/BvhdrXnXQeM=
Date:   Thu, 28 May 2020 11:49:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200528164938.GA325239@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528163809.54f5ldvphrjg3zg3@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 06:38:09PM +0200, Pali Rohár wrote:
> On Thursday 28 May 2020 11:26:04 Bjorn Helgaas wrote:
> > On Thu, May 28, 2020 at 04:31:41PM +0200, Pali Rohár wrote:
> > > When there is no PCIe card connected and advk_pcie_rd_conf() or
> > > advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
> > > root bridge, the aardvark driver throws the following error message:
> > > 
> > >   advk-pcie d0070000.pcie: config read/write timed out
> > > 
> > > Obviously accessing PCIe registers of disconnected card is not possible.
> > > 
> > > Extend check in advk_pcie_valid_device() function for validating
> > > availability of PCIe bus. If PCIe link is down, then the device is marked
> > > as Not Found and the driver does not try to access these registers.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 90ff291c24f0..53a4cfd7d377 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> > >  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> > >  		return false;
> > >  
> > > +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> > > +		return false;
> > 
> > I don't think this is the right fix.  This makes it racy because the
> > link may go down after we call advk_pcie_valid_device() but before we
> > perform the config read.
> 
> Yes, it is racy, but I do not think it cause problems. Trying to read
> PCIe registers when device is not connected cause just those timeouts,
> printing error message and increased delay in advk_pcie_wait_pio() due
> to polling loop. This patch reduce unnecessary access to PCIe registers
> when advk_pcie_wait_pio() polling just fail.
> 
> I think it is a good idea to not call blocking advk_pcie_wait_pio() when
> it is not needed. We could have faster enumeration of PCIe buses when
> card is not connected.

Maybe advk_pcie_check_pio_status() and advk_pcie_wait_pio() could be
combined so we could get the correct error status as soon as it's
available, without waiting for a timeout?

In any event, the "return PCIBIOS_SET_FAILED" needs to be fixed.  Most
callers of config read do not check for failure, but most of the ones
that do, check for "val == ~0".  Only a few check for a status of
other than PCIBIOS_SUCCESSFUL.

> > I have no objection to removing the "config read/write timed out"
> > message.  The "return PCIBIOS_SET_FAILED" in the read case probably
> > should be augmented by setting "*val = 0xffffffff".
> > 
> > >  	return true;
> > >  }
> > >  
> > > -- 
> > > 2.20.1
> > > 
