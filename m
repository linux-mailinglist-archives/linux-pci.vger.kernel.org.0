Return-Path: <linux-pci+bounces-21350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051FA3413E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3611C3AB489
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236D242938;
	Thu, 13 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGa3VQ+4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F332222CE;
	Thu, 13 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455159; cv=none; b=e32MrrdLYwH9F3IY8C9F2jfgCpvln7gbNVc0Dq1Fj660rBTO7EtZi9YKymz9MfFx81ZxTt4xKww668WDNygp94Y9/f6/BHLKqblLESll8s1jo+MHXPhty87vLEAORzNTwl5ogpmLWL1ZlOTsiWR1S44rEptoVHmDZemi/F+BzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455159; c=relaxed/simple;
	bh=euBBwIvDl7tFCURaGUj3PZmj5h1cb0chWSv5lC4FY7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUE9xVMKUTw5NnItVaQRDHOKpEkXfVZl0r7LDLG4nNiySq2Sk+GynAO00PaZ3oaSmRsXHw+EUB6kVhVyKqjzE2Gl9VuzRtei4eRfNQAEvLKEwiawaiSkSm91yfqmYhspazWwFJW7IWvtCJQNK8T4Cz5Qcd5aZzdb7cv6Ubo7U+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGa3VQ+4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739455158; x=1770991158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=euBBwIvDl7tFCURaGUj3PZmj5h1cb0chWSv5lC4FY7A=;
  b=OGa3VQ+41bSQNmXGf9mCtwOiuJj9X+H08BpuYLdGxOn5yQqnK+4F3KdY
   1mtPovJBu7niUknlYoA6w7CtDG05RCrjXjbDvJzsDKPtulRQ1PxvUyWaZ
   ANoknf6biXf8H3ixSnA11dVCNPLXrk3JhY4Db1pNKpjaRS0Uy5MRp+e1T
   px1MwvPcEAhcI7iDcXpGAiPcVmmlzmFajCivC6+wbbpQUo+x6nUruuD8c
   9ZWNyRUy+7XpGgR12Xi89TnrvSTGN3K+7H8WhxAfpqq5+3L3PlEGL5yOV
   7yL3DDuQlrO7jRo/MSIOPmCHwStt10cu/S3GghOonPA7mY3ZhhgIXlGxA
   g==;
X-CSE-ConnectionGUID: vcx5dfXkTgq0+GhUJWc9Mg==
X-CSE-MsgGUID: FOtI2ojXQDmSp45Sv+y/pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40189093"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40189093"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:59:16 -0800
X-CSE-ConnectionGUID: tHRhaz9eRf6DnqbU8OsLZQ==
X-CSE-MsgGUID: I2OxGvF3TRyCM+nntBIXpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118157960"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 13 Feb 2025 05:59:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 99C9C1FD; Thu, 13 Feb 2025 15:59:11 +0200 (EET)
Date: Thu, 13 Feb 2025 15:59:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250213135911.GG3713119@black.fi.intel.com>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>

Hi,

On Mon, Feb 10, 2025 at 10:17:47PM -0800, Kenneth Crudup wrote:
> 
> The setup is fairly simple (once I'd figured out the failure mode):
> 
> - Have an ASMedia 246x NVMe-to-USB4 housing (with NVMe drive) attached to
> the system via my TB4 dock (CalDigit TS4, but I've had it happen with a Dell
> dock as well (either with the drive mounted, or not) when I suspend
> 
> - Resume with the drive disconnected (i.e., I've gone from home to the
> office).

I see this is fairly normal use-case (sans the disk I guess). Steps to
follow are then something like:

1. Boot the system, nothing connected.
2. Connect CalDigit TS4 (PCIe tunnel is enabled by the UI) to the host Type-C port.
3. Connect ASMedia NVMe to CalDigit downstream Type-C port (PCIe tunnel is enabled by the UI).
4. Verify that the NVMe is visible (lspci, lsblk).

The topology looks like below:

  Host <- TB -> CalDigit TS4 <- TB -> NVMe

5. Suspend the system (close the lid).
6. Unplug the CalDigit TS4.
7. Resume the system (open the lid).

Expectation: system wakes up just fine.
Actual behavior: system crashes and burns.

Do you BTW, unmount the filesystem before you suspend?

> It doesn't happen every time, and for some crazy reason elapsed time between
> suspend and resume seems to make it more likely to happen. Plus it seems
> directly attaching the drive (i.e., no dock in between) doesn't cause
> resumes to fail.

It would be good to see the dmesg output (with thunderbolt.dyndbg=+p) with
these connected, even without suspending so see if there is anything
missing. Since it is Dell system I would expect they have tested this in
Linux pretty well so probably we don't see anything weird there.

I have similar here (not the same devices though) so I can try on my end if
this repros.

