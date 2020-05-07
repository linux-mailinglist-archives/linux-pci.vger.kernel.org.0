Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C261C9735
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGRLa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 13:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgEGRLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 13:11:30 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3198F2083B;
        Thu,  7 May 2020 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588871489;
        bh=ji9miQsvojjWPiHau4ve0YmAWTu9UG3t4rvaQ+hPCYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v9vR9w8b4e4h1ZxmT7hO5RahiR/PrHwTMrDV+YgsVse6Eu+KLvV5yAK/FZ0qYOFrT
         Hl2sd/B/9FIzTgiLL8MUsAPRpEN8XLnL0wka+oQ9fpuBUcY7Z7bfTGhTT7CYxpKXfd
         gaEpRsRBSkoZAVvYbPQH7jAINkwdHfHfmJ+kkQzI=
Date:   Thu, 7 May 2020 12:11:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200507171127.GA7761@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507134627.GY487496@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 04:46:27PM +0300, Mika Westerberg wrote:
> On Thu, May 07, 2020 at 08:33:27AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 7, 2020 at 7:36 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Thu, May 07, 2020 at 07:24:37AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 7, 2020 at 6:45 AM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, May 06, 2020 at 05:42:28PM -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> > > > > > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > > > > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > > > > > sleep (s2idle).
> > > > > > >
> > > > > > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > > > > > announces support for speeds > 5 GT/s but it is then capped by the
> > > > > > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > > > > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > > > > > it ended up waiting for 1100 ms as these ports do not support active
> > > > > > > link layer reporting either.
> > > > > > >
> > > > > > > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > > > > > > before sending configuration request to the device below, if the port
> > > > > > > does not support speeds > 5 GT/s, and if it does we first need to wait
> > > > > > > for the data link layer to become active before waiting for that 100 ms.
> > > > > > >
> > > > > > > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > > > > > > that support speeds > 5 GT/s must support active link layer reporting so
> > > > > > > instead of looking for the speed we can check for the active link layer
> > > > > > > reporting capability and determine how to wait based on that (as they go
> > > > > > > hand in hand).
> > > > > >
> > > > > > I can't quite tell what the defect is here.
> > > > > >
> > > > > > I assume you're talking about this text from sec 6.6.1:
> > > > > >
> > > > > >   - With a Downstream Port that does not support Link speeds greater
> > > > > >     than 5.0 GT/s, software must wait a minimum of 100 ms before
> > > > > >     sending a Configuration Request to the device immediately below
> > > > > >     that Port.
> > > > > >
> > > > > >   - With a Downstream Port that supports Link speeds greater than 5.0
> > > > > >     GT/s, software must wait a minimum of 100 ms after Link training
> > > > > >     completes before sending a Configuration Request to the device
> > > > > >     immediately below that Port. Software can determine when Link
> > > > > >     training completes by polling the Data Link Layer Link Active bit
> > > > > >     or by setting up an associated interrupt (see Section 6.7.3.3 ).
> > > > > >
> > > > > > I don't understand what Link Control 2 has to do with this.  The spec
> > > > > > talks about ports *supporting* certain link speeds, which sounds to me
> > > > > > like the Link Capabilities.  It doesn't say anything about the current
> > > > > > or target link speed.
> > > > >
> > > > > PCIe 5.0 page 764 recommends using Supported Link Speeds Vector in Link
> > > > > Capabilities 2 register and that's what pcie_get_speed_cap() is doing.
> > > > >
> > > > > However, we can avoid figuring the speed altogether by checking the
> > > > > dev->link_active_reporting instead because that needs to be implemented
> > > > > by all Downstream Ports that supports speeds > 5 GT/s (PCIe 5.0 page 735).
> > > >
> > > > I understand that part.  But the code as-is matches sec 6.6.1, which
> > > > makes it easy to understand.  Checking link_active_reporting instead
> > > > makes it harder to understand because it makes it one step removed
> > > > from 6.6.1.  And link_active_reporting must be set for ports that
> > > > support > 5 GT/s, but it must *also* be set in some hotplug cases, so
> > > > that further complicates the connection between it and 6.6.1.
> > > >
> > > > And apparently there's an actual defect, and I don't understand what
> > > > that is yet.  It sounds like we agree that pcie_get_speed_cap() is
> > > > doing the right thing.  Is there something in
> > > > pci_bridge_wait_for_secondary_bus() that doesn't match sec 6.6.1?
> > >
> > > The defect is that some downstream PCIe ports on a system Kai-Heng is
> > > using have Supported Link Speeds Vector with > 5GT/s and it does not
> > > support active link reporting so the currect code ends up waiting 1100 ms
> > > slowing down resume time.

Ah.  From the lspci and dmesg instrumentation in the bugzilla, I
guess:

  04:00.0 Thunderbolt Downstream Port to [bus 05]
    LnkCap: Speed 2.5GT/s, LLActRep-
    LnkSta: Speed 2.5GT/s
    LnkCap2: Supported Link Speeds: 2.5-8GT/s
    LnkCtl2: Target Link Speed: 2.5GT/s
  04:02.0 Thunderbolt Downstream Port to [bus 39]
    LnkCap: Speed 2.5GT/s, LLActRep-
    LnkSta: Speed 2.5GT/s
    LnkCap2: Supported Link Speeds: 2.5-8GT/s
    LnkCtl2: Target Link Speed: 2.5GT/s

So per the Link Cap 2 Supported Link Speeds Vector, both devices
support up to 8GT/s, but neither one advertises Data Link Layer Link
Active Reporting Capable in Link Cap.

The Root Port to the NVIDIA GPU is similar; it advertises 8GT/s
support but not LLActRep:

  00:01.0 Root Port to [bus 01]
    LnkCap: Speed 8GT/s, LLActRep-
    LnkSta: Speed 8GT/s
    LnkCap2: Supported Link Speeds: 2.5-8GT/s
    LnkCtl2: Target Link Speed: 8GT/s

The fact that all three of these don't match what I expect makes me
wonder if I'm reading the spec wrong or lspci is decoding something
wrong.

For the Thunderbolt ports we could make the argument (as I think
you're suggesting) that the "supported link speed" is really the
minimum of the "Link Cap 2 Supported Link Speed" and the "Link Control
2 Target Link Speed".

But even that wouldn't explain why 00:01.0 doesn't advertise LLActRep+
when it is actually running at 8GT/s.

> > That sounds like a hardware defect that should be worked around with a
> > quirk or something.  If we just restructure the code to avoid the
> > problem, we're likely to reintroduce it later because there's no hint
> > in the code about this problem.
> 
> That's why I added the comment there to explain this.
> 
> Can you propose a patch following what you were thinking that solves
> this so Kai-Heng can try it out?
> 
> > > The Target Link Speed of this port (in Link Control 2) has the speed
> > > capped to 2.5 GT/s.
> > 
> > I saw you mentioned this before, but I don't understand yet why it's
> > relevant.  The spec says "supported,", not "current" or "target".
> 
> Because my interpretation of this part of the spec is that supported
> speed is supported up to what is set in target speed. In other words you
> can have 8GT/s there in the supported vector and the hardware/firmware
> can force the target to be lower therefore the link speed is always
> capped by that.
> 
> I'm not talking about "current" here. Only "supported" and "target".

Kai-Heng, would you mind attaching the "sudo lspci -vvxxxx" output to
the bugzilla?  I can use that to test my lspci patch.
