Return-Path: <linux-pci+bounces-1025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E969813D1A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 23:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44491F21918
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32992671E8;
	Thu, 14 Dec 2023 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUqBLkCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DED67206
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702592148; x=1734128148;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OH9K6eWkUx93qmk8br41DvvYucDOOCk7pScw3UkFuIo=;
  b=NUqBLkCJBGhryFYihs7ogeAKG/FFxt7LYoXyx20pzYMGRty+WtBr6MQI
   y4ag19jnS5YQvX6Elsp4MacFibUhaCsLU7LcyEhgfQgljacvLUo0Ez1My
   2JbbPdx9TdzLAV1ibbc7gpqLGouagSvKqjsxohV9Oexh3WVELGDXZtfaY
   sbR8n8RGPd8uOpLh9bprxx6+odpT6Wzv/Vf9rsebRN1wh6taDfZNqqbkB
   2+bNFEHYOtndelKHLwG4v6hMRLViGy/KJC7fHgaJEhhb6rhQFfDEXHCnD
   Zd/zboZdJ8lw5Isgf9RTIJ6XmGHgmuyx2Wc0sYNttWBofiA205w32xK3w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8592917"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="8592917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808747584"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="808747584"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:15:46 -0800
Message-ID: <24a4e9c73f6447f5bb67906c57520514dfa77389.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com
Date: Thu, 14 Dec 2023 15:22:21 -0700
In-Reply-To: <20231214192325.GA1095340@bhelgaas>
References: <20231214192325.GA1095340@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2023-12-14 at 13:23 -0600, Bjorn Helgaas wrote:
> On Wed, Dec 13, 2023 at 06:07:02PM -0700, Nirmal Patel wrote:
> > On Tue, 2023-12-12 at 15:13 -0600, Bjorn Helgaas wrote:
> > > On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> > > > On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> > > > > ...
> > > > > > Currently Hotplug is controlled by _OSC in both host and
> > > > > > Guest.
> > > > > > In case of guest, it seems guest BIOS hasn't implemented
> > > > > > _OSC
> > > > > > since all the flags are set to 0 which is not the case in
> > > > > > host.
> > > > > 
> > > > > I think you want pciehp to work on the VMD Root Ports in the
> > > > > Guest, no matter what, on the assumption that any _OSC that
> > > > > applies to host bridge A does not apply to the host bridge
> > > > > created
> > > > > by the vmd driver.
> > > > > 
> > > > > If so, we should just revert 04b12ef163d1 ("PCI: vmd: Honor
> > > > > ACPI
> > > > > _OSC on PCIe features").  Since host bridge B was not
> > > > > enumerated
> > > > > via ACPI, the OS owns all those features under B by default,
> > > > > so
> > > > > reverting 04b12ef163d1 would leave that state.
> > > > > 
> > > > > Obviously we'd have to first figure out another solution for
> > > > > the
> > > > > AER message flood that 04b12ef163d1 resolved.
> > > > 
> > > > If we revert 04b12ef163d1, then VMD driver will still enable
> > > > AER
> > > > blindly which is a bug. So we need to find a way to make VMD
> > > > driver
> > > > aware of AER platform setting and use that information to
> > > > enable or
> > > > disable AER for its child devices.
> > > > 
> > > > There is a setting in BIOS that allows us to enable OS native
> > > > AER
> > > > support on the platform. This setting is located in EDK Menu ->
> > > > Platform configuration -> system event log -> IIO error
> > > > enabling ->
> > > > OS native AER support.
> > > > 
> > > > This setting is assigned to VMD bridge by
> > > > vmd_copy_host_bridge_flags in patch 04b12ef163d1. Without the
> > > > patch 04b12ef163d1, VMD driver will enable AER even if platform
> > > > has disabled OS native AER support as mentioned earlier. This
> > > > will result in an AER flood mentioned in 04b12ef163d1 since
> > > > there is no AER handlers. 
> 
> I missed this before.  What does "there are no AER handlers"
> mean?  Do
> you mean there are no *firmware* AER handlers?  
Sorry for confusing wordings. Your understanding is correct. The patch
04b12ef163d1 is used to disable AER on vmd and avoid the AER flooding
by applying _OSC settings since vmd driver doesn't give a choice to
toggle AER, DPC, LTR, etc.
> 
> The dmesg log at https://bugzilla.kernel.org/attachment.cgi?id=299571
> (from https://bugzilla.kernel.org/show_bug.cgi?id=215027, the bug
> fixed by 04b12ef163d1), shows this:
> 
>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> Segments MSI HPX-Type3]
>   acpi PNP0A08:00: _OSC: platform does not support [AER]
>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME
> PCIeCapability LTR]
> 
> so the firmware did not grant AER control to the OS (I think
> "platform
> does not support" is a confusing description).
> 
> Prior to 04b12ef163d1, Linux applied _OSC above the VMD bridge but
> not
> below it, so Linux had native control below VMD and it did handle AER
> interrupts from the 10000:e0:06.0 Root Port below VMD:
> 
>   vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
>   pcieport 10000:e0:06.0: AER: Corrected error received:
> 10000:e1:00.0
> 
> After 04b12ef163d1, Linux applied _OSC below the VMD bridge as well,
> so it did not enable or handle any AER interrupts.  I suspect the
> platform didn't handle AER interrupts below VMD either, so those
> errors were probably just ignored.
> 
> > > > If VMD is aware of OS native AER support setting, then we will
> > > > not
> > > > see AER flooding issue.
> > > > 
> > > > Do you have any suggestion on how to make VMD driver aware of
> > > > AER
> > > > setting and keep it in sync with platform setting.
> > > 
> > > Well, this is the whole problem.  IIUC, you're saying we should
> > > use
> > > _OSC to negotiate for AER control below the VMD bridge, but
> > > ignore
> > > _OSC for hotplug control.
> > 
> > Because VMD has its own hotplug BIOS setting which allows vmd to
> > enable or disable hotplug on its domain. However we don't have VMD
> > specific AER, DPC, LTR settings. 
> 
> I don't quite follow.  The OS knows nothing about whether BIOS
> settings exist, so they can't be used to determine where _OSC
> applies.
> 
> > Is it okay if we include an additional check for hotplug? i.e.
> > Hotplug capable bit in SltCap register which reflects VMD BIOS
> > hotplug setting.
> 
> I don't know what check you have in mind, but the OS can definitely
> use SltCap to decide what features to enable.
Yes I agree. That is what I am also suggesting in this patch.
> 
> You suggest above that you want vmd to be aware of AER ownership per
> _OSC, but it sounds more like you just want AER disabled below VMD
> regardless.  Or do you have platforms that can actually handle AER
> interrupts from Root Ports below VMD?
No I dont want AER disabled below VMD all the time. I am suggesting vmd
should be in sync with all the _OSC flags since vmd doesn't give a
choice to toggle. However, the issue arises in guest where _OSC setting
for hotplug is always 0 eventhough hotplug is 1 in host and hotplug
enable bit in SltCap register is 1 in both host and guest. So we can
use that to enable hotplug in guest. Like you suggested in your above
comment. 
> 
> > Another way is to overwrite _OSC setting for hotplug only in Guest
> > OS.  If we make VMD driver aware of Host or Guest environment, only
> > in case of Guest we overwrite _OSC hotplug using SltCap register
> > and
> > we don't revert the 04b12ef163d1.
> 
> Making vmd aware of being in host or guest sounds kind of ugly to me.
I agree.
> 
> Bjorn


