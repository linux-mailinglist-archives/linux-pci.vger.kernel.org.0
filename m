Return-Path: <linux-pci+bounces-13569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC49876A6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682A11F210F4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214272AE74;
	Thu, 26 Sep 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fai85Ng7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5215350B
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365143; cv=none; b=fNpE5Drw1Kx88F7s5KXc3dKm2rOZLSZnWAeuhlyxlxKifWf/OZfFcLkLFoYj2o49TejUPgkYDc4yIMV8uXJgE5H6DHg5mlmVi/WYQtUVIYiJKSGV3gisvhesUH7+MmEpNV6PTruCdb2LUZjYp+AdVkVVMzfipNI+TCXOu/yKXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365143; c=relaxed/simple;
	bh=V1U06E2MlCeR50riCBWCo5M/Xz0LW1McMLC0hGKItVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba93WOXoYg/PVimjLtHg2sDM0pRMvzRZoqr1nq3aY7Ux3Nv4pgBk9WXQLN+siOihsPDGvsF7ZrV5pOb+06TPccHc8bk7zAEoAr5egp6gfNillZIgwZ/B6VHczcqzOl/1Ill306GHb0bu4Y7jlPF2aH69C+DGRe3/jYCVVrNtsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fai85Ng7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727365141; x=1758901141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V1U06E2MlCeR50riCBWCo5M/Xz0LW1McMLC0hGKItVY=;
  b=fai85Ng7ZPwqqjii+a9tg2I2oiAOetFbubGXz/g1lJFRzgekcAu97MkM
   PthcVuiWe9Lq8ZJB3PbzNznkaOxAiCK9gzl1t2E/nIK++Oap7Wxric2JY
   8rs9Bwxf8Qzs7ctJF5gMP6WqcWVhcwGiqinvYByfl6R4gAXi22MsCZ/a5
   9h609Hbp6LbHQjanYpZcAaS08kCKou3msu+4c1zJ3yXP9trX1bb4Eyxk+
   kNyjaP4uf1o4HIeabmsnDCQoyK8QeERkwR6qL810wET5SqT4h46+2Dprn
   aGmyxsVKC88sWmH1WlPnr4oLkSFwqCJBDeFEJ98/uSCuKsBO09lRfB/ft
   w==;
X-CSE-ConnectionGUID: NuLmmQEHT/ih6LnFq/dL/w==
X-CSE-MsgGUID: EY3ulr3dSk2ctxH/6jYYAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26343837"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26343837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:39:00 -0700
X-CSE-ConnectionGUID: c37OdxQyTPuJfgb4cmBYxQ==
X-CSE-MsgGUID: /mOosNWKQRC5PCZ9vweCVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72349068"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 26 Sep 2024 08:38:57 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 26 Sep 2024 18:38:56 +0300
Date: Thu, 26 Sep 2024 18:38:56 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/i915/pm: Simplify pm hook documentation
Message-ID: <ZvWAEN0n1y4xx_AO@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-4-ville.syrjala@linux.intel.com>
 <ZvVzmKIL_PrM2fds@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvVzmKIL_PrM2fds@intel.com>
X-Patchwork-Hint: comment

On Thu, Sep 26, 2024 at 10:45:44AM -0400, Rodrigo Vivi wrote:
> On Wed, Sep 25, 2024 at 05:45:23PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Stop spelling out each variant of the hook ("" vs. "_late" vs.
> > "_early") and just say eg. "@thaw*" to indicate all of them.
> > Avoids having to update the docs whenever we start/stop using
> > one of the variants.
> 
> That or simply remove them all and refer only to the pm documentation?
> "Entering Hibernation" of Documentation/driver-api/pm/devices.rst

That's not very succinct. Having a better quick overview
of the whole situation might still be nice. 

> 
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_driver.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > index 9d557ff8adf5..1e5abf72dfc4 100644
> > --- a/drivers/gpu/drm/i915/i915_driver.c
> > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > @@ -1644,18 +1644,18 @@ const struct dev_pm_ops i915_pm_ops = {
> >  
> >  	/*
> >  	 * S4 event handlers
> > -	 * @freeze, @freeze_late    : called (1) before creating the
> > -	 *                            hibernation image [PMSG_FREEZE] and
> > -	 *                            (2) after rebooting, before restoring
> > -	 *                            the image [PMSG_QUIESCE]
> > -	 * @thaw, @thaw_early       : called (1) after creating the hibernation
> > -	 *                            image, before writing it [PMSG_THAW]
> > -	 *                            and (2) after failing to create or
> > -	 *                            restore the image [PMSG_RECOVER]
> > -	 * @poweroff, @poweroff_late: called after writing the hibernation
> > -	 *                            image, before rebooting [PMSG_HIBERNATE]
> > -	 * @restore, @restore_early : called after rebooting and restoring the
> > -	 *                            hibernation image [PMSG_RESTORE]
> > +	 * @freeze*   : called (1) before creating the
> > +	 *              hibernation image [PMSG_FREEZE] and
> > +	 *              (2) after rebooting, before restoring
> > +	 *              the image [PMSG_QUIESCE]
> > +	 * @thaw*     : called (1) after creating the hibernation
> > +	 *              image, before writing it [PMSG_THAW]
> > +	 *              and (2) after failing to create or
> > +	 *              restore the image [PMSG_RECOVER]
> > +	 * @poweroff* : called after writing the hibernation
> > +	 *              image, before rebooting [PMSG_HIBERNATE]
> > +	 * @restore*  : called after rebooting and restoring the
> > +	 *              hibernation image [PMSG_RESTORE]
> >  	 */
> >  	.freeze = i915_pm_freeze,
> >  	.freeze_late = i915_pm_freeze_late,
> > -- 
> > 2.44.2
> > 

-- 
Ville Syrjälä
Intel

