Return-Path: <linux-pci+bounces-2456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A074838745
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 07:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B50A28CA51
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187635025A;
	Tue, 23 Jan 2024 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azjYG4gi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2945025B;
	Tue, 23 Jan 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990708; cv=none; b=jJLZdZq4snByAj3pOIGH7fbqPQ8lkrRxWo47F3Udciqhu3T6t4zMgn/E2HtgN6UjVElEztunWDOaudgBztrSt/vVb60xjrkx8t4IQNhLcLAg5Z08jRYXIG4PmxUGeKm2o4LWYK1xszZxSObcjQT4bhg3jItMgioSuiBaBPvBUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990708; c=relaxed/simple;
	bh=xBese3EjrHpBy6b6usLoEuNNOkbyMDMvVUWw0nYxG/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APEreUDt3FPwKPD3XQiFVX+xbtkHWimMTbXbZp9PBzLtYoVDvq5CJr+lyf9+WyYxFtaspqG8Xmxzlvk0sH2SarZz88vNvPJVVtPfL2YR4eOQ7UrXC/weIk6YTXy/jD4Gsc8T+SD2y4MsdAGLmjcWRqDtmDQ8LeDppabPWfYLiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azjYG4gi; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705990706; x=1737526706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xBese3EjrHpBy6b6usLoEuNNOkbyMDMvVUWw0nYxG/k=;
  b=azjYG4giwNgYAYyHqWgp20/mSbMT5RD+iPy+tPKrxt5UJSFAhMGHc/oO
   keATHLlVetE5P9mZHUPVsE3mxaUqaRqoc64ZXdpiErneZunpHHYQhgs66
   aLfxJRGSmpxiRo8qqVlaxPxrMmmYiQy1By0Y39WIsDxKCFzIYnJGYlgT+
   jM++wTtXaOJfZlwi8L/22PUbv6Nc1F2AhrrJTzb9yDhhYb90R9UOpLKN7
   ep1vg/Az/LUVz/hNPVymbZ3fc812/O6LoqNIci0/qEVPbtGRoouipsJkz
   kiG4bA/yIlNwesmmC7wDXvUqLeTh0Im8Td/Vr0SsUFBiIVAONtQc7uAPT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="401082741"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="401082741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929235690"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="929235690"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2024 22:18:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 320099F; Tue, 23 Jan 2024 08:18:20 +0200 (EET)
Date: Tue, 23 Jan 2024 08:18:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240123061820.GL2543524@black.fi.intel.com>
References: <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>

On Mon, Jan 22, 2024 at 05:50:24PM -0600, Mario Limonciello wrote:
> On 1/19/2024 04:22, Mika Westerberg wrote:
> > On Fri, Jan 19, 2024 at 09:48:29AM +0200, Mika Westerberg wrote:
> > > On Fri, Jan 19, 2024 at 07:37:56AM +0200, Mika Westerberg wrote:
> > > > On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
> > > > > On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> > > > > > On 1/18/2024 00:00, Mika Westerberg wrote:
> > > > > > > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > > > > > > labeled “removable”:
> > > > > > > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > > > > > > {removable} -e {device} -e {vendor} -e looking
> > > > > > > >     looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > > > > > > >       ATTR{device}=="0x15d3"
> > > > > > > >       ATTR{removable}=="removable"
> > > > > > > >       ATTR{vendor}=="0x8086"
> > > > > > > 
> > > > > > > This is actually accurate. The Thunderbolt controller is itself
> > > > > > > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > > > > > > firmware upgrades to the device.
> > > > > 
> > > > > This is quite interesting take. Does fwupd rip the controller out of the
> > > > > box to update it? By that account your touchpad is also removable as it
> > > > > may stop functioning when its firmware gets updated.
> > > > 
> > > > The Thunderbolt controller is connected to a hotpluggable PCIe root port
> > > > so it will be dissappear from the userspace so that "removable" in that
> > > > sense is accurate.
> > > 
> > > There are systems as well where the Thunderbolt (and/or xHCI) controller
> > > only appears if there is anything plugged to the physical Type-C ports
> > > and it gets removed pretty soon after the physical device gets
> > > unplugged. These are also the same Alpine Ridge and Titan Ridge
> > > controllers that this patch is dealing with.
> > > 
> > > I tried to think about some sort of more generic heuristic how to figure
> > > out that the controller is actually inside the physical system but there
> > > is a problem that the same controller can appear on the bus as well, eg.
> > > you plug in Thunderbolt dock and that one has xHCI controller too. That
> > > device should definitely be "removable". With the "software CM" systems
> > > we have a couple of additional hints in the ACPI tables that can be used
> > > to identify the "tunneled" ports but this does not apply to the older
> > > systems I'm afraid.
> > 
> > The below "might" work:
> > 
> > 1. A device that is directly behind a PCIe root or downstream port that
> >     has ->external_facing == 1.
> > 
> > 2. It is a PCIe endpoint.
> > 
> > 3. It is a sibling to or has any of the below PCI IDs (see
> >     drivers/thunderbolt/nhi.h for the definitions):
> > 
> >     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI
> >     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI
> >     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI
> >     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI
> >     PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI
> >     PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI
> >     PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI
> > 
> >     And for all USB4 we can use the PCI class:
> > 
> >     PCI_CLASS_SERIAL_USB_USB4
> > 
> > (4. With USB4 systems we could also add the check that the device is not
> > below the tunneled PCIe ports but that's kind of redundant).
> > 
> > I think this covers the existing devices as well as future discrete USB4
> > controllers and marks both the NHI and the xHCI as "fixed" which we
> > could also use to lift the bounce buffering restriction from them.
> > 
> > @Mario, did I miss anything?
> 
> The bounce buffering restriction is only for unaligned DMA isn't it? Does
> that tend to happen a lot?

AFAICT no but this would allow to use IOMMU identity mappings instead of
full mappings with these devices.

> But otherwise I think this does a good job.  It will cover external
> enclosure cases too because of having to check it's directly behind a root
> port.
> 
> But it should also include comments about why it's not needed on newer
> systems (IE the ACPI hints for someone with no prior knowledge looking at
> this to find).

Agree.

