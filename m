Return-Path: <linux-pci+bounces-29026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7EACEEAA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C12164B4D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1CF214818;
	Thu,  5 Jun 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM/khJLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E741C27;
	Thu,  5 Jun 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123896; cv=none; b=AsDEfd7XqdUM/fUc/XfJMVbkkUnW7eLEhndmZiAuFULBTEU2criZNnjRdWoatL8EeAmz2rsviKrhme/LuvsFFL5PfWTqUATz0psYGxOzJ+PzSURza9oiDusgYfuMZZtbqBhRlZem1TPbpailaxb0b9CLq8D2+2PgF1FXmNiD21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123896; c=relaxed/simple;
	bh=NzPkbUkN3Txeqet1Im5YkbvnKI7AuzMxCQo+dJH86v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0uIXGZst+KJmOw3RH3wjPcLur7mwa1bhBfV/ibv8Gs5rJrS9fkRYbonskMDNhYmFfa43I0nktUEBDitIEO0l5B3j9juKqouftqVwCOMz+KJOXsdHoSle3qeV/O7a+76krtLsseamY71sg1y7yc15BoQFYwECkkMGzTjyyZXbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM/khJLQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749123895; x=1780659895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NzPkbUkN3Txeqet1Im5YkbvnKI7AuzMxCQo+dJH86v4=;
  b=FM/khJLQHIadGMPscHNFU/UMCrboF5PePZ/4vt5R5HPVb3NRiJ238S01
   kLsho65Jb14+7q+gmUS6QXi03hwhVkVkUy9QPd0eWr70A26G+VJ+MuF0b
   l4HtUa61TUK66UZPe5DcvoFlXG8SXZdoapT5X7vYqWmEaxtqH0Ftr3kVj
   XCCYszd3QgDrrKQgU3/5AtiPH2kHI0JoSkAKtbS2z9qNx3Y4+2Pop93MD
   kMHvwAebpGgPwK5IjBUQOP3oB0dQ4/ZcGPEsMFX0RG5q/3VU0bTDkpajs
   ooL2tDPscMBF/LaKvblq1gx6vmGtEk/bun4/Oxm0vkyqTaeAd2pIPNcCP
   Q==;
X-CSE-ConnectionGUID: v1jwG2eQSz2SMVMSW7Qdvg==
X-CSE-MsgGUID: A16MX5bfTuqTQgOM7dxPbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51236299"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51236299"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 04:44:54 -0700
X-CSE-ConnectionGUID: i+dOHlE1SJqrKaX++mLgSQ==
X-CSE-MsgGUID: rOi131nVRQSOXbJb9D8/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="145364817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 04:44:51 -0700
Date: Thu, 5 Jun 2025 14:44:47 +0300
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
Message-ID: <aEGDL0IF10QX3Abr@black.fi.intel.com>
References: <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
 <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>

On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 5:43 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, May 30, 2025 at 7:23 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> >
> > ...
> >
> > > > > > > > From the driver perspective it does have expectations that the parts outside
> > > > > > > > the driver did the right thing.  If the driver was expecting the root port
> > > > > > > > to be powered down at suspend and it wasn't there are hardware components
> > > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > > >
> > > > > > > Which means the expectation set by the driver is the opposite of the
> > > > > > > purpose of this patch, and it's going to fail if any kind of error is
> > > > > > > detected under root port during suspend.
> > > > > >
> > > > > > And IMV this driver's expectation is questionable at least.
> > > > > >
> > > > > > There is no promise whatsoever that the device will always be put into
> > > > > > D3cold during system suspend.
> > > > >
> > > > > For instance, user space may disable D3cold for any PCI device via the
> > > > > d3cold_allowed attribute in sysfs.
> > > > >
> > > > > If the driver cannot handle this, it needs to be fixed.
> > > >
> > > > Thanks for confirming. So should we consider this patch to be valid
> > > > and worth moving forward?
> > >
> > > It doesn't do anything that would be invalid in principle IMV.
> > >
> > > You need to consider one more thing, though: It may be necessary to
> > > power-cycle the device in order to kick it out of the erroneous state
> > > and the patch effectively blocks this if I'm not mistaken.
> > >
> > > But admittedly I'm not sure if this really matters.
> >
> > Wouldn't something like bus reset (SBR) be more predictable?
> 
> Maybe.
> 
> The device state is most likely inconsistent in that case, so it depends.

My limited understanding is that if SBR doesn't help, at that point all
bets are off including PMCSR configuration and probably a cold boot is
needed.

Please correct me if I've misunderstood.

Raag

