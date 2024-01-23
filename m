Return-Path: <linux-pci+bounces-2458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31D838832
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB091C22A69
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8752F9B;
	Tue, 23 Jan 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1peFCRO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE80524DC;
	Tue, 23 Jan 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995916; cv=none; b=pRcsU14aQNLEOh/gd3dqvD+q5euXJfEfo0GhhCqT/l2wjkMxZrWODzzI0gNSkMLg5QMBlb1SWvhacnU62ixKYhRmR6BtGDyz/zWHirtu9pHMym/3SM33jdtwJM/R10nNrUmKpTzqO8Oa4r9yHQ0EZJHTy5raxsDxTZte7pJHKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995916; c=relaxed/simple;
	bh=gR1DaQBEiwp7b8LXQ3gqb1TinU2mUqOSau6sGyjnT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFA8TbyE+uxp/hex/XOvsWPWp1Qeg3y5NEFgExC4UauoA89NoUplrQAIu8iKbFtQbRigIsSXZw6YhT6XZ98h4sMohyC5YVdmBys5P0FJFvg9tLPJ9J2ghxHJuaNgCQHSgvSE2ufDF9SnxRUma0vUIk3IOPbkwkjjMF8nME5dm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1peFCRO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705995915; x=1737531915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gR1DaQBEiwp7b8LXQ3gqb1TinU2mUqOSau6sGyjnT/I=;
  b=h1peFCROm9fade0rEu976ABmV1J9R9L4GGyBGxIBuzOXGqiOsmu2gilY
   P4omdRlUA6oAv9eUjAlumNfh9LO4+PjvCm9U0+IxQRGsCYCacxEvy/U5O
   5BsWHfuAlZLu27bQFDuDQhGVoroqxkUQ51z9x5pRR5IsYSH1Wi4lMX664
   zjzjUea6mCJ7o3ajNb/9jjbxv8hqel12Xf6/oxLNs+DfOA/SxBqKhGki/
   8pANVaCC3DawY9yeoJXrgKiCPQJEVqdi3xiIl1WT6ZrZ/HGaLXbUdlSDq
   Zb69fvlTviKiKnHo0FvKlrS+IIA1qOceOH/z1qA86DbiX/9v+zdD9oZqu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1336526"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1336526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="909211748"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="909211748"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:45:06 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 81AD911FB9B;
	Tue, 23 Jan 2024 09:45:03 +0200 (EET)
Date: Tue, 23 Jan 2024 07:45:03 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pm@vger.kernel.org,
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
Subject: Re: [PATCH v3 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <Za9uf3icrVE6Ajbe@kekkonen.localdomain>
References: <20240122114121.56752-2-sakari.ailus@linux.intel.com>
 <20240122181205.GA275751@bhelgaas>
 <CAJZ5v0gUpo6Shz2kQzie4XE23=fiPvD0=2yhjGptw8QbCq2SAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gUpo6Shz2kQzie4XE23=fiPvD0=2yhjGptw8QbCq2SAg@mail.gmail.com>

Hi Rafael, Björn,

Thanks for the review.

On Mon, Jan 22, 2024 at 07:16:54PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2024 at 7:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Jan 22, 2024 at 01:41:21PM +0200, Sakari Ailus wrote:
> > > There are two ways to opportunistically increment a device's runtime PM
> > > usage count, calling either pm_runtime_get_if_active() or
> > > pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> > > ignore the usage count or not, and the latter simply calls the former with
> > > ign_usage_count set to false. The other users that want to ignore the
> > > usage_count will have to explitly set that argument to true which is a bit
> > > cumbersome.
> >
> > s/explitly/explicitly/
> >
> > > To make this function more practical to use, remove the ign_usage_count
> > > argument from the function. The main implementation is renamed as
> > > pm_runtime_get_conditional().
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Reviewed-by: Alex Elder <elder@linaro.org> # drivers/net/ipa/ipa_smp2p.c
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
> > > Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # drivers/accel/ivpu/
> > > Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
> > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/
> >
> > > -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> > > +EXPORT_SYMBOL_GPL(pm_runtime_get_conditional);
> >
> > If pm_runtime_get_conditional() is exported, shouldn't it also be
> > documented in Documentation/power/runtime_pm.rst?
> >
> > But I'm dubious about exporting it because
> > __intel_runtime_pm_get_if_active() is the only caller, and you end up
> > with the same pattern there that we have before this series in the PM
> > core.  Why can't intel_runtime_pm.c be updated to use
> > pm_runtime_get_if_active() or pm_runtime_get_if_in_use() directly, and
> > make pm_runtime_get_conditional() static?
> 
> Sounds like a good suggestion to me.

The i915 driver uses both but I guess it's not too much different to check
ignore_usecount separately than passing it to the API function?

I'll add another patch to do this and moving
pm_runtime_get_if_{active,in_use} implementations to runtime.c.

-- 
Regards,

Sakari Ailus

