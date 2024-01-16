Return-Path: <linux-pci+bounces-2228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D282FC1F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5AB1C2779F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF11DA47;
	Tue, 16 Jan 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+2Frh9X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5A1D68C
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437064; cv=none; b=glPdjSywpHixpkBKeSjpSpH9YGzrmijKuNAWpGh778h+4ZgHinZnKQpGFLsqrN7B94Jbfk6dtWToG435McUXsOODfHTpw6dTwh0d0M8UE9ZdW0kdfHQS6R5EDqucQpUyuA7ePnjc2cfi+6/Nzao9TRSmfS5qN0VrlVIyHTles/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437064; c=relaxed/simple;
	bh=mXZTWOdRJkqlgMYn8hp3w+9kYAMAx9AXBY1IuGUJfo8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding; b=dRjmdxvcjvZ8rtoKLBact+ObORuamtsGnCljQOfL0U2Z/q2JOWTARrHOZIsl0B9BfXjLkTJonx3T0aPQ4tK9xMCZa6Y2342JBpuo48Z/ndDJZgLD8v5//j0XTrcVdG+b/1jvPnjyzvfHrk+fUl/QyTLbaoWtrw5kZt4iaGFL27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+2Frh9X; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705437062; x=1736973062;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXZTWOdRJkqlgMYn8hp3w+9kYAMAx9AXBY1IuGUJfo8=;
  b=n+2Frh9XMo8PLBA2qPUq1uAh5K07leUnrAJ/mXfdxGVL6HC6Q7OeWQbB
   a+J4u7Ow5QS9lEKeL+QX+ZGQPHZipe0zkS7wsZQu6RrjX/5Lh9VFn80FC
   c1TVUhbB40aBK0lcRK0SZZBCb8pKScZ7tPB0T4bdVxFgX0oY5jqod40nC
   rY6fSBqTxkK+Xw1Dx06PrQeAoxT6nOL1Q1Jpscw6vBT3jmU4k14p+m1Cg
   tiv1qipiDIlr1/Nsmd8u6dqB7au+J/s2U4paw6Fc05MeDffHE2B87DgJ9
   6Iy6futRQlX40WKeevQYkys8HVxkintgKhJHQMDFic6IXXT4x/iZDmLod
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="397136465"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="397136465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 12:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="25934466"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 12:31:01 -0800
Message-ID: <2cf8a41181e07ec15dbc95e42c527b6429db8c50.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com, "Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 16 Jan 2024 13:37:32 -0700
In-Reply-To: <20240112225504.GA1129179@bhelgaas>
References: <20240112225504.GA1129179@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-01-12 at 16:55 -0600, Bjorn Helgaas wrote:
> [+cc Rafael, Kai-Heng]
> 
> On Thu, Dec 14, 2023 at 03:22:21PM -0700, Nirmal Patel wrote:
> > On Thu, 2023-12-14 at 13:23 -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 13, 2023 at 06:07:02PM -0700, Nirmal Patel wrote:
> > > > On Tue, 2023-12-12 at 15:13 -0600, Bjorn Helgaas wrote:
> > > > > On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> > > > > > On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > > > > > > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel
> > > > > > > wrote:
> > > > > > > ...
> > > > > > > > Currently Hotplug is controlled by _OSC in both host
> > > > > > > > and
> > > > > > > > Guest.  In case of guest, it seems guest BIOS hasn't
> > > > > > > > implemented _OSC since all the flags are set to 0 which
> > > > > > > > is not the case in host.
> > > > > > > 
> > > > > > > I think you want pciehp to work on the VMD Root Ports in
> > > > > > > the Guest, no matter what, on the assumption that any
> > > > > > > _OSC
> > > > > > > that applies to host bridge A does not apply to the host
> > > > > > > bridge created by the vmd driver.
> > > > > > > 
> > > > > > > If so, we should just revert 04b12ef163d1 ("PCI: vmd:
> > > > > > > Honor ACPI _OSC on PCIe features").  Since host bridge B
> > > > > > > was not enumerated via ACPI, the OS owns all those
> > > > > > > features under B by default, so reverting 04b12ef163d1
> > > > > > > would leave that state.
> > > > > > > 
> > > > > > > Obviously we'd have to first figure out another solution
> > > > > > > for the AER message flood that 04b12ef163d1 resolved.
> > > > > > 
> > > > > > If we revert 04b12ef163d1, then VMD driver will still
> > > > > > enable
> > > > > > AER blindly which is a bug. So we need to find a way to
> > > > > > make
> > > > > > VMD driver aware of AER platform setting and use that
> > > > > > information to enable or disable AER for its child devices.
> > > > > > 
> > > > > > There is a setting in BIOS that allows us to enable OS
> > > > > > native AER support on the platform. This setting is located
> > > > > > in EDK Menu -> Platform configuration -> system event log
> > > > > > ->
> > > > > > IIO error enabling -> OS native AER support.
> > > > > > 
> > > > > > This setting is assigned to VMD bridge by
> > > > > > vmd_copy_host_bridge_flags in patch 04b12ef163d1. Without
> > > > > > the patch 04b12ef163d1, VMD driver will enable AER even if
> > > > > > platform has disabled OS native AER support as mentioned
> > > > > > earlier. This will result in an AER flood mentioned in
> > > > > > 04b12ef163d1 since there is no AER handlers. 
> > > 
> > > I missed this before.  What does "there are no AER handlers"
> > > mean?
> > > Do you mean there are no *firmware* AER handlers?  
> > 
> > Sorry for confusing wordings. Your understanding is correct. The
> > patch
> > 04b12ef163d1 is used to disable AER on vmd and avoid the AER
> > flooding
> > by applying _OSC settings since vmd driver doesn't give a choice to
> > toggle AER, DPC, LTR, etc.
> > > The dmesg log at 
> > > https://bugzilla.kernel.org/attachment.cgi?id=299571
> > > (from https://bugzilla.kernel.org/show_bug.cgi?id=215027, the bug
> > > fixed by 04b12ef163d1), shows this:
> > > 
> > >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> > > Segments MSI HPX-Type3]
> > >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> > >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug
> > > PME
> > > PCIeCapability LTR]
> > > 
> > > so the firmware did not grant AER control to the OS (I think
> > > "platform does not support" is a confusing description).
> > > 
> > > Prior to 04b12ef163d1, Linux applied _OSC above the VMD bridge
> > > but
> > > not below it, so Linux had native control below VMD and it did
> > > handle AER interrupts from the 10000:e0:06.0 Root Port below VMD:
> > > 
> > >   vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
> > >   pcieport 10000:e0:06.0: AER: Corrected error received:
> > > 10000:e1:00.0
> > > 
> > > After 04b12ef163d1, Linux applied _OSC below the VMD bridge as
> > > well,
> > > so it did not enable or handle any AER interrupts.  I suspect the
> > > platform didn't handle AER interrupts below VMD either, so those
> > > errors were probably just ignored.
> > > 
> > > > > > If VMD is aware of OS native AER support setting, then we
> > > > > > will not see AER flooding issue.
> > > > > > 
> > > > > > Do you have any suggestion on how to make VMD driver aware
> > > > > > of AER setting and keep it in sync with platform setting.
> > > > > 
> > > > > Well, this is the whole problem.  IIUC, you're saying we
> > > > > should use _OSC to negotiate for AER control below the VMD
> > > > > bridge, but ignore _OSC for hotplug control.
> > > > 
> > > > Because VMD has its own hotplug BIOS setting which allows vmd
> > > > to
> > > > enable or disable hotplug on its domain. However we don't have
> > > > VMD specific AER, DPC, LTR settings. 
> > > 
> > > I don't quite follow.  The OS knows nothing about whether BIOS
> > > settings exist, so they can't be used to determine where _OSC
> > > applies.
> > > 
> > > > Is it okay if we include an additional check for hotplug? i.e.
> > > > Hotplug capable bit in SltCap register which reflects VMD BIOS
> > > > hotplug setting.
> > > 
> > > I don't know what check you have in mind, but the OS can
> > > definitely use SltCap to decide what features to enable.
> > 
> > Yes I agree. That is what I am also suggesting in this patch.
> 
> I should have said "the OS can use SltCap to *help* decide what
> features to enable."  For ACPI host bridges, _OSC determines whether
> hotplug should be operated by the platform or the OS.
> 
> I think we're converging on the idea that since VMD is effectively
> *not* an ACPI host bridge and doesn't have its own _OSC, the _OSC
> that
> applies to the VMD endpoint does *not* apply to the hierarchy below
> the VMD.  In that case, the default is that the OS owns all the
> features (hotplug, AER, etc) below the VMD.
Well there will be few problems if VMD owns/assigns all the flags by itself. We discussed all of the potential problems but due to the holidays I think I should summarize them again.
#1 : Currently there is no way to pass the information about AER, DPC,
etc to VMD driver from BIOS or from boot parameter. For example, If VMD
blindly enables AER and platform has AER disabled, then we will see
AERs from devices under VMD but user have no way to toggle it since we
rejected idea of adding boot parameter for AER, DPC under VMD. I
believe you also didn't like the idea of sysfs knob suggested by Kai-
Heng.

#2 : Even if we use VMD hardware register to store AER, DPC and make
UEFI VMD driver to write information about Hotplug, DPC, AER, we still
dont have a way to change the setting if user wants to alter them. Also
the issue will still persist in client platforms since we don't own
their UEFI VMD driver. It will be a huge effort.

#3 : At this moment, user can enable/disable only Hotplug in VMD BIOS
settings (meaning no AER, DPC, LTR, etc)and VMD driver can read it from
SltCap register. This means BIOS needs to add other settings and VMD
needs to figure out to read them which at this moment VMD can't do it.

#4 : consistency with Host OS and Guest OS.

I believe the current propesed patch is the best option which requires
minimal changes without breaking other platform features and unblock
our customers. This issues has been a blocker for us.

For your concerns regarding how VMD can own all the _OSC features, i am
open to other ideas and will discuss with the architect if they have
any suggestions.


> 
> > > You suggest above that you want vmd to be aware of AER ownership
> > > per
> > > _OSC, but it sounds more like you just want AER disabled below
> > > VMD
> > > regardless.  Or do you have platforms that can actually handle
> > > AER
> > > interrupts from Root Ports below VMD?
> > 
> > No I dont want AER disabled below VMD all the time. I am suggesting
> > vmd should be in sync with all the _OSC flags since vmd doesn't
> > give
> > a choice to toggle.
> 
> This is what I don't understand.  If we decide that _OSC doesn't
> apply
> below VMD because the VMD host bridge isn't described in ACPI, the
> idea of being in sync with _OSC doesn't make sense.
> 
> > However, the issue arises in guest where _OSC setting for hotplug
> > is
> > always 0 even though hotplug is 1 in host and hotplug enable bit in
> > SltCap register is 1 in both host and guest. So we can use that to
> > enable hotplug in guest. Like you suggested in your above comment. 
> 
> All this got paged out over the holidays, so I need to refresh my
> understanding here.  Maybe it will help if we can make the situation
> more concrete.  I'm basing this on the logs at
> https://bugzilla.kernel.org/show_bug.cgi?id=215027.  I assume the
> 10000:e0:06.0 Root Port and the 10000:e1:00.0 NVMe device are both
> passed through to the guest.  I'm sure I got lots wrong here, so
> please correct me :)
> 
>   Host OS sees:
> 
>     PNP0A08 host bridge to 0000 [bus 00-ff]
>       _OSC applies to domain 0000
>       OS owns [PCIeHotplug SHPCHotplug PME PCIeCapability LTR] in
> domain 0000
>     vmd 0000:00:0e.0: PCI host bridge to domain 10000 [bus e0-ff]
>       no _OSC applies in domain 10000;
>       host OS owns all PCIe features in domain 10000
>     pci 10000:e0:06.0: [8086:464d]             # VMD root port
>     pci 10000:e0:06.0: PCI bridge to [bus e1]
>     pci 10000:e0:06.0: SltCap: HotPlug+        # Hotplug Capable
>     pci 10000:e1:00.0: [144d:a80a]             # nvme
> 
>   Guest OS sees:
> 
>     PNP0A03 host bridge to 0000 [bus 00-ff]
>       _OSC applies to domain 0000
>       platform owns [PCIeHotplug ...]          # _OSC doesn't grant
> to OS
>     pci 0000:e0:06.0: [8086:464d]              # VMD root port
>     pci 0000:e0:06.0: PCI bridge to [bus e1]
>     pci 0000:e0:06.0: SltCap: HotPlug+         # Hotplug Capable
>     pci 0000:e1:00.0: [144d:a80a]             # nvme
> 
> So the guest OS sees that the VMD Root Port supports hotplug, but it
> can't use it because it was not granted ownership of the feature?
You are correct about _OSC not granting access in Guest. This is what I
see on my setup.

	Host OS:

	ACPI: PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
	acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI EDR HPX-Type3]
	acpi PNP0A08:0b: _OSC: platform does not support [SHPCHotplug
AER DPC]
	acpi PNP0A08:0b: _OSC: OS now controls [PCIeHotplug PME
PCIeCapability LTR]
	PCI host bridge to bus 0000:e2

	vmd 0000:e2:00.5: PCI host bridge to bus 10007:00
	vmd 0000:e2:00.5: Bound to PCI domain 10007

	Guest OS:

	ACPI: PCI Root Bridge [PC0G] (domain 0000 [bus 03])
	acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI EDR HPX-Type3]
	acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug
SHPCHotplug PME AER LTR DPC]
	acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]

	vmd 0000:03:00.0: Bound to PCI domain 10000

	SltCap: PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
	

	
> 
> Bjorn


