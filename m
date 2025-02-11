Return-Path: <linux-pci+bounces-21136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EECA3031B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C813A80EB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 05:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4C1E5B6F;
	Tue, 11 Feb 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXxt8LgV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656E1E572A;
	Tue, 11 Feb 2025 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253449; cv=none; b=a2lG5zh6Bum5AaP7ndnWWHhoF5soOhSLoKHehsxmiRjkJXTWn7yIJ4YRuFrjZGhs3IvxgrY7AEmdvc8TcVHwcfu1/exbdCbqNl0tW1PRCwUN4UfA2CEFPlFTpOA0l7TZIrSvmLnhB/dyBbwP+AjBFq3e2jZL98H0ZwONbmb8fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253449; c=relaxed/simple;
	bh=zqf5jLkSm8sTjh+xVPPHCA3ep9BI0AwbVfILj3fYa4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtcv19I1Oac2P2jQrUfLpnRDPDbexec+vPNP6zgNEBC2wdv4MJAEW57HMh8biJLxdrWzfWCNZZ7mInI81KaMvsxTaNlNl9bdTk188hO2IIXgMalRavuKdH7+oo1637uRQf0TwGDE7S7WIGknTEUu7QcHs7VmHrCdXiuDBKlOIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXxt8LgV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739253447; x=1770789447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zqf5jLkSm8sTjh+xVPPHCA3ep9BI0AwbVfILj3fYa4s=;
  b=KXxt8LgV31LYCgz7xoC3FxRRxi7+nqcWHmJ50/MKXymVqe1k+zIsFb7i
   +WNx6WrQfgv29hPDqXdG3MqY55GnQy494dlkNVjx3c8jrn7gQB5cECtvy
   WH3n/0Ti0mCZ4ZPMcoc0+R9aqtW3VQtlGBaMhByMBR11fhZhpFfdiD/NB
   kuL1YpC01aElEqacnFEXvCgwE7GoWlokGumbYFHgUoHcf0W63S9zGd2YS
   Pn2MFK3M2MLvJYNV+gKu5QX6QK9MA69POFE/2fZmcVHIzN4N0m5gTByYg
   W31G5P172ybks0cbp7FLsrdvBWlnSDXUwPG4xiIZ0TF85zkzXBzFetNo6
   g==;
X-CSE-ConnectionGUID: tpsHR1QxRU6peFrwsZQUpA==
X-CSE-MsgGUID: spgO0jX9SG2Ns+Sp4WnYrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51288890"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51288890"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 21:57:26 -0800
X-CSE-ConnectionGUID: nOWJNRT5QFaYbJwlXwo4kA==
X-CSE-MsgGUID: wAZH6rr1QZWIiM8j7QThng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143310642"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2025 21:57:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 70DFF2CA; Tue, 11 Feb 2025 07:57:22 +0200 (EET)
Date: Tue, 11 Feb 2025 07:57:22 +0200
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
Subject: Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac)
Message-ID: <20250211055722.GW3713119@black.fi.intel.com>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>

Hi,

Can you elaborate what are the steps you do to reproduce the issue? Also it
would help to see full dmesg if possible with "thunderbolt.dyndbg=+p" in
the kernel command line.

I suspect based on the below is that the USB4 link just goes down and does
not come up upon resume. What kind of devices are involved?

Actually it would be good if you could greate entry on bugzilla.kernel.org
and attach the files there.

On Mon, Feb 10, 2025 at 04:18:51PM -0800, Kenneth Crudup wrote:
> 
> I wonder about that, too- but for the most part, my resumes from
> hibernate/suspend tend to work most of the time.
> 
> I've instrumented .../drivers/thunderbolt/path.c to add some pr_info()s in
> __tb_path_deactivate_hop() to see if it's either tripping up on a NPE and to
> see where it dies, but since then nothing has happened again, so I do wonder
> sometimes if it's an errant driver (i.e., just subtle changes in the
> ordering of code could be making a difference).
> 
> That being said, leaving a USB4-to-NVMe bridged NVMe device connected to a
> Thunderbolt dock on suspend causes hangs on resume that only the power
> button seems to recover from. I've really been trying to bisect the cause on
> this one as it's usually my only failure mode (and frustrating when I forget
> to unplug before I suspend). What complicates that one more is it now
> doesn't happen EVERY time.
> 
> One change I've done from Linus' master (which I tend to grab every few
> days) and have for a while is this:
> 
> ----
> -        cflags-$(CONFIG_MCORE2)                += -march=core2
> +        cflags-$(CONFIG_MCORE2) += \
> +                $(call cc-option,-march=alderlake,$(call
> cc-option,-mtune=native)) \
> +                $(call cc-option,-mtune=alderlake,$(call
> cc-option,-mtune=native))
> ----
> 
> But I'm running "gcc (Ubuntu 14.2.0-4ubuntu2) 14.2.0", so that should be
> mature enough to not introduce any Intel-chipset-specific bugs, right?
> 
> -Kenny
> 
> On 2/10/25 13:05, Bjorn Helgaas wrote:
> > [+cc Thunderbolt folks, original post
> > https://lore.kernel.org/r/04091f53-3c94-4533-ab48-e9296e6e2841@panix.com]
> > 
> > Wow, something about your platform or usage is really good at finding
> > these bugs ;)  The original post is a page fault in xe_display_pm_resume()
> > and this one a NULL pointer dereference in __tb_path_deactivate_hop().
> > You see these so frequently that I would think Google would find more
> > reports, but I don't see any, which makes me wonder if this is some
> > kind of memory corruption related to a driver on your system.
> > 
> > On Sat, Feb 08, 2025 at 07:47:10PM -0800, Kenneth Crudup wrote:
> > > Eh, NVM.
> > > 
> > > Just had another resume crash with it reverted:
> > > 
> > > ----
> > > <6>[69848.656985][T25549] CPU19 is up
> > > <6>[69848.666220][T25549] ACPI: PM: Waking up from system sleep state S4
> > > <6>[69848.693976][T25549] ACPI: EC: interrupt unblocked
> > > <4>[69848.704735][T25549] thunderbolt 0000:00:0d.2: 0:5: path does not end
> > > on a DP adapter, cleaning up
> > > <1>[69848.706322][T25549] BUG: kernel NULL pointer dereference, address:
> > > 0000000000000384
> > > <1>[69848.706324][T25549] #PF: supervisor read access in kernel mode
> > > <1>[69848.706325][T25549] #PF: error_code(0x0000) - not-present page
> > > <6>[69848.706326][T25549] PGD 0 P4D 0
> > > <4>[69848.706327][T25549] Oops: Oops: 0000 [#1] PREEMPT SMP
> > > <4>[69848.706330][T25549] CPU: 1 UID: 0 PID: 25549 Comm: systemd-sleep
> > > Tainted: G S   U     O       6.14.0-rc1-kenny+ #4
> > > <4>[69848.706332][T25549] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER,
> > > [O]=OOT_MODULE
> > > <4>[69848.706332][T25549] Hardware name: Dell Inc. XPS 9320/0KNXGD, BIOS
> > > 2.18.1 12/24/2024
> > > <4>[69848.706333][T25549] RIP: 0010:__tb_path_deactivate_hop+0x25/0x220
> > > <4>[69848.706337][T25549] Code: 5d 5d c3 c3 90 55 48 89 e5 41 57 41 56 41 55
> > > 41 54 53 48 83 ec 18 89 55 c4 65 48 8b 04 25 28 00 00 00 48 89 45 d0 48 8b
> > > 47 20 <80> b8 84 03 00 00 00 0f 85 64 01 00 00 8b 90 04 03 00 00 44 8d 2c
> > > <4>[69848.706338][T25549] RSP: 0000:ffffa2d40a9fb7f8 EFLAGS: 00010292
> > > <4>[69848.706339][T25549] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> > > 0000000000000002
> > > <4>[69848.706340][T25549] RDX: 000000000000000e RSI: 00000000a863e150 RDI:
> > > ffffa2d400803b00
> > > <4>[69848.706340][T25549] RBP: ffffa2d40a9fb838 R08: 0000000000000000 R09:
> > > ffffffffa9a55760
> > > <4>[69848.706341][T25549] R10: 0000000000000000 R11: 0000000000000000 R12:
> > > ffff8d1fc6bce7c0
> > > <4>[69848.706341][T25549] R13: 0000000000000028 R14: ffff8d1fc1861000 R15:
> > > ffff8d1fc18513e8
> > > <4>[69848.706342][T25549] FS:  00007fb5b3631940(0000)
> > > GS:ffff8d272f440000(0000) knlGS:0000000000000000
> > > <4>[69848.706343][T25549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > <4>[69848.706343][T25549] CR2: 0000000000000384 CR3: 00000003cea00003 CR4:
> > > 0000000000770ef0
> > > <4>[69848.706344][T25549] PKRU: 55555554
> > > <4>[69848.706344][T25549] Call Trace:
> > > <4>[69848.706345][T25549]  <TASK>
> > > <4>[69848.706348][T25549]  ? show_regs.part.0+0x1d/0x20
> > > <4>[69848.706351][T25549]  ? __die+0x52/0x91
> > > <4>[69848.706352][T25549]  ? page_fault_oops+0x9a/0x220
> > > <4>[69848.706354][T25549]  ? exc_page_fault+0x2fc/0x5c0
> > > <4>[69848.706357][T25549]  ? asm_exc_page_fault+0x27/0x30
> > > <4>[69848.706359][T25549]  ? __tb_path_deactivate_hop+0x25/0x220
> > > <4>[69848.706360][T25549]  __tb_path_deactivate_hops+0x37/0x60
> > > <4>[69848.706361][T25549]  tb_path_deactivate+0x1e/0x110
> > > <4>[69848.706362][T25549]  tb_tunnel_deactivate+0x65/0x120
> > > <4>[69848.706363][T25549]  tb_tunnel_discover_dp+0x373/0x670
> > > <4>[69848.706364][T25549]  tb_switch_discover_tunnels+0x71/0x1e0
> > > <4>[69848.706366][T25549]  tb_resume_noirq+0x91/0x2a0
> > > <4>[69848.706368][T25549]  tb_domain_resume_noirq+0x3f/0x60
> > > <4>[69848.706369][T25549]  nhi_resume_noirq+0x34/0x90
> > > <4>[69848.706370][T25549]  pci_pm_restore_noirq+0x71/0xc0
> > > <4>[69848.706372][T25549]  ? new_id_store+0x1b0/0x1b0
> > > <4>[69848.706373][T25549]  dpm_run_callback+0x40/0xb0
> > > <4>[69848.706375][T25549]  device_resume_noirq+0xc4/0x2a0
> > > <4>[69848.706376][T25549]  dpm_noirq_resume_devices+0x11b/0x150
> > > <4>[69848.706376][T25549]  dpm_resume_start+0xc/0x30
> > > <4>[69848.706377][T25549]  hibernation_snapshot+0x26d/0x430
> > > <4>[69848.706379][T25549]  hibernate.cold+0x9c/0x333
> > > <4>[69848.706380][T25549]  state_store+0xbe/0xc0
> > > <4>[69848.706381][T25549]  kobj_attr_store+0xf/0x20
> > > <4>[69848.706383][T25549]  sysfs_kf_write+0x34/0x40
> > > <4>[69848.706385][T25549]  kernfs_fop_write_iter+0x134/0x1e0
> > > <4>[69848.706386][T25549]  vfs_write+0x244/0x410
> > > <4>[69848.706388][T25549]  ksys_write+0x63/0xd0
> > > <4>[69848.706389][T25549]  __x64_sys_write+0x14/0x20
> > > <4>[69848.706390][T25549]  x64_sys_call+0x9eb/0xa00
> > > <4>[69848.706392][T25549]  do_syscall_64+0x63/0xf0
> > > <4>[69848.706394][T25549]  ? do_filp_open+0xbe/0x170
> > > <4>[69848.706395][T25549]  ? do_wp_page+0x7f3/0xe80
> > > <4>[69848.706398][T25549]  ? ___pte_offset_map+0x17/0xe0
> > > <4>[69848.706399][T25549]  ? __handle_mm_fault+0xb13/0x1160
> > > <4>[69848.706400][T25549]  ? do_syscall_64+0x6f/0xf0
> > > <4>[69848.706401][T25549]  ? strncpy_from_user+0x25/0xf0
> > > <4>[69848.706402][T25549]  ? __count_memcg_events+0x49/0xe0
> > > <4>[69848.706403][T25549]  ? handle_mm_fault+0x181/0x2a0
> > > <4>[69848.706404][T25549]  ? irqentry_exit+0x4a/0x60
> > > <4>[69848.706405][T25549]  ? exc_page_fault+0x196/0x5c0
> > > <4>[69848.706406][T25549]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > <4>[69848.706407][T25549] RIP: 0033:0x7fb5b3526274
> > > <4>[69848.706411][T25549] Code: Unable to access opcode bytes at
> > > 0x7fb5b352624a.
> > > <4>[69848.706411][T25549] RSP: 002b:00007ffe667063f8 EFLAGS: 00000202
> > > ORIG_RAX: 0000000000000001
> > > <4>[69848.706412][T25549] RAX: ffffffffffffffda RBX: 0000000000000005 RCX:
> > > 00007fb5b3526274
> > > <4>[69848.706413][T25549] RDX: 0000000000000005 RSI: 000055ae2380a030 RDI:
> > > 0000000000000007
> > > <4>[69848.706413][T25549] RBP: 00007ffe66706420 R08: 0000000000000000 R09:
> > > 0000000000000001
> > > <4>[69848.706414][T25549] R10: 0000000000000003 R11: 0000000000000202 R12:
> > > 0000000000000005
> > > <4>[69848.706414][T25549] R13: 000055ae2380a030 R14: 000055ae237f62a0 R15:
> > > 00007fb5b360fea0
> > > <4>[69848.706415][T25549]  </TASK>
> > > <4>[69848.706415][T25549] Modules linked in: vmw_vmci snd_soc_sof_sdw
> > > snd_soc_sdw_utils snd_sof_probes iwlmvm mei_hdcp mei_pxp mac80211
> > > snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic
> > > snd_sof_pci soundwire_intel soundwire_generic_allocation soundwire_cadence
> > > snd_sof_intel_hda_common snd_soc_hdac_hda iwlwifi btusb
> > > snd_sof_intel_hda_mlink btintel snd_sof_intel_hda cfg80211 mei_me ov01a10 xe
> > > drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec i915
> > > drm_buddy intel_gtt drm_display_helper cec ttm
> > > <4>[69848.706433][T25549] CR2: 0000000000000384
> > > <4>[69848.706435][T25549] ---[ end trace 0000000000000000 ]
> > > ----
> > > 
> > > On 2/8/25 12:56, Kenneth Crudup wrote:
> > > > 
> > > > Guys, I don't think this commit is right; I've had 2 out of three resume
> > > > failures since this change went into Linus' master. I've attached a
> > > > pstore dump of the latest crash, and while it appears to be coming from
> > > > the Intel XE driver, 95% of my (s0ix) resumes worked previously[1]
> > > > before this change.
> > > > 
> > > > LMK if you need more information.
> > > > 
> > > > -Kenny
> > > > 
> > > > [1] - unless I forget to detach my NVMe USB4 external drive before
> > > > suspending, which is a breakage that appears to have gone in sometime
> > > > around the 6.10 series, but I haven't been able to bisect it
> > > 
> > > -- 
> > > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> > > CA
> > > 
> > 
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA

