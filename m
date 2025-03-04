Return-Path: <linux-pci+bounces-22864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF1A4E580
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7524A8859D8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A127CCDF;
	Tue,  4 Mar 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XARYIuYr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733927CCD5;
	Tue,  4 Mar 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102472; cv=none; b=XxfxMgWSNc4KYhio+RgndxOSsiZ+4xfww7m2FejtlHvXGkfRAxDx9SH9BKMDirMnmMjOKnMHmrM0tbpor11bbNhMXPIElVyBcMWRZDrioMvyPCVoX1IX1PDQWR37PHlL6iBylZSU6re0OL+alQCU97TOltBTVxeJZ9jCRJsOVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102472; c=relaxed/simple;
	bh=H0Nu6AdoApme9k39syzCONUq4pJUthJi+iBb+eyJkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YbZLWaTxmNS3oRDm76RGLU3mHMWCmwiRh4C5VFx8axXgX5DG1mPigYGckaKbgikGC3WGr6bfLQMuWuihcVzFvlPpg6gNJsniHIt4BpIuDVs8hdOiWo/AMkoATHVcTLuHuQmc4z04hP2/kyivUb26tjqMCH07G4pkI0/6vE84MVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XARYIuYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240DAC4CEE5;
	Tue,  4 Mar 2025 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741102472;
	bh=H0Nu6AdoApme9k39syzCONUq4pJUthJi+iBb+eyJkVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XARYIuYrlWgJj9dDrgvYD8z5gwOWHAfuk0TYWmZ4rk6MywSTNvvaw/Qw52GRiuEiq
	 834Mjaxz8P8Zw2d+EPgnWHySwkrmhRAS+yIokkz8FLXvg+tZ4CY/t2V0Fxxw68E5TH
	 RaK0NTPszIwgnLNaoc+OtrGataycbcmOu9A9bseptM77Ryq0g4EBc/Ii/RqGx0IG+b
	 jKb1uzgeAJZiTOMMCkfwQTHh8QPp3fpabbVxXmm4eccGza7kldl7+szXRSkcgXl6di
	 B4p3VxTXGHvxOVOgGX3oPEWCzcTbZezWWVzMFWnfGdgRjYl0N5Kaa3irUwvQVtNpsH
	 4yziXr8n8LJlA==
Date: Tue, 4 Mar 2025 09:34:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: Avoid pointless capability searches
Message-ID: <20250304153430.GA227597@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503042124.7627f722-lkp@intel.com>

On Tue, Mar 04, 2025 at 10:12:48PM +0800, kernel test robot wrote:
> kernel test robot noticed "last_state.booting" on:
> 
> commit: c8a9382e172ac80bc96820b3ec758e35cdc05c06 ("[PATCH v2 1/2] PCI: Avoid pointless capability searches")
> url: https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-Avoid-pointless-capability-searches/20250215-080525
> base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
> patch link: https://lore.kernel.org/all/20250215000301.175097-2-helgaas@kernel.org/
> patch subject: [PATCH v2 1/2] PCI: Avoid pointless capability searches

This patch was dropped in next-20250224.

> in testcase: xfstests
> version: xfstests-x86_64-8467552f-1_20241215
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: ext2
> 	test: generic-holetest
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503042124.7627f722-lkp@intel.com
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250304/202503042124.7627f722-lkp@intel.com
> 
> 
> 
> [   62.784123][  T284] LKP: waiting for network...
> [   62.784128][  T284] 
> [   63.218408][  T284] ls /sys/class/net
> [   63.218417][  T284] 
> [   63.224484][  T284] lo
> [   63.224490][  T284] 
> [   64.076175][    T1] watchdog: watchdog0: watchdog did not stop!
> [   64.157917][    T1] watchdog: watchdog0: watchdog did not stop!
> [   64.196710][    T1] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
> [   64.202659][    T1] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   64.969888][    T1] pcieport 0000:00:01.0: VC0 negotiation stuck pending
> [   64.977342][    T1] ACPI: PM: Preparing to enter system sleep state S5
> [   64.986446][    T1] kvm: exiting hardware virtualization
> reboot: Restarting system
> 
> 
> there is no more useful information, seems our test machine just reboot here.
> this is not observed on the parent commit, c71f7bbc5d794, which chosen as the
> base by bot.
> 
> * a234e07a63859 (linux-review/Bjorn-Helgaas/PCI-Avoid-pointless-capability-searches/20250215-080525) PCI: Cache offset of Resizable BAR capability
> * c8a9382e172ac PCI: Avoid pointless capability searches
> *   c71f7bbc5d794 Merge branch 'pci/endpoint'
> 
> c71f7bbc5d794984 c8a9382e172ac80bc96820b3ec7
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     last_state.booting
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

