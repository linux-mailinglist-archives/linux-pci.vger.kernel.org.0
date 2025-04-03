Return-Path: <linux-pci+bounces-25199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC15A79A56
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4266018916E1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148811662E7;
	Thu,  3 Apr 2025 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUTR4bAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD21854;
	Thu,  3 Apr 2025 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649973; cv=none; b=PChpVmBahfo8sjZ9kDpw/ztNkbfy2xy7s2aeaObiCURzwhMzOvEPqFDJ4sgRfiuCIKTcQj8m/rtYqvrbm63xuYbW++apcOYAa00YAuLVH1D4G96vkSyzCuVr8rHcEr0xINrZYboJ46uhi/EdVFG4uXkLrm5nJAuyzrcKsMQaizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649973; c=relaxed/simple;
	bh=YdNEYByXpy+p25o+6gqrAJE7UbZXNce2qEd5iM0TBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsiEu6mPj3AQjjj+xqD6Nzq4x9jcjhOak7RvNY+uJyH2/i4Y3dglp52/0bToHOIH21iyXGDr3QgIPEAyDEF592hkdaS1ps9N6+hYTRvZR2fhWOA8qJvv04yg8PMfPzWUPuTjDvyeexkkjk7WZwH9mGL1hxrz0eme7gC6D2gBtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUTR4bAI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743649971; x=1775185971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YdNEYByXpy+p25o+6gqrAJE7UbZXNce2qEd5iM0TBE4=;
  b=iUTR4bAIf+emBfQqecJlgEGP/yLyAU8vx3mBoVz5htqZd/pEe73mbhQI
   TXTeVHVOGAbHmXV1lcaUSbN3OwFJwV1schrAUMj73gWDkc+g25sVv76DS
   t6D/WvGBbXijsWzyfOT+gvrehnv4PAvutlPbcfSok2DqR2pYTQ9XDJumw
   kw/pCrlflDM4nQBZI/Z5OnfwD+VrsyX2Fv/7EG//PAwhe3Y6Qsg6hdxLQ
   6u/NZPPZIjf/FLKGUyJUPtput6NT3TMnPgAbTRIuDNf+f/KvY7Hop0oEN
   Pu9XmIhUaVno58O0ET24WMUBKu3OKDbmEB4EC1NJaOzBUEvaeWE8AY9Ue
   w==;
X-CSE-ConnectionGUID: wcXyotbiQliI7f5CUBMFGA==
X-CSE-MsgGUID: s7kXbsmoTJmbi6Ddvp3Gwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44935535"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44935535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:12:50 -0700
X-CSE-ConnectionGUID: ka3ORGejSiecYb5pL+m57A==
X-CSE-MsgGUID: HZ0o/hq7TZiLjnpMOCnkVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127376205"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:12:47 -0700
Date: Thu, 3 Apr 2025 06:12:44 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	intel-xe@lists.freedesktop.org, anshuman.gupta@intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe/d3cold: Set power state to D3Cold during s2idle/s3
Message-ID: <Z-38rPeN_j7YGiEl@black.fi.intel.com>
References: <Z-WHYbhu1QdjUFPR@intel.com>
 <Z-bICZUBN_Fk0_mM@intel.com>
 <Z-eDJUtxjzIjGlJT@black.fi.intel.com>
 <Z-q_n1g9wIEZc-dm@intel.com>
 <2d3f3cbe-c33d-4ded-8c19-e2bd2e76a68b@intel.com>
 <Z-woHnrukI7qtB4m@black.fi.intel.com>
 <CAJZ5v0j7ob4YQ9weQ6e5iVbHyRwf-6Vk2MU4r9mK11-8wD09RQ@mail.gmail.com>
 <Z-znv8D3qIcVX-p1@black.fi.intel.com>
 <Z-z2fz97RwX2kBya@black.fi.intel.com>
 <CAJZ5v0hpkjH_Q7V70jWpC68YQxKkmh0wpwrPrHcUwQJ6uRGrOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hpkjH_Q7V70jWpC68YQxKkmh0wpwrPrHcUwQJ6uRGrOQ@mail.gmail.com>

Cc: PCI maintainers

On Wed, Apr 02, 2025 at 12:31:48PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 2, 2025 at 10:34 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 10:31:16AM +0300, Raag Jadav wrote:
> > > On Tue, Apr 01, 2025 at 09:35:49PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Apr 1, 2025 at 7:53 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > >
> > > ...
> > >
> > > > > That's not what I meant here. There are multiple issues at play.
> > > > >
> > > > > 1. An AER is reported[*] on root port during system suspend even before we
> > > > >    reach any of the driver PM callback. From initial investigation it seems
> > > > >    like a case of misbehaviour by some child device, but this is a different
> > > > >    issue entirely.
> > > > >
> > > > > [*] irq/120-aerdrv-145     [002] .....  1264.981023: <stack trace>
> > > > > => xe_pm_runtime_resume
> > > > > => xe_pci_runtime_resume
> > > > > => pci_pm_runtime_resume
> > > > > => __rpm_callback
> > > > > => rpm_callback
> > > > > => rpm_resume
> > > > > => __pm_runtime_resume
> > > > > => pci_pm_runtime_get_sync
> > > > > => __pci_walk_bus
> > > > > => pci_walk_bus
> > > > > => pcie_do_recovery
> > > > > => aer_process_err_devices
> > > > > => aer_isr
> > > > >
> > > > > 2. Setting explicit pci_set_power_state(pdev, PCI_D3cold) from xe_pm_suspend().
> > > > >    Although we see many drivers do it for their case, it's quite a questionable
> > > > >    choice (atleast IMHO) to hard suspend the device from driver PM callback
> > > > >    without any regard to runtime_usage counter. It can hide potential issues
> > > > >    like AER during system suspend (regardless of whether or not it is supported
> > > > >    by the driver, since it is supposed to keep the device active on such a
> > > > >    catastrophic failure anyway), but I'll leave it to the experts to decide.
> > > >
> > > > If the driver does not set DPM_FLAG_SMART_SUSPEND, and xe doesn't set
> > > > it AFAICS (at least not in the mainline), pci_pm_suspend() will resume
> > > > the device from runtime suspend before invoking its driver's callback.
> > > >
> > > > This guarantees that the device is always RPM_ACTIVE when
> > > > xe_pci_suspend() runs and it cannot be runtime-suspended because the
> > > > core is holding a runtime PM reference on it (and so the runtime PM
> > > > usage counter is always greater than zero when xe_pci_suspend() runs).
> > > >
> > > > This means that neither xe_pci_runtime_suspend() nor
> > > > xe_pci_runtime_resume() can run concurrently with respect to it, so
> > > > xe_pci_suspend() can change the power state of the device etc. safely.
> > >
> > > Ah, I failed to notice that __pm_runtime_resume() is taking a spin_lock_irqsave().
> > > Thanks for clearing this up.
> >
> > On second thought, pcie_do_recovery() can still race with xe_pci_suspend(),
> > is this understanding correct?
> 
> Yes, it can, but this is an AER issue.
> 
> Apparently, somebody took runtime PM into account, but they failed to
> take system suspend into account.
> 
> There are many drivers that do PCI PM in their ->suspend() callbacks
> and this predates pcie_do_recovery() AFAICS.  Some of them don't even
> support runtime PM.
> 
> > I'm assuming this is why it's much safer to do pci_save_state() and
> > pci_prepare_to_sleep() only in ->noirq() callbacks like originally done
> > by PCI PM, right?
> 
> Not really, but close.
> 
> The noirq phases were introduced because drivers often failed to
> prevent their interrupt handlers from messing up with devices after
> powering them down.
> 
> Recovery is kind of like hot-add, doing any of them during system
> suspend is a bad idea because the outcome is hard to predict.
> 
> AER needs to be fixed.

I agree it's a bad idea and should be fixed but even more unpredictable
in such cases is resuming the device afterwards, which may or may not
succeed depending on the fault that has happened. So perhaps just not
let the device suspend to D3 at all?

Raag

