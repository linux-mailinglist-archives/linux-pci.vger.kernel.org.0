Return-Path: <linux-pci+bounces-29326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3083AAD39AC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11845188B7C1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72929A9ED;
	Tue, 10 Jun 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3uX39r3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CB298262;
	Tue, 10 Jun 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563079; cv=none; b=rrXaxXhHgkf/ra1u++Y1RzQ1w74kKSQR0kKLdGWU6qlvWXgN4Jc/TpMqdhQrRZNQG7XVTKktyqVpSUCqzhPOtNQ6dXAd/ejFIDx/3kf1iKHflUy5OjDH05FHApDRgc7npBt7ZOyNNubmRfi8aE/3hX4w2SsNeAjafobqd6NICIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563079; c=relaxed/simple;
	bh=QG2no251uN9UOUAEGMrzI+i0kO5ytw3rD+Js5QWuDq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mooSZeCjNMYMDHJ1UezxNPkMbqLqiEjlsw0/eFF5FABS4pAeewI7l39GT9Mndd+H/8Du/uvjx9pFnqa8RirOxtVnpmP5mlo2EYXfsK5c/3Ba+yquKJHv5qx+B42cJrp5Mprd7bGLSehABA2ygmBOHieCCfa47bWu1NNDz2cCYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3uX39r3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749563077; x=1781099077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QG2no251uN9UOUAEGMrzI+i0kO5ytw3rD+Js5QWuDq0=;
  b=l3uX39r3o8ipO/VRR/y7QRzJ9ygJYhNrTydDbJ0ykAyOjDvx1FfjEsrt
   t0gF+wADNAwGrd3C1Y5LL7UBm6vve+I30AcQq1mJ+t+FZkBtOVrHuN3vm
   imzFxrPkzmD5WVioLaGG94Ik7yXPdPDtPUOeWRc+X84VWZBMLw6qOE9mh
   yq115p/Xsf/kQLpdjJdGO1QjQohBPNRTzf4Mk616CQao3X9FJ+pHZ1k/q
   fRJcD1AwyT/PWw3M1LalEG7KPUj0Fcv85o9D+c0XANY/Haq3EOJCBmSEJ
   VfJWIy99FuYbrTPPajWIPpdqw5f/N5F5uzPiwx1LSJ6gmR5a59mBoCQ/v
   g==;
X-CSE-ConnectionGUID: O+QF4IW3THiixk1osAcz4w==
X-CSE-MsgGUID: VjmBtRqvRjGwt8h0GT8WwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51766910"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51766910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:44:37 -0700
X-CSE-ConnectionGUID: ZbQ7PVNPSlCNNLiZJ8AA3w==
X-CSE-MsgGUID: VuwpZ/3IRGGugqatbVXsWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151982804"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:44:34 -0700
Date: Tue, 10 Jun 2025 16:44:31 +0300
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
Message-ID: <aEg2vzf6tn4j96LG@black.fi.intel.com>
References: <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
 <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
 <aEGDL0IF10QX3Abr@black.fi.intel.com>
 <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>

On Thu, Jun 05, 2025 at 02:26:05PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 5, 2025 at 1:44 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 4, 2025 at 5:43 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, May 30, 2025 at 7:23 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > >
> > > > ...
> > > >
> > > > > > > > > > From the driver perspective it does have expectations that the parts outside
> > > > > > > > > > the driver did the right thing.  If the driver was expecting the root port
> > > > > > > > > > to be powered down at suspend and it wasn't there are hardware components
> > > > > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > > > > >
> > > > > > > > > Which means the expectation set by the driver is the opposite of the
> > > > > > > > > purpose of this patch, and it's going to fail if any kind of error is
> > > > > > > > > detected under root port during suspend.
> > > > > > > >
> > > > > > > > And IMV this driver's expectation is questionable at least.
> > > > > > > >
> > > > > > > > There is no promise whatsoever that the device will always be put into
> > > > > > > > D3cold during system suspend.
> > > > > > >
> > > > > > > For instance, user space may disable D3cold for any PCI device via the
> > > > > > > d3cold_allowed attribute in sysfs.
> > > > > > >
> > > > > > > If the driver cannot handle this, it needs to be fixed.
> > > > > >
> > > > > > Thanks for confirming. So should we consider this patch to be valid
> > > > > > and worth moving forward?
> > > > >
> > > > > It doesn't do anything that would be invalid in principle IMV.
> > > > >
> > > > > You need to consider one more thing, though: It may be necessary to
> > > > > power-cycle the device in order to kick it out of the erroneous state
> > > > > and the patch effectively blocks this if I'm not mistaken.
> > > > >
> > > > > But admittedly I'm not sure if this really matters.
> > > >
> > > > Wouldn't something like bus reset (SBR) be more predictable?
> > >
> > > Maybe.
> > >
> > > The device state is most likely inconsistent in that case, so it depends.
> >
> > My limited understanding is that if SBR doesn't help, at that point all
> > bets are off including PMCSR configuration and probably a cold boot is
> > needed.
> 
> I'm not talking about PMCSR, I'm talking about power removal (D3cold).
> This should be equivalent to a cold boot for the particular device
> except that cold boot would also reset the hierarchy above it.

Sure. But for D3cold we rely on everything else under root port to also
be suspended, which we can't predict while in endpoint suspend path. And
with that we're back to "no guarantees" problem, which was the case either
way. The patch might just prevent any further damage than what's already
done.

Raag

