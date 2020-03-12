Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21A182DF5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 11:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLKmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 06:42:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:48226 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLKmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 06:42:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 03:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="354101503"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2020 03:41:58 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Mar 2020 12:41:58 +0200
Date:   Thu, 12 Mar 2020 12:41:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
Message-ID: <20200312104158.GS2540@lahna.fi.intel.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
 <20200311103840.GB2540@lahna.fi.intel.com>
 <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
 <20200312081509.GI2540@lahna.fi.intel.com>
 <C687BE86-1CCB-417B-8546-77F76127B266@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C687BE86-1CCB-417B-8546-77F76127B266@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 06:10:45PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Mar 12, 2020, at 16:15, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > On Thu, Mar 12, 2020 at 12:41:08PM +0800, Kai-Heng Feng wrote:
> >> 
> >> 
> >>> On Mar 11, 2020, at 18:38, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >>> 
> >>> On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
> >>>> Hi,
> >>>> 
> >>>> I am currently investigating long suspend and resume time of suspend-to-idle.
> >>>> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
> >>>> 
> >>>> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
> >>>> 
> >>>> 	/* Avoid direct_complete to let wakeup_path propagate. */
> >>>> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
> >>>> 			dev->power.direct_complete = false;
> >>> 
> >>> You need to be careful here because otherwise you end up situation where
> >>> the link is not properly trained and we tear down the whole tree of
> >>> devices which is worse than waiting bit more for resume.
> >> 
> >> My idea is to direct-complete when there's no PCI or USB device
> >> plugged into the TBT, and use pm_reuqest_resume() in complete() so it
> >> won't block resume() or resume_noirq().
> > 
> > Before doing that..
> > 
> >>>> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
> >>>> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
> >>>> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
> >>>> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
> >>>> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...
> >>> 
> >>> Which system this is? ICL?
> >> 
> >> CML-H + Titan Ridge.
> > 
> > .. we should really understand this better because CML-H PCH root ports
> > and Titan/Alpine Ridge downstream ports all support active link
> > reporting so instead of the 1000+100ms you should see something like
> > this:
> 
> Root port for discrete graphics:
> # lspci -vvnn -s 00:01.0                    
> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 02) (prog-if 00 [Normal decode])
>         Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
>                 LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
>                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

Interesting, Titan Ridge is connected to the graphics slot, no? What
system this is?

> Thunderbolt ports:
> # lspci -vvvv -s 04:00
> 04:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
>         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

This one leads to the TBT NHI.

> # lspci -vvnn -s 04:01
> 04:01.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
>         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

This one is one of the extension downstream ports and it supports active
link reporting.

> # lspci -vvnn -s 04:02 
> 04:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
>         Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
>                 LnkCap: Port #2, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

This one leads to the xHCI.

> So both CML-H PCH and TBT ports report "LLActRep-".

So in pci_bridge_wait_for_secondary_bus() we only call
pcie_wait_for_link_delay() if the port supports speeds higher than 5
GT/s (gen2). Now if I read the above correct all the ports except the
root port support 2.5 GT/s (gen1) speeds so we should go to the
msleep(delay) branch and not call pcie_wait_for_link_delay() at all:

        if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
                pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
                msleep(delay);
        } else {
                pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
                        delay);
                if (!pcie_wait_for_link_delay(dev, true, delay)) {
                        /* Did not train, no need to wait any further */
                        return;
                }
        }

Only explanation I have is that delay itself is set to 1000ms for some
reason. Can you check if that's the case and then maybe check where that
delay is coming from?

> >  1. Wait for the link + 100ms for the root port
> >  2. Wait for the link + 100ms for the Titan Ridge downstream ports
> >    (these are run paraller wrt all Titan Ridge downstream ports that have
> >     something connected)
> > 
> > If there is a TBT device connected then 2. is repeated for it and so on.
> > 
> > So the 1000ms+ is really unexpected. Are you running mainline kernel and
> > if so, can you share dmesg with CONFIG_PCI_DEBUG=y so we can see the
> > delays there? Maybe also add some debugging to
> > pcie_wait_for_link_delay() where it checks for the
> > !pdev->link_active_reporting and waits for 1100ms.
> 
> I added the debug log in another thread and it does reach !pdev->link_active_reporting.

Hmm, based on the above that should not happen :-(

> Let me see if patch link active reporting for the ports in PCI quirks can help.

Let's first investigate bit more to understand what is going on.

I suggest to create kernel.org bugzilla about this. Please include full
dmesg and 'sudo lspci -vv' output at least and of course the steps you
use to reproduce this.
