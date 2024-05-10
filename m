Return-Path: <linux-pci+bounces-7342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C3A8C2239
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69081C21E47
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB884FC8;
	Fri, 10 May 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NY8K5RzM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71955C3B
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337264; cv=none; b=Km29j9g2gJfXcp49jnbImPoQR4s9D2rm/LyzahfJTz/DD/VqizANgOGYlS31u6E3wWVWqCWylOWbb3dRIAh6Pjx1vbhkDrUzfLPF6hhtH7RcHevyRRLwHoB+Kf4nLSs8rKcAH7+xgppuT9tLsc+vl995MvypUfu58ORxHr7eCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337264; c=relaxed/simple;
	bh=hv04sRqCA31uFmQ4yw/szZ1Jv9n99l6K92wWek1+Yuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMb1e9ssMs8hQV9NpPlu1jaB/76oR8CPOFvzFU35H81L3vulKD4OolRMjXVN54dsM4eP0QHFTldDFPwaFeRRtRdDdd5cxVIZkO9DWQcih8c+eIayg6YofC0h8qP5mmYXrIBS6OyOZe7rJVEml5ZZdzrtyiOIhOfLrdm6wOS3Aqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NY8K5RzM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715337263; x=1746873263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hv04sRqCA31uFmQ4yw/szZ1Jv9n99l6K92wWek1+Yuc=;
  b=NY8K5RzMASCRVsNgbgMDgYdeKev9XtxlFYvUS9Vnn7lSWjR0nTyfIy6G
   DrmQy2oP5m7ImawkrgenHH0dwscUT6YBlYTHF8l/JAHuVOjtrhlGJ5FwW
   laz/AFrBQu3BoylFrzj6vP3vrPi5XxmCJY9rS9hHvIS/p6dJBDccwF1d9
   kuB06QvwiQYAJbVvoQMzsavk8mDi/bou7tnwm/A7FySUjfs2xGKLPTxpE
   Acgc/RehRPwoFt9rOVZJ5GlJ5AlCUfDSCpxSTuDNs9B4HmpOUIfwraBBi
   CNUJH4eGdoXCvPgcKAIRfx4Xg2aatnYO6ZtDeIJUtnyRwJwoc+X2NRCfR
   Q==;
X-CSE-ConnectionGUID: dVyMkHN1RKKqx97nEi0YbQ==
X-CSE-MsgGUID: /Nbdd6wQR1eI/j9a1iP8+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11190395"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11190395"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:34:21 -0700
X-CSE-ConnectionGUID: o/tSbNKlSx+2TIjNlt6A2Q==
X-CSE-MsgGUID: FzdSfPQcSeidHxKFN0+Ibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29519006"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 10 May 2024 03:34:19 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 10 May 2024 13:34:17 +0300
Date: Fri, 10 May 2024 13:34:17 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
	lucas.demarchi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Message-ID: <Zj34KTmYP6VNQ3CS@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com>
 <ZjtapMK6kadLqHCN@intel.com>
 <87o79gjznd.fsf@intel.com>
 <ZjtprkZVSQ-o_qch@intel.com>
 <87le4ihsmr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le4ihsmr.fsf@intel.com>
X-Patchwork-Hint: comment

On Fri, May 10, 2024 at 01:24:12PM +0300, Jani Nikula wrote:
> On Wed, 08 May 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Wed, May 08, 2024 at 02:45:10PM +0300, Jani Nikula wrote:
> >> On Wed, 08 May 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> >> > On Tue, May 07, 2024 at 09:47:16AM -0400, Rodrigo Vivi wrote:
> >> >> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
> >> >> > It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
> >> >> > we treat them the same in a lot of places, CML is a platform of its own,
> >> >> > and the lists of PCI IDs should not conflate them.
> 
> [snip]
> 
> >> >> Why only CML and not AML and WHL as well?
> >> >
> >> > Why do we even have CML as a separate platform? The only difference 
> >> > I can see is is that we do allow_read_ctx_timestamp() for CML but
> >> > not for CFL. Does that even make sense?
> >> 
> >> git blame tells me:
> >> 
> >> 5f4ae2704d59 ("drm/i915: Identify Cometlake platform")
> >> dbc7e72897a4 ("drm/i915/gt: Make the CTX_TIMESTAMP readable on !rcs")
> >
> > Right. That explains why we need it on CML+. But is there some reason
> > we  can't just do it on CFL as well, even if not strictly necessary?
> > I would assume that setting FORCE_TO_NONPRIV on an already
> > non-privileged register should be totally fine.
> 
> I have absolutely no idea.
> 
> I'm somewhat thinking "CML being a separate platform" is a separate
> problem from "CFL PCI ID macros including CML".
> 
> I'm starting to think the PCI ID macros should be grouped by "does the
> platform have a name of its own",

That and/or "does bspec have a separate 'Confgurations <platform>' page?"

> not by how those macros are actually
> used by the driver. Keeping them separate at the PCI ID macro level just
> reduces the pain in maintaining the PCI IDs, and lets us wiggle stuff
> around in the driver how we see fit.

Aye.

> 
> And that spins back to Rodrigo's question, "Why only CML and not AML and
> WHL as well?". Yeah, indeed.
> 
> If we decide to stop treating CML as a separate platform in the
> *driver*, that's another matter.

Sure. Seeing it just got me wondering...

-- 
Ville Syrjälä
Intel

