Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9949547
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfFQWlE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 18:41:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64736 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfFQWlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 18:41:04 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id be3d876888b6f07f; Tue, 18 Jun 2019 00:41:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/PME: Fix race on PME polling
Date:   Tue, 18 Jun 2019 00:41:01 +0200
Message-ID: <2521908.csJO6TsRBn@kreacher>
In-Reply-To: <20190617143510.GT2640@lahna.fi.intel.com>
References: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de> <1957149.eOSnrBRbHu@kreacher> <20190617143510.GT2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, June 17, 2019 4:35:10 PM CEST Mika Westerberg wrote:
> On Mon, Jun 17, 2019 at 12:37:06PM +0200, Rafael J. Wysocki wrote:
> > On Sunday, June 9, 2019 1:29:33 PM CEST Lukas Wunner wrote:
> > > Since commit df17e62e5bff ("PCI: Add support for polling PME state on
> > > suspended legacy PCI devices"), the work item pci_pme_list_scan() polls
> > > the PME status flag of devices and wakes them up if the bit is set.
> > > 
> > > The function performs a check whether a device's upstream bridge is in
> > > D0 for otherwise the device is inaccessible, rendering PME polling
> > > impossible.  However the check is racy because it is performed before
> > > polling the device.  If the upstream bridge runtime suspends to D3hot
> > > after pci_pme_list_scan() checks its power state and before it invokes
> > > pci_pme_wakeup(), the latter will read the PMCSR as "all ones" and
> > > mistake it for a set PME status flag.  I am seeing this race play out as
> > > a Thunderbolt controller going to D3cold and occasionally immediately
> > > going to D0 again because PM polling was performed at just the wrong
> > > time.
> > > 
> > > Avoid by checking for an "all ones" PMCSR in pci_check_pme_status().
> > > 
> > > Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
> > > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: stable@vger.kernel.org # v2.6.34+
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/pci/pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8abc843b1615..eed5db9f152f 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1989,6 +1989,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
> > >  	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> > >  	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> > >  		return false;
> > > +	if (pmcsr == 0xffff)
> > > +		return false;
> > >  
> > >  	/* Clear PME status. */
> > >  	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> > > 
> > 
> > Added to my 5.3 queue, thanks!
> 
> Today when doing some PM testing I noticed that this patch actually
> reveals an issue in our native PME handling. Problem is in
> pcie_pme_handle_request() where we first convert req_id to struct
> pci_dev and then call pci_check_pme_status() for it. Now, when a device
> triggers wake the link is first brought up and then the PME is sent to
> root complex with req_id matching the originating device. However, if
> there are PCIe ports in the middle they may still be in D3 which means
> that pci_check_pme_status() returns 0xffff for the device below so there
> are lots of
> 
> 	Spurious native interrupt"
> 
> messages in the dmesg but the actual PME is never handled.
> 
> It has been working because pci_check_pme_status() returned true in case
> of 0xffff as well and we went and runtime resumed to originating device.

In this case 0xffff is as good as PME Status set, that is the device needs to be
resumed.

This is a regression in the $subject patch, not a bug in the PME code.

> I think the correct way to handle this is actually drop the call to
> pci_check_pme_status() in pcie_pme_handle_request() because the whole
> idea of req_id in PME message is to allow the root complex and SW to
> identify the device without need to poll for the PME status bit.

Not really, because if there is a PCIe-to-PCI bridge below the port, it is
expected to use the req_id of the bridge for all of the devices below it.

I'm going to drop this patch from my queue.



