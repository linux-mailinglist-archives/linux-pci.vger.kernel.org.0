Return-Path: <linux-pci+bounces-27647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746B5AB5878
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D174A782C
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E32BE111;
	Tue, 13 May 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8vB7xWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF72BE110;
	Tue, 13 May 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149456; cv=none; b=Tdlqcx1vD4W0qaRuTCYdW8ssewqJ6CE17eU9M0ngUj1AEHPNic9m/v3l23pzEixizXMtrDqidhWly7P+RDIh9k4x7fNupLeXr9XKbWkQEjk6euBCyNhdHgwKEL2+OcW+bOLAQLbzVM05pWn8QHViRNxzQ0PGAo9yCRC8weey+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149456; c=relaxed/simple;
	bh=5dEZPjeFOHBN2WQfltNsxASob8VuvLED4acGGlIaNh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOYAJaXAvlLjx5vstvzLBhev5dBvhvSwgXT5juKFAnsH94cbcAfyL0Kq83X/3kjB1PzeI11ABnuWEwtJBxbyp9zvVas+aflwb5je8whP+C0pwrHUR4vTfLWLLhC7C7D+ZZ0bHrJ9KoIC42N0Y9uy5MsS7Oue7QtKR8U3LFMEJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8vB7xWh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747149455; x=1778685455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5dEZPjeFOHBN2WQfltNsxASob8VuvLED4acGGlIaNh0=;
  b=c8vB7xWhNy3AAkObCukBLzAcYc6ffHhETYkSUmlRIVWsCV7jS9aA3hlS
   Y1yt1fFKcH2g8sqKy8hhlo9vOxgzhNa6ukIqV9os6EG40kw3NTLTHnzh7
   yLW6TkEh8yckXqgqf2yEQhZnx+MjR32XTSH2Bov23LA6YYiEYp2GtkGeB
   tJDPePNBFRmRerRbNSL3yM4ipO8Vho3f24SgFEawqt4eZA9+1KUhn25ll
   j2AUTjFM6pwK+Lfdx5lekRXwLcl/cUyRGTwlRuGgsIAT+uu6OTauen8bV
   ZmVMJlEkF/GB9HHjzI40d2ToBOnLclA/sYFkFrQEc4YFIsYfoVz/gCj5/
   A==;
X-CSE-ConnectionGUID: AkqlcayKTuCAq1n+bYP3qw==
X-CSE-MsgGUID: nH29lKd+TS2sThpk+nHcsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48692875"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="48692875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 08:17:33 -0700
X-CSE-ConnectionGUID: foIf9rVzS2qb614Fx8hxgg==
X-CSE-MsgGUID: yOkzsa18SK+HOugVHjqNcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138155411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 08:17:31 -0700
Date: Tue, 13 May 2025 18:17:28 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCNiiHzOksQFrPe1@black.fi.intel.com>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <aCLNe2wHTiKdE5ZO@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCLNe2wHTiKdE5ZO@wunner.de>

On Tue, May 13, 2025 at 06:41:31AM +0200, Lukas Wunner wrote:
> On Sun, May 04, 2025 at 02:34:44PM +0530, Raag Jadav wrote:
> > If error flags are set on an AER capable device, most likely either the
> > device recovery is in progress or has already failed. Neither of the
> > cases are well suited for power state transition of the device, since
> > this can lead to unpredictable consequences like resume failure, or in
> > worst case the device is lost because of it. Leave the device in its
> > existing power state to avoid such issues.
> 
> Have you witnessed this on a particular platform / hardware combination?
> If so, it would be good to mention it.  If I'd happen to find this
> commit in the future through "git blame", that's the first question
> that would come to mind:  How and on what hardware was this actually
> triggered, how can I reproduce it.

We have a few issues[1] reported which are similar in nature. But since
they are not easily reproducible and still under investigation, I'm
a bit hesitant to explicitly reference it.

[1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4395

> > +	/*
> > +	 * If error flags are set on an AER capable device, most likely either
> > +	 * the device recovery is in progress or has already failed. Neither of
> > +	 * the cases are well suited for power state transition of the device,
> > +	 * since this can lead to unpredictable consequences like resume
> > +	 * failure, or in worst case the device is lost because of it. Leave the
> > +	 * device in its existing power state to avoid such issues.
> > +	 */
> 
> That's quite verbose and merely a 1:1 repetition of the commit message.
> I'd recommend a more condensed code comment and anyone interested in
> further details may look them up in the commit message.

Sure, will update.

Raag

