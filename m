Return-Path: <linux-pci+bounces-6304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5618A62B9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 07:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E559A1C215C3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FB38385;
	Tue, 16 Apr 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nk/jTxL2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865E381C4;
	Tue, 16 Apr 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243839; cv=none; b=tzsKNCfbnaehl+Ke8tN0C4jiqCLIl+WG8BUXG9YwZfHCm+XdwEPhuYgmxrXckuNCDcTrI1Z2OpHEqLK0ojo7RJ8N+lSYRZp1ArMoON7WhbVxvAGIQ+shQr67Hr8HGTbVmRsBVRh3K9aizO5+T86OLOTjtCREoC803+XYoY3Dvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243839; c=relaxed/simple;
	bh=BmAO5cfNjGRgDXrBQ5fdgxvu5LWToVi7vPs5S0LNEhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3iRgzLIAbJExCrHf7mOy9lHAOXuiEciNfK+T3w4YAL9AwKoga/Pj/FSfdiKSDtav1El9eBEvKcm9Zlsm95VnZRARuc7Huhq71Fj+huJXS+B8X8O2s8SJEQiPx7goW2ECr6NPZJOG2oO0+FjFpIopFuUG7OqQgo937NykNGBhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nk/jTxL2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713243838; x=1744779838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmAO5cfNjGRgDXrBQ5fdgxvu5LWToVi7vPs5S0LNEhs=;
  b=nk/jTxL20dJoxoTLm+ti3tVNADo0s5kdSmxxnKPMM/mGrzrnrgLbBNer
   rvo1tEJXyyPq527u4MJNWcImERvR33UvGihghDIAflAOhoCqYjw6bRKD5
   6xy3Q0JcsKTignhz2By9YGSc7nO2a+Va+oIk2LtpRuio6/NMkUHVcRbdv
   PAvWx7FpOHR2i0NZ5HKvukRZnPZb4kqNr2s1JQcHwPhgsYXK2NMnQjyLD
   Wp/cmuCxGKsMnpePmMnbe+pz72btxSF87rZBCdSvLskIgj6duwAaoC4ni
   lwjEPwDEXcghJ8iGSNHw9vfC7N8F6JJ+pcao95D19aNzqAo1JF+n7O7rJ
   g==;
X-CSE-ConnectionGUID: +98Uazk+Tzq3K1YUQCWEjw==
X-CSE-MsgGUID: WcGLKVplT8masosNATRfyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8522672"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8522672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:03:57 -0700
X-CSE-ConnectionGUID: 0pv7ImchTRa3QmIWDC+K6w==
X-CSE-MsgGUID: kBzoafTDS/i/5W0wywmRFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="53094970"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 15 Apr 2024 22:03:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2D40FE1; Tue, 16 Apr 2024 08:03:53 +0300 (EEST)
Date: Tue, 16 Apr 2024 08:03:53 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240416050353.GI112498@black.fi.intel.com>
References: <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>

Hi,

On Mon, Apr 15, 2024 at 06:34:00PM -0400, Esther Shimanovich wrote:
> Hey!
> Asking for some help on implementation.
> So I implemented most of this, and successfully tested the quirk on 6
> different devices with various types of discrete fixed JHL Thunderbolt
> chips.
> 
> However I want to add an additional check. A device wouldn't need this
> quirk if it already has Thunderbolt functionality built in within its
> Root Port.

There is really no "Thunderbolt functionality built in within its Root
Port".

More accurate is that the Thunderbolt/USB4 controller is integrated into
the CPU and the PCIe tunnels go out through the CPU PCIe Root Ports.

> I tried to use "is_thunderbolt" as an identifier for that type of
> device--- but when I tested on a device with a thunderbolt root port,
> "is_thunderbolt" was false for all the Thunderbolt PCI components
> listed below.

You should not use is_thunderbolt for anything else than with the legacy
Apple systems.

> ~ # lspci -nn | grep Thunderbolt
> 00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
> 4 PCI Express Root Port #1 [8086:9a25] (rev 01)
> 00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt
> 4 PCI Express Root Port #2 [8086:9a27] (rev 01)
> 00:0d.0 USB controller [0c03]: Intel Corporation Tiger Lake-LP
> Thunderbolt 4 USB Controller [8086:9a13] (rev 01)
> 00:0d.2 USB controller [0c03]: Intel Corporation Tiger Lake-LP
> Thunderbolt 4 NHI #0 [8086:9a1b] (rev 01)
> 00:0d.3 USB controller [0c03]: Intel Corporation Tiger Lake-LP
> Thunderbolt 4 NHI #1 [8086:9a1d] (rev 01)

Okay this is integrated Thunderbolt/USB4 controller.

> The device I tested was the Lenovo carbon X1 Gen 9. When
> set_pcie_thunderbolt is run, the devices listed above return false on
> the pci_find_next_ext_capability check.
> 
> I have spent some time trying to see if there are any ACPI values or
> any alternative indicators to reliably know if a root port has
> thunderbolt capabilities. I do see that ADBG is often set to TBT but
> that looks like a debugging tool in ACPI.
> 
> I also looked through lspci -vvv and compared the output with a device
> that has no Thunderbolt built into its CPU, which gave me nothing.

For integrated and most recent systems (that's with the software
connection manager) the tunneled PCIe ports (Root or Downstream) can be
identified by looking at "usb4-host-interface" ACPI _DSD property. In
addition to this there is the "External Facing Port" ACPI _DSD property
attached to them too. Maybe these help?

With the firmware connection manager there is only the "External Facing
Port" _DSD though.

The Microsoft documentation for this that we also use in Linux is here:

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

