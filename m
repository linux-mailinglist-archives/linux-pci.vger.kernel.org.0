Return-Path: <linux-pci+bounces-13222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D79794F9
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4C1C20BE9
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA991B59A;
	Sun, 15 Sep 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izJ2nuxY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646D22315;
	Sun, 15 Sep 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384452; cv=none; b=D6cZ14h/cKr8jCb/R7Enp4rWiHDvRyg/F1eQMnEhF30IRYyLEQeO767agjqG1Oh7S7G87q/wtXXr6MGSs5Na9A/6XmOR6qnjFbaLmNGlJwvTFApkDneTYSSGgc9QseF88QipgphYudBlaVtAj+/61Ed752UvQVMfiR4EVleV8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384452; c=relaxed/simple;
	bh=gguBgbwKdqH6OkJl+S82MCRDHkOu58Yma2Jh+r+nV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukrvjTgEoC+fASiRebnbEyUz57mQken7g0dr0OCEuruWmobdb6iLzlkHwGBw67R3eW1KIviHXIXG3t5NKfcvbUsW2C3mryXd4BiCq1XbTFdpOTN1xN1XjqFlliBtVD3KpQk7OAHU9gybiu7qpEebo+PfDgx/X2NxPESxiGVfT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izJ2nuxY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726384450; x=1757920450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gguBgbwKdqH6OkJl+S82MCRDHkOu58Yma2Jh+r+nV5M=;
  b=izJ2nuxYbtwavD32BSyDbG1UQLu09OCShfeHS41skcCXt9yWKRPvOwX0
   2/aAE+t6mUiRjsgb6zkTfiDIw4l5n3rsvpT/fQS0PARfi+4G1lwyFOmOx
   o5u0ndTVlSDGxsyHWvMVvRaoSuzUv6uLmVLyzS+k1IWM8MXhhErkB6qKB
   9RgGOmGP+R2dqmLmO/keyBL2yWv/3y4pFa+k3ro1XghBZkYOQ1JkZtcsu
   oWKNhBxJw91aoWP6NvSxJKwuWCmu68lxT8S+crtpqqS5MNPNhoa/FTEaA
   5MTVuEOM+Gmh62Y/ZM+BajqLQGoLa5UWOVkDBuDijn/l6lOtI1BZA1ezS
   w==;
X-CSE-ConnectionGUID: e4Yd1kpoRBG4capf0g0jSg==
X-CSE-MsgGUID: Oe8qf89JTc+LiFFIyi9dBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="24726730"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="24726730"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:14:09 -0700
X-CSE-ConnectionGUID: 8uaiC5iITU2eoNyQ1j54EA==
X-CSE-MsgGUID: nyexTW3fQL6QfXyJF+6FTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="69061964"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 15 Sep 2024 00:14:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 727AA18F; Sun, 15 Sep 2024 10:14:06 +0300 (EEST)
Date: Sun, 15 Sep 2024 10:14:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Kai-Heng Feng <kaihengfeng@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20240915071406.GR275077@black.fi.intel.com>
References: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
 <20240912165709.GA674430@bhelgaas>
 <CAMusMWqxi3s8sb+j0wV251kRj9R9-oqKQUqKscVTk_sktm2m5A@mail.gmail.com>
 <20240913080123.GP275077@black.fi.intel.com>
 <12857e01-f6cc-4489-935b-7e6c354706e9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12857e01-f6cc-4489-935b-7e6c354706e9@amd.com>

Hi,

On Fri, Sep 13, 2024 at 03:33:33PM -0500, Mario Limonciello wrote:
> > I know this is about entering S5 (power off) but I wonder if simply
> > disabling the device (I/O, MMIO and bus mastering) could stop it from
> > waking up?
> 
> To me, it's a two-fold problem.  The device consumes too much power, and the
> device issues interrupts when system is in S5.
> 
> Putting it in D3 should nip both, disabling the device might help the
> latter.
> 
> I did the same thing a vendor did for KH where I double checked the waveform
> at S5 and could see the devices still in D0.
> 
> Or do you think that by the device being in D0 but disabled should be enough
> for decreasing power?

No, not about power but just to solve the issue here. I'm not objecting
putting the device into D3 instead on the grounds that if Windows does
this then probably it is safe or us to do as well and also avoids
possible untested paths in the firmware side too.

Strictly based on ACPI spec [1] there is no such requirement though.

[1] https://uefi.org/specs/ACPI/6.5/16_Waking_and_Sleeping.html#transitioning-from-the-working-to-the-soft-off-state

