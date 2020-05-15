Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E01D5B01
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOUxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 16:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEOUxY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 16:53:24 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C4B205CB;
        Fri, 15 May 2020 20:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589576003;
        bh=/Iwb+td4MxPQglrT0VvZCwMFa1bO2G0rLLp/F8fEdOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uhoj7S8JFD1zV6yxDNCrt1I9DW6e2tErxXu/6zhumJ28mNrSJ+05rewlaCXPQGGIU
         8t45ls2qNvIal3+JD4NfuSKyrbTHFYrtHvtX3k5s/xMg+Zz7TuLNsMAf75y0Pq0nnh
         gOIICxS91M/rTaMHn3HRga58TTOt/EmHtK/CGz+w=
Date:   Fri, 15 May 2020 15:53:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine
 when to start waiting
Message-ID: <20200515205321.GA538705@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515095535.GH2571@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 12:55:35PM +0300, Mika Westerberg wrote:
> On Thu, May 14, 2020 at 05:41:32PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 14, 2020 at 04:30:43PM +0300, Mika Westerberg wrote:
> > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > sleep (s2idle).
> > > 
> > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > announces support for speeds > 5 GT/s but it is then capped by the
> > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > it ended up waiting for 1100 ms as these ports do not support active
> > > link layer reporting either.
> > 
> > I don't think PCI_EXP_LNKCTL2 is relevant here.  I think the lack of
> > Data Link Layer Link Active is just a chip erratum.  Is that
> > documented anywhere?
> 
> I think it is relevant because if you hard-code (hardware) LNKCTL2 to
> always target 2.5GT/s then it effectively does not need to implement
> data link layer active because the link speed never goes higher than
> that.

I don't think it's reasonable to expect software to check Link
Capabilities 2, then try to write Link Control 2 and figure out
whether the target speed is hard-wired.  I think these devices
are just broken (at least per spec).

> > > @@ -4701,7 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
> > >  		msleep(10);
> > >  		timeout -= 10;
> > >  	}
> > 
> > I think maybe the code above (not included in the context here) should
> > say:
> > 
> >   if (!pdev->link_active_reporting) {
> >     msleep(timeout + delay);
> >     return true;
> >   }
> > 
> > to match the rest of 4827d63891b6 ("PCI/PM: Add
> > pcie_wait_for_link_delay()").  What do you think?  If you agree, I'd
> > make that a separate patch because it's not related to the current
> > fix.
> 
> Yes, I agree.

OK, I added a patch to do this and applied both to pci/pm for v5.8.
Thanks!

Bjorn
