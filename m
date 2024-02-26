Return-Path: <linux-pci+bounces-3995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C87F866B31
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 08:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2861C2232E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99717199DC;
	Mon, 26 Feb 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3APoHxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11701C6B1;
	Mon, 26 Feb 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933325; cv=none; b=UFE34kDk55Sy2RCl+97GdqLQ5yjinCKIggudtdWUfLX539D8UJwnIrz9lXSCDmWiMPw+ShKFFOgUiz+eKO5ezl78ZOxumyl3GGy+02Kxjn5RG6p4eInQjZES7JM4owWa9nPyEro5y6shK0tAYX1Xi6OE+AU0/5X5ihunk8V0asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933325; c=relaxed/simple;
	bh=M9655n1nbTGN1V8URNmOSh7TWinS9TWboOwZYE+4udY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj6KEO7xRWcdEx6JCfAEQ8TbyU9R9wevKeNY7dGdl8EOkMmp/t6ZDXumyc1qE9eRs8G2r2DKzY1R/KFmpT6MudYrk+OTB3dwUa6R2s/6EREZIhQ3m+FiPpU4F2g2xZgF0lBypEjUyGI5yqgm8pfTsZ1JYER8bNyyDvcYtXcw8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3APoHxl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708933324; x=1740469324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M9655n1nbTGN1V8URNmOSh7TWinS9TWboOwZYE+4udY=;
  b=h3APoHxlyxshL4kX6O7uNgYk7beo57k0pCjliazfDnejf+depX65Mu+6
   chO6/eTgm947887vjMXsFU+uF+DhxJGgcMAbhjzEZOc8JN6gIjHEEiSZ0
   myqkr7dIhjIL2yqE5EXwnFLkzUMh0HqcbsX40qvrZJSFrBi8L0GqUh9qq
   EY6BYR1owa1IXT1lF0+dtqvy0dyQQCPmUgPKWVJMkFQdjuhBa78gEEAzC
   gmko0I+M5w36wa78j7cckIgi68Ym2sbUQx6csIe3lVUYDlssK+gjXJMv8
   fgSmd3AP+4BwB5Wv876BP6rp4bY5PHzQBAbaVpHit2NfYAqtzHeDWleyD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3367288"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3367288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029415"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029415"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 23:41:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4CDA148F; Mon, 26 Feb 2024 09:41:13 +0200 (EET)
Date: Mon, 26 Feb 2024 09:41:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, bhelgaas@google.com,
	andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <20240226074113.GZ8454@black.fi.intel.com>
References: <93c77778-fbdc-4345-be8b-04959d1ce929@linux.intel.com>
 <20240214165800.GA1254628@bhelgaas>
 <Zc0fW0ZIzfNOMj2w@black.fi.intel.com>
 <Zdw_SV81YfJvCx2I@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zdw_SV81YfJvCx2I@black.fi.intel.com>

On Mon, Feb 26, 2024 at 09:35:37AM +0200, Raag Jadav wrote:
> On Wed, Feb 14, 2024 at 10:15:29PM +0200, Raag Jadav wrote:
> > On Wed, Feb 14, 2024 at 10:58:00AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Feb 14, 2024 at 08:58:48AM +0200, Jarkko Nikula wrote:
> > > > On 2/13/24 22:06, Bjorn Helgaas wrote:
> > > > > > Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > 
> > > > > Sounds like this resolves a problem report?  Is there a URL we can
> > > > > cite?  If not, at least a mention of what the user-visible problem is?
> > > > > 
> > > > >  From the c5eb1190074c commit log, it sounds like maybe this allows
> > > > > devices to be autosuspended when they previously could not be?
> > > > > 
> > > > > Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> > > > > runtime PM without callback functions")" since it sounds like it goes
> > > > > with it?
> > > > > 
> > > > I don't think there's known regression but my above commit wasn't complete.
> > > > Autosuspending works without runtime PM callback as long as the driver has
> > > > the PM callbacks structure set.
> > > 
> > > I didn't suggest there was a regression, but if we mention that Mika
> > > debugged something, I want to know what the something was.
> > 
> > Considering it's not a bug to begin with, perhaps we can change it to
> > Suggested-by or Co-developed-by?
> 
> Hi Mika,
> 
> If you are okay with this, please let me know and perhaps suggest a better
> fit for the scenario.

You can just drop my name from it completely.

