Return-Path: <linux-pci+bounces-1010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1890813AAA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD322824AD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A03692BE;
	Thu, 14 Dec 2023 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwxPxTNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796C692B9
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 19:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4001C433C7;
	Thu, 14 Dec 2023 19:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702581807;
	bh=+0UfPob4hYaGACQyIJrqY5Yy2HgpLGGz6ylBgO8R5Ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IwxPxTNWAw9iO+4TuBGenMF0jzXlntgLsCMdYuipDdhkhderZP/otcuNwEELtyo+C
	 EqGbbKIiPtrAk+liM5c3NtJjtK0FsCMeF2Cyp/k8z+7J7fdRAHKBTAzOQyqopABsJw
	 G1H4POB4Ay7zS83VjiKjm9s+k4nmSbjQAha7ZZJNWrBkGoBR+STUrBuFGGWzHQ/8XO
	 QrQiCaWFQZQ5bjgZkH+CxK5K20ICEkyvMxALa4XmpTs5Cbf+Gp5mH+T7jSLsJiES6+
	 BlkSA2wIY5uz3QfInjqHaoLKRuPUxw2EbhjYDPoUx+hhAExnneSnzrLw33RLTeylOe
	 8X2DMiKZMBBQg==
Date: Thu, 14 Dec 2023 13:23:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231214192325.GA1095340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1727eab115466d1573104a1543fb3637f6156f.camel@linux.intel.com>

On Wed, Dec 13, 2023 at 06:07:02PM -0700, Nirmal Patel wrote:
> On Tue, 2023-12-12 at 15:13 -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> > > On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > > > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> > > > ...
> > > > > Currently Hotplug is controlled by _OSC in both host and Guest.
> > > > > In case of guest, it seems guest BIOS hasn't implemented _OSC
> > > > > since all the flags are set to 0 which is not the case in host.
> > > > 
> > > > I think you want pciehp to work on the VMD Root Ports in the
> > > > Guest, no matter what, on the assumption that any _OSC that
> > > > applies to host bridge A does not apply to the host bridge
> > > > created
> > > > by the vmd driver.
> > > > 
> > > > If so, we should just revert 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > > > _OSC on PCIe features").  Since host bridge B was not enumerated
> > > > via ACPI, the OS owns all those features under B by default, so
> > > > reverting 04b12ef163d1 would leave that state.
> > > > 
> > > > Obviously we'd have to first figure out another solution for the
> > > > AER message flood that 04b12ef163d1 resolved.
> > > 
> > > If we revert 04b12ef163d1, then VMD driver will still enable AER
> > > blindly which is a bug. So we need to find a way to make VMD driver
> > > aware of AER platform setting and use that information to enable or
> > > disable AER for its child devices.
> > > 
> > > There is a setting in BIOS that allows us to enable OS native AER
> > > support on the platform. This setting is located in EDK Menu ->
> > > Platform configuration -> system event log -> IIO error enabling ->
> > > OS native AER support.
> > > 
> > > This setting is assigned to VMD bridge by
> > > vmd_copy_host_bridge_flags in patch 04b12ef163d1. Without the
> > > patch 04b12ef163d1, VMD driver will enable AER even if platform
> > > has disabled OS native AER support as mentioned earlier. This
> > > will result in an AER flood mentioned in 04b12ef163d1 since
> > > there is no AER handlers. 

I missed this before.  What does "there are no AER handlers" mean?  Do
you mean there are no *firmware* AER handlers?  

The dmesg log at https://bugzilla.kernel.org/attachment.cgi?id=299571
(from https://bugzilla.kernel.org/show_bug.cgi?id=215027, the bug
fixed by 04b12ef163d1), shows this:

  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  acpi PNP0A08:00: _OSC: platform does not support [AER]
  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]

so the firmware did not grant AER control to the OS (I think "platform
does not support" is a confusing description).

Prior to 04b12ef163d1, Linux applied _OSC above the VMD bridge but not
below it, so Linux had native control below VMD and it did handle AER
interrupts from the 10000:e0:06.0 Root Port below VMD:

  vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0

After 04b12ef163d1, Linux applied _OSC below the VMD bridge as well,
so it did not enable or handle any AER interrupts.  I suspect the
platform didn't handle AER interrupts below VMD either, so those
errors were probably just ignored.

> > > If VMD is aware of OS native AER support setting, then we will not
> > > see AER flooding issue.
> > > 
> > > Do you have any suggestion on how to make VMD driver aware of AER
> > > setting and keep it in sync with platform setting.
> > 
> > Well, this is the whole problem.  IIUC, you're saying we should use
> > _OSC to negotiate for AER control below the VMD bridge, but ignore
> > _OSC for hotplug control.
>
> Because VMD has its own hotplug BIOS setting which allows vmd to
> enable or disable hotplug on its domain. However we don't have VMD
> specific AER, DPC, LTR settings. 

I don't quite follow.  The OS knows nothing about whether BIOS
settings exist, so they can't be used to determine where _OSC applies.

> Is it okay if we include an additional check for hotplug? i.e.
> Hotplug capable bit in SltCap register which reflects VMD BIOS
> hotplug setting.

I don't know what check you have in mind, but the OS can definitely
use SltCap to decide what features to enable.

You suggest above that you want vmd to be aware of AER ownership per
_OSC, but it sounds more like you just want AER disabled below VMD
regardless.  Or do you have platforms that can actually handle AER
interrupts from Root Ports below VMD?

> Another way is to overwrite _OSC setting for hotplug only in Guest
> OS.  If we make VMD driver aware of Host or Guest environment, only
> in case of Guest we overwrite _OSC hotplug using SltCap register and
> we don't revert the 04b12ef163d1.

Making vmd aware of being in host or guest sounds kind of ugly to me.

Bjorn

