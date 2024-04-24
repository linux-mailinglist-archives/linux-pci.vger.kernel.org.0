Return-Path: <linux-pci+bounces-6610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD48B051F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50FE286DD5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D7158A1A;
	Wed, 24 Apr 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+D6EDAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC8158A24;
	Wed, 24 Apr 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948973; cv=none; b=ABtD90AOZhqaSOrIcan5dIqZrRfyL/rhBC9snKACfv6x78u5PquOUgVzn7qcKJnIWl2yNYL1tWmLyZE9DSkn+5+RbtovND7qbsU8WLNimnY/LO2YpZnm6pYCV3nTb3r/MNowqV0xnL4V7nNLKny7fbimH3C+Jm9tYsFK0K9R3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948973; c=relaxed/simple;
	bh=OMY1dJ2IvSs34UYUfdvXZ7JDxKmxi8MJwNj523szlxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1k1SdcYSETaLfzmGeJKz7On5GlVBm5SS4OiNVg5xFTBoeJsOksPMDRbip76Vdanb0FjSReQZkYoYfpkFt6cCxmOTNT/30zVyZhKKLXveej7T034PCJ5bj2DosbfJFcw41sR8le6yJL1Azy2uIGmXzh39YSmCw3M9Cgo2WHHGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+D6EDAw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713948972; x=1745484972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMY1dJ2IvSs34UYUfdvXZ7JDxKmxi8MJwNj523szlxo=;
  b=J+D6EDAwUkj5bNO1NmFXXy3MvP5XavXW9gWi05Y3WDSf2zV9rjt8kVfw
   71tNl6TXurjcXkjDE1dfnPwTfGq079xKjls58+E9FdFRpFNuU6EtUdLY3
   mkIhzQ+jYLNB7qzAhSW7+IhQV0aR2HxXnk0yZwvQOSpJ+vbdz3Sz22VMy
   vw6bLi18PCYPtMXqivkDRMEpKb9Lz4qt4VMbBWpGojqr5nk81pP5uWD+c
   Xphx3PbtkzQ7HBzAEuBif1kSi2S+CUnndCGk47jlEkCr0H3xeYkugU/Ge
   PKBzOxtU4m9oEpQXO+nTQiJOFvvg2RfVxd0yuK0GwdsH6fby186R7SzuQ
   Q==;
X-CSE-ConnectionGUID: 8My9nlAeRqGy25BQicU/rw==
X-CSE-MsgGUID: f9diaejdQvqzcOnSj+/+vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13401251"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13401251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:56:12 -0700
X-CSE-ConnectionGUID: QMYg4QyeR3SVgFM3kBgwtA==
X-CSE-MsgGUID: dzAmgWWySqifjj7KNXPHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29106228"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2024 01:56:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2F01CA5; Wed, 24 Apr 2024 11:56:08 +0300 (EEST)
Date: Wed, 24 Apr 2024 11:56:08 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240424085608.GE112498@black.fi.intel.com>
References: <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>

On Tue, Apr 23, 2024 at 11:59:36AM -0500, Mario Limonciello wrote:
> On 4/23/2024 00:33, Mika Westerberg wrote:
> > On Mon, Apr 22, 2024 at 02:21:18PM -0500, Mario Limonciello wrote:
> > > On 4/22/2024 14:17, Esther Shimanovich wrote:
> > > > Thanks for the explanation! I still don't fully understand how that
> > > > would work for my use case.
> > > > 
> > > > Perhaps it would be better for me to describe the case I am trying to
> > > > protect against.
> > > > 
> > > > To rehash, this quirk was written for devices with discrete
> > > > Thunderbolt controllers.
> > > > 
> > > > For example,
> > > > CometLake_CPU -> AlpineRidge_Chip -> USB-C Port
> > > > This device has the ExternalFacingPort property in ACPI.
> > > > My quirk relabels the Alpine Ridge chip as "fixed" and
> > > > external-facing, so that devices attached to the USB-C port could be
> > > > labeled as "removable"
> > > > 
> > > > Let's say we have a TigerLake CPU, which has integrated
> > > > Thunderbolt/USB4 capabilities:
> > > > 
> > > > TigerLake_ThunderboltCPU -> USB-C Port
> > > > This device also has the ExternalFacingPort property in ACPI and lacks
> > > > the usb4-host-interface property in the ACPI.
> > > > 
> > > > My worry is that someone could take an Alpine Ridge Chip Thunderbolt
> > > > Dock and attach it to the TigerLake CPU
> > > > 
> > > > TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
> > > > 
> > > > If that were to happen, this quirk would incorrectly label the Alpine
> > > > Ridge Dock as "fixed" instead of "removable".
> > > > 
> > > > My thinking was that we could prevent this scenario from occurring if
> > > > we filtered this quirk not to apply on CPU's like Tiger Lake, with
> > > > integrated Thunderbolt/USB4 capabilities.
> > > > 
> > > > ExternalFacingPort is found both on the Comet Lake ACPI and also on
> > > > the Tiger Lake ACPI. So I can't use that to distinguish between CPUs
> > > > which don't have integrated Thunderbolt, like Comet Lake, and CPUs
> > > > with integrated Thunderbolt, like Tiger Lake.
> > > > 
> > > > I am looking for something that can tell me if the device's Root Port
> > > > has the Thunderbolt controller upstream to it or not.
> > > > Is there anything like that?
> > > > Or perhaps should I add a check which compares the name of the
> > > > device's CPU with a list of CPUs that this quirk can be applied to?
> > > > Or is there some way I can identify the Thunderbolt controller, then
> > > > determine if it's upstream or downstream from the root port?
> > > > Or are Alpine Ridge docks not something to worry about at all?
> > > 
> > > My thought was once you have a device as untrusted, everything else
> > > connected to it should "also" be untrusted.
> > 
> > I think what you are looking for is that anything behind a PCIe tunnel
> > should not have this applied. IIRC the AMD GPU or some code there were
> > going to add identification of "virtual" links to the bandwidth
> > calculation functionality.
> > 
> > @Mario, do you remember if this was done already and if that could maybe
> > be re-used here?
> 
> Yeah there was a series that I worked on a few spins a while back
> specifically in the context of eGPUs to identify virtual links and take them
> out of bandwidth calculations.
> 
> It didn't get merged, I recall it got stalled on various feedback and I
> didn't dust it off because the series also did prompt discussions about the
> reasoning that amdgpu was doing this in the first place.  It turned out to
> be a bad assumption in the code and I instead made a change to amdgpu to not
> look at the whole topology but just the link partner
> (466a7d115326ece682c2b60d1c77d1d0b9010b4f if anyone is curious).

Okay that makes sense. Thanks!

