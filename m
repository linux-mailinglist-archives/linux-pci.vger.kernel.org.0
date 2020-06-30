Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18EE20F7C3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgF3O6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 10:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgF3O6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 10:58:51 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D8E20675;
        Tue, 30 Jun 2020 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593529130;
        bh=PVTznXJyCvr/0gWflz6qqUnQVBqnaxBytLpA2ScZi2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UGrtzr6l/Dz1zgmF5Gn8ardEy1SuMln8GZ6PHPueInRFfTdL6xyccEtApRZUKzTkL
         j88PiPHDI8upfuyPX0p7SuHNe/Dn2IeiyQaogjChp6gqk6lkgA3IFhSioq7CnkWU/6
         +rJo94TNidFUjFViAcaPH9sNj1lnDmYdpa+4u5b4=
Date:   Tue, 30 Jun 2020 09:58:48 -0500
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
Message-ID: <20200630145848.GA3419143@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630140420.7qkuq7wturmaafzf@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 04:04:20PM +0200, Pali Rohár wrote:
> On Tuesday 30 June 2020 08:51:27 Bjorn Helgaas wrote:
> > On Thu, May 28, 2020 at 06:38:09PM +0200, Pali Rohár wrote:
> > > On Thursday 28 May 2020 11:26:04 Bjorn Helgaas wrote:
> > > > On Thu, May 28, 2020 at 04:31:41PM +0200, Pali Rohár wrote:
> > > > > When there is no PCIe card connected and advk_pcie_rd_conf() or
> > > > > advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
> > > > > root bridge, the aardvark driver throws the following error message:
> > > > > 
> > > > >   advk-pcie d0070000.pcie: config read/write timed out
> > > > > 
> > > > > Obviously accessing PCIe registers of disconnected card is not possible.
> > > > > 
> > > > > Extend check in advk_pcie_valid_device() function for validating
> > > > > availability of PCIe bus. If PCIe link is down, then the device is marked
> > > > > as Not Found and the driver does not try to access these registers.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > index 90ff291c24f0..53a4cfd7d377 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> > > > >  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> > > > >  		return false;
> > > > >  
> > > > > +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> > > > > +		return false;
> > > > 
> > > > I don't think this is the right fix.  This makes it racy because the
> > > > link may go down after we call advk_pcie_valid_device() but before we
> > > > perform the config read.
> > > 
> > > Yes, it is racy, but I do not think it cause problems. Trying to read
> > > PCIe registers when device is not connected cause just those timeouts,
> > > printing error message and increased delay in advk_pcie_wait_pio() due
> > > to polling loop. This patch reduce unnecessary access to PCIe registers
> > > when advk_pcie_wait_pio() polling just fail.
> > 
> > What happens when the device is removed after advk_pcie_link_up()
> > returns true, but before we actually do the config access?
> 
> Do you mean to remove device physically at runtime? I was told that our
> board would crash or issue reset. Removing device from mini PCIe slot
> without power off is not supported.

Right, I don't think PCIe mini cards support hotplug.

> Anyway, currently we are trying to read from device registers even when
> no device is connected. So when advk_pcie_link_up() returns true and
> after that device is not connected (somehow board and kernel would be
> still alive) I guess that it would behave as without applying this
> patch. So kernel starts reading from register and would wait until
> timeout expires. As device is not connected there would be no answer,
> so kernel print error message to dmesg (same as in commit message) and
> returns error that read failed.

OK, so if I understand correctly, checking advk_pcie_link_up() is
strictly an optimization.  If we guess wrong (e.g., after calling
advk_pcie_link_up(), the link went down because the card was removed,
DPC triggered, etc), the only bad thing is that we wait for a timeout;
it never causes a crash.

If that's the case, I'm fine with this.  But please add a comment to
that effect.

I think several other drivers check for the link being up because we
actually crash if we try to read config space when the link is down.
That's what I was trying to avoid here.

Bjorn
