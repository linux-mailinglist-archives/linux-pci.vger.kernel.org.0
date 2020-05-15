Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6E21D4A24
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgEOJzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 05:55:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:60197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgEOJzj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 05:55:39 -0400
IronPort-SDR: c/6+z+AQWN/t6qum0eirLnQwzkiqU+VhtEWi5w9JBHiZSlKNIg1IzJTLHRZ8fY3lfjeQReS/nO
 6jmDcB5WSITg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 02:55:38 -0700
IronPort-SDR: BDqmiyszU3H7FLlVNyHi+5zhGZbpkirlxpkiCBtSDCQ2DUtnw2JJQtehQFhK6vJI9CuqU81BLn
 M6QPwaiy8JOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="372642669"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 May 2020 02:55:36 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 15 May 2020 12:55:35 +0300
Date:   Fri, 15 May 2020 12:55:35 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine
 when to start waiting
Message-ID: <20200515095535.GH2571@lahna.fi.intel.com>
References: <20200514133043.27429-1-mika.westerberg@linux.intel.com>
 <20200514224132.GA476999@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514224132.GA476999@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 05:41:32PM -0500, Bjorn Helgaas wrote:
> On Thu, May 14, 2020 at 04:30:43PM +0300, Mika Westerberg wrote:
> > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > Thunderbolt connected PCIe devices from both runtime suspend and system
> > sleep (s2idle).
> > 
> > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > announces support for speeds > 5 GT/s but it is then capped by the
> > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > it ended up waiting for 1100 ms as these ports do not support active
> > link layer reporting either.
> 
> I don't think PCI_EXP_LNKCTL2 is relevant here.  I think the lack of
> Data Link Layer Link Active is just a chip erratum.  Is that
> documented anywhere?

I think it is relevant because if you hard-code (hardware) LNKCTL2 to
always target 2.5GT/s then it effectively does not need to implement
data link layer active because the link speed never goes higher than
that.

I don't think these devices have public documentation.

> > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > before sending configuration request to the device below, if the port
> > does not support speeds > 5 GT/s, and if it does we first need to wait
> > for the data link layer to become active before waiting for that 100 ms.
> > 
> > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > that support speeds > 5 GT/s must support active link layer reporting so
> > instead of looking for the speed we can check for the active link layer
> > reporting capability and determine how to wait based on that (as they go
> > hand in hand).
> > 
> > While there restructure the code a bit so that the delay is always
> > issued in pci_bridge_wait_for_secondary_bus() by passing value of 0 to
> > pcie_wait_for_link_delay().
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
> > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > v2: Restructured the code a bit so that it should be more readable now
> > 
> > Previous version can be found here:
> > 
> >   https://lore.kernel.org/linux-pci/20200514123105.GW2571@lahna.fi.intel.com/
> > 
> > @Kai-heng, since this patch is slightly different than what you tried, I
> > wonder if you could check that it still solves the and does not break
> > anything? I tested it myself but it would be nice to get your Tested-by to
> > make sure it still works.
> > 
> >  drivers/pci/pci.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 595fcf59843f..590c73dc7e0d 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4660,7 +4660,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
> >   * pcie_wait_for_link_delay - Wait until link is active or inactive
> >   * @pdev: Bridge device
> >   * @active: waiting for active or inactive?
> > - * @delay: Delay to wait after link has become active (in ms)
> > + * @delay: Delay to wait after link has become active (in ms). Specify %0
> > + *	   for no delay.
> >   *
> >   * Use this to wait till link becomes active or inactive.
> >   */
> > @@ -4701,7 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
> >  		msleep(10);
> >  		timeout -= 10;
> >  	}
> 
> I think maybe the code above (not included in the context here) should
> say:
> 
>   if (!pdev->link_active_reporting) {
>     msleep(timeout + delay);
>     return true;
>   }
> 
> to match the rest of 4827d63891b6 ("PCI/PM: Add
> pcie_wait_for_link_delay()").  What do you think?  If you agree, I'd
> make that a separate patch because it's not related to the current
> fix.

Yes, I agree.

> > -	if (active && ret)
> > +	if (active && ret && delay)
> >  		msleep(delay);
> >  	else if (ret != active)
> >  		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> > @@ -4822,17 +4823,21 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> >  	if (!pcie_downstream_port(dev))
> >  		return;
> >  
> > -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> > -		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > -		msleep(delay);
> > -	} else {
> > -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> > -			delay);
> > -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > +	/*
> > +	 * Since PCIe spec mandates that all downstream ports that support
> > +	 * speeds greater than 5 GT/s must support data link layer active
> > +	 * reporting so if it is supported we poll for the link to become
> > +	 * active before issuing the mandatory delay.
> > +	 */
> > +	if (dev->link_active_reporting) {
> > +		pci_dbg(dev, "waiting for link to train\n");
> > +		if (!pcie_wait_for_link_delay(dev, true, 0)) {
> >  			/* Did not train, no need to wait any further */
> >  			return;
> >  		}
> >  	}
> > +	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
> > +	msleep(delay);
> 
> Nice solution, I like this a lot.

Thanks :)
