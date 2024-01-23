Return-Path: <linux-pci+bounces-2508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF5839C6A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 23:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0031C220D8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DD537E4;
	Tue, 23 Jan 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnj7jTy9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8551010;
	Tue, 23 Jan 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049636; cv=none; b=bQzyTop+bcFmah4nVLgHqIL+rO4us8EXsXOhL9x96j/MP4mTWCYzu2CYcEuYv7kdJ7b8DDwoiFNt7QOJYfu1p6DOhU4g6bNulni4KEVZhV+fSQF21JiUqX9aOcOLUXER4TIuIEXBBCEaZ0pWQW/fSaymSnxn0zNRDeHwwaaBMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049636; c=relaxed/simple;
	bh=Z/gVOBIyuGeHrB0qusJzDPUINYJVDgoRszKTN0NH9s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y51A5jGrmoKH5LlYAKc4Ic+GaIg1KbsG//PuSaauml/TX8DWLGg2n1KRvLw9mNTbT1aOZ7uKh5XMto3b6iko990BPPxQQyfMwRGVV96BPCEcb+DiGrGqHHu/sIdB4MAktXTslaAGH1pD0G3MG/ly4GpgQwNm160lrbHW4SIQN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnj7jTy9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706049635; x=1737585635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z/gVOBIyuGeHrB0qusJzDPUINYJVDgoRszKTN0NH9s0=;
  b=Nnj7jTy9QoK33F0B+UdzyR3BS7WDenry6lephSpBjaV37LgcAmS6CM6b
   kQnqXtXu8K9z/Mi6eOWJaHmg4DZBPKzeeUi2V466xkG9ITTPn2ayT6bLz
   NvCVJtFrwcXJajnkX4KUz3eaKKnEtf2l9bNOB6LBh+Z4OL4Bem0xOapUz
   DREVz3hF44258RZJOtvbHzrE/JLamoaKOz/FDVXTDT4VkTmUDv63lGfXE
   FJxYbeSPDMC4x1//Sia7CDSntGNS7bUiPCMEkCPa+KCVipRzw0u0Uu8yi
   Hq5RpDuaQh6srUU+mkRu5+ySmWHLXcqzEkf2KhO9kImTEuDqIZvYFUoLA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="573954"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="573954"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 14:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876490218"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="876490218"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 14:40:27 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 596D411FB8E;
	Wed, 24 Jan 2024 00:40:25 +0200 (EET)
Date: Tue, 23 Jan 2024 22:40:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Jaroslav Kysela <perex@perex.cz>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	laurent.pinchart@ideasonboard.com, David Airlie <airlied@gmail.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-media@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Daniel Vetter <daniel@ffwll.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <ZbBAWROxRKE8Y8VU@kekkonen.localdomain>
References: <ZbAlFKE_fZ_riRVu@kekkonen.localdomain>
 <20240123214801.GA330312@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123214801.GA330312@bhelgaas>

On Tue, Jan 23, 2024 at 03:48:01PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2024 at 08:44:04PM +0000, Sakari Ailus wrote:
> > On Tue, Jan 23, 2024 at 11:24:23AM -0600, Bjorn Helgaas wrote:
> > ...
> 
> > > - I don't know whether it's feasible, but it would be nice if the
> > >   intel_pm_runtime_pm.c rework could be done in one shot instead of
> > >   being split between patches 1/3 and 2/3.
> > > 
> > >   Maybe it could be a preliminary patch that uses the existing
> > >   if_active/if_in_use interfaces, followed by the trivial if_active
> > >   updates in this patch.  I think that would make the history easier
> > >   to read than having the transitory pm_runtime_get_conditional() in
> > >   the middle.
> > 
> > I think I'd merge the two patches. The second patch is fairly small, after
> > all, and both deal with largely the same code.
> 
> I'm not sure which two patches you mean, but the fact that two patches
> deal with largely the same code is not necessarily an argument for
> merging them.  From a reviewing perspective, it's nice if a patch like

Patches 1 and 2. The third patch introduces a new Runtime PM API function.

> 1/3, where it's largely mechanical and easy to review, is separated
> from patches that make more substantive changes.
> 
> That's why I think it'd be nice if the "interesting"
> intel_pm_runtime_pm.c changes were all in the same patch, and ideally,
> if that patch *only* touched intel_pm_runtime_pm.c.

I don't think squashing the second patch to the first really changes this
meaningfully: the i915 driver simply needs both
pm_runtime_get_if_{active,in_use}, and this is what the patch does to other
drivers already. Making the pm_runtime_get_conditional static would also
fit for the first patch if the desire is to not to introduce it at all.

-- 
Sakari Ailus

