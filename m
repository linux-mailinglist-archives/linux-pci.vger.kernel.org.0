Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C181CD642
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEKKQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:16:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:21477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKKQL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:16:11 -0400
IronPort-SDR: 2ihpwHt8pm9NiulFh6umtIuLeLqJZZuuRO4neI+2UFDp5L9I48m4piOqP6ocfoK8WCOkQMJoRP
 WJFxgi8WIOQw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:16:10 -0700
IronPort-SDR: 1vlMM2iaLWHvDXq4t59YhcH+OAStEcbsISYlRKaakS7nh9azwPUEaDUNeGevsXWTRpGI/69eQs
 KBD5mKtrt8Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371179223"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:16:07 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 11 May 2020 13:16:06 +0300
Date:   Mon, 11 May 2020 13:16:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
Message-ID: <20200511101606.GD487496@lahna.fi.intel.com>
References: <20200507171127.GA7761@bjorn-Precision-5520>
 <20200508225821.GA99686@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508225821.GA99686@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 05:58:21PM -0500, Bjorn Helgaas wrote:
> On Thu, May 07, 2020 at 12:11:27PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 07, 2020 at 04:46:27PM +0300, Mika Westerberg wrote:
> > > On Thu, May 07, 2020 at 08:33:27AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 7, 2020 at 7:36 AM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, May 07, 2020 at 07:24:37AM -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, May 7, 2020 at 6:45 AM Mika Westerberg
> > > > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 06, 2020 at 05:42:28PM -0500, Bjorn Helgaas wrote:
> > > > > > > > On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> > > > > > > > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > > > > > > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > > > > > > > sleep (s2idle).
> > > > > > > > >
> > > > > > > > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > > > > > > > announces support for speeds > 5 GT/s but it is then capped by the
> > > > > > > > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > > > > > > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > > > > > > > it ended up waiting for 1100 ms as these ports do not support active
> > > > > > > > > link layer reporting either.
> > > > > > > > >
> > > > > > > > > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > > > > > > > > before sending configuration request to the device below, if the port
> > > > > > > > > does not support speeds > 5 GT/s, and if it does we first need to wait
> > > > > > > > > for the data link layer to become active before waiting for that 100 ms.
> > > > > > > > >
> > > > > > > > > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > > > > > > > > that support speeds > 5 GT/s must support active link layer reporting so
> > > > > > > > > instead of looking for the speed we can check for the active link layer
> > > > > > > > > reporting capability and determine how to wait based on that (as they go
> > > > > > > > > hand in hand).
> > > > > > > >
> > > > > > > > I can't quite tell what the defect is here.
> > > > > > > >
> > > > > > > > I assume you're talking about this text from sec 6.6.1:
> > > > > > > >
> > > > > > > >   - With a Downstream Port that does not support Link speeds greater
> > > > > > > >     than 5.0 GT/s, software must wait a minimum of 100 ms before
> > > > > > > >     sending a Configuration Request to the device immediately below
> > > > > > > >     that Port.
> > > > > > > >
> > > > > > > >   - With a Downstream Port that supports Link speeds greater than 5.0
> > > > > > > >     GT/s, software must wait a minimum of 100 ms after Link training
> > > > > > > >     completes before sending a Configuration Request to the device
> > > > > > > >     immediately below that Port. Software can determine when Link
> > > > > > > >     training completes by polling the Data Link Layer Link Active bit
> > > > > > > >     or by setting up an associated interrupt (see Section 6.7.3.3 ).
> > > > > > > >
> > > > > > > > I don't understand what Link Control 2 has to do with this.  The spec
> > > > > > > > talks about ports *supporting* certain link speeds, which sounds to me
> > > > > > > > like the Link Capabilities.  It doesn't say anything about the current
> > > > > > > > or target link speed.
> > > > > > >
> > > > > > > PCIe 5.0 page 764 recommends using Supported Link Speeds Vector in Link
> > > > > > > Capabilities 2 register and that's what pcie_get_speed_cap() is doing.
> > > > > > >
> > > > > > > However, we can avoid figuring the speed altogether by checking the
> > > > > > > dev->link_active_reporting instead because that needs to be implemented
> > > > > > > by all Downstream Ports that supports speeds > 5 GT/s (PCIe 5.0 page 735).
> > > > > >
> > > > > > I understand that part.  But the code as-is matches sec 6.6.1, which
> > > > > > makes it easy to understand.  Checking link_active_reporting instead
> > > > > > makes it harder to understand because it makes it one step removed
> > > > > > from 6.6.1.  And link_active_reporting must be set for ports that
> > > > > > support > 5 GT/s, but it must *also* be set in some hotplug cases, so
> > > > > > that further complicates the connection between it and 6.6.1.
> > > > > >
> > > > > > And apparently there's an actual defect, and I don't understand what
> > > > > > that is yet.  It sounds like we agree that pcie_get_speed_cap() is
> > > > > > doing the right thing.  Is there something in
> > > > > > pci_bridge_wait_for_secondary_bus() that doesn't match sec 6.6.1?
> > > > >
> > > > > The defect is that some downstream PCIe ports on a system Kai-Heng is
> > > > > using have Supported Link Speeds Vector with > 5GT/s and it does not
> > > > > support active link reporting so the currect code ends up waiting 1100 ms
> > > > > slowing down resume time.
> > 
> > Ah.  From the lspci and dmesg instrumentation in the bugzilla, I
> > guess:
> > 
> >   04:00.0 Thunderbolt Downstream Port to [bus 05]
> >     LnkCap: Speed 2.5GT/s, LLActRep-
> >     LnkSta: Speed 2.5GT/s
> >     LnkCap2: Supported Link Speeds: 2.5-8GT/s
> >     LnkCtl2: Target Link Speed: 2.5GT/s
> >   04:02.0 Thunderbolt Downstream Port to [bus 39]
> >     LnkCap: Speed 2.5GT/s, LLActRep-
> >     LnkSta: Speed 2.5GT/s
> >     LnkCap2: Supported Link Speeds: 2.5-8GT/s
> >     LnkCtl2: Target Link Speed: 2.5GT/s
> > 
> > So per the Link Cap 2 Supported Link Speeds Vector, both devices
> > support up to 8GT/s, but neither one advertises Data Link Layer Link
> > Active Reporting Capable in Link Cap.
> > 
> > The Root Port to the NVIDIA GPU is similar; it advertises 8GT/s
> > support but not LLActRep:
> > 
> >   00:01.0 Root Port to [bus 01]
> >     LnkCap: Speed 8GT/s, LLActRep-
> >     LnkSta: Speed 8GT/s
> >     LnkCap2: Supported Link Speeds: 2.5-8GT/s
> >     LnkCtl2: Target Link Speed: 8GT/s
> > 
> > The fact that all three of these don't match what I expect makes me
> > wonder if I'm reading the spec wrong or lspci is decoding something
> > wrong.
> > 
> > For the Thunderbolt ports we could make the argument (as I think
> > you're suggesting) that the "supported link speed" is really the
> > minimum of the "Link Cap 2 Supported Link Speed" and the "Link Control
> > 2 Target Link Speed".
> > 
> > But even that wouldn't explain why 00:01.0 doesn't advertise LLActRep+
> > when it is actually running at 8GT/s.
> 
> FWIW, I posted a question about this to the PCI-SIG forum.  I don't
> have high hopes because that's a really low-bandwidth channel.

OK, thanks.

> > > > That sounds like a hardware defect that should be worked around with a
> > > > quirk or something.  If we just restructure the code to avoid the
> > > > problem, we're likely to reintroduce it later because there's no hint
> > > > in the code about this problem.
> > > 
> > > That's why I added the comment there to explain this.
> > > 
> > > Can you propose a patch following what you were thinking that solves
> > > this so Kai-Heng can try it out?
> 
> I think your patch actually makes a lot more *sense* than the language
> in the spec does.  For the second rule:
> 
>   With a Downstream Port that supports Link speeds greater than 5.0
>   GT/s, software must wait a minimum of 100 ms after Link training
>   completes before sending a Configuration Request to the device
>   immediately below that Port. Software can determine when Link
>   training completes by polling the Data Link Layer Link Active bit or
>   by setting up an associated interrupt (see Section 6.7.3.3).
> 
> we have to be able to tell when Link training completes, then wait
> 100ms.  For us to tell when training is complete, Data Link Layer Link
> Active must be implemented, and the spec says it should be implemented
> iff Data Link Layer Link Active Reporting Capable bit is set.
> 
> The 6.6.1 language about "greater than 5.0 GT/s" is one step removed.
> What we really care about is Data Link Layer Link Active, not the link
> speed.  It seems like the spec would be much clearer if it said:
> 
>   With a Downstream Port that implements the Data Link Layer Link
>   Active bit, software must wait a minimum of 100 ms after Link training
>   completes ...

Yes, I agree. That would make it more understandable.

Do you want me to do some changes to the patch or you are fine with it?
