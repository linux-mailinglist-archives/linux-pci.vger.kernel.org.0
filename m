Return-Path: <linux-pci+bounces-2346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E0832795
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6756F1C223FD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551F3CF42;
	Fri, 19 Jan 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHdhVAUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114136138;
	Fri, 19 Jan 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659785; cv=none; b=QqZyX0yH3h2NPvtW/52YZBlOUpEGHFt7Hbo6NAWCpef1qZ/z90ANCD3bSC3jkp/yhojb9RrdGm8ygqRV0QxI21akn5ELWjKiCm3sWnO8g3VdPG6u4xVvoRH29cbVXfENVvXbtIIzul68hgaacOjkjHw/j8UYBm/BGd2IWY07+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659785; c=relaxed/simple;
	bh=+J0CO6a+MEvtWB8JYt98J+05IRCxT9Ub3fmh88Ph2k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE6VUDHue2PN98z/hocl1TZSUy9jM5Q6KW6NoIpmyupWYgpilRJVCMrxKeltp/hkrgiGMiqsgzskjc9ca7XMSggLrvh3qMzoSOvBsEWRb1vivCX86y6LKowiDGCWGYvSU9hQf56YX+i4ta/pT66WHVwtMdSo6leaD7hLoIZunZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHdhVAUY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705659784; x=1737195784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+J0CO6a+MEvtWB8JYt98J+05IRCxT9Ub3fmh88Ph2k0=;
  b=bHdhVAUYEMaywkz8qq1gVtwFb7OeOEInePgboy9jkDOdK9OKrMDp4JQG
   G0Kq8zzaFah3Vj2ayi1LyrINTx00Azehkc3PEUV+qPJOMAyp9gRuX7ea4
   0jZcuQ1Yy2PNit0iy6Vn3qiiFyRWu80dzu9GnC02QBun1CcxogBI0foau
   lAwGcFj5wkPdpfru+EChHHUxYGrk3DXbcWnsVSLBkWE23/AsIjtWhY4Yu
   VGRgRt0qgYysqz0XfPYlt1LRkkygkVbFzd5b3Ll//Q4kIppxasJGKtCKU
   1Yomuw7sn90ErdHZBD8g33+nreMaorPJ7ptOWEam61FJ/ZAJZvIVxwBNL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="8088412"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="8088412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 02:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="928370826"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="928370826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2024 02:23:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0DF5CE3; Fri, 19 Jan 2024 12:22:58 +0200 (EET)
Date: Fri, 19 Jan 2024 12:22:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240119102258.GE2543524@black.fi.intel.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119074829.GD2543524@black.fi.intel.com>

On Fri, Jan 19, 2024 at 09:48:29AM +0200, Mika Westerberg wrote:
> On Fri, Jan 19, 2024 at 07:37:56AM +0200, Mika Westerberg wrote:
> > On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
> > > On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> > > > On 1/18/2024 00:00, Mika Westerberg wrote:
> > > > > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > > > > labeled “removable”:
> > > > > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > > > > {removable} -e {device} -e {vendor} -e looking
> > > > > >    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > > > > >      ATTR{device}=="0x15d3"
> > > > > >      ATTR{removable}=="removable"
> > > > > >      ATTR{vendor}=="0x8086"
> > > > > 
> > > > > This is actually accurate. The Thunderbolt controller is itself
> > > > > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > > > > firmware upgrades to the device.
> > > 
> > > This is quite interesting take. Does fwupd rip the controller out of the
> > > box to update it? By that account your touchpad is also removable as it
> > > may stop functioning when its firmware gets updated.
> > 
> > The Thunderbolt controller is connected to a hotpluggable PCIe root port
> > so it will be dissappear from the userspace so that "removable" in that
> > sense is accurate.
> 
> There are systems as well where the Thunderbolt (and/or xHCI) controller
> only appears if there is anything plugged to the physical Type-C ports
> and it gets removed pretty soon after the physical device gets
> unplugged. These are also the same Alpine Ridge and Titan Ridge
> controllers that this patch is dealing with.
> 
> I tried to think about some sort of more generic heuristic how to figure
> out that the controller is actually inside the physical system but there
> is a problem that the same controller can appear on the bus as well, eg.
> you plug in Thunderbolt dock and that one has xHCI controller too. That
> device should definitely be "removable". With the "software CM" systems
> we have a couple of additional hints in the ACPI tables that can be used
> to identify the "tunneled" ports but this does not apply to the older
> systems I'm afraid.

The below "might" work:

1. A device that is directly behind a PCIe root or downstream port that
   has ->external_facing == 1.

2. It is a PCIe endpoint.

3. It is a sibling to or has any of the below PCI IDs (see
   drivers/thunderbolt/nhi.h for the definitions):

   PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI
   PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI
   PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI
   PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI
   PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI
   PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI
   PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI

   And for all USB4 we can use the PCI class:

   PCI_CLASS_SERIAL_USB_USB4

(4. With USB4 systems we could also add the check that the device is not
below the tunneled PCIe ports but that's kind of redundant).

I think this covers the existing devices as well as future discrete USB4
controllers and marks both the NHI and the xHCI as "fixed" which we
could also use to lift the bounce buffering restriction from them.

@Mario, did I miss anything?

