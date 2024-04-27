Return-Path: <linux-pci+bounces-6725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E88B44F5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD211C20FBE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C4739AF9;
	Sat, 27 Apr 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbaiDA7u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84836AEC;
	Sat, 27 Apr 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714203711; cv=none; b=ZTE48wXc01pSmdhD+ikoIf7gFpZ5RbnRbAJHTDVDBjMIUxCviyfdfTUuTGEPoyVH9gFVyhvKj2wb9vTFv9dEHXtuPy+Npj5J7ZJSlCZttzpAZCHX6uRLnrwplpSe+GQ5apAMlr9cZnF7+X4A9UDzQPIfSpaTyU2XYYqAgtaFuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714203711; c=relaxed/simple;
	bh=SDRme7v+9fMuy3jIlBPR7b2mzba950u1Nro4MGcYrHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU0eS5tl4k83CgZFKTY9ZANqDTx50fKguqCKnOJkYsNC1PPToc/pDNm55PL2IQ1qkgjaSghxcFHrkvf5Xe9SQHVZ2X1ydKnmSensB6nhd3J3WgkX8g26XXt9lTnqFuELqN2NgZINTPYO8c14dnStl13tDX5figUv7Mp3sgF0wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbaiDA7u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714203710; x=1745739710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDRme7v+9fMuy3jIlBPR7b2mzba950u1Nro4MGcYrHk=;
  b=cbaiDA7uNGkG0nmg+Eohc27giR+ogCMJiM8XbXJAJb0da0+Q4em7nHx2
   6bdYz2yWCT9l0nClalYpqysq0PfJ/DAghpS5dwx0QCNaSB860L9ZzoXbx
   KDb074QEceeC2ekdvOEFwjYLFLm71YrIV4A3O/FFYvf+yFbTlzNGCSWgA
   onThEz4Ab4+FxsYc9JPxN1pOKnfrBxjXTS/JZZY3D/WMTT5ISIrH0G1IX
   ocR5R6UADMwgD7IEALN6+X+igmKW0XiXCaMt78thUrW3zAAM0+OXBIthq
   80sawFDhMp2NAVAJWzBNzgOutKHRrxUav1z7VKHdfm0jHedMB+Q/5YhP+
   w==;
X-CSE-ConnectionGUID: 8J6ziTvFSHmQVFKqMtqG/w==
X-CSE-MsgGUID: qzxsUA4BQpiBLBdnH60Ezg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13770867"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="13770867"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 00:41:49 -0700
X-CSE-ConnectionGUID: SHEzQjZ1TVC12YTR0YPuJw==
X-CSE-MsgGUID: Tv8ehnxeQfuQbtL64YuwDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="25702352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2024 00:41:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5A9C1329; Sat, 27 Apr 2024 10:41:45 +0300 (EEST)
Date: Sat, 27 Apr 2024 10:41:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240427074145.GD3969176@black.fi.intel.com>
References: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <20240426045207.GI112498@black.fi.intel.com>
 <ZiyOpZlHVH2yaC1B@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiyOpZlHVH2yaC1B@wunner.de>

On Sat, Apr 27, 2024 at 07:35:33AM +0200, Lukas Wunner wrote:
> On Fri, Apr 26, 2024 at 07:52:07AM +0300, Mika Westerberg wrote:
> > On Thu, Apr 25, 2024 at 05:16:24PM -0400, Esther Shimanovich wrote:
> > > I did find one example of a docking station that uses the DSL6540
> > > chip, which has PCI IDs defined in include/linux/pci_ids.h:
> > > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
> > > #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> > > It seems like it has an NHI, despite being in an external, removable
> > > docking station. This appears to contradict what you say about only
> > > having "NHI" on a host router. I am assuming that by host router, you
> > > mean the fixed discrete, fixed thunderbolt chip, or the thunderbolt
> > > controller upstream to the root port. Please correct me if I got
> > > anything wrong!
> > 
> > So it goes same way with other discrete chips from Intel at least. It is
> > the same silicon but the NHI is disabled on device routers.
> > 
> > That said, it is entirely possible for a "malicious" device to pretend
> > to have one so we need to be careful.
> 
> If a device (accidentally or maliciously) exposes an NHI, the thunderbolt
> driver will try to bind to it.
> 
> Do we take any precautions to prevent that?

Not at the moment but it will be behind the IOMMU so it cannot access
any other memory that what is reserved for it.

> AFAICS we'd be allocating a duplicate root_switch with route 0.
> Seems dangerous if two driver instances talk to the same Root Switch.

I don't think it even works because it cannot have topology ID of 0 if
it is a device router which it is in this case since it is being first
enumerated by the "real" host.

That said we have not tested this either so can be 100% sure.

