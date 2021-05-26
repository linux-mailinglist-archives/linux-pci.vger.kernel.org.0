Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0171391538
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhEZKo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:44:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:49232 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234083AbhEZKoY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 06:44:24 -0400
IronPort-SDR: qQkcY2xXSkWW8h/1QpUITYGcRz/Od1JOTD0ZHuCatZytLhcdSXj//3tLbCPEhNOqnNSYZsdcli
 QbwxL7M0XYyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="266329583"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="266329583"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 03:42:48 -0700
IronPort-SDR: roehaz2kwBxDRGnqcDF28RuFQa1/Ls5i+Y4NuZlmi+Gqt7RZ87l2WH7Akp3S6zD6m1iXYGw5uK
 x9f5yuUzr3qA==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="397247961"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 03:42:45 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 26 May 2021 13:42:43 +0300
Date:   Wed, 26 May 2021 13:42:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge
 is power manageable
Message-ID: <20210526104243.GC291593@lahna.fi.intel.com>
References: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
 <20210525233604.GA1236347@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525233604.GA1236347@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, May 25, 2021 at 06:36:04PM -0500, Bjorn Helgaas wrote:
> On Mon, May 10, 2021 at 01:26:47PM +0300, Mika Westerberg wrote:
> > ASMedia xHCI controller only supports PME from D3cold:
> > 
> > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> >   ...
> >   Capabilities: [78] Power Management version 3
> >   	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > 	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 
> > Now, if the controller is part of a Thunderbolt device for instance, it
> > is connected to a PCIe switch downstream port. When the hierarchy then
> > enters D3cold as a result of s2idle cycle pci_target_state() returns D0
> > because the device does not support PME from the default target_state
> > (D3hot). So what happens is that the whole hierarchy is left into D0
> > breaking power management.
> > 
> > For this reason choose target_state to be D3cold if there is a upstream
> > bridge that is power manageable. The reasoning here is that the upstream
> > bridge will be also placed into D3 making the effective power state of
> > the device in question to be D3cold.
> 
> I'm having a hard time understanding this in a generic way and
> relating it to anything in the specs.  This isn't written as a quirk,
> so I assume this is not specific to the ASM1042A or to Thunderbolt.

Right. Sorry about that. I tried to explain this as well as I can.

> The same considerations apparently should apply to *any* device that
> is below a power-manageable bridge and doesn't support PME from D3hot.
> If so, let's lead off the commit log with that, and use ASM1042A
> merely as an example instead of as the motivation.

OK, got it.

> "When the hierarchy enters D3cold" -- I guess you mean the bridge and
> all downstream devices are in D3cold?  Does a bridge being in D3cold
> actually force all downstream devices to be in D3cold as well?  I
> guess not, because it seems that the bridge is in D3 but the whole
> point of this is to change the target_state of the device from D0 to
> D3cold, right?

Right but the upstream bridge must not be in higher power state than the
children so if the brige is in D3cold so are its children. Otherwise it
is against the PCIe spec.

> Is s2idle relevant in itself?  My impression is that the important
> things are the PME capabilities and the D0/D3hot/D3cold states of the
> bridge and the device, and "s2idle" is just a distraction.

It is not relevant. Only an example of a situation we observe the issue.

> "Breaking power management" -- I assume this just means we don't save
> as much power as we'd like?

Yes, it means we leave one root port and the connected devices fully
powered, and in case of Intel hardware it means the system does not
enter low power idle states either.

> "For this reason" -- I missed the actual reason.  Is the reason "the
> whole hierarchy is in D0 and wastes more power"?  I guess we don't
> really need a *reason*; saving power is good enough.  What we *do*
> need is justification for why it is safe, and I can't connect the dots
> yet.
> 
> You mention putting the bridge in D3.  Does that mean D3hot or D3cold?
> If it can be either, say that.  If it means only one, be specific.
> I'd like to eradicate "D3" from PCI because the ambiguity just makes
> things hard.

It means D3hot but later on D3cold once the ACPI power resource has been
turned off. That's why I said only D3. But sure.

> What does "the effective power state of the device is D3cold" mean?
> Does that mean the device is *actually* in D3cold, so it has no power
> and will need complete re-initialization?  Or does it simply mean that
> the device is unreachable because the bridge is not in D0, and the OS
> can't directly wake it?

It means the upstream bridge is in D3hot and thus not forward
configuration requests to the device below it. In addition once all the
devices under the root port are in D3hot the ACPI powre resource is
turned off, the links go to L2 (or L3) and the device is actually in
D3cold and need to go through reset and complete re-initialization
before it can be functional again.

> These are all questions I'd like to see answered in the commit log,
> not just in the email thread.

Sure.

In a nutshell what happens here is that the one device prevents all the
devices above it (up to the root port) to enter low power states thus
wasting energy.

I will add all these to the commit log in next version.

> > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > Reported-by: Koba Ko <koba.ko@canonical.com>
> > Tested-by: Koba Ko <koba.ko@canonical.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b717680377a9..e3f3b9010762 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2578,8 +2578,19 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> >  		return target_state;
> >  	}
> >  
> > -	if (!dev->pm_cap)
> > +	if (!dev->pm_cap) {
> >  		target_state = PCI_D0;
> > +	} else {
> > +		struct pci_dev *bridge;
> > +
> > +		/*
> > +		 * If the upstream bridge can be put to D3 then it means
> > +		 * that our target state is D3cold instead of D3hot.
> 
> Can you expand on this a bit?  Expand "D3" to be specific, and more
> importantly, say something about *why* the target state is D3cold.

OK.

> > +		 */
> > +		bridge = pci_upstream_bridge(dev);
> > +		if (bridge && pci_bridge_d3_possible(bridge))
> > +			target_state = PCI_D3cold;
> 
> I guess we don't or can't do this for the
> platform_pci_power_manageable() case?

No because this may be a bridge that has no ACPI description (e.g
further down the hierarchy).

> 
> > +	}
> >  
> >  	/*
> >  	 * If the device is in D3cold even though it's not power-manageable by
> > -- 
> > 2.30.2
> > 
