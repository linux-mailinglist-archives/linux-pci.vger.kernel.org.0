Return-Path: <linux-pci+bounces-2332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56B83247B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 07:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83F61F241DA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F94A15;
	Fri, 19 Jan 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeV+Fpez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762384A0C;
	Fri, 19 Jan 2024 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644206; cv=none; b=QhWUeJL0luzKAbWI4S3F9WB1sopZt8ybrpsFPDV5S5VMV2jcE+HYka9WFEW8rAHMXVT0LBXmPIrLXCrCxAvCZcvr3cKQBSZ6BuAQ4W6Ed8K5PO+pDPMjyBibJU4k/KQgpDPfcuvUj++6k016rcQ5pFbekAUJ1aAKPj7xsaT2r8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644206; c=relaxed/simple;
	bh=fElIcAvj+JU3H2ET/6sVLuziTay9kn5vl9dtRYelW34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAX2zKByS9dnJ0nSyWCfZ0bGIxiBTCPVKXEsVOLh5RaGu+py2KT+9CY48+hSc1JluAztawCXUupiiQRnKEpI1n2G2TwIKmlJCRnF5Zti26BzmgebLkEm/+NJyeFZYAJ34xRHC7yoJBvEhqfkRXSPKBUVpJQ+zBKolZ2YmS6V+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeV+Fpez; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705644206; x=1737180206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fElIcAvj+JU3H2ET/6sVLuziTay9kn5vl9dtRYelW34=;
  b=YeV+FpezRSAXXMAndxGm44UCHMLNXvXs+2OMRKBoXVGiccubsVFQTclM
   GhBT/bWpTevuwhReE3boaUrGVLZno//kQ5gx35IN6TMh+Fdwwqm8HtiZM
   hjPHkja4qJPlmlxXaVdiAoau4nNYanry/lrLkqbJa+gtlXH2VZRRdFxs5
   3Z9q8+2HgSvcfYtoAKibNj0Q1S8+aghSi+IlDDrRIupFO8bi85948iRMI
   BJlo0cfC4xqYbdYxTanZG3fgnOI5A3mdUX7d9DJkbKghXry7/hvHBlads
   fJXvFl6Zi4HwEnHuUUz+jF3LuraJPJRXjWNGip1isyHySkAHyXnK07pVm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="14192965"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="14192965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 22:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="875291857"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="875291857"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2024 22:03:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 572EEE3; Fri, 19 Jan 2024 07:37:56 +0200 (EET)
Date: Fri, 19 Jan 2024 07:37:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240119053756.GC2543524@black.fi.intel.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZalOCPrVA52wyFfv@google.com>

On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> > On 1/18/2024 00:00, Mika Westerberg wrote:
> > > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > > labeled “removable”:
> > > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > > {removable} -e {device} -e {vendor} -e looking
> > > >    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > > >      ATTR{device}=="0x15d3"
> > > >      ATTR{removable}=="removable"
> > > >      ATTR{vendor}=="0x8086"
> > > 
> > > This is actually accurate. The Thunderbolt controller is itself
> > > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > > firmware upgrades to the device.
> 
> This is quite interesting take. Does fwupd rip the controller out of the
> box to update it? By that account your touchpad is also removable as it
> may stop functioning when its firmware gets updated.

The Thunderbolt controller is connected to a hotpluggable PCIe root port
so it will be dissappear from the userspace so that "removable" in that
sense is accurate.

> > Depending on the consumers of this removable attribute I wonder if we need
> > to a new ATTR of "external" instead of overloading "removable".
> 
> Isn't this the same thing? From
> Documentation/ABI/testing/sysfs-devices-removable:
> 
> What:		/sys/devices/.../removable
> Date:		May 2021
> Contact:	Rajat Jain <rajatxjain@gmail.com>
> Description:
> 		Information about whether a given device can be removed from the
> 		platform by the	user. This is determined by its subsystem in a
> 		bus / platform-specific way. This attribute is only present for
> 		devices that can support determining such information:
> 
> 		===========  ===================================================
> 		"removable"  device can be removed from the platform by the user
> 		"fixed"      device is fixed to the platform / cannot be removed
> 			     by the user.
> 
> Note this "by the user". Maybe we should add word "physically" here to
> qualify the meaning completely, but that is what it is. Not that it
> disappears from the bus or stops operating for some time because of
> firmware updates, but it can be physically detached from the
> platform/system.

That would be good to fully qualify what this means. But I get you it is
intented to identify devices that can be physically unplugged from the
system.

