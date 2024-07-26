Return-Path: <linux-pci+bounces-10828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE793CEDB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780B4B22CD2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108F176255;
	Fri, 26 Jul 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apLvUBI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2D176252
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979003; cv=none; b=NSrsJ8rtFEgV50ms8EBVNx/sdou8+DpUtUWyg7/55hEQ9bj+w4rUzSqpuQqvVBOBbM7WrIARRGMJTO7rdVXeZZA3fCZmJUi4TLBhX4XjgjBnNr7ZF1rErt5p0FT8N8FkOPoEwX/A3ghIaNYq79NpPJkSXFsZuBoC43VAbVEQhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979003; c=relaxed/simple;
	bh=hpSo3OxJVkWPVomcn518gtcFv8PdP1Xf+q4k4GP9HzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRqV9/UDX+csK/7SXjO8ggdQs0KvqkukreL9Zp7craDS3P1yGEyy+xMyMoOMzK5FLCvUa6y/WWBdCOGCP8XgzB/smfQ3jUoFUrJZVu3z+z/IWufZxRrP6oC2IZb0lXXs6irllNZ8F/Yru9+SUq0jTj6L/XPBKYTgn908FfaM5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apLvUBI7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721979002; x=1753515002;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpSo3OxJVkWPVomcn518gtcFv8PdP1Xf+q4k4GP9HzY=;
  b=apLvUBI7FOCiX0qVntcKhKSdDHC7vF2EghTOwEisoT4dBWdly4bHKxDq
   CtFbSVWtGNJ5K7OfoBPcqHIkUDPJ0d5uO5F0f9tzC7mX7/g7vNvBpsj4v
   DEjWUqsPge6KfkGOoR+fU0iYRof64GyMrfwmKul8D52AXP+PE1g1Br9OY
   zKT1eh3WgP2DxjtcpCuuyLhrHGVBdMZaHG2C6U52wM0clE5qMYpmRn3Pd
   yrncWJhrqNF17ej8dtHwbPiEXkPYxjxU+gFOqmyt7QOncEEuKIsoXy9iK
   UV6XJ79YuZKvAyTiIoMvpuu+a5WEbBDrGm1Z5/ADe/FkmJThNafoa7PAj
   g==;
X-CSE-ConnectionGUID: fxnvIp4ZSeqR+F3plMLnxw==
X-CSE-MsgGUID: sbEddzBcQYuER3ZIMoLgcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23517619"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="23517619"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:30:02 -0700
X-CSE-ConnectionGUID: BeIgU2FaTN+UugkLS0u8Eg==
X-CSE-MsgGUID: dpI2ZSEgS52q+/NYQX9LEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53260388"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.82.157])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:29:58 -0700
Date: Fri, 26 Jul 2024 09:29:53 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Christoph
 Hellwig <hch@lst.de>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan
 Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, Marek Behun
 <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Blazej Kucman
 <blazej.kucman@intel.com>
Subject: Re: [PATCH v4 0/3] PCIe Enclosure LED Management
Message-ID: <20240726092953.000007fa@linux.intel.com>
In-Reply-To: <20240725200819.GA856133@bhelgaas>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
	<20240725200819.GA856133@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 15:08:19 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Blazej]
> 
> On Thu, Jul 11, 2024 at 10:30:06AM +0200, Mariusz Tkaczyk wrote:
> > Patchset is named as PCIe Enclosure LED Management because it adds two
> > features:
> > - Native PCIe Enclosure Management (NPEM)
> > - PCIe SSD Status LED Management (DSM)
> > 
> > Both are pattern oriented standards, they tell which "indication" should
> > blink. It doesn't control physical LED or pattern visualization.
> > 
> > Overall, driver is simple but it was not simple to fit it into interfaces
> > we have in kernel (We considered leds and enclosure interfaces). It reuses
> > leds interface, this approach seems to be the best because:
> > - leds are actively maintained, no new interface added.
> > - leds do not require any extensions, enclosure needs to be adjusted first.
> > 
> > There are trade-offs:
> > - "brightness" is the name of sysfs file to control led. It is not
> >   natural to use brightness to set patterns, that is why multiple led
> >   devices are created (one per indication);
> > - Update of one led may affect other leds, led triggers may not work
> >   as expected.  
> 
> I see the sysfs interface (/sys/.../leds/10000:02:05.0:enclosure:fail,
> etc).  I assume this is intended for things like ledmon?  I think this
> should be documented somewhere in Documentation/ABI/ if it's not
> already there.

Currently, ledmon is not familiar with the kernel LEDs class so I do not expect
have it documented in kernel.

I will create Documentation/ABI/testing/sysfs-class-led-npem-dsm and resend it.

> 
> I think that sysfs interface is the same for NPEM and _DSM?

Yes, in this implementation the backend (NPEM/DSM) is not presented to
userspace.

> 
> I guess this is basically a newer, better, more generic approach to
> the pciehp functionality added by 576243b3f9ea ("PCI: pciehp: Allow
> exclusive userspace control of indicators") for NVMe behind VMD?

So far I know, the motivation of NPEM was to provide enterprise enclosure led
management for NVMes. NPEM capable hardware is replacing VMD blinking on Intel
platforms as you expect.

In ledmon, if both VMD and NPEM detected, NPEM has higher priority.
Ledmon is able to manipulate NPEM directly now, we will switch it to kernel
driver.

> 
> I suppose it's too late for any hope of unifying all these things in
> terms of the user interface?  I guess we're stuck with maintaining
> 576243b3f9ea regardless since users are using it, but the VMD stuff in
> ledmon seems like kind of an ugly special case.

Yes, we cannot abandon VMD blinking :(
NPEM is a hardware feature, we cannot just switch to NPEM with new kernels,
hardware must support it.

Mariusz

