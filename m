Return-Path: <linux-pci+bounces-1627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7838230B5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0601F2475D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5C1A735;
	Wed,  3 Jan 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUaT5R0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAE1B26E;
	Wed,  3 Jan 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704296477; x=1735832477;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8yW+4S0w+uEglASxoKqT/Sve6+lVV5XbEpuHMegpsmE=;
  b=MUaT5R0HnpXnU4YtvMde8cuFRjkZFxen/Zp1/ciuDh5HPU0P3o0BJgYp
   GnRDf/uL79Is9uz5apj0TZCBZBC783Rrl2Y7q/XAuWA/Z+fcS5soqVdE1
   JT76Ox0qMROJJW+yugAuPiJ8696z4H/HGcUcidVxfcGTQn/MxhjzQePtI
   Is5LQgLssVdQxly5Ex4OjuHrM0hOwNtRNFsAYaZc531yr4JerXs/rSu9N
   I0IgDZ4B27ChmZ4Wn8MFF4/Y2sbEoPmBEbFizNjPKnDoyS1jZSXxZk1b5
   6b99ekJ5aUiNqiuY4iEJbkw2L2HIid6VW0Sz7UhGWeUYWCSGQRgW9L+Ju
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="376511073"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="376511073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903476497"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="903476497"
Received: from bergbenj-mobl1.ger.corp.intel.com ([10.251.211.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:41:12 -0800
Date: Wed, 3 Jan 2024 17:41:10 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Michael Schaller <michael@5challer.de>, bhelgaas@google.com, 
    kai.heng.feng@canonical.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev, 
    macro@orcam.me.uk, ajayagarwal@google.com, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hkallweit1@gmail.com, 
    michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
In-Reply-To: <20240101181348.GA1684058@bhelgaas>
Message-ID: <d7e7b133-d373-e850-1f5f-deee8aa86958@linux.intel.com>
References: <20240101181348.GA1684058@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1968396436-1704296360=:1706"
Content-ID: <ad5d1828-34ff-da67-d24d-4f236cae15b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1968396436-1704296360=:1706
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <38a9c490-447b-39b3-f8d-1a6f83eb8a6@linux.intel.com>

On Mon, 1 Jan 2024, Bjorn Helgaas wrote:

> On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
> > Issue:
> > On resume from suspend to RAM there is no output for about 12 seconds, then
> > shortly a blinking cursor is visible in the upper left corner on an
> > otherwise black screen which is followed by a reboot.
> > 
> > Setup:
> > * Machine: ASUS mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1)
> > * Firmware: 0508 (latest; also tested previous 0505)
> > * OS: Ubuntu 23.10 (except kernel)
> > * Kernel: 6.6.8 (also tested 6.7-rc7; config attached)
> > 
> > Debugging summary:
> > * Kernel 5.10.205 isn’t affected.
> > * Bisect identified commit 08d0cc5f34265d1a1e3031f319f594bd1970976c as
> > cause.
> > * PCI device 0000:03:00.0 (Intel 8265 Wifi) causes resume issues as long as
> > ASPM is enabled (default).
> > * The commit message indicates that a quirk could be written to mitigate the
> > issue but I don’t know how to write such a quirk.
> > 
> > Confirmed workarounds:
> > * Connect a USB flash drive (no clue why; maybe this causes a delay that
> > lets the resume succeed)
> > * Revert commit 08d0cc5f34265d1a1e3031f319f594bd1970976c (commit seemed
> > intentional; a quirk seems to be the preferred solution)
> > * pcie_aspm=off
> > * pcie_aspm.policy=performance
> > * echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm
> > 
> > Debugging details:
> > * The resume trigger (power button, keyboard, mouse) doesn’t seem to make
> > any difference.
> > * Double checked that the kernel is configured to *not* reboot on panic.
> > * Double checked that there still isn't any kernel output without quiet and
> > splash.
> > * The issue doesn’t happen if a USB flash drive is connected. The content of
> > the flash drive doesn’t appear to matter. The USB port doesn’t appear to
> > matter.
> > * No information in any logs after the reboot. I suspect the resume from
> > suspend to RAM isn’t getting far enough as that logs could be written.
> > * Kernel 5.10.205 isn’t affected. Kernel 5.15.145, 6.6.8 and 6.7-rc7 are
> > affected.
> > * A kernel bisect has revealed the following commit as cause:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=08d0cc5f34265d1a1e3031f319f594bd1970976c
> > * The commit was part of kernel 5.20 and has been backported to 5.15.
> > * The commit mentions that a device-specific quirk could be added in case of
> > new issues.
> > * According to sysfs and lspci only device 0000:03:00.0 (Intel 8265 Wifi)
> > has ASPM enabled by default.
> > * Disabling ASPM for device 0000:03:00.0 lets the resume from suspend to RAM
> > succeed.
> > * Enabling ASPM for all devices except 0000:03:00.0 lets the resume from
> > suspend to RAM succeed.
> > * This would indicate that a quirk is missing for the device 0000:03:00.0
> > (Intel 8265 Wifi) but I have no clue how to write such a quirk or how to get
> > the specifics for such a quirk.
> > * I still have no clue how a USB flash drive plays into all this. Maybe some
> > kind of a timing issue where the connected USB flash drive delays something
> > long enough so that the resume succeeds. Maybe the code removed by commit
> > 08d0cc5f34265d1a1e3031f319f594bd1970976c caused a similar delay. ¯\_(ツ)_/¯
> 
> Hmmm.  08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> appeared in v6.0, released Oct 2, 2022, so it's been there a while.
> 
> But I think the best option is to revert it until this issue is
> resolved.  Per the commit log, 08d0cc5f3426 solved two problems:
> 
>   1) ASPM config changes done via sysfs are lost if the device power
>      state is changed, e.g., typically set to D3hot in .suspend() and
>      D0 in .resume().
> 
>   2) If L1SS is restored during system resume, that restored state
>      would be overwritten.
> 
> Problem 2) relates to a patch that is currently reverted (a7152be79b62
> ("Revert "PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume""), so I don't think reverting 08d0cc5f3426 will make
> this problem worse.
> 
> Reverting 08d0cc5f3426 will make 1) a problem again.  But my guess is
> ASPM changes via sysfs are fairly unusual and the device probably
> remains functional even though it may use more power because the ASPM
> configuration was lost.
> 
> So unless somebody has a counter-argument, I plan to queue a revert of
> 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
> v6.7.

Hi,

I cannot understand how 1) even occurs. AFAICT, nothing 
pcie_aspm_pm_state_change() calls into overwrites link->aspm_disable that 
is the variable storing user inputs via sysfs. So how the changes via 
sysfs are lost?

-- 
 i.
--8323329-1968396436-1704296360=:1706--

