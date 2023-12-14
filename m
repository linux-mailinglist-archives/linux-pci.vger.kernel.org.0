Return-Path: <linux-pci+bounces-920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C117812434
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E694028220B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E108138E;
	Thu, 14 Dec 2023 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XD2KRXSw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C9D0
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 17:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702515628; x=1734051628;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNzBzKroNnKmXszX/ASCbNlUqDlt4oHbLngVbr4g7BY=;
  b=XD2KRXSwSXS9lAXAOZroIry7S/DfzMa1AKydR2eGMyeiA3zNYFey/Jlv
   2BP+02jqt2pk9s/fpLX8eoJUuGLxAuVjkdJ8Gby+OmLzKBQPD8H5brSSc
   81seRbHGjo1D8hEt0Ipl7MRKWCY0q3TYwBo5cuzbe6hp3+/2sX+GH415c
   Ta48RcApJgC+KQKL7+0SmcEc2KdlBEe6r1rKxbBQ3lw9jBWatYpQOs0VX
   g5b4nttq4Qr8UE8M5I8fYHuTbRTKOJZtNkzs1C7YF1bqi6pEC1CNcVekA
   K+BJVStMv8EY8Rfi4X+aQrBgsDwuMKOLpsL2MXCRzZgrwhw4tK4tKdJvp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2205835"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2205835"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="22186172"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:00:27 -0800
Message-ID: <de1727eab115466d1573104a1543fb3637f6156f.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com
Date: Wed, 13 Dec 2023 18:07:02 -0700
In-Reply-To: <20231212211351.GA1020185@bhelgaas>
References: <20231212211351.GA1020185@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2023-12-12 at 15:13 -0600, Bjorn Helgaas wrote:
> On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> > On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> > > ...
> > > > Currently Hotplug is controlled by _OSC in both host and Guest.
> > > > In case of guest, it seems guest BIOS hasn't implemented _OSC
> > > > since all the flags are set to 0 which is not the case in host.
> > > 
> > > I think you want pciehp to work on the VMD Root Ports in the
> > > Guest, no matter what, on the assumption that any _OSC that
> > > applies to host bridge A does not apply to the host bridge
> > > created
> > > by the vmd driver.
> > > 
> > > If so, we should just revert 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > > _OSC on PCIe features").  Since host bridge B was not enumerated
> > > via ACPI, the OS owns all those features under B by default, so
> > > reverting 04b12ef163d1 would leave that state.
> > > 
> > > Obviously we'd have to first figure out another solution for the
> > > AER message flood that 04b12ef163d1 resolved.
> > 
> > If we revert 04b12ef163d1, then VMD driver will still enable AER
> > blindly which is a bug. So we need to find a way to make VMD driver
> > aware of AER platform setting and use that information to enable or
> > disable AER for its child devices.
> > 
> > There is a setting in BIOS that allows us to enable OS native AER
> > support on the platform. This setting is located in EDK Menu ->
> > Platform configuration -> system event log -> IIO error enabling ->
> > OS native AER support.
> > 
> > This setting is assigned to VMD bridge by
> > vmd_copy_host_bridge_flags
> > in patch 04b12ef163d1. Without the patch 04b12ef163d1, VMD driver
> > will enable AER even if platform has disabled OS native AER support
> > as mentioned earlier. This will result in an AER flood mentioned in
> > 04b12e f163d1 since there is no AER handlers. 
> > 
> > I believe the rate limit will not alone fix the issue rather will
> > act as a work around.
> 
> I agree with this part.  A rate limit would not solve the problem of
> an interrupt storm consuming the CPU.  That could be addressed by
> switching to polling when the rate is high or possibly other ways.
> 
> > If VMD is aware of OS native AER support setting, then we will not
> > see AER flooding issue.
> > 
> > Do you have any suggestion on how to make VMD driver aware of AER
> > setting and keep it in sync with platform setting.
> 
> Well, this is the whole problem.  IIUC, you're saying we should use
> _OSC to negotiate for AER control below the VMD bridge, but ignore
> _OSC for hotplug control.
Because VMD has it's own hotplug BIOS setting which allows vmd to
enable or disable hotplug on it's domain. However we dont have VMD
specific AER, DPC, LTR settings. Is it okay if we include an additional
check for hotplug? i.e. Hotplug capable bit in SltCap register which
reflects VMD BIOS hotplug setting.

Another way is to overwrite _OSC setting for hotplug only in Guest OS.
If we make VMD driver aware of Host or Guest environment, only in case
of Guest we overwrite _OSC hotplug using SltCap register and we don't
revert the 04b12ef163d1.
> 
> I don't see how to read the _OSC spec and decide which things apply
> below a VMD bridge and which things don't.
> 
> But I think a proposal that "_OSC doesn't apply to any devices below
> a
> VMD bridge," that *is* a pretty generic principle.  If we think
> that's
> the right way to use _OSC, shouldn't the vmd driver be able to
> configure AER for devices below the VMD bridge in any way it wants?
> 
> I'm not sure what "_OSC doesn't apply below a VMD" would mean for
> things like firmware-first error logging below the VMD.  Maybe
> firmware-first doesn't make sense below VMD anyway because firmware
> and the OS have different ideas about the Segment for those devices?
> 
> Bjorn


