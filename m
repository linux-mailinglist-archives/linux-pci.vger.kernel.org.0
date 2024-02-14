Return-Path: <linux-pci+bounces-3457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E6854F4B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 18:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF0AB2334D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B82604DC;
	Wed, 14 Feb 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL2nwhSi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF94604BC;
	Wed, 14 Feb 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929882; cv=none; b=cAcJRTBZDQTosAYyDSayPuWR8wlVlcZA+4Nx9BKHjxwZoYdMF6n13j+muXq4cdW55ABLYQBydpfyoJ2Q3OPHd2NVdxUEz+fzVNA9qhWIUiJzd3Asnnr4N7wDb8uSCRhg5j/KF4aSZqK8HRuV+hgyUxBrkUcsv/fgps+iKPxaT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929882; c=relaxed/simple;
	bh=QZHxpOWGstMLL7cOOITs7En2K1eIVAPNG1eepxsSzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bjzvKAm3TkrqJKKvGybnA1R4+Z39Hehgwp5Erj/FjCLyqq2yotAi8PKMxoiX9gG40NMpz9WZW1Yzwk3784PHDX+uu2GRhIfMwFvhTluNLfbBKf6DHo4ro+cofzT9G0HJzaA6DribHLvdkJuJlW8d5Rt1HnUPun/V+BLSoQCuUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL2nwhSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0529DC433F1;
	Wed, 14 Feb 2024 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929882;
	bh=QZHxpOWGstMLL7cOOITs7En2K1eIVAPNG1eepxsSzQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pL2nwhSiDD9P3cmh9vfh1L2zZAuGnHwMUNz6aVd0nq3Nxy7qJuus9zSnoVPvIpDBC
	 m3AVtdTDmqJc5GLDa0HOMFkCbFvgoG06GFbkjo07iJMsVxkpfmZCg75D06Q8FbDQyE
	 TLfmEjSNzHQZcY2e36Bp20ncZlRl9vDrBq0OeunZ0SMoERwrDU5sFEwwWuGG2PBw7h
	 Gm+O+kBHzD8LpLdG7gi3ckxxvJuwvlMr/2dfQFjnygONmmrGd8QcmztWnafleZGOlV
	 wI+g/eGieKBAUOcWsHYruB9dmergGF78Runlp2uSxTemqyEKb9+0epi/unWqXNSTl4
	 YytRU5dwBDNwg==
Date: Wed, 14 Feb 2024 10:58:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <20240214165800.GA1254628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c77778-fbdc-4345-be8b-04959d1ce929@linux.intel.com>

On Wed, Feb 14, 2024 at 08:58:48AM +0200, Jarkko Nikula wrote:
> On 2/13/24 22:06, Bjorn Helgaas wrote:
> > > Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Sounds like this resolves a problem report?  Is there a URL we can
> > cite?  If not, at least a mention of what the user-visible problem is?
> > 
> >  From the c5eb1190074c commit log, it sounds like maybe this allows
> > devices to be autosuspended when they previously could not be?
> > 
> > Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> > runtime PM without callback functions")" since it sounds like it goes
> > with it?
> > 
> I don't think there's known regression but my above commit wasn't complete.
> Autosuspending works without runtime PM callback as long as the driver has
> the PM callbacks structure set.

I didn't suggest there was a regression, but if we mention that Mika
debugged something, I want to know what the something was.

I'm guessing runtime PM doesn't work for some subset of drivers, and
this patch fixes that.  So let's say exactly how to find that subset
of drivers, e.g., "drivers that implement X but not Y" or whatever.

> For example the drivers/i2c/busses/i2c-i801.c has system suspend/resume
> callbacks. I tested this patch by hack-removing them and yes, autosuspend
> doesn't work without this patch.
> 
> Raag and Mika noticed the issue when cleaning up empty runtime PM callbacks
> from an another driver which doesn't have any other PM callbacks.

Bjorn

