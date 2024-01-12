Return-Path: <linux-pci+bounces-2131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDE82C77E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 23:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBE71C20993
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 22:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD214F6D;
	Fri, 12 Jan 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyweQNuZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866618C15
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 22:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3431FC433F1;
	Fri, 12 Jan 2024 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705100106;
	bh=pEwQv/Qj8zmtSiFXwxVpcohqeY+Xq9lkGG9PpXnb40U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UyweQNuZh8yocAhLxumFylmXqaANYSAz7vXxOaBvImAAhRFe6t2kolaXsiHwVPlsh
	 d9Dcm3S1Hw1FvQGiqVStTlSSWAxFk+GKR7YMDhW/1d7W91C8AaIAlgdzk1JVh4DAUk
	 nlIK341QO4x/6hw1A9a79kFlEvIvIyoC07R5EymaVXygoCBAZsfci6xZE0Bw+L3WJw
	 jF4URS9megMe8krTUniAnSrnlFALxusesjcwxRw3n4DBhi1yec0vAfL9zlyUDWxn3k
	 msWuxx95XmvdT82rTTbaSD4gPnCqOjuoKZ38zq5rXIs4eWcLX7q3Mm69CELH3f0UKE
	 6N/zaLxmdSO4A==
Date: Fri, 12 Jan 2024 16:55:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240112225504.GA1129179@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a4e9c73f6447f5bb67906c57520514dfa77389.camel@linux.intel.com>

[+cc Rafael, Kai-Heng]

On Thu, Dec 14, 2023 at 03:22:21PM -0700, Nirmal Patel wrote:
> On Thu, 2023-12-14 at 13:23 -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 13, 2023 at 06:07:02PM -0700, Nirmal Patel wrote:
> > > On Tue, 2023-12-12 at 15:13 -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> > > > > On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> > > > > > ...
> > > > > > > Currently Hotplug is controlled by _OSC in both host and
> > > > > > > Guest.  In case of guest, it seems guest BIOS hasn't
> > > > > > > implemented _OSC since all the flags are set to 0 which
> > > > > > > is not the case in host.
> > > > > > 
> > > > > > I think you want pciehp to work on the VMD Root Ports in
> > > > > > the Guest, no matter what, on the assumption that any _OSC
> > > > > > that applies to host bridge A does not apply to the host
> > > > > > bridge created by the vmd driver.
> > > > > > 
> > > > > > If so, we should just revert 04b12ef163d1 ("PCI: vmd:
> > > > > > Honor ACPI _OSC on PCIe features").  Since host bridge B
> > > > > > was not enumerated via ACPI, the OS owns all those
> > > > > > features under B by default, so reverting 04b12ef163d1
> > > > > > would leave that state.
> > > > > > 
> > > > > > Obviously we'd have to first figure out another solution
> > > > > > for the AER message flood that 04b12ef163d1 resolved.
> > > > > 
> > > > > If we revert 04b12ef163d1, then VMD driver will still enable
> > > > > AER blindly which is a bug. So we need to find a way to make
> > > > > VMD driver aware of AER platform setting and use that
> > > > > information to enable or disable AER for its child devices.
> > > > > 
> > > > > There is a setting in BIOS that allows us to enable OS
> > > > > native AER support on the platform. This setting is located
> > > > > in EDK Menu -> Platform configuration -> system event log ->
> > > > > IIO error enabling -> OS native AER support.
> > > > > 
> > > > > This setting is assigned to VMD bridge by
> > > > > vmd_copy_host_bridge_flags in patch 04b12ef163d1. Without
> > > > > the patch 04b12ef163d1, VMD driver will enable AER even if
> > > > > platform has disabled OS native AER support as mentioned
> > > > > earlier. This will result in an AER flood mentioned in
> > > > > 04b12ef163d1 since there is no AER handlers. 
> > 
> > I missed this before.  What does "there are no AER handlers" mean?
> > Do you mean there are no *firmware* AER handlers?  
>
> Sorry for confusing wordings. Your understanding is correct. The patch
> 04b12ef163d1 is used to disable AER on vmd and avoid the AER flooding
> by applying _OSC settings since vmd driver doesn't give a choice to
> toggle AER, DPC, LTR, etc.
> > 
> > The dmesg log at https://bugzilla.kernel.org/attachment.cgi?id=299571
> > (from https://bugzilla.kernel.org/show_bug.cgi?id=215027, the bug
> > fixed by 04b12ef163d1), shows this:
> > 
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> > Segments MSI HPX-Type3]
> >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME
> > PCIeCapability LTR]
> > 
> > so the firmware did not grant AER control to the OS (I think
> > "platform does not support" is a confusing description).
> > 
> > Prior to 04b12ef163d1, Linux applied _OSC above the VMD bridge but
> > not below it, so Linux had native control below VMD and it did
> > handle AER interrupts from the 10000:e0:06.0 Root Port below VMD:
> > 
> >   vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
> >   pcieport 10000:e0:06.0: AER: Corrected error received:
> > 10000:e1:00.0
> > 
> > After 04b12ef163d1, Linux applied _OSC below the VMD bridge as well,
> > so it did not enable or handle any AER interrupts.  I suspect the
> > platform didn't handle AER interrupts below VMD either, so those
> > errors were probably just ignored.
> > 
> > > > > If VMD is aware of OS native AER support setting, then we
> > > > > will not see AER flooding issue.
> > > > > 
> > > > > Do you have any suggestion on how to make VMD driver aware
> > > > > of AER setting and keep it in sync with platform setting.
> > > > 
> > > > Well, this is the whole problem.  IIUC, you're saying we
> > > > should use _OSC to negotiate for AER control below the VMD
> > > > bridge, but ignore _OSC for hotplug control.
> > > 
> > > Because VMD has its own hotplug BIOS setting which allows vmd to
> > > enable or disable hotplug on its domain. However we don't have
> > > VMD specific AER, DPC, LTR settings. 
> > 
> > I don't quite follow.  The OS knows nothing about whether BIOS
> > settings exist, so they can't be used to determine where _OSC
> > applies.
> > 
> > > Is it okay if we include an additional check for hotplug? i.e.
> > > Hotplug capable bit in SltCap register which reflects VMD BIOS
> > > hotplug setting.
> > 
> > I don't know what check you have in mind, but the OS can
> > definitely use SltCap to decide what features to enable.
>
> Yes I agree. That is what I am also suggesting in this patch.

I should have said "the OS can use SltCap to *help* decide what
features to enable."  For ACPI host bridges, _OSC determines whether
hotplug should be operated by the platform or the OS.

I think we're converging on the idea that since VMD is effectively
*not* an ACPI host bridge and doesn't have its own _OSC, the _OSC that
applies to the VMD endpoint does *not* apply to the hierarchy below
the VMD.  In that case, the default is that the OS owns all the
features (hotplug, AER, etc) below the VMD.

> > You suggest above that you want vmd to be aware of AER ownership per
> > _OSC, but it sounds more like you just want AER disabled below VMD
> > regardless.  Or do you have platforms that can actually handle AER
> > interrupts from Root Ports below VMD?
>
> No I dont want AER disabled below VMD all the time. I am suggesting
> vmd should be in sync with all the _OSC flags since vmd doesn't give
> a choice to toggle.

This is what I don't understand.  If we decide that _OSC doesn't apply
below VMD because the VMD host bridge isn't described in ACPI, the
idea of being in sync with _OSC doesn't make sense.

> However, the issue arises in guest where _OSC setting for hotplug is
> always 0 even though hotplug is 1 in host and hotplug enable bit in
> SltCap register is 1 in both host and guest. So we can use that to
> enable hotplug in guest. Like you suggested in your above comment. 

All this got paged out over the holidays, so I need to refresh my
understanding here.  Maybe it will help if we can make the situation
more concrete.  I'm basing this on the logs at
https://bugzilla.kernel.org/show_bug.cgi?id=215027.  I assume the
10000:e0:06.0 Root Port and the 10000:e1:00.0 NVMe device are both
passed through to the guest.  I'm sure I got lots wrong here, so
please correct me :)

  Host OS sees:

    PNP0A08 host bridge to 0000 [bus 00-ff]
      _OSC applies to domain 0000
      OS owns [PCIeHotplug SHPCHotplug PME PCIeCapability LTR] in domain 0000
    vmd 0000:00:0e.0: PCI host bridge to domain 10000 [bus e0-ff]
      no _OSC applies in domain 10000;
      host OS owns all PCIe features in domain 10000
    pci 10000:e0:06.0: [8086:464d]             # VMD root port
    pci 10000:e0:06.0: PCI bridge to [bus e1]
    pci 10000:e0:06.0: SltCap: HotPlug+        # Hotplug Capable
    pci 10000:e1:00.0: [144d:a80a]             # nvme

  Guest OS sees:

    PNP0A03 host bridge to 0000 [bus 00-ff]
      _OSC applies to domain 0000
      platform owns [PCIeHotplug ...]          # _OSC doesn't grant to OS
    pci 0000:e0:06.0: [8086:464d]              # VMD root port
    pci 0000:e0:06.0: PCI bridge to [bus e1]
    pci 0000:e0:06.0: SltCap: HotPlug+         # Hotplug Capable
    pci 0000:e1:00.0: [144d:a80a]             # nvme

So the guest OS sees that the VMD Root Port supports hotplug, but it
can't use it because it was not granted ownership of the feature?

Bjorn

