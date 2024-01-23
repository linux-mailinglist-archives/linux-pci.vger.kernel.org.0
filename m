Return-Path: <linux-pci+bounces-2503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E6839A7C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC349B2B882
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB96210F;
	Tue, 23 Jan 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6LkV1EI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251355662;
	Tue, 23 Jan 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042656; cv=none; b=IqUKdQaNUwpr8DsPmoY4RTP9/wHVNjZQe6q+u27PxEC33T1gvT2/X1jCcYQFTCqVRp/OklZalc2K793tllYVeu+zBQhHBO0zlchHFM0TSlkG6mgZ3I6kIGKXgL/bB8dvBaQ69p+6ZvlZUr9ttRazeJbhhAihoVuN1p3HAeBa2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042656; c=relaxed/simple;
	bh=YTYq9NKaF9Qyd5spfDIHdzZzMX2Nn0CsEqHbs7SWNQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7mH4xSl3b7g1H4jV40FnP8dEVY4YQDnfETY6kLCyEt+3pb4TWcDsko0DX3qXkxrVDhEo0HcNGWtN2iWINal+LxDoMgtT1ap1phXdfRzqt2UrEOES6KvdHa/j4OnhljKK5q8zE+tkn1EgxlrOcNGB3RC+WEAXDobIE2Ww6hxFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6LkV1EI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706042655; x=1737578655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YTYq9NKaF9Qyd5spfDIHdzZzMX2Nn0CsEqHbs7SWNQo=;
  b=C6LkV1EIWCLsYBwDFmHNKwBKMCwhZE5rt2ttdKiYHQyLM3L2L4oGN8QB
   C7ZuWdXR6AEE1mPiohT2CAJcUiSIgDM/RwoSL577UIrq8ZwoZhY0lyQk4
   zgm0TpfAZEbKvGFtiE70m1X7YtGBCTfT05fiIJqGS3wgNU+pCsCbXAeJM
   I1NUe9d1P8Gmk1nvcE8JLQxCv0+0JUdmtO0Y8DkSk8DdIjgOmi7ehYyX4
   enfa6LoXEURFbwoCFocq0eSoBbAlUmUQuXYL8Z0T/TQhxE+D3MMRIGqJZ
   E4yspDEdwYywB4qjSvkIbHn4pvPnYCaywUtmv3XE43OV1DTP/xZCrVHvW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23114666"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="23114666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 12:44:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905365871"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="905365871"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 12:44:07 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7F17811FAD4;
	Tue, 23 Jan 2024 22:44:04 +0200 (EET)
Date: Tue, 23 Jan 2024 20:44:04 +0000
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
Message-ID: <ZbAlFKE_fZ_riRVu@kekkonen.localdomain>
References: <20240123095642.97303-2-sakari.ailus@linux.intel.com>
 <20240123172423.GA317147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123172423.GA317147@bhelgaas>

Hi Bjorn,

Thanks for the review.

On Tue, Jan 23, 2024 at 11:24:23AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2024 at 11:56:42AM +0200, Sakari Ailus wrote:
> > There are two ways to opportunistically increment a device's runtime PM
> > usage count, calling either pm_runtime_get_if_active() or
> > pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> > ignore the usage count or not, and the latter simply calls the former with
> > ign_usage_count set to false. The other users that want to ignore the
> > usage_count will have to explitly set that argument to true which is a bit
> > cumbersome.
> > 
> > To make this function more practical to use, remove the ign_usage_count
> > argument from the function. The main implementation is renamed as
> > pm_runtime_get_conditional().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Alex Elder <elder@linaro.org> # drivers/net/ipa/ipa_smp2p.c
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
> > Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # drivers/accel/ivpu/
> > Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/
> 
> - Previous PM history uses "PM: " in the subject lines (not "pm: ").

Oops. I'm not sure why I used lower case. (Maybe I've written too many
times "media:" prefix to the subject?) I'll fix this in v5.

> 
> - I don't know whether it's feasible, but it would be nice if the
>   intel_pm_runtime_pm.c rework could be done in one shot instead of
>   being split between patches 1/3 and 2/3.
> 
>   Maybe it could be a preliminary patch that uses the existing
>   if_active/if_in_use interfaces, followed by the trivial if_active
>   updates in this patch.  I think that would make the history easier
>   to read than having the transitory pm_runtime_get_conditional() in
>   the middle.

I think I'd merge the two patches. The second patch is fairly small, after
all, and both deal with largely the same code.

> 
> - Similarly, it would be nice if pm_runtime_get_conditional() never
>   had to be published in pm_runtime.h, instead of being temporarily
>   added there by this patch and then immediately made private by 2/3.
>   Maybe that's not practical, I dunno.

-- 
Regards,

Sakari Ailus

