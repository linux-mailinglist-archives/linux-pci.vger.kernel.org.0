Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04744858D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFQOfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 10:35:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:51264 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFQOfP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 10:35:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 07:35:14 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 17 Jun 2019 07:35:11 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Jun 2019 17:35:10 +0300
Date:   Mon, 17 Jun 2019 17:35:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/PME: Fix race on PME polling
Message-ID: <20190617143510.GT2640@lahna.fi.intel.com>
References: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de>
 <1957149.eOSnrBRbHu@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957149.eOSnrBRbHu@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 12:37:06PM +0200, Rafael J. Wysocki wrote:
> On Sunday, June 9, 2019 1:29:33 PM CEST Lukas Wunner wrote:
> > Since commit df17e62e5bff ("PCI: Add support for polling PME state on
> > suspended legacy PCI devices"), the work item pci_pme_list_scan() polls
> > the PME status flag of devices and wakes them up if the bit is set.
> > 
> > The function performs a check whether a device's upstream bridge is in
> > D0 for otherwise the device is inaccessible, rendering PME polling
> > impossible.  However the check is racy because it is performed before
> > polling the device.  If the upstream bridge runtime suspends to D3hot
> > after pci_pme_list_scan() checks its power state and before it invokes
> > pci_pme_wakeup(), the latter will read the PMCSR as "all ones" and
> > mistake it for a set PME status flag.  I am seeing this race play out as
> > a Thunderbolt controller going to D3cold and occasionally immediately
> > going to D0 again because PM polling was performed at just the wrong
> > time.
> > 
> > Avoid by checking for an "all ones" PMCSR in pci_check_pme_status().
> > 
> > Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v2.6.34+
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8abc843b1615..eed5db9f152f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1989,6 +1989,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
> >  	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> >  	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> >  		return false;
> > +	if (pmcsr == 0xffff)
> > +		return false;
> >  
> >  	/* Clear PME status. */
> >  	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> > 
> 
> Added to my 5.3 queue, thanks!

Today when doing some PM testing I noticed that this patch actually
reveals an issue in our native PME handling. Problem is in
pcie_pme_handle_request() where we first convert req_id to struct
pci_dev and then call pci_check_pme_status() for it. Now, when a device
triggers wake the link is first brought up and then the PME is sent to
root complex with req_id matching the originating device. However, if
there are PCIe ports in the middle they may still be in D3 which means
that pci_check_pme_status() returns 0xffff for the device below so there
are lots of

	Spurious native interrupt"

messages in the dmesg but the actual PME is never handled.

It has been working because pci_check_pme_status() returned true in case
of 0xffff as well and we went and runtime resumed to originating device.

I think the correct way to handle this is actually drop the call to
pci_check_pme_status() in pcie_pme_handle_request() because the whole
idea of req_id in PME message is to allow the root complex and SW to
identify the device without need to poll for the PME status bit.
