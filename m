Return-Path: <linux-pci+bounces-7223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA68BFCCC
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F91C20CF4
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65F82D82;
	Wed,  8 May 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvLCVHWM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA6763EE
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169716; cv=none; b=u6jvbIHF2Ft6Rc7z3Hy5j/LNRzEmy3oNvCNOEQ8BjX1XBYTsytzIbsKT3m2XCZlGG2JFGMjsoxko2H5bdxBbqCLeoGqB1tqmab7qp7EJj5Y30Le0C4FkVBAzWpSHVxfXT61loBRiUc/3Iue1Fp9yaENLpwOvD8lPW713XrY8TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169716; c=relaxed/simple;
	bh=1GMXAMBME28AjcT8fvUTLf65HIRzj4KQd4hDC0vgPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7Uz9JM2XTQQMwfhCtKQvmpAdZlgdHxa1nJy+0McjVTMr1Nr50FpRqJV21GVkkEEI61NOeEG+Q6KsE3fRjwt8mUpfMtPaUBzaRqZerNHzUFJLqA6SPCoYlqMaQpX/tsH1RpCmWuWrFASGrzv/jeXNCrPb2u+/1Ks2/+VkH6SJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvLCVHWM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715169715; x=1746705715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1GMXAMBME28AjcT8fvUTLf65HIRzj4KQd4hDC0vgPLw=;
  b=UvLCVHWMEICICJDukqwo1KOpdzH03ALwRsNTc0rZV1AHcZI5Av3gksVQ
   mC6Y3MsH04hSKdrSldEiPX566A//pVKMltPz+q5QwPgqUhXTY4DaFkik2
   bfyNWzG8wA/7xZwgVkFsEw3brKee+iBdlXAIy9E/u3+/+mTXhM7GoZ4dD
   NqaRzdEtW+cFC0YPe8p+tBz0qer2A7x0IpUfVPmO2vTjpksGODqtL831z
   /d+JarovcIgriTmzv+rugL5H7QdaN4chEieqqzqBQpPYP6FmAWgiYSN9g
   ABLbAdbKvTRmvSoapegVwRY4r7rJxs+h5AKtemNkJAgAhjdjDYIIVq48a
   g==;
X-CSE-ConnectionGUID: vCDby39ISRO+esiTUxeQLw==
X-CSE-MsgGUID: lA/hBc1DRf+QaTsZB/8e0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10959785"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10959785"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 05:01:54 -0700
X-CSE-ConnectionGUID: qtq7JvQ0RrGfA4cN+3Uahg==
X-CSE-MsgGUID: tOCdVGzJT1+no3pQZeNPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28800988"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 08 May 2024 05:01:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 08 May 2024 15:01:50 +0300
Date: Wed, 8 May 2024 15:01:50 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
	lucas.demarchi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Message-ID: <ZjtprkZVSQ-o_qch@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com>
 <ZjtapMK6kadLqHCN@intel.com>
 <87o79gjznd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o79gjznd.fsf@intel.com>
X-Patchwork-Hint: comment

On Wed, May 08, 2024 at 02:45:10PM +0300, Jani Nikula wrote:
> On Wed, 08 May 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Tue, May 07, 2024 at 09:47:16AM -0400, Rodrigo Vivi wrote:
> >> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
> >> > It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
> >> > we treat them the same in a lot of places, CML is a platform of its own,
> >> > and the lists of PCI IDs should not conflate them.
> >> > 
> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> > Cc: linux-pci@vger.kernel.org
> >> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >> > ---
> >> >  arch/x86/kernel/early-quirks.c                      |  1 +
> >> >  drivers/gpu/drm/i915/display/intel_display_device.c |  1 +
> >> >  include/drm/i915_pciids.h                           | 12 +++++++-----
> >> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> >> > index 59f4aefc6bc1..2e2d15be4025 100644
> >> > --- a/arch/x86/kernel/early-quirks.c
> >> > +++ b/arch/x86/kernel/early-quirks.c
> >> > @@ -547,6 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> >> >  	INTEL_BXT_IDS(&gen9_early_ops),
> >> >  	INTEL_KBL_IDS(&gen9_early_ops),
> >> >  	INTEL_CFL_IDS(&gen9_early_ops),
> >> > +	INTEL_CML_IDS(&gen9_early_ops),
> >> >  	INTEL_GLK_IDS(&gen9_early_ops),
> >> >  	INTEL_CNL_IDS(&gen9_early_ops),
> >> >  	INTEL_ICL_11_IDS(&gen11_early_ops),
> >> > diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> >> > index 56a2e17d7d9e..3aa7d1cdd228 100644
> >> > --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> >> > +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> >> > @@ -832,6 +832,7 @@ static const struct {
> >> >  	INTEL_GLK_IDS(&glk_display),
> >> >  	INTEL_KBL_IDS(&skl_display),
> >> >  	INTEL_CFL_IDS(&skl_display),
> >> > +	INTEL_CML_IDS(&skl_display),
> >> >  	INTEL_ICL_11_IDS(&icl_display),
> >> >  	INTEL_EHL_IDS(&jsl_ehl_display),
> >> >  	INTEL_JSL_IDS(&jsl_ehl_display),
> >> > diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> >> > index 85ce33ad6e26..5f52c504ffde 100644
> >> > --- a/include/drm/i915_pciids.h
> >> > +++ b/include/drm/i915_pciids.h
> >> > @@ -472,6 +472,12 @@
> >> >  	INTEL_VGA_DEVICE(0x9BCA, info), \
> >> >  	INTEL_VGA_DEVICE(0x9BCC, info)
> >> >  
> >> > +#define INTEL_CML_IDS(info) \
> >> > +	INTEL_CML_GT1_IDS(info), \
> >> > +	INTEL_CML_GT2_IDS(info), \
> >> > +	INTEL_CML_U_GT1_IDS(info), \
> >> > +	INTEL_CML_U_GT2_IDS(info)
> >> > +
> >> >  #define INTEL_KBL_IDS(info) \
> >> >  	INTEL_KBL_GT1_IDS(info), \
> >> >  	INTEL_KBL_GT2_IDS(info), \
> >> > @@ -535,11 +541,7 @@
> >> >  	INTEL_WHL_U_GT1_IDS(info), \
> >> >  	INTEL_WHL_U_GT2_IDS(info), \
> >> >  	INTEL_WHL_U_GT3_IDS(info), \
> >> > -	INTEL_AML_CFL_GT2_IDS(info), \
> >> > -	INTEL_CML_GT1_IDS(info), \
> >> > -	INTEL_CML_GT2_IDS(info), \
> >> > -	INTEL_CML_U_GT1_IDS(info), \
> >> > -	INTEL_CML_U_GT2_IDS(info)
> >> > +	INTEL_AML_CFL_GT2_IDS(info)
> >> 
> >> Why only CML and not AML and WHL as well?
> >
> > Why do we even have CML as a separate platform? The only difference 
> > I can see is is that we do allow_read_ctx_timestamp() for CML but
> > not for CFL. Does that even make sense?
> 
> git blame tells me:
> 
> 5f4ae2704d59 ("drm/i915: Identify Cometlake platform")
> dbc7e72897a4 ("drm/i915/gt: Make the CTX_TIMESTAMP readable on !rcs")

Right. That explains why we need it on CML+. But is there some reason
we  can't just do it on CFL as well, even if not strictly necessary?
I would assume that setting FORCE_TO_NONPRIV on an already
non-privileged register should be totally fine.

-- 
Ville Syrjälä
Intel

