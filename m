Return-Path: <linux-pci+bounces-22379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E6A44ACA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5534D423251
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F181A01CC;
	Tue, 25 Feb 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVymymKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F71624E9;
	Tue, 25 Feb 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509097; cv=none; b=XfMssOtK+PIxNsftCjBKm4Bp3IlZPOfdsfa9ZQsaVWITZP2FIEPqANqVgsCT8ayN0woynuFg/kv/p9h+eNQV7YP9T4ySqx/FSvQxfdGhZ2lwxpiiKt9YdbaRfkTbdqGUqEus4VQE/UMuswaELCBUQKOLJyjRXBGuwFkSsSnh3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509097; c=relaxed/simple;
	bh=GYDlNB56m1w3vQUJ/axjsG35l/1LTdFrpvom/9utQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ36P1hajLKY2jvNWTSOPcsf/O8igI+ajCAHI9tXXMA8cL1hKYi/SiQSCQN3QtGbSFUl8X7nXNbwTrYZJibq07fLvgXgyAru4ViP4zL58ooo4eHLEGC2+XcFu/nNIpWnNaVnPSPPip7BHGqfZVancQuKQOFSl3uuSH4sc8GIO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVymymKm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740509095; x=1772045095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GYDlNB56m1w3vQUJ/axjsG35l/1LTdFrpvom/9utQDs=;
  b=cVymymKmnH8y33sPUIqTTbS1IO3c6t767eOiDOKaUd+kP5Uo0D90TN58
   v06NqgZJnaMbisb/hUajoH6Tv082ZHWmIAgeR7ODTH8aXu0tnO/sM6Ykh
   4A4C4K/P/Cw3kxiPiyLcM8I+jsk5WgC726UTDDCen11MjgfTO8sbkNGxH
   AD+CreTyg3MQe7GrJM8D0y8Nw0ANp/0DY4Y9Vbq0pWrQ0ROzOgOjZ1++6
   6uMneNy7ZaKNLqh/dTRIbFae0mQyobYgcGcMgAf2cWz/Jxs6aY2D+UOTp
   AGr6aJHEaxo1PmcTqbzOgHS2ajfGn3IG8bUws5/FnqLI65mgXfoiR49tQ
   Q==;
X-CSE-ConnectionGUID: sMPe2deYRXGNx0UxKIaVoA==
X-CSE-MsgGUID: 7HaAvXWkQ1yQJPlyU6zwFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41584231"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41584231"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 10:44:54 -0800
X-CSE-ConnectionGUID: d/dlnUTWRBinGNLStWC9Iw==
X-CSE-MsgGUID: Xw7swzyPTo+gzTir2NOaVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121715741"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 25 Feb 2025 10:44:50 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 25 Feb 2025 20:44:49 +0200
Date: Tue, 25 Feb 2025 20:44:49 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Gupta, Anshuman" <anshuman.gupta@intel.com>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"Nasim, Kam" <kam.nasim@intel.com>
Subject: Re: [RFC 5/6] drm/xe/pm: D3Cold target state
Message-ID: <Z74PoePChen4Bn8F@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-6-anshuman.gupta@intel.com>
 <Z74Cv8EneHF1frww@intel.com>
 <CY5PR11MB62113ABBF2CDB9F621B1A92595C32@CY5PR11MB6211.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY5PR11MB62113ABBF2CDB9F621B1A92595C32@CY5PR11MB6211.namprd11.prod.outlook.com>
X-Patchwork-Hint: comment

On Tue, Feb 25, 2025 at 06:00:04PM +0000, Gupta, Anshuman wrote:
> 
> 
> > -----Original Message-----
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Sent: Tuesday, February 25, 2025 11:20 PM
> > To: Gupta, Anshuman <anshuman.gupta@intel.com>
> > Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> > pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> > bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> > <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilawar,
> > Badal <badal.nilawar@intel.com>; Nasim, Kam <kam.nasim@intel.com>
> > Subject: Re: [RFC 5/6] drm/xe/pm: D3Cold target state
> > 
> > On Mon, Feb 24, 2025 at 10:18:48PM +0530, Anshuman Gupta wrote:
> > > Trade-off D3Cold target state based upon current vram usages.
> > > if vram usages is greater than vram_d3cold_threshold and GPU has
> > > display connected
> > 
> > Why would anyone care about displays being connected or not?
> As per specs we got to enable vrsr only when there is display connected,

What specs? And why do they say connected displays should be
a factor here?

I think the only thing that makes any sense for this kind of stuff
would be sysfs power/ knobs that allow the system administrator to
tune the behaviour for their specific use case. And if no such knobs
exist currently then perhaps they should be added.

> We can check that in probe but a drm connector status can change after completion of probe. That is the reason to put a check for display connected in idle callback.
> Thanks,
> Anshuman
> > 
> > > then target D3Cold state is D3Cold-VRSR otherwise target state is
> > > D3COLD-Off.
> > >
> > > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
> > > drivers/gpu/drm/xe/display/xe_display.h |  1 +
> > >  drivers/gpu/drm/xe/xe_pm.c              | 12 ++++++++++++
> > >  3 files changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/xe/display/xe_display.c
> > > b/drivers/gpu/drm/xe/display/xe_display.c
> > > index 02a413a07382..140a43d6b1b6 100644
> > > --- a/drivers/gpu/drm/xe/display/xe_display.c
> > > +++ b/drivers/gpu/drm/xe/display/xe_display.c
> > > @@ -548,3 +548,25 @@ int xe_display_probe(struct xe_device *xe)
> > >  	unset_display_features(xe);
> > >  	return 0;
> > >  }
> > > +
> > > +bool xe_display_connected(struct xe_device *xe) {
> > > +	struct drm_connector *list_connector;
> > > +	struct drm_connector_list_iter iter;
> > > +	bool ret = false;
> > > +
> > > +	mutex_lock(&xe->drm.mode_config.mutex);
> > > +	drm_connector_list_iter_begin(&xe->drm, &iter);
> > > +
> > > +	drm_for_each_connector_iter(list_connector, &iter) {
> > > +		if (list_connector->status == connector_status_connected) {
> > > +			ret = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	drm_connector_list_iter_end(&iter);
> > > +	mutex_unlock(&xe->drm.mode_config.mutex);
> > > +
> > > +	return ret;
> > > +}
> > > diff --git a/drivers/gpu/drm/xe/display/xe_display.h
> > > b/drivers/gpu/drm/xe/display/xe_display.h
> > > index 685dc74402fb..c6bc54323084 100644
> > > --- a/drivers/gpu/drm/xe/display/xe_display.h
> > > +++ b/drivers/gpu/drm/xe/display/xe_display.h
> > > @@ -40,6 +40,7 @@ void xe_display_pm_resume(struct xe_device *xe);
> > > void xe_display_pm_runtime_suspend(struct xe_device *xe);  void
> > > xe_display_pm_runtime_suspend_late(struct xe_device *xe);  void
> > > xe_display_pm_runtime_resume(struct xe_device *xe);
> > > +bool xe_display_connected(struct xe_device *xe);
> > >
> > >  #else
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > > index 81e67b5693dc..6d28aedcb062 100644
> > > --- a/drivers/gpu/drm/xe/xe_pm.c
> > > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > > @@ -198,6 +198,14 @@ static void xe_rpm_lockmap_release(const struct
> > xe_device *xe)
> > >  			 &xe_pm_runtime_d3cold_map);
> > >  }
> > >
> > > +static void xe_pm_suspend_prepare(struct xe_device *xe) {
> > > +	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> > > +		xe_pm_d3cold_allowed_toggle(xe);
> > > +	else
> > > +		xe->d3cold.allowed = XE_D3COLD_OFF; }
> > > +
> > >  /**
> > >   * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
> > >   * @xe: xe device instance
> > > @@ -213,6 +221,8 @@ int xe_pm_suspend(struct xe_device *xe)
> > >  	drm_dbg(&xe->drm, "Suspending device\n");
> > >  	trace_xe_pm_suspend(xe, __builtin_return_address(0));
> > >
> > > +	xe_pm_suspend_prepare(xe);
> > > +
> > >  	err = xe_pxp_pm_suspend(xe->pxp);
> > >  	if (err)
> > >  		goto err;
> > > @@ -875,6 +885,8 @@ void xe_pm_d3cold_allowed_toggle(struct
> > xe_device
> > > *xe)
> > >
> > >  	if (total_vram_used_mb < xe->d3cold.vram_threshold)
> > >  		xe->d3cold.allowed = XE_D3COLD_OFF;
> > > +	else if (xe->d3cold.vrsr_capable && xe_display_connected(xe))
> > > +		xe->d3cold.allowed = XE_D3COLD_VRSR;
> > >  	else
> > >  		xe->d3cold.allowed = XE_D3HOT;
> > >
> > > --
> > > 2.34.1
> > 
> > --
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel

