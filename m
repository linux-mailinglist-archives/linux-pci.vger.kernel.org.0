Return-Path: <linux-pci+bounces-2596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18C83DFEE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6441C22186
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896701EB4F;
	Fri, 26 Jan 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGN2MhwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8720309;
	Fri, 26 Jan 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289829; cv=none; b=Co5zhZ5ORxPgU0BIX6jZs5Af9UbA2EwAA0a5FuZFXtS4uETP2Q5k6CsEB+zz0GiHigUoRhwKfoA6UV8Lw/stqIu4eMnod+xZl5b9O6Qc0XFRGeEllT7oq61Uzm0Lainzl062xhKOx3j0uPDSyqsvZ6Pn0+H6Cse/w76i3RYfA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289829; c=relaxed/simple;
	bh=tSMX1Ae/bCy8FGpCcBWLPQYfg2LBDt1gaBUpHaOLi0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoWVy8kDl7CDf+nGNVTX1nENFY6pMCJxanId3sg9MkTl7VlC1N0/8omrITeqn4pDE1wfMjDdnYgdJUd8oSMUHeF8YmpFmUVo4fmWkvWiOcxqeegaCzlqBo4hqgb5qv+00WK6gq0dHshrmDungGDNRn4xslW+f9iHbo+SsADGiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGN2MhwY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706289828; x=1737825828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tSMX1Ae/bCy8FGpCcBWLPQYfg2LBDt1gaBUpHaOLi0k=;
  b=DGN2MhwY1qzdGQQuouBLgsHjbAKjNxJZVCkyR7K+a56/QEpmlAHljgcy
   8TmhZ/wyano9KvxRn+onRjs3F5ZktguIiFrTVzJvZsmlmUa31YYKuSU6S
   j+xiEjYRYIbPWqV28jBH6n8JM/mLhzqbje77Qtb87Rp6y8RrM2vOe783X
   CXm8SHD6/3xym+wv1qh5mzUh8PYZf6BI59nB3pDFF48UZ2vI4u8QxwqTY
   KwVyEmwVmxBOB7FNbuKN6UbLyyj2fkTliZef6pxF8xmThPQRzG7+JBCn8
   7G7V+/HURLZvsQNW/HD2s2IX/4R5z+dcM+6nU2Jd40yjtPxjLntATwHsz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9900855"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9900855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960260973"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960260973"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:23:39 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id BC8AF11FBD1;
	Fri, 26 Jan 2024 19:23:36 +0200 (EET)
Date: Fri, 26 Jan 2024 17:23:36 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Alex Elder <elder@ieee.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <ZbPqmA4GkunkJqb0@kekkonen.localdomain>
References: <20240122114121.56752-1-sakari.ailus@linux.intel.com>
 <20240122114121.56752-2-sakari.ailus@linux.intel.com>
 <912d4439-86cd-4060-a66d-baba5fa2bdec@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912d4439-86cd-4060-a66d-baba5fa2bdec@ieee.org>

Hi Alex,

On Fri, Jan 26, 2024 at 09:12:02AM -0600, Alex Elder wrote:
> On 1/22/24 5:41 AM, Sakari Ailus wrote:
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
> 
> I actually intended my "Reviewed-by" to cover the entire patch.  I
> checked every caller and they all looked good to me.

Thanks, I'll drop the file name. AFAIR it was just below that file, so I
added it, but I could be wrong, too.

v5 will also squash the 2nd patch of v4 into this one
<URL:https://lore.kernel.org/linux-pm/ZbBAWROxRKE8Y8VU@kekkonen.localdomain/T/#m76d34e679e12d8536a20eb29af6e826e2a85a24b>,
I hope that's fine.

-- 
Kind regards,

Sakari Ailus

