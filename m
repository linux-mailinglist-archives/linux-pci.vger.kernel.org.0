Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5277C1C8CDB
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGNqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 09:46:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:26139 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgEGNqb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 09:46:31 -0400
IronPort-SDR: dyuoTG0Bi6WNRWtw7MSG0XPA9ShvrC+d1g7GGR3mJDZNUeSalthcJbJXKRZpL4QMxhtF7ra3fY
 Ku9HgcsP1v/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:46:30 -0700
IronPort-SDR: h/bfegnZUD8K/637QCmj55W6107uxV04ghTbNkrpXXGpDlrAWPz/0/16CADkkgbF3EJZKswQCD
 F6EW3KnRIZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="370120789"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 May 2020 06:46:27 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 07 May 2020 16:46:27 +0300
Date:   Thu, 7 May 2020 16:46:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     bjorn@helgaas.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200507134627.GY487496@lahna.fi.intel.com>
References: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
 <20200506224228.GA458845@bjorn-Precision-5520>
 <20200507114553.GH487496@lahna.fi.intel.com>
 <CABhMZUVsYUc7o-LLSdy1XzD55zTJk74A6JdSftHdxVJs2-LWFQ@mail.gmail.com>
 <20200507123558.GS487496@lahna.fi.intel.com>
 <CABhMZUVqH-4Qkf=P2gDBdQQR8rqs3R2r5_YkFnspmUO6qe-jDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUVqH-4Qkf=P2gDBdQQR8rqs3R2r5_YkFnspmUO6qe-jDQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 08:33:27AM -0500, Bjorn Helgaas wrote:
> On Thu, May 7, 2020 at 7:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, May 07, 2020 at 07:24:37AM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 7, 2020 at 6:45 AM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > On Wed, May 06, 2020 at 05:42:28PM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> > > > > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > > > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > > > > sleep (s2idle).
> > > > > >
> > > > > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > > > > announces support for speeds > 5 GT/s but it is then capped by the
> > > > > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > > > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > > > > it ended up waiting for 1100 ms as these ports do not support active
> > > > > > link layer reporting either.
> > > > > >
> > > > > > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > > > > > before sending configuration request to the device below, if the port
> > > > > > does not support speeds > 5 GT/s, and if it does we first need to wait
> > > > > > for the data link layer to become active before waiting for that 100 ms.
> > > > > >
> > > > > > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > > > > > that support speeds > 5 GT/s must support active link layer reporting so
> > > > > > instead of looking for the speed we can check for the active link layer
> > > > > > reporting capability and determine how to wait based on that (as they go
> > > > > > hand in hand).
> > > > >
> > > > > I can't quite tell what the defect is here.
> > > > >
> > > > > I assume you're talking about this text from sec 6.6.1:
> > > > >
> > > > >   - With a Downstream Port that does not support Link speeds greater
> > > > >     than 5.0 GT/s, software must wait a minimum of 100 ms before
> > > > >     sending a Configuration Request to the device immediately below
> > > > >     that Port.
> > > > >
> > > > >   - With a Downstream Port that supports Link speeds greater than 5.0
> > > > >     GT/s, software must wait a minimum of 100 ms after Link training
> > > > >     completes before sending a Configuration Request to the device
> > > > >     immediately below that Port. Software can determine when Link
> > > > >     training completes by polling the Data Link Layer Link Active bit
> > > > >     or by setting up an associated interrupt (see Section 6.7.3.3 ).
> > > > >
> > > > > I don't understand what Link Control 2 has to do with this.  The spec
> > > > > talks about ports *supporting* certain link speeds, which sounds to me
> > > > > like the Link Capabilities.  It doesn't say anything about the current
> > > > > or target link speed.
> > > >
> > > > PCIe 5.0 page 764 recommends using Supported Link Speeds Vector in Link
> > > > Capabilities 2 register and that's what pcie_get_speed_cap() is doing.
> > > >
> > > > However, we can avoid figuring the speed altogether by checking the
> > > > dev->link_active_reporting instead because that needs to be implemented
> > > > by all Downstream Ports that supports speeds > 5 GT/s (PCIe 5.0 page 735).
> > >
> > > I understand that part.  But the code as-is matches sec 6.6.1, which
> > > makes it easy to understand.  Checking link_active_reporting instead
> > > makes it harder to understand because it makes it one step removed
> > > from 6.6.1.  And link_active_reporting must be set for ports that
> > > support > 5 GT/s, but it must *also* be set in some hotplug cases, so
> > > that further complicates the connection between it and 6.6.1.
> > >
> > > And apparently there's an actual defect, and I don't understand what
> > > that is yet.  It sounds like we agree that pcie_get_speed_cap() is
> > > doing the right thing.  Is there something in
> > > pci_bridge_wait_for_secondary_bus() that doesn't match sec 6.6.1?
> >
> > The defect is that some downstream PCIe ports on a system Kai-Heng is
> > using have Supported Link Speeds Vector with > 5GT/s and it does not
> > support active link reporting so the currect code ends up waiting 1100 ms
> > slowing down resume time.
> 
> That sounds like a hardware defect that should be worked around with a
> quirk or something.  If we just restructure the code to avoid the
> problem, we're likely to reintroduce it later because there's no hint
> in the code about this problem.

That's why I added the comment there to explain this.

Can you propose a patch following what you were thinking that solves
this so Kai-Heng can try it out?

> > The Target Link Speed of this port (in Link Control 2) has the speed
> > capped to 2.5 GT/s.
> 
> I saw you mentioned this before, but I don't understand yet why it's
> relevant.  The spec says "supported,", not "current" or "target".

Because my interpretation of this part of the spec is that supported
speed is supported up to what is set in target speed. In other words you
can have 8GT/s there in the supported vector and the hardware/firmware
can force the target to be lower therefore the link speed is always
capped by that.

I'm not talking about "current" here. Only "supported" and "target".
