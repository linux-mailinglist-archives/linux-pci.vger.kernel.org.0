Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CE9E418
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfH0JZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:25:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:37469 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfH0JZs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 05:25:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="197266455"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 27 Aug 2019 02:25:43 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 27 Aug 2019 12:25:42 +0300
Date:   Tue, 27 Aug 2019 12:25:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <20190827092542.GB3177@lahna.fi.intel.com>
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <20190824021254.GB127465@google.com>
 <20190826101726.GD19908@lahna.fi.intel.com>
 <20190826140712.GC127465@google.com>
 <20190826144242.GA2643@lahna.fi.intel.com>
 <20190826220502.GD127465@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826220502.GD127465@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 05:05:02PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 26, 2019 at 05:42:42PM +0300, Mika Westerberg wrote:
> > On Mon, Aug 26, 2019 at 09:07:12AM -0500, Bjorn Helgaas wrote:
> > > On Mon, Aug 26, 2019 at 01:17:26PM +0300, Mika Westerberg wrote:
> > > > On Fri, Aug 23, 2019 at 09:12:54PM -0500, Bjorn Helgaas wrote:
> 
> > > > > But the "wait downstream" part seems a little too specific to be at
> > > > > the .resume_noirq and .runtime_resume level.
> > > > > 
> > > > > Do we descend the hierarchy and call .resume_noirq and .runtime_resume
> > > > > for the children of the bridge, too?
> > > > 
> > > > We do but at that time it is too late as we have already resumed pciehp
> > > > of the parent downstream port and it may have already started tearing
> > > > down the device stack below.
> > > > 
> > > > I'm open to any better ideas where this delay could be added, though :)
> > > 
> > > So we resume pciehp *before* we're finished resuming the Downstream
> > > Port?  That sounds wrong.
> > 
> > I mean once we resume the downstream port (the bridge) we also resume
> > "PCIe port services" including pciehp and only then descend to whatever
> > device is physically connected to that port.
> 
> That order sounds right.  I guess I'd have to see more details about
> what's happening with pciehp to understand this.  Do you happen to
> have a trace (dmesg, backtrace, etc) of pciehp tearing things down?

Here are the relevant parts from ICL. I'll send you the full dmesg as
a separate email. The topology is such that I have 2 Titan Ridge devices
connected in chain (each include PCIe switch + xHCI). I wait for the
whole hierarchy to enter D3cold:

[   50.485411] thunderbolt 0000:00:0d.3: power state changed by ACPI to D3cold

Here I plug in normal type-C memory stick to last Titan Ridge port which
wakes up the hierarchy:

[   63.404860] thunderbolt 0000:00:0d.3: power state changed by ACPI to D0
[   63.408558] thunderbolt 0000:00:0d.2: power state changed by ACPI to D0
[   63.512696] pcieport 0000:00:07.3: power state changed by ACPI to D0
[   63.512921] pcieport 0000:00:07.0: power state changed by ACPI to D0
[   63.512960] pcieport 0000:00:07.2: power state changed by ACPI to D0
[   63.519567] pcieport 0000:00:07.1: power state changed by ACPI to D0
[   63.524365] thunderbolt 0000:00:0d.3: PME# disabled
[   63.524379] thunderbolt 0000:00:0d.3: control channel starting...
[   63.524382] thunderbolt 0000:00:0d.3: starting TX ring 0
[   63.524388] thunderbolt 0000:00:0d.3: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   63.524390] thunderbolt 0000:00:0d.3: starting RX ring 0
[   63.524396] thunderbolt 0000:00:0d.3: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   63.525777] thunderbolt 0000:00:0d.2: PME# disabled
[   63.592667] thunderbolt 0000:00:0d.3: ICM rtd3 veto=0x00000001
[   63.627014] pcieport 0000:00:07.3: restoring config space at offset 0x2c (was 0x60, writing 0x60)
[   63.627018] pcieport 0000:00:07.0: restoring config space at offset 0x2c (was 0x60, writing 0x60)
[   63.627026] pcieport 0000:00:07.0: restoring config space at offset 0x28 (was 0x60, writing 0x60)
[   63.627028] pcieport 0000:00:07.3: restoring config space at offset 0x28 (was 0x60, writing 0x60)
[   63.627034] pcieport 0000:00:07.3: restoring config space at offset 0x24 (was 0x7bf16001, writing 0x7bf16001)
[   63.627036] pcieport 0000:00:07.0: restoring config space at offset 0x24 (was 0x1bf10001, writing 0x1bf10001)
[   63.632439] pcieport 0000:00:07.0: PME# disabled
[   63.632465] pcieport 0000:00:07.2: restoring config space at offset 0x2c (was 0x60, writing 0x60)
[   63.632467] pcieport 0000:00:07.2: restoring config space at offset 0x28 (was 0x60, writing 0x60)
[   63.632468] pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x5bf14001, writing 0x5bf14001)
[   63.634219] pcieport 0000:00:07.3: PME# disabled
[   63.634324] pcieport 0000:82:00.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
[   63.634333] pcieport 0000:82:00.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
[   63.634337] pcieport 0000:82:00.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
[   63.634341] pcieport 0000:82:00.0: restoring config space at offset 0x24 (was 0x10001, writing 0x7bf16001)
[   63.634344] pcieport 0000:82:00.0: restoring config space at offset 0x20 (was 0x0, writing 0x5c105000)
[   63.634348] pcieport 0000:82:00.0: restoring config space at offset 0x1c (was 0x101, writing 0xb171)
[   63.634352] pcieport 0000:82:00.0: restoring config space at offset 0x18 (was 0x0, writing 0xac8382)
[   63.634363] pcieport 0000:82:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100007)
[   63.634852] pcieport 0000:00:07.1: restoring config space at offset 0x2c (was 0x60, writing 0x60)
[   63.634854] pcieport 0000:00:07.1: restoring config space at offset 0x28 (was 0x60, writing 0x60)
[   63.634856] pcieport 0000:00:07.1: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
[   63.636163] pcieport 0000:00:07.2: PME# disabled
[   63.636320] pcieport 0000:82:00.0: PME# disabled
[   63.636451] pcieport 0000:83:02.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
[   63.636473] pcieport 0000:83:02.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
[   63.636480] pcieport 0000:83:02.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
[   63.636488] pcieport 0000:83:02.0: restoring config space at offset 0x24 (was 0x10001, writing 0x60116011)
[   63.636495] pcieport 0000:83:02.0: restoring config space at offset 0x20 (was 0x0, writing 0x50105010)
[   63.636502] pcieport 0000:83:02.0: restoring config space at offset 0x1c (was 0x101, writing 0x8181)
[   63.636510] pcieport 0000:83:02.0: restoring config space at offset 0x18 (was 0x0, writing 0x858583)
[   63.636529] pcieport 0000:83:02.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
[   63.636575] pcieport 0000:83:04.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
[   63.636597] pcieport 0000:83:04.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
[   63.636603] pcieport 0000:83:04.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
[   63.636609] pcieport 0000:83:04.0: restoring config space at offset 0x24 (was 0x10001, writing 0x7bf16021)
[   63.636615] pcieport 0000:83:04.0: restoring config space at offset 0x20 (was 0x0, writing 0x5c105020)
[   63.636621] pcieport 0000:83:04.0: restoring config space at offset 0x1c (was 0x101, writing 0xb191)
[   63.636627] pcieport 0000:83:04.0: restoring config space at offset 0x18 (was 0x0, writing 0xac8683)
[   63.636641] pcieport 0000:83:04.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
[   63.639915] pcieport 0000:83:01.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
[   63.639926] pcieport 0000:83:01.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
[   63.639931] pcieport 0000:83:01.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
[   63.639936] pcieport 0000:83:01.0: restoring config space at offset 0x24 (was 0x10001, writing 0x60016001)
[   63.639941] pcieport 0000:83:01.0: restoring config space at offset 0x20 (was 0x0, writing 0x50005000)
[   63.639946] pcieport 0000:83:01.0: restoring config space at offset 0x1c (was 0x101, writing 0x7171)
[   63.639951] pcieport 0000:83:01.0: restoring config space at offset 0x18 (was 0x0, writing 0x848483)
[   63.639963] pcieport 0000:83:01.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
[   63.640473] pcieport 0000:00:07.1: PME# disabled
[   63.640515] pcieport 0000:83:04.0: PME# disabled
[   63.640537] pcieport 0000:83:04.0: pciehp: Slot(4): Card not present

Here pciehp notices the card is not present and starts tearing down the
devices below.

[   63.640539] pcieport 0000:87:04.0: PME# disabled
[   63.648104] pcieport 0000:83:04.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:86:00
[   63.648105] pcieport 0000:86:00.0: Refused to change power state, currently in D3
[   63.656858] pcieport 0000:86:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x201ff)
[   63.656858] pcieport 0000:86:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
[   63.656859] pcieport 0000:86:00.0: restoring config space at offset 0x34 (was 0xffffffff, writing 0x80)
[   63.656859] pcieport 0000:86:00.0: restoring config space at offset 0x30 (was 0xffffffff, writing 0x0)
[   63.656860] pcieport 0000:86:00.0: restoring config space at offset 0x2c (was 0xffffffff, writing 0x60)
[   63.656860] pcieport 0000:86:00.0: restoring config space at offset 0x28 (was 0xffffffff, writing 0x60)
[   63.656861] pcieport 0000:86:00.0: restoring config space at offset 0x24 (was 0xffffffff, writing 0x7bf16021)
[   63.656862] pcieport 0000:86:00.0: restoring config space at offset 0x20 (was 0xffffffff, writing 0x5c105020)
[   63.656862] pcieport 0000:86:00.0: restoring config space at offset 0x1c (was 0xffffffff, writing 0xb191)
[   63.656863] pcieport 0000:86:00.0: restoring config space at offset 0x18 (was 0xffffffff, writing 0xac8786)
[   63.656863] pcieport 0000:86:00.0: restoring config space at offset 0x14 (was 0xffffffff, writing 0x0)
[   63.656864] pcieport 0000:86:00.0: restoring config space at offset 0x10 (was 0xffffffff, writing 0x0)
[   63.656864] pcieport 0000:86:00.0: restoring config space at offset 0xc (was 0xffffffff, writing 0x10000)
[   63.656865] pcieport 0000:86:00.0: restoring config space at offset 0x8 (was 0xffffffff, writing 0x6040006)
[   63.656865] pcieport 0000:86:00.0: restoring config space at offset 0x4 (was 0xffffffff, writing 0x100007)
[   63.656866] pcieport 0000:86:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x15ef8086)
[   63.656883] pcieport 0000:86:00.0: PME# disabled
[   63.656884] pcieport 0000:87:04.0: Refused to change power state, currently in D3

There is also another case which does not involve pciehp. The xHCI issue
Kai-Heng reported. In that case PCI core tries to access xHCI too soon
and fails to resume it:

[   74.100492] pcieport 0000:04:02.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
[   74.100498] pcieport 0000:04:02.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100406)
[   74.100545] pcieport 0000:04:02.0: PME# disabled
[   74.100554] xhci_hcd 0000:39:00.0: Refused to change power state, currently in D3
[   74.102769] xhci_hcd 0000:39:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
[   74.102774] xhci_hcd 0000:39:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
[   74.102778] xhci_hcd 0000:39:00.0: restoring config space at offset 0x34 (was 0xffffffff, writing 0x80)
[   74.102782] xhci_hcd 0000:39:00.0: restoring config space at offset 0x30 (was 0xffffffff, writing 0x0)
[   74.102787] xhci_hcd 0000:39:00.0: restoring config space at offset 0x2c (was 0xffffffff, writing 0x9261028)

the full dmesg is here:

  https://bugzilla.kernel.org/attachment.cgi?id=284427

> > > > > > +static int pcie_get_downstream_delay(struct pci_bus *bus)
> > > > > > +{
> > > > > > +	struct pci_dev *pdev;
> > > > > > +	int min_delay = 100;
> > > > > > +	int max_delay = 0;
> > > > > > +
> > > > > > +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> > > > > > +		if (pdev->imm_ready)
> > > > > > +			min_delay = 0;
> > > > > > +		else if (pdev->d3cold_delay < min_delay)
> > > > > > +			min_delay = pdev->d3cold_delay;
> > > > > > +		if (pdev->d3cold_delay > max_delay)
> > > > > > +			max_delay = pdev->d3cold_delay;
> > > > > > +	}
> > > > > > +
> > > > > > +	return max(min_delay, max_delay);
> > > > > > +}
> > > 
> > > > > > + */
> > > > > > +void pcie_wait_downstream_accessible(struct pci_dev *pdev)
> > > 
> > > > > Do we need to observe the Trhfa requirements for Conventional PCI and
> > > > > PCI-X devices here?  If we don't do it here, where is it observed?
> > > > 
> > > > We probably should but I intended this to be PCIe specific since there
> > > > we have issues. For conventional PCI/PCI-X things "seem" to work and we
> > > > don't power manage those bridges anyway.
> > > > 
> > > > I'm not aware if Trhfa is handled in anywhere in the PCI stack
> > > > currently.
> > > 
> > > I think we should make this agnostic of the Conventional/PCIe
> > > difference if possible.  I assume we can tell if we're dealing with a
> > > D3->D0 transition and we only add delays in that case.  If we don't
> > > power manage Conventional PCI devices, I assume we won't see D3->D0
> > > transitions for runtime resume so there won't be any harm.
> > >
> > > Making it PCIe-specific seems like it adds extra code ("dev-is-PCIe
> > > checks") with no obvious reason for existence and an implicit
> > > dependency on the fact that we only power manage PCIe devices.  If we
> > > ever *did* support runtime power-management for Conventional PCI, we'd
> > > trip over that implicit dependency and probably debug this issue
> > > again.
> > > 
> > > But I guess it might slow down system resume for Conventional PCI
> > > devices.  If we rely on delays in firmware, I wonder if there's
> > > any point during resume where we could grab an early timestamp, then
> > > take another timestamp here and deduce that we've already delayed the
> > > difference?
> > 
> > That sounds rather complex, to be honest ;-)
> 
> Maybe so, I was just trying to brainstorm possibilities for making
> sure we observe the delay requirements without slowing down resume.
> 
> For example, if we have several devices on the same bus, we shouldn't
> have to do the delays serially; we should be able to take advantage of
> the fact that the Trhfa period starts at the same time for all of
> them.

Also we do async suspend these days for PCI devices so I think sibling
devices are already resumed concurrently.

> > > > > > +	delay = pcie_get_downstream_delay(bus);
> > > > > > +	if (!delay)
> > > > > > +		return;
> > > > > 
> > > > > I'm not sold on the idea that this delay depends on what's *below* the
> > > > > bridge.  We're using sec 6.6.1 to justify the delay, and that section
> > > > > doesn't say anything about downstream devices.
> > > > 
> > > > 6.6.1 indeed talks about Downstream Ports and devices immediately below
> > > > them.
> > > 
> > > Wait, I don't think we're reading this the same way.  6.6.1 mentions
> > > Downstream Ports: "With a Downstream Port that does not support Link
> > > speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > > before sending a Configuration Request to the device immediately below
> > > that Port."
> > > 
> > > This says we have to delay before sending a config request to a device
> > > below a Downstream Port, but it doesn't say anything about the
> > > characteristics of that device.  In particular, I don't think it says
> > > the delay can be shortened if that device supports Immediate Readiness
> > > or implements a readiness _DSM.
> > 
> > Well it says this:
> > 
> >   To allow components to perform internal initialization, system software
> >   must wait a specified minimum period following the end of a Conventional
> >   Reset of one or more devices before it is permitted to issue
> >   Configuration Requests to those devices, unless Readiness Notifications
> >   mechanisms are used
> > 
> > My understanding of the above (might be wrong) is that Readiness
> > Notification can shorten the delay.
> 
> Yeeesss, but if we're talking about transitioning device X from
> D3->D0, I think this is talking about config requests to device X,
> not to something downstream from X.
> 
> And we have no support for Readiness Notifications, although maybe the
> _DSM stuff qualifies as "a mechanism that supersedes FRS and/or DRS"
> (as mentioned in 6.23).
> 
> If device X was in D3cold, don't we have to assume that devices
> downstream from X may have been added/removed while X was in D3cold?

Yes, I think so.
