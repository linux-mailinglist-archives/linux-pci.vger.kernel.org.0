Return-Path: <linux-pci+bounces-3435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EE85476E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B6AB211E9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16218021;
	Wed, 14 Feb 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wgk+GVca"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD823C2C6;
	Wed, 14 Feb 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907424; cv=none; b=l1rYz/ZSudG9QmX7UiGmFilCOVkzrBZ6pm/k0r/1R8EEUwRL839v/Sc+E18+oay2eV6yG+mGYwjGf4og346RuBZUqyxUig+lNlR9gbthPDskS3VI2MdP7OmpY6m+xgQpHeACtdAGpjeFi9xadIFVKivmNzfNZQHurbFhIGsS6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907424; c=relaxed/simple;
	bh=jsUtVeXk9SEIvKEq3azTe0X1RfROgbYT2UhZC0H8aAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmnWemI/D97uyQRHNaT7D52iO8yD7sYdHB6+h9E7zOB3mqlMJWZWOEzx9YWMBOsRqv5/KIdxa8r+Kp2nWtFaZfgKv/beH7P+awXorAZbJxewaknKOu7+DqgKDnbVg6yt3xq4lG+Hc38B0ejS2l1Xd+hOude5fP5uVQGO/RsTvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wgk+GVca; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707907423; x=1739443423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsUtVeXk9SEIvKEq3azTe0X1RfROgbYT2UhZC0H8aAw=;
  b=Wgk+GVcaXJSsVWqyUFwMTzP6a2knQBVbZmNwXRKx1033yg9UBshVKzvx
   hhTyeN/gkEbLbGRMW/w0rD6ok/PAMlWZwlbp0fTREwbz3ekx5T+CfaLnn
   w8KwYUjFMHEcnZvO8uDoxq5ZLgpaUcKg7FNlzEgHoRVqYMo7/ja6QhDDQ
   BlhnKnbN4UTVzTaVs7fW3gSMG5WRn7wJW5GSb6MhqkZsuLVgNL6px4dID
   aJgYhSZ4zuX70YBupYqClI++mNMWzTx3P1LV/TJX5E7UsXdffYBq5BRre
   S9mnIaA2OtWJnlBRxDPexVNPRTt2zZxsKMvaCgUoGFyfR2aBweCRvuDLa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19358809"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="19358809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935615683"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935615683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:43:38 -0800
Date: Wed, 14 Feb 2024 12:43:35 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <ZcyZV2q1_QoK43vz@black.fi.intel.com>
References: <20240212063233.5599-1-raag.jadav@intel.com>
 <20240213200648.GA1219964@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213200648.GA1219964@bhelgaas>

On Tue, Feb 13, 2024 at 02:06:48PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 12, 2024 at 12:02:33PM +0530, Raag Jadav wrote:
> > Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
> > functions") tried to eliminate the need for runtime PM callbacks
> > by modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(),
> > but didn't modify pci_pm_runtime_idle() with relevant changes, which
> > still returns -ENOSYS if the driver supplies no runtime PM callbacks.
> > 
> > Fix this by modifying pci_pm_runtime_idle() such that it allows PCI
> > device power state transitions without runtime PM callbacks.
> > 
> >  0)               |  pm_runtime_work() {
> >  0)               |    rpm_idle() {
> >  0)               |      rpm_check_suspend_allowed() {
> >  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
> >  0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
> >  0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
> >  0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
> >  0) + 17.070 us   |    } /* rpm_idle = -38 */
> >  0) + 22.450 us   |  } /* pm_runtime_work = -38 */
> 
> What is this timing information telling me?

It's a raw ftrace dump.

> > Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Sounds like this resolves a problem report?  Is there a URL we can
> cite?  If not, at least a mention of what the user-visible problem is?
> 
> From the c5eb1190074c commit log, it sounds like maybe this allows
> devices to be autosuspended when they previously could not be?
> 
> Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> runtime PM without callback functions")" since it sounds like it goes
> with it?

As pointed out by Jarkko, it's not a regression. The implementation
in original commit is incomplete. We discovered it while cleaning
up another PCI based driver.

> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > ---
> > 
> > This is not marked for linux-stable for the need of extensive testing
> > and can be backported after a few releases if no issues are reported.
> 
> If you think this should not get backported to stable, you'll have to
> watch the backports to prevent it.  Lots of stuff gets auto-backported
> even though not explicitly marked for stable.  This comment won't
> prevent it (and won't even appear in the commit log).

This is why I've added Greg and Sasha here.

Raag

