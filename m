Return-Path: <linux-pci+bounces-2406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37B3835ACE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 07:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92684283A5A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B195672;
	Mon, 22 Jan 2024 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvOYMQ2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A35257;
	Mon, 22 Jan 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903811; cv=none; b=RrsS2AKBRfGKxCombhXw6bZ3XEIqrQOfRoS3PVij3C/hD0sY+LNUq5WanHjRDKr6XkLau6vzGTZQjs15YuOmrgQFommnwiapuPUMZTSyUGTqPbRsNchCqdXgxVxcJLTVlf5FR7xzO3qoRKH72/zl7RNjZ+gDVpOfLqo1J5zhddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903811; c=relaxed/simple;
	bh=On0vUh6bL9hDWUBP2BgNGBtra1N1h8+b39/EcbN/CM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeZB9+hEvOWuOLa700u79mNJjFSYIIqcpIscw4cgatGa5PeknkQemkHhlbuBLH1M6vIdaRDQ4Rk+kX+jEppYzvxhc9iO3KPU6prD47k4AC5vDNnYqeam0CzPYyt+z3cyImb16/wqtTKmZ8QKC2uEeE4K834KDeh6MnIuvtUvSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvOYMQ2H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705903810; x=1737439810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=On0vUh6bL9hDWUBP2BgNGBtra1N1h8+b39/EcbN/CM8=;
  b=bvOYMQ2Hgyx0oTrBMbvMk2q/t8/BO9UCIugdx0CXcjOyt/C38cCw2A7K
   XfXBD4lYAGk5PZ7EUpoqke2lkZ6hQ74PmBbu5YC4ToEvAYkNttP9nEme5
   iMP6eyjHIRhvS655np8R7dVipBRookoxtIDT6yiCt5c3fGIhCmFDJLKO/
   T/lqfpnT6xfXj+nD0UIjHyXd5PAUGI9MVCBKb1Bjl8GEO1ZOhtg2mLdoL
   HzaM/CLwQFF48YRUyeoWdpkbGmzr9DAtXU86ClrRW2LyQUgbD8r8WIYMp
   jYB3qbuUf4PYOxzwWTLgery5IQ0agCKDXr/kqaHRPGG74k/7+g8iu4fAo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8508479"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8508479"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 22:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="904742683"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="904742683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2024 22:10:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 99C1323A; Mon, 22 Jan 2024 08:10:05 +0200 (EET)
Date: Mon, 22 Jan 2024 08:10:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240122061005.GF2543524@black.fi.intel.com>
References: <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
 <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com>
 <20240119102258.GE2543524@black.fi.intel.com>
 <CA+Y6NJHhTaroqJKEvOebRvbTdgkxW8tqFvq5MrOVE9swmwmtOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJHhTaroqJKEvOebRvbTdgkxW8tqFvq5MrOVE9swmwmtOw@mail.gmail.com>

On Fri, Jan 19, 2024 at 11:03:18AM -0500, Esther Shimanovich wrote:
> On Thu, Jan 18, 2024 at 1:01 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Well that's pretty much all Intel Titan Ridge and Maple Ridge based
> > systems. Some early ones did not use IOMMU but all the rest do.
> ...
> > Before Intel Ice Lake it was all discrete and it is still discrete with
> > the Barlow Ridge controller who will have exact same ExternalFacing port
> > as the previous models.
> 
> Next week I'll try those devices in our inventory to see if I can find
> another one with this bug. I'll get back to you on that!
> 
> On Fri, Jan 19, 2024 at 2:58 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Now if I understand the reason behind this patch is actually not about
> > "removability" that much than about identifying a trusted vs. untrusted
> > device and attaching a driver to those. I was under impression that
> > there is already a solution to this in ChromeOS kernel. It has an
> > allowlist of drivers that are allowed to attach these devices and that
> > includes the PCIe port drivers, xhci_hcd and the thunderbolt driver,
> > possibly something else too. Is this not working for your case?
> 
> This device shouldn’t be treated as a removable thunderbolt device
> that is enabled by policy because it is an internal device that should
> be trusted in the first place.
> Even so, while learning about this problem I tried modifying the
> ChromeOS policy but it ended up not fixing the issue because it seems
> like there is an expectation for it to see an existing “fixed”
> thunderbolt port before it loads anything else. But the fixed
> thunderbolt port is prevented from enumerating during bootup, before
> the policy has a chance to work.

Have you contacted the Chrome kernel folks about this? Perhaps they
have thought about this already?

> On Fri, Jan 19, 2024 at 5:23 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > The below "might" work:
> >
> > 1. A device that is directly behind a PCIe root or downstream port that
> >    has ->external_facing == 1.
> >
> > 2. It is a PCIe endpoint.
> >
> > 3. It is a sibling to or has any of the below PCI IDs (see
> >    drivers/thunderbolt/nhi.h for the definitions):
> 
> External pci devices seem to have the same kinds of chips in them. So
> this wouldn’t distinguish the “fixed but discrete” embedded pci
> devices from the “removable” pcie through usb devices. My monitor with
> thunderbolt capabilities has the JHL7540 chip in it. From the kernel's
> perspective, I have only found that the subsystem id is what
> distinguishes these devices.
> 
> That is, unless I am missing something in your proposal that would
> distinguish a fixed JHL6540 chip from an external JHL6540 chip. Please
> correct me on any assumptions I get wrong!

Yes, you are missing the 1. that it needs to be directly behind the PCIe
root or downstream port that is marked as ->external_facing, and the
fact that there can't be NHI's (that's the host controller with the IDs
I listed in 3.) anywhere else except starting the topology according the
USB4 spec (and the same applies to Thunderbolt 1-3).

