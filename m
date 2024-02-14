Return-Path: <linux-pci+bounces-3448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B139C854A57
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 14:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B541C21C41
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E465466A;
	Wed, 14 Feb 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcu8K7K8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56453E06;
	Wed, 14 Feb 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916844; cv=none; b=mInpg5+akBvWLIso7Tcuj24k04PSyNfILB2rdzf8bu6LxNcHDsWWM/HBxpJAhjO9KS/iG+3Y1buo8oAnqCJ9BLK9vtJi+tSWQTjLq6kjb3j+yUgAAv1XgM1QnMciqKcKzd7hEdbjGzmjVC8tagxx9W4jI2M4+qhkWYF5BwuMYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916844; c=relaxed/simple;
	bh=5p9vcV6S7UhZtSa+IUxmeaWyzLVKNJsKQnAivVunf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPAO67Jc5791kowYb4Zhvyxy+l5HJ3ZqqqMsPiW71G/kBdy6vfegev2Oblt0HbRer7CXM5l7eZYRz7by07yhDVwRVpq+5YPpLAtho6zcaaZBgAQJHOqXTrKpUDvdW8zC91IRNWZDTqJmjGBBpZXGouYz9Fq8QsSRfTzQnVeVfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcu8K7K8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707916843; x=1739452843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5p9vcV6S7UhZtSa+IUxmeaWyzLVKNJsKQnAivVunf6c=;
  b=bcu8K7K8dMvELxSlPA9n4g4X8g0rSTyn0n7psP5suA0Y19InAUZAniGQ
   zBVRWfGTke4xJruETUrIwHyUQELYF5nsBU59+Mzp0wB+hcii+gpH4+HyN
   e7LqhJWSx1HP5DuH5rnl+XvCXI42IXPXh4bjMgslkjOG2Ut/0e2cjYR4L
   NNkXOfm09pKJpYApN3+EBDGjpqk9sfP3FN9Nwpips0M5RClcfRs3rI2c8
   cXPHckHIZ2KS14HuiUaAdIXtXAq5tlblQ/BQ+uoHzYHDkSVpzeYJ9dlag
   1cXPvK/hAdFarJjvsrOMMZyC4bH8rR4jNvSxxbJJwfVnHmyihTpU9lS3v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2098343"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2098343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935616536"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935616536"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:20:38 -0800
Date: Wed, 14 Feb 2024 15:20:35 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <Zcy-I9-HcA_RuOyY@black.fi.intel.com>
References: <20240212063233.5599-1-raag.jadav@intel.com>
 <20240213200648.GA1219964@bhelgaas>
 <ZcyZV2q1_QoK43vz@black.fi.intel.com>
 <Zcy5qZ4rEbpY7ouC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcy5qZ4rEbpY7ouC@smile.fi.intel.com>

On Wed, Feb 14, 2024 at 03:01:29PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 12:43:35PM +0200, Raag Jadav wrote:
> > On Tue, Feb 13, 2024 at 02:06:48PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 12, 2024 at 12:02:33PM +0530, Raag Jadav wrote:
> 
> ...
> 
> > > >  0)               |  pm_runtime_work() {
> > > >  0)               |    rpm_idle() {
> > > >  0)               |      rpm_check_suspend_allowed() {
> > > >  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
> > > >  0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
> > > >  0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
> > > >  0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
> > > >  0) + 17.070 us   |    } /* rpm_idle = -38 */
> > > >  0) + 22.450 us   |  } /* pm_runtime_work = -38 */
> > > 
> > > What is this timing information telling me?
> > 
> > It's a raw ftrace dump.
> 
> (Told ya that people would be surprised with this without seeing how you get
>  this and what fields mean)

I can add stat headers in v2 which I think will be more helpful.

Raag

