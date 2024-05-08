Return-Path: <linux-pci+bounces-7220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA98BFB62
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC75E1F21075
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C07EF1E;
	Wed,  8 May 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auONveUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59C12E7C
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165866; cv=none; b=JfW5nYSjvzu7ylDKEJJSzepvxw7gSTttWFUMuONY/rKd6YuutNkdcjJyLM/H/hydSiHOggxn0uj944EkhicpbSMFQAnDDg+jHT+rzrdB0sP2tuwzxSmZaHEs26EpDVzZKxfMf84B3hiWKBBPAFnt3O/h+iyuXBIdyigtQZBp10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165866; c=relaxed/simple;
	bh=iJ8E+E7J1K+NVSwbAfDZYzLm03hFC3LLRc9MuZ6t6j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5VxyZGcAmlxSdB2eZ95uRr9ETokvzCKPhJ9aVq9wA7YaHv+XPinhH8496wh9PAVyFq8cKV184yUT3PwCOh1OzWpYuZjjGoRH+VSNRN5Ldxf0Ypy1k2FXKt7ZwFUimlV06+O2XULJTTL+jm2hfBSFfETxIaJLXBKmBaK2yyVqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auONveUa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165864; x=1746701864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iJ8E+E7J1K+NVSwbAfDZYzLm03hFC3LLRc9MuZ6t6j0=;
  b=auONveUaviA7KFmzuNY5imY66RbmRE7ESiEn7/Rr5H0WfK1o0W5w38xI
   dT5SgVtkkvy7oLUF0uqmULVn3NFXhXtUuw3RjXdB/FNxqXh75JYsC5g0v
   Nu3p6fizZC4xEEQFwSPN62ucdVwOD2ETG1F4q4Mv/YKRaw9pkgjq6aWC6
   +E+Mw74zvyshU22etCTDG1HjtgfDfCpDRtuPSG6gZAHHGzsfIM7f1e4OF
   J+ba7vqHJwxFhdlG01NGbUxi9xc25Hh2uB6CPeHHtFW64ZIzFYNwFycSJ
   Go+182UA1Bs8joDh7Jop8OyD1F+UQC/JYbHhUhThN3lv+yOyYt6l6DWhF
   g==;
X-CSE-ConnectionGUID: SO+Hr760QTmgSi/1NtZphg==
X-CSE-MsgGUID: OH7jhdnBSm+g4I7DeuV+ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11179533"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11179533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:57:44 -0700
X-CSE-ConnectionGUID: rx7Id90nS4yPMNNkVjPvXA==
X-CSE-MsgGUID: KC1Nx96LRpWl3JHr2J3rEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28787314"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 08 May 2024 03:57:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 08 May 2024 13:57:40 +0300
Date: Wed, 8 May 2024 13:57:40 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
	lucas.demarchi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Message-ID: <ZjtapMK6kadLqHCN@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjow5HXrXpg2cuOA@intel.com>
X-Patchwork-Hint: comment

On Tue, May 07, 2024 at 09:47:16AM -0400, Rodrigo Vivi wrote:
> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
> > It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
> > we treat them the same in a lot of places, CML is a platform of its own,
> > and the lists of PCI IDs should not conflate them.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> > ---
> >  arch/x86/kernel/early-quirks.c                      |  1 +
> >  drivers/gpu/drm/i915/display/intel_display_device.c |  1 +
> >  include/drm/i915_pciids.h                           | 12 +++++++-----
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index 59f4aefc6bc1..2e2d15be4025 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -547,6 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> >  	INTEL_BXT_IDS(&gen9_early_ops),
> >  	INTEL_KBL_IDS(&gen9_early_ops),
> >  	INTEL_CFL_IDS(&gen9_early_ops),
> > +	INTEL_CML_IDS(&gen9_early_ops),
> >  	INTEL_GLK_IDS(&gen9_early_ops),
> >  	INTEL_CNL_IDS(&gen9_early_ops),
> >  	INTEL_ICL_11_IDS(&gen11_early_ops),
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> > index 56a2e17d7d9e..3aa7d1cdd228 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> > @@ -832,6 +832,7 @@ static const struct {
> >  	INTEL_GLK_IDS(&glk_display),
> >  	INTEL_KBL_IDS(&skl_display),
> >  	INTEL_CFL_IDS(&skl_display),
> > +	INTEL_CML_IDS(&skl_display),
> >  	INTEL_ICL_11_IDS(&icl_display),
> >  	INTEL_EHL_IDS(&jsl_ehl_display),
> >  	INTEL_JSL_IDS(&jsl_ehl_display),
> > diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> > index 85ce33ad6e26..5f52c504ffde 100644
> > --- a/include/drm/i915_pciids.h
> > +++ b/include/drm/i915_pciids.h
> > @@ -472,6 +472,12 @@
> >  	INTEL_VGA_DEVICE(0x9BCA, info), \
> >  	INTEL_VGA_DEVICE(0x9BCC, info)
> >  
> > +#define INTEL_CML_IDS(info) \
> > +	INTEL_CML_GT1_IDS(info), \
> > +	INTEL_CML_GT2_IDS(info), \
> > +	INTEL_CML_U_GT1_IDS(info), \
> > +	INTEL_CML_U_GT2_IDS(info)
> > +
> >  #define INTEL_KBL_IDS(info) \
> >  	INTEL_KBL_GT1_IDS(info), \
> >  	INTEL_KBL_GT2_IDS(info), \
> > @@ -535,11 +541,7 @@
> >  	INTEL_WHL_U_GT1_IDS(info), \
> >  	INTEL_WHL_U_GT2_IDS(info), \
> >  	INTEL_WHL_U_GT3_IDS(info), \
> > -	INTEL_AML_CFL_GT2_IDS(info), \
> > -	INTEL_CML_GT1_IDS(info), \
> > -	INTEL_CML_GT2_IDS(info), \
> > -	INTEL_CML_U_GT1_IDS(info), \
> > -	INTEL_CML_U_GT2_IDS(info)
> > +	INTEL_AML_CFL_GT2_IDS(info)
> 
> Why only CML and not AML and WHL as well?

Why do we even have CML as a separate platform? The only difference 
I can see is is that we do allow_read_ctx_timestamp() for CML but
not for CFL. Does that even make sense?

-- 
Ville Syrjälä
Intel

