Return-Path: <linux-pci+bounces-28727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74AAC94A7
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B071BC4829
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A776229B3D;
	Fri, 30 May 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Czs5aWxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214962D600;
	Fri, 30 May 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625800; cv=none; b=c7xR8C8o/TUr6D0Bbpk4RKkG8RZxNpcdQK+N8rRja33pOhPdlSLB5y9Y0QpJk9x8vgvRiza1fGeVpf5WXiLY5UUUX9emnFf+aoGs8M4mgRKy11qXQu/D3lsWQ5Hvfpw63dRIhN0+pVOE1mRuQ4QTwu9iA7j9+JF/Qy76ERZkSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625800; c=relaxed/simple;
	bh=LtRRKOvFNPh4KPAIWtI8ZscFptnvxHt2EGEbh94LZIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/iyZojJsWpF0NXCVgbSRchP4fHr6wc9U5WGIBna1LN5KWO0u5bloIr2pchGP3VZe7ibJb26z4YPxs4Y05TANxDOJF55qt26gsrX6Sbq1bHJr7MYJCx14YfXHF5+j1igJIDMrqQy0qrz8sgloZnyyvc7RJgRcN0j1X5bEetjUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Czs5aWxI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748625799; x=1780161799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LtRRKOvFNPh4KPAIWtI8ZscFptnvxHt2EGEbh94LZIs=;
  b=Czs5aWxI6AEGisCp/Q7ulqklIE1OCsxgzabUJGkf5iTiUcP5t3Amj9Mv
   vwl8OkY4OZVjmhqttYnY2lTGXZ4FtonOlTQ3IQ8/NJJy45vhFOxJ4MRyT
   8MnouiXpQ8C/EBZTJyTOgL/0kA0ndA4J+RpUStOWftNd4C8AnlE7TjNr3
   Suf05k7ClHNiUDC9qMIcMVJhBtgBJwbyQOKo99y5BIwDt8TLuEjRJnKPf
   QN/i5FFi3ch6zaMAqi67uffXjcawjlX9uMxfloPhlJ4zqgA7oxvTYg/og
   tSORU63MDneepiz1wkrKDRD2yPLZKmZ6jUUfA8qgBt+6kdWRcrg4UkuMG
   w==;
X-CSE-ConnectionGUID: csyql8cFRDa+Z/EVffjujw==
X-CSE-MsgGUID: aKG6pb9RT7atlXjLuhV5pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="53358145"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="53358145"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:23:16 -0700
X-CSE-ConnectionGUID: mLev60PqRjq57WMIW+1/gw==
X-CSE-MsgGUID: TXtpvKYOQcS9ic/fGl60qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143961547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:23:12 -0700
Date: Fri, 30 May 2025 20:23:08 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com,
	oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aDnpfKvLwRZsKxhH@black.fi.intel.com>
References: <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>

On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > > > > On 5/20/2025 12:22 PM, Denis Benato wrote:
> > > > > > > On 5/20/25 17:49, Mario Limonciello wrote:
> > > > > > > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > > > > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello wrote:
> > > > > > > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
> > > > > > > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
> > > > > > > > > > > > > > If error status is set on an AER capable device, most likely either the
> > > > > > > > > > > > > > device recovery is in progress or has already failed. Neither of the
> > > > > > > > > > > > > > cases are well suited for power state transition of the device, since
> > > > > > > > > > > > > > this can lead to unpredictable consequences like resume failure, or in
> > > > > > > > > > > > > > worst case the device is lost because of it. Leave the device in its
> > > > > > > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > > > > > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> > > > > > > > > > > > > >         Elaborate "why" (Bjorn)
> > > > > > > > > > > > > > v4: Rely on error status instead of device status
> > > > > > > > > > > > > >         Condense comment (Lukas)
> > > > > > > > > > > > > Since pci_aer_in_progress() is changed I've not included Rafael's tag with
> > > > > > > > > > > > > my understanding of this needing a revisit. If this was a mistake, please
> > > > > > > > > > > > > let me know.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > > > > > >
> > > > > > > > > > > > Hello,
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the test. It seems there's no hotplug event this time around
> > > > > > > > > > > and endpoint device is still intact without any PCI related failure.
> > > > > > > > > > >
> > > > > > > > > > > Also,
> > > > > > > > > > >
> > > > > > > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> > > > > > > > > > >
> > > > > > > > > > > Which means whatever you're facing is either not related to this patch,
> > > > > > > > > > > or at best exposed some nasty side-effect that's not handled correctly
> > > > > > > > > > > by the driver.
> > > > > > > > > > >
> > > > > > > > > > > I'd say amdgpu folks would be of better help for your case.
> > > > > > > > > > >
> > > > > > > > > > > Raag
> > > > > > > > > >
> > > > > > > > > > So according to the logs Denis shared with v4
> > > > > > > > > > (https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. This
> > > > > > > > > > stands for "Bus off Chip Off"
> > > > > > > > > >
> > > > > > > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
> > > > > > > > > >
> > > > > > > > > > If it's going to D3hot - that's not going to be BOCO, it should be going to
> > > > > > > > > > D3cold.
> > > > > > > > >
> > > > > > > > > Yes, because upstream port is in D0 for some reason (might be this patch
> > > > > > > > > but not sure) and so will be the root port.
> > > > > > > > >
> > > > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > > > > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > > > > > >
> > > > > > > > > and my best guess is the driver is not able to cope with the lack of D3cold.
> > > > > > > >
> > > > > > > > Yes; if the driver is configured to expect BOCO (D3cold) if it doesn't get it, chaos ensues.
> > > > > > > >
> > > > > > > > I guess let's double check the behavior with CONFIG_PCI_DEBUG to verify this patch is what is changing that upstream port behavior.
> > > > > > >
> > > > > > >
> > > > > > > This is the very same exact kernel, minus the patch in question:  https://pastebin.com/rwMYgG7C
> > > > > > >
> > > > > > >
> > > > > > > Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
> > > > > > >
> > > > > > > Removed the initial bootup sequence to be able to use pastebin.
> > > > > >
> > > > > > Thanks - this confirms that the problem is the root port not going to D3.
> > > > > > This new log shows:
> > > > > >
> > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> > > > > >
> > > > > > So I feel we should fixate on solving that.
> > > > >
> > > > > Which means what you're looking for is error flag being set somewhere in
> > > > > the hierarchy that is preventing suspend.
> > > >
> > > > Is the issue perhaps that this is now gated on both correctable and
> > > > uncorrectable errors?
> > > >
> > > > Perhaps should *correctable errors* be emitted with a warning and the
> > > > *uncorrectable errors* be fatal?
> > >
> > > That'd be more or less inline with hiding the issue, and it can also race
> > > with err_handler callback if driver has registered it.
> > >
> > > > > But regardless of it, my understanding is that root port suspend depends
> > > > > on a lot of factors (now errors flags being one of them with this patch)
> > > > > and endpoint driver can't possibly enforce or guarantee it - the best it
> > > > > can do is try.
> > > > >
> > > > > What's probably needed is D3cold failure handling on driver side, but I'm
> > > > > no PCI PM expert and perhaps Rafael can comment on it.
> > > > >
> > > > > Raag
> > > >
> > > > From the driver perspective it does have expectations that the parts outside
> > > > the driver did the right thing.  If the driver was expecting the root port
> > > > to be powered down at suspend and it wasn't there are hardware components
> > > > that didn't power cycle and that's what we're seeing here.
> > >
> > > Which means the expectation set by the driver is the opposite of the
> > > purpose of this patch, and it's going to fail if any kind of error is
> > > detected under root port during suspend.
> >
> > And IMV this driver's expectation is questionable at least.
> >
> > There is no promise whatsoever that the device will always be put into
> > D3cold during system suspend.
> 
> For instance, user space may disable D3cold for any PCI device via the
> d3cold_allowed attribute in sysfs.
> 
> If the driver cannot handle this, it needs to be fixed.

Thanks for confirming. So should we consider this patch to be valid
and worth moving forward?

Raag

