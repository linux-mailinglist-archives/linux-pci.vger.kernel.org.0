Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0921A265
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 16:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGIOrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 10:47:10 -0400
Received: from foss.arm.com ([217.140.110.172]:34320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgGIOrK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 10:47:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DEC631B;
        Thu,  9 Jul 2020 07:47:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 233F73F792;
        Thu,  9 Jul 2020 07:47:08 -0700 (PDT)
Date:   Thu, 9 Jul 2020 15:47:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709122208.rmfeuu6zgbwh3fr5@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 02:22:08PM +0200, Pali Rohár wrote:
> On Thursday 09 July 2020 12:35:09 Lorenzo Pieralisi wrote:
> > On Thu, Jul 02, 2020 at 10:30:36AM +0200, Pali Rohár wrote:
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
> > > This is just an optimization to prevent accessing PCIe registers when card
> > > is disconnected. Trying to access PCIe registers of disconnected card does
> > > not cause any crash, kernel just needs to wait for a timeout. So if card
> > > disappear immediately after checking for PCIe link (before accessing PCIe
> > > registers), it does not cause any problems.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Changes in V3:
> > > * Add comment to the code
> > > Changes in V2:
> > > * Update commit message, mention that this is optimization
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 90ff291c24f0..d18f389b36a1 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -644,6 +644,13 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> > >  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> > >  		return false;
> > >  
> > > +	/*
> > > +	 * If the link goes down after we check for link-up, nothing bad
> > > +	 * happens but the config access times out.
> > > +	 */
> > > +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> > > +		return false;
> > > +
> > >  	return true;
> > >  }
> > 
> > Question: this basically means that you can only effectively enumerate
> > bus number == root_bus_nr and AFAICS if at probe the link did not
> > come up it will never do, will it ?
> > 
> > Isn't this equivalent to limiting the bus numbers the bridge is capable
> > of handling ?
> > 
> > Reworded: if in advk_pcie_setup_hw() the link does not come up, what's
> > the point of trying to enumerate the bus hierarchy below the root bus ?
> 
> Hello Lorenzo!
> 
> PCIe link can theoretically come up even after boot, but aardvark driver
> currently does not support link detection at runtime. So it checks and
> enumerate device only at probe time.

If the link is not up at probe enumerating devices below the root
bus is basically useless and that's actually what is causing the
delays you are fixing. Is this correct ?

> I do not know if hardware has some mechanism to inform kernel that PCIe
> link come up (or down) and re-enumeration is required. Or the only
> option is polling via advk_pcie_link_up().
> 
> So if device is not visible at the probe time then it would not appear
> in system and cannot be used. This is current state.
> 
> Just to note that our hardware does not support physical hotplug of
> mPCIe cards. You need to connect card when board is powered off.
> 
> So if at the aardvark probe time PCIe link is not up then trying to
> enumerate devices under (software) root bridge is not needed. But it is
> needed to register/enumerate software root bridge device and currently
> both is done by one (recursive) call pci_host_probe().

I understand that but the bridge bus resource can be trimmed to just
contain the root bus because that's the only one where there is a
chance you can enumerate a device.

I would like to get Bjorn's opinion on this, I don't like these "link is
up" checks in config accessors (they are racy and honestly it is a
run-time check that does not make much sense, either it is always
true/false or it is inevitably racy) I was wondering if we can find an
alternative solution but I am not sure the one I suggested above is
better than this patch.

Lorenzo
