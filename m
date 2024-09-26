Return-Path: <linux-pci+bounces-13568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70598769C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FFD1F20F01
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC44145B2E;
	Thu, 26 Sep 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWp4pJdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D684D8C8
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364981; cv=none; b=QKp1SOyloJcBLSu4/1IHdcbDKoEUrpN3+BT0tshRBhL1VxIkUrYWQotCEoMHt1a+IRgs5SV+4x4aHo8wqI97vS0m0ILxuYRU2xJB3DMaJenMdl21IZUa7VBTR+jZpCw+OSRY7uhBfAizhukyB/MwZUPusK7LtgMLq8C0qEcYRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364981; c=relaxed/simple;
	bh=iH5NKtPl+sVwvJSTAprOedM3IxW5u+ld2hMpbYFJy78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyIws5qXzplLZy/HuyUM99qYO3HqNgPkYkLi6UIY/lHQ2CjPi9fAuMk6GGEmSY4le9qXqgVzUhSxN5AxUjWJSj+5S48QVAxuuqDoc04h4g1Cnk6Q3KMQC5Bxtj34z2ZxfqqJwrEzcZhfA/t+fCBmFSlPtvdRp+8VagidXCsNuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWp4pJdi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727364980; x=1758900980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iH5NKtPl+sVwvJSTAprOedM3IxW5u+ld2hMpbYFJy78=;
  b=aWp4pJdimIcginChZpxlUUmRiXpf+VnjPH70kArJi181Ssdsb1IknY+F
   eDOOsTL5mkUFnRGC4SBwaSwOFJ1RfhsVHA5gY5wnlB8W8Gkx2x9+zWFfV
   3GbShDI25a9NdMsQj68W8k7ZRzfL79DObnD79z/fZ5kqGsA92f3to6bsv
   MAUnrRhZD5BW7zXSFHmIJf4ZPNfRy8OK85CqyM1saOSX7xFws4iPKvRHt
   60ygZVjXUF3fskNpNNjuhxaSugqgJFKowuF6M1czURD5sVYMFezUuMRGz
   v5MoQTmzhYt5mtSCdNBmIOspZwgG81NugCXcsyGt5YRWdcH664XexJYUG
   A==;
X-CSE-ConnectionGUID: djzZKXdESSSnAhTEBXQi1A==
X-CSE-MsgGUID: K+mX7XsoQ+WxGmfS5OZ7Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26343520"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26343520"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:36:17 -0700
X-CSE-ConnectionGUID: NwHverycQ2WPkRO0v6+dqA==
X-CSE-MsgGUID: en3z69NcSbqUtRb3s27lxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72347893"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 26 Sep 2024 08:36:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 26 Sep 2024 18:36:13 +0300
Date: Thu, 26 Sep 2024 18:36:13 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/i915/pm: Do pci_restore_state() in switcheroo
 resume hook
Message-ID: <ZvV_bdAIYcVQVold@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-6-ville.syrjala@linux.intel.com>
 <ZvV0STiWx6xyIE0E@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvV0STiWx6xyIE0E@intel.com>
X-Patchwork-Hint: comment

On Thu, Sep 26, 2024 at 10:48:41AM -0400, Rodrigo Vivi wrote:
> On Wed, Sep 25, 2024 at 05:45:25PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Since this switcheroo stuff bypasses all the core pm we
> > have to manually manage the pci state. To that end add the
> > missing pci_restore_state() to the switcheroo resume hook.
> > We already have the pci_save_state() counterpart on the
> > suspend side.
> > 
> > I suppose this might not matter in practice as the
> > integrated GPU probably won't lose any state in D3,
> > and I presume there are no machines where this code
> > would come into play with an Intel discrete GPU.
> > 
> > Arguably none of this code should exist in the driver
> > in the first place, and instead the entire switcheroo
> > mechanism should be rewritten and properly integrated into
> > core pm code...
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_driver.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > index fe7c34045794..c3e7225ea1ba 100644
> > --- a/drivers/gpu/drm/i915/i915_driver.c
> > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > @@ -1311,6 +1311,8 @@ int i915_driver_resume_switcheroo(struct drm_i915_private *i915)
> >  	if (ret)
> >  		return ret;
> >  
> > +	pci_restore_state(pdev);
> 
> then why not simply call that inside the resume, for a better alignment
> with the save counterpart?

This is switcheroo resume. And the counterpart is in switcheroo suspend.

For the core pm hooks I'm getting rid of both save and restore.

> 
> > +
> >  	ret = i915_drm_resume_early(&i915->drm);
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.44.2
> > 

-- 
Ville Syrjälä
Intel

