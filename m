Return-Path: <linux-pci+bounces-28983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F9ACE1B3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E1D3A89E9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217E19F42D;
	Wed,  4 Jun 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGCUjSWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696E38384;
	Wed,  4 Jun 2025 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051789; cv=none; b=g2CPtXxzxrLaPCTo1VDAs2vOoWuhM1mceGYnrJCC1iL2ZRsBs3BrCCYZxdhhOt+uY9vgX8eS1cZFJSV3yCkYlsbqo5bb8mHaO/SWCmJHeCG+sQqu6W/UDdTtUkax84wa96BScQzFG+pvm4XRF9tp5ff4Y9CuysihhYc7eaWjw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051789; c=relaxed/simple;
	bh=KBvw1K5sntUXh/9Sm7OBz9ypq0dkXEpUOjGj1PVTgew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCOn+3tIAE5OVwXeRmjY5PEVjZjgX11CF9w/F+ZHZOxY45juktRJb5jmZ5+Lcn3Vvow/GhgrHxrBO7rx6YIU6ZVW6d8cW9IY8uHS3MwdiEx3rP5ywwCnEQ/Wetv4YqhQTX0iaCx0yZ+um90ng+3CXxp6tnckdjJJTULkSmiAaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGCUjSWm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749051787; x=1780587787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KBvw1K5sntUXh/9Sm7OBz9ypq0dkXEpUOjGj1PVTgew=;
  b=NGCUjSWmDbOruvhDnh5hgI5IFBax/CYRayIHn3YjYEDQq55HAOIQlRkB
   oTcfe5LzQzWBnjBqyxoDqxeV4Vol+l1gI0jRMN7TL7hdyjAb8FwiOAU2r
   0w0A/yNW0iDrNVa01RGu201zm3ydsz1oOhcFpOWF5076qhlNlKDMS89H7
   2F6NOwC3qDQq7UsMzSzL72aF9csMEOhSequT5AaSn7JoTiNHJU2r5FAna
   FqCp07DJX9m8daQfLWx5oBzXBknzsQsb6CWksgfE5pZslayvhJ/61dvBH
   z4zLeHo/KmEnfwUNR2mNYKbeed8P1y2mjCIg7a6DFUDnpiGLGfkW/ffDO
   Q==;
X-CSE-ConnectionGUID: WGPZyiQmSPK+tGc/HfVUsQ==
X-CSE-MsgGUID: 94z7YzrQQ4ieGv868V0LFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54805232"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54805232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:43:06 -0700
X-CSE-ConnectionGUID: Hv+B9f7XStyUfmL40SnJng==
X-CSE-MsgGUID: mdH1lAQOTdeUENpSGK9z6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145557168"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:42:50 -0700
Date: Wed, 4 Jun 2025 18:42:47 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com,
	oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
References: <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>

On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 30, 2025 at 7:23 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:

...

> > > > > > From the driver perspective it does have expectations that the parts outside
> > > > > > the driver did the right thing.  If the driver was expecting the root port
> > > > > > to be powered down at suspend and it wasn't there are hardware components
> > > > > > that didn't power cycle and that's what we're seeing here.
> > > > >
> > > > > Which means the expectation set by the driver is the opposite of the
> > > > > purpose of this patch, and it's going to fail if any kind of error is
> > > > > detected under root port during suspend.
> > > >
> > > > And IMV this driver's expectation is questionable at least.
> > > >
> > > > There is no promise whatsoever that the device will always be put into
> > > > D3cold during system suspend.
> > >
> > > For instance, user space may disable D3cold for any PCI device via the
> > > d3cold_allowed attribute in sysfs.
> > >
> > > If the driver cannot handle this, it needs to be fixed.
> >
> > Thanks for confirming. So should we consider this patch to be valid
> > and worth moving forward?
> 
> It doesn't do anything that would be invalid in principle IMV.
> 
> You need to consider one more thing, though: It may be necessary to
> power-cycle the device in order to kick it out of the erroneous state
> and the patch effectively blocks this if I'm not mistaken.
> 
> But admittedly I'm not sure if this really matters.

Wouldn't something like bus reset (SBR) be more predictable?

Raag

