Return-Path: <linux-pci+bounces-22415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F880A458A7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 09:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D16188C62A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A31A9B34;
	Wed, 26 Feb 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGYLBH8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5FF258CEF;
	Wed, 26 Feb 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559460; cv=none; b=exEH5Sk6ZXsLnjKYtNe4MmnBewhnwc7n8NxUGwjNX3M4UiHx9F5qCEmcUkl/xP/3PLi6h5gd9KbpYP8twfnIraVmwjArnHlKJ5Wt8kolJZgAUvCGh7j5nmd50zU8AJVBnvKKsq4FlDx56Nkzu86YDuLVcAD4AsGNOxh/LXR7ELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559460; c=relaxed/simple;
	bh=jCh9W8aSvRFH5llc2+ORfAK5JSX500fcoe7YCIsoubA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmlCm64R87oSpUVfpR9vj6MFjSegQWavjsP/UNLqoRUp3fSNQNn/lShNYAT2Q7x5WmQGWxeC/yyF32/wTt/KuFNbXfi6opp77tPatS++0VmKAuaYUwafc0VABdwBFQXxlbJbAni8pgE83gaAUfBDFctVzfS/QfG0VTGCOqLqc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGYLBH8E; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740559458; x=1772095458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCh9W8aSvRFH5llc2+ORfAK5JSX500fcoe7YCIsoubA=;
  b=ZGYLBH8ELLb6GFKI0d6Mj7qyYApFShZBr07prHtHxLc7vm10fnKtCR6i
   VIWhz4TqPmPfj4fp5t8zW7OTYYNlWK6hK7oVUrn9GYE4lAGwNzKP8DEq/
   kgyhi65IpOxZkUHDKdXCkNkuRhhGI9BgpqJ/3PGxOFjGsbZdFUGZJRvdv
   pa06H19txnW1RRjM8MN6RrSBKcSSB5qb/EGaq/KIu4RL6P7vTp22RqHJm
   Bvh7dMiV6wF8Be0L/MaWA/0KRNmzxmt2qveFA2ZMxN/GJpT4L9ryzY0+1
   qMrWsQmJyLVX3sxSCo2j3tY9BqSk7bjB7qynHGptP+NHmXMXBGkZNok0M
   g==;
X-CSE-ConnectionGUID: NHDpiLzCQ+uoq/LfVOODWQ==
X-CSE-MsgGUID: czQPaisoQWiBu5RIm9TkUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="40576089"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="out'?scan'208";a="40576089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:44:09 -0800
X-CSE-ConnectionGUID: 7BKYKK8BTFWGprvMqoyNfw==
X-CSE-MsgGUID: 6hJAUOT0QxS01f7zTcTSDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="out'?scan'208";a="121257299"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 26 Feb 2025 00:44:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7D16C1FF; Wed, 26 Feb 2025 10:44:04 +0200 (EET)
Date: Wed, 26 Feb 2025 10:44:04 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250226084404.GM3713119@black.fi.intel.com>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Em+1iO18oe4Jv6Cs"
Content-Disposition: inline
In-Reply-To: <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>


--Em+1iO18oe4Jv6Cs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Kenneth,

On Fri, Feb 14, 2025 at 09:39:33AM -0800, Kenneth Crudup wrote:
> 
> This is excellent news that you were able to reproduce it- I'd figured this
> regression would have been caught already (as I do remember this working
> before) and was worried it may have been specific to a particular piece of
> hardware (or software setup) on my system.
> 
> I'll see what I can dig up on my end, but as I'm not expert in these
> subsystems I may not be able to diagnose anything until your return.

[Back now]

My git bisect ended up to this commit:

  9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")

Adding Lukas who is the expert.

My steps to reproduce on Intel Meteor Lake based reference system are:

1. Boot the system up, nothing connected.
2. Once up, connect Thunderbolt 4 dock and Thunderbolt 3 NVMe in a chain:

  [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]

3. Authorize PCIe tunnels (whatever your distro provides, my buildroot just
    has the debugging tools so running 'tbauth -r 301')

4. Check that the PCIe topology matches the expected (lspci)

5. Enter s2idle:

  # rtcwake -s 30 -mmem

6. Once it is suspended, unplug the cable between the host and the dock.

7. Wait for the resume to happen.

Expectation: The system wakes up fine, notices that the TB and PCIe devices
are gone, stays responsive and usable.

Actual result: Resume never completes.

I added "no_console_suspend" to the command line and the did sysrq-w to
get list of blocked tasks. I've attached it just in case it is needed.

If I revert the above commit the issue is gone. Now I'm not sure if this is
exactly the same issue that you are seeing but nevertheless this is kind of
normal use case so definitely something we should get fixed.

Lukas, if you need any more information let me know. I can reproduce this
easily.

> I also saw some DRM/connected fixes posted to Linus' master so maybe one of
> them corrects this new display-crash issue (I'm not home on my big monitor
> to be able to test yet).
> 
> -Kenny
> 
> On 2/14/25 08:29, Mika Westerberg wrote:
> > Hi,
> > 
> > On Thu, Feb 13, 2025 at 11:19:35AM -0800, Kenneth Crudup wrote:
> > > 
> > > On 2/13/25 05:59, Mika Westerberg wrote:
> > > 
> > > > Hi,
> > > 
> > > As Murphy's would have it, now my crashes are display-driver related (this
> > > is Xe, but I've also seen it with i915).
> > > 
> > > Attached here just for the heck of it, but I'll be better testing the NVMe
> > > enclosure-related failures this weekend. Stay tuned!
> > 
> > Okay, I checked quickly and no TB related crash there but I was actually
> > able to reproduce hang when I unplug the device chain during suspend. I did
> > not yet have time to look into it deeper. I'm sure this has been working
> > fine in the past as we tested all kinds of topologies including similar to
> > this.
> > 
> > I will be out next week for vacation but will continue after that if the
> > problem is not alraedy solved ;-)
> > 
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA

--Em+1iO18oe4Jv6Cs
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="6.14-hang-nvme.out"

[ 1371.331135] sysrq: Show Blocked State
[ 1371.334833] task:kworker/u56:0   state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00004000
[ 1371.345878] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[ 1371.351243] Call Trace:
[ 1371.353684]  <TASK>
[ 1371.355780]  __schedule+0x1074/0x3000
[ 1371.359428]  ? __pfx___schedule+0x10/0x10
[ 1371.363415]  ? do_raw_spin_lock+0x12f/0x270
[ 1371.367575]  ? __kasan_check_write+0x14/0x20
[ 1371.371818]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1371.376316]  ? __kasan_check_read+0x11/0x20
[ 1371.380471]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1371.384711]  schedule+0x78/0x320
[ 1371.387924]  schedule_preempt_disabled+0x18/0x30
[ 1371.392509]  __mutex_lock.constprop.0+0x989/0x15d0
[ 1371.397270]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
[ 1371.402454]  ? __kasan_check_write+0x14/0x20
[ 1371.406694]  ? __pfx_mutex_unlock+0x10/0x10
[ 1371.410850]  __mutex_lock_slowpath+0x13/0x20
[ 1371.415089]  mutex_lock+0xcd/0xe0
[ 1371.418383]  ? __pfx_mutex_lock+0x10/0x10
[ 1371.422366]  ? __pfx___flush_workqueue+0x10/0x10
[ 1371.426950]  acpi_device_hotplug+0x85/0xa20
[ 1371.431110]  ? __pfx_acpi_device_hotplug+0x10/0x10
[ 1371.435870]  acpi_hotplug_work_fn+0x5e/0x90
[ 1371.440026]  process_one_work+0x640/0xeb0
[ 1371.444006]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1371.448503]  ? __pfx___timer_delete_sync+0x10/0x10
[ 1371.453261]  worker_thread+0x5ec/0x1050
[ 1371.457078]  ? __pfx_worker_thread+0x10/0x10
[ 1371.461319]  kthread+0x384/0x7e0
[ 1371.464528]  ? __pfx_kthread+0x10/0x10
[ 1371.468253]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1371.472581]  ? calculate_sigpending+0x77/0xa0
[ 1371.476909]  ? __pfx_kthread+0x10/0x10
[ 1371.480632]  ret_from_fork+0x3a/0x80
[ 1371.484188]  ? __pfx_kthread+0x10/0x10
[ 1371.487912]  ret_from_fork_asm+0x1a/0x30
[ 1371.491811]  </TASK>
[ 1371.494089] task:irq/123-pciehp  state:D stack:0     pid:140   tgid:140   ppid:2      task_flags:0x288040 flags:0x00004000
[ 1371.505034] Call Trace:
[ 1371.507470]  <TASK>
[ 1371.509563]  __schedule+0x1074/0x3000
[ 1371.513204]  ? __pfx___schedule+0x10/0x10
[ 1371.517187]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1371.521687]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.526612]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1371.530853]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.535780]  schedule+0x78/0x320
[ 1371.538988]  __synchronize_irq+0x160/0x1d0
[ 1371.543059]  ? __pfx___synchronize_irq+0x10/0x10
[ 1371.547645]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1371.552832]  free_irq+0x2db/0x860
[ 1371.556127]  pcie_shutdown_notification+0xed/0x1a0
[ 1371.560887]  pciehp_remove+0x45/0xa0
[ 1371.564444]  pcie_port_remove_service+0x6a/0xa0
[ 1371.568944]  device_remove+0x118/0x170
[ 1371.572671]  device_release_driver_internal+0x3c1/0x570
[ 1371.577857]  ? klist_devices_put+0x31/0x50
[ 1371.581925]  device_release_driver+0x12/0x20
[ 1371.586165]  bus_remove_device+0x1e8/0x3d0
[ 1371.590233]  device_del+0x398/0x960
[ 1371.593701]  ? __pfx_device_del+0x10/0x10
[ 1371.597684]  ? __kasan_check_read+0x11/0x20
[ 1371.601839]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1371.606081]  ? __pfx_remove_iter+0x10/0x10
[ 1371.610152]  device_unregister+0x17/0xa0
[ 1371.614048]  remove_iter+0x46/0x60
[ 1371.617430]  device_for_each_child+0xe5/0x170
[ 1371.621761]  ? __pfx_pciehp_is_native+0x10/0x10
[ 1371.626263]  ? __pfx_device_for_each_child+0x10/0x10
[ 1371.631193]  ? __kasan_check_read+0x11/0x20
[ 1371.635350]  pcie_portdrv_remove+0x30/0x80
[ 1371.639418]  pci_device_remove+0xa9/0x1d0
[ 1371.643402]  device_remove+0xc4/0x170
[ 1371.647044]  device_release_driver_internal+0x3c1/0x570
[ 1371.652228]  device_release_driver+0x12/0x20
[ 1371.656469]  pci_stop_bus_device+0x102/0x150
[ 1371.660709]  pci_stop_bus_device+0xa2/0x150
[ 1371.664864]  pci_stop_bus_device+0xa2/0x150
[ 1371.669018]  pci_stop_bus_device+0xca/0x150
[ 1371.673173]  pci_stop_and_remove_bus_device+0x12/0x30
[ 1371.678187]  pciehp_unconfigure_device+0x231/0x360
[ 1371.682947]  ? __pfx_pciehp_unconfigure_device+0x10/0x10
[ 1371.688221]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1371.692459]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.697385]  pciehp_disable_slot+0xfc/0x2f0
[ 1371.701540]  ? __pfx_pciehp_disable_slot+0x10/0x10
[ 1371.706300]  ? __pfx_mutex_unlock+0x10/0x10
[ 1371.710455]  ? mutex_lock_interruptible+0xc0/0xe0
[ 1371.715127]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.720055]  pciehp_handle_presence_or_link_change+0x114/0xa00
[ 1371.725842]  ? down_read+0x110/0x480
[ 1371.729395]  ? __pfx___synchronize_hardirq+0x10/0x10
[ 1371.734323]  ? __pfx_pciehp_handle_presence_or_link_change+0x10/0x10
[ 1371.740625]  pciehp_ist+0x23b/0x380
[ 1371.744090]  ? __pfx_pciehp_ist+0x10/0x10
[ 1371.748071]  irq_thread_fn+0x89/0x160
[ 1371.751714]  irq_thread+0x33b/0x580
[ 1371.755180]  ? __pfx_irq_thread_fn+0x10/0x10
[ 1371.759420]  ? __pfx_irq_thread+0x10/0x10
[ 1371.763402]  ? __pfx_irq_thread_dtor+0x10/0x10
[ 1371.767812]  ? __kasan_check_read+0x11/0x20
[ 1371.771967]  ? __kthread_parkme+0x8f/0x160
[ 1371.776036]  ? __pfx_irq_thread+0x10/0x10
[ 1371.780020]  kthread+0x384/0x7e0
[ 1371.783227]  ? __pfx_kthread+0x10/0x10
[ 1371.786951]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1371.791277]  ? calculate_sigpending+0x77/0xa0
[ 1371.795606]  ? __pfx_kthread+0x10/0x10
[ 1371.799327]  ret_from_fork+0x3a/0x80
[ 1371.802882]  ? __pfx_kthread+0x10/0x10
[ 1371.806607]  ret_from_fork_asm+0x1a/0x30
[ 1371.810503]  </TASK>
[ 1371.812759] task:irq/217-pciehp  state:D stack:0     pid:548   tgid:548   ppid:2      task_flags:0x208040 flags:0x00004000
[ 1371.823705] Call Trace:
[ 1371.826142]  <TASK>
[ 1371.828232]  __schedule+0x1074/0x3000
[ 1371.831876]  ? __pfx___schedule+0x10/0x10
[ 1371.835859]  ? __kasan_check_write+0x14/0x20
[ 1371.840102]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1371.844602]  ? __pfx_osq_unlock+0x10/0x10
[ 1371.848587]  schedule+0x78/0x320
[ 1371.851794]  schedule_preempt_disabled+0x18/0x30
[ 1371.856381]  __mutex_lock.constprop.0+0x989/0x15d0
[ 1371.861137]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
[ 1371.866323]  ? __pfx___dynamic_dev_dbg+0x10/0x10
[ 1371.870908]  ? up_read+0x215/0x7b0
[ 1371.874292]  __mutex_lock_slowpath+0x13/0x20
[ 1371.878532]  mutex_lock+0xcd/0xe0
[ 1371.881827]  ? __pfx_mutex_lock+0x10/0x10
[ 1371.885813]  ? __pfx_pci_dev_set_disconnected+0x10/0x10
[ 1371.891000]  pci_lock_rescan_remove+0x15/0x20
[ 1371.895332]  pciehp_unconfigure_device+0x185/0x360
[ 1371.900087]  ? __pfx_pciehp_unconfigure_device+0x10/0x10
[ 1371.905359]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1371.909598]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.914527]  pciehp_disable_slot+0xfc/0x2f0
[ 1371.918683]  ? __pfx_pciehp_disable_slot+0x10/0x10
[ 1371.923441]  ? __pfx_mutex_unlock+0x10/0x10
[ 1371.927597]  ? mutex_lock_interruptible+0xc0/0xe0
[ 1371.932265]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1371.937194]  pciehp_handle_presence_or_link_change+0x114/0xa00
[ 1371.942979]  ? down_read+0x110/0x480
[ 1371.946532]  ? __pfx___synchronize_hardirq+0x10/0x10
[ 1371.951462]  ? __pfx_pciehp_handle_presence_or_link_change+0x10/0x10
[ 1371.957763]  pciehp_ist+0x23b/0x380
[ 1371.961230]  ? kfree+0x106/0x3b0
[ 1371.964438]  ? __pfx_pciehp_ist+0x10/0x10
[ 1371.968420]  irq_thread_fn+0x89/0x160
[ 1371.972062]  irq_thread+0x33b/0x580
[ 1371.975532]  ? __pfx_irq_thread_fn+0x10/0x10
[ 1371.979770]  ? __pfx_irq_thread+0x10/0x10
[ 1371.983752]  ? __pfx_irq_thread_dtor+0x10/0x10
[ 1371.988162]  ? __kasan_check_read+0x11/0x20
[ 1371.992318]  ? __kthread_parkme+0x8f/0x160
[ 1371.996385]  ? __pfx_irq_thread+0x10/0x10
[ 1372.000367]  kthread+0x384/0x7e0
[ 1372.003575]  ? __pfx_kthread+0x10/0x10
[ 1372.007304]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1372.011630]  ? calculate_sigpending+0x77/0xa0
[ 1372.015954]  ? __pfx_kthread+0x10/0x10
[ 1372.019677]  ret_from_fork+0x3a/0x80
[ 1372.023230]  ? __pfx_kthread+0x10/0x10
[ 1372.026954]  ret_from_fork_asm+0x1a/0x30
[ 1372.030850]  </TASK>
[ 1372.033030] task:irq/221-pciehp  state:D stack:0     pid:551   tgid:551   ppid:2      task_flags:0x208040 flags:0x00004000
[ 1372.043974] Call Trace:
[ 1372.046411]  <TASK>
[ 1372.048503]  __schedule+0x1074/0x3000
[ 1372.052142]  ? __pfx___schedule+0x10/0x10
[ 1372.056125]  ? __kasan_check_write+0x14/0x20
[ 1372.060366]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.064865]  ? dev_printk_emit+0xa2/0xd5
[ 1372.068765]  schedule+0x78/0x320
[ 1372.071972]  schedule_preempt_disabled+0x18/0x30
[ 1372.076560]  __mutex_lock.constprop.0+0x989/0x15d0
[ 1372.081320]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
[ 1372.086505]  ? __pfx___dynamic_dev_dbg+0x10/0x10
[ 1372.091087]  ? up_read+0x215/0x7b0
[ 1372.094470]  __mutex_lock_slowpath+0x13/0x20
[ 1372.098710]  mutex_lock+0xcd/0xe0
[ 1372.102006]  ? __pfx_mutex_lock+0x10/0x10
[ 1372.105989]  ? __pfx_pci_dev_set_disconnected+0x10/0x10
[ 1372.111175]  pci_lock_rescan_remove+0x15/0x20
[ 1372.115504]  pciehp_unconfigure_device+0x185/0x360
[ 1372.120262]  ? __pfx_pciehp_unconfigure_device+0x10/0x10
[ 1372.125531]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1372.129773]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1372.134700]  pciehp_disable_slot+0xfc/0x2f0
[ 1372.138856]  ? __pfx_pciehp_disable_slot+0x10/0x10
[ 1372.143614]  ? __pfx_mutex_unlock+0x10/0x10
[ 1372.147767]  ? mutex_lock_interruptible+0xc0/0xe0
[ 1372.152434]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1372.157363]  pciehp_handle_presence_or_link_change+0x114/0xa00
[ 1372.163152]  ? down_read+0x110/0x480
[ 1372.166703]  ? __pfx___synchronize_hardirq+0x10/0x10
[ 1372.171631]  ? __pfx_pciehp_handle_presence_or_link_change+0x10/0x10
[ 1372.177934]  pciehp_ist+0x23b/0x380
[ 1372.181400]  ? kfree+0x106/0x3b0
[ 1372.184608]  ? __pfx_pciehp_ist+0x10/0x10
[ 1372.188590]  irq_thread_fn+0x89/0x160
[ 1372.192232]  irq_thread+0x33b/0x580
[ 1372.195697]  ? __pfx_irq_thread_fn+0x10/0x10
[ 1372.199938]  ? __pfx_irq_thread+0x10/0x10
[ 1372.203922]  ? __pfx_irq_thread_dtor+0x10/0x10
[ 1372.208332]  ? __kasan_check_read+0x11/0x20
[ 1372.212486]  ? __kthread_parkme+0x8f/0x160
[ 1372.216553]  ? __pfx_irq_thread+0x10/0x10
[ 1372.220536]  kthread+0x384/0x7e0
[ 1372.223744]  ? __pfx_kthread+0x10/0x10
[ 1372.227468]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1372.231798]  ? calculate_sigpending+0x77/0xa0
[ 1372.236128]  ? __pfx_kthread+0x10/0x10
[ 1372.239851]  ret_from_fork+0x3a/0x80
[ 1372.243404]  ? __pfx_kthread+0x10/0x10
[ 1372.247129]  ret_from_fork_asm+0x1a/0x30
[ 1372.251031]  </TASK>
[ 1372.253210] task:rtcwake         state:D stack:0     pid:570   tgid:570   ppid:375    task_flags:0x80400000 flags:0x00004002
[ 1372.264324] Call Trace:
[ 1372.266764]  <TASK>
[ 1372.268855]  __schedule+0x1074/0x3000
[ 1372.272493]  ? __pfx___schedule+0x10/0x10
[ 1372.276475]  ? __kasan_check_write+0x14/0x20
[ 1372.280716]  ? do_raw_spin_lock+0x12f/0x270
[ 1372.284871]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.289371]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1372.293611]  ? __kasan_check_read+0x11/0x20
[ 1372.297766]  schedule+0x78/0x320
[ 1372.300979]  async_synchronize_cookie_domain+0x1af/0x210
[ 1372.306252]  ? __pfx_async_synchronize_cookie_domain+0x10/0x10
[ 1372.312038]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[ 1372.316967]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1372.322154]  ? mutex_unlock+0x83/0xd0
[ 1372.325796]  ? __pfx_mutex_unlock+0x10/0x10
[ 1372.329954]  ? __pfx_mutex_lock+0x10/0x10
[ 1372.333938]  async_synchronize_full+0x17/0x20
[ 1372.338268]  dpm_resume+0x256/0x5c0
[ 1372.341733]  ? __pfx_dpm_resume+0x10/0x10
[ 1372.345716]  ? __pfx_dpm_resume_early+0x10/0x10
[ 1372.350219]  ? acpi_set_gpe_wake_mask+0x172/0x250
[ 1372.354888]  dpm_resume_end+0x11/0x30
[ 1372.358529]  suspend_devices_and_enter+0x371/0x11a0
[ 1372.363379]  ? __pfx_suspend_devices_and_enter+0x10/0x10
[ 1372.368653]  pm_suspend+0x2a7/0xaa0
[ 1372.372117]  state_store+0xaa/0x150
[ 1372.375584]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1372.379918]  kobj_attr_store+0x36/0x70
[ 1372.383643]  ? __pfx_mutex_lock+0x10/0x10
[ 1372.387626]  ? __pfx_kobj_attr_store+0x10/0x10
[ 1372.392042]  sysfs_kf_write+0x122/0x1c0
[ 1372.395856]  ? __kasan_check_write+0x14/0x20
[ 1372.400098]  kernfs_fop_write_iter+0x321/0x4d0
[ 1372.404517]  vfs_write+0x5be/0xf40
[ 1372.407903]  ? __pfx_vfs_write+0x10/0x10
[ 1372.411803]  ? do_sys_openat2+0x115/0x170
[ 1372.415789]  ? __kasan_check_read+0x11/0x20
[ 1372.419944]  ? fdget_pos+0x1be/0x4c0
[ 1372.423497]  ? __rseq_handle_notify_resume+0x49b/0xaf0
[ 1372.428600]  ksys_write+0x106/0x200
[ 1372.432064]  ? __pfx_ksys_write+0x10/0x10
[ 1372.436046]  ? __pfx___x64_sys_openat+0x10/0x10
[ 1372.440545]  __x64_sys_write+0x72/0xb0
[ 1372.444269]  ? syscall_exit_to_user_mode+0x54/0x190
[ 1372.449109]  x64_sys_call+0x28f/0x1d70
[ 1372.452832]  do_syscall_64+0x4b/0x110
[ 1372.456475]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1372.461496] RIP: 0033:0x7fe7c939b25e
[ 1372.465051] RSP: 002b:00007ffde0114988 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 1372.472560] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe7c939b25e
[ 1372.479634] RDX: 0000000000000003 RSI: 00007ffde0116e90 RDI: 0000000000000004
[ 1372.486708] RBP: 00007ffde0116e90 R08: 0000000000000000 R09: 0000000000000000
[ 1372.493784] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[ 1372.500858] R13: 00007fe7c92d86c8 R14: 00005647ef246e7b R15: 0000000000000000
[ 1372.507934]  </TASK>
[ 1372.510116] task:kworker/u57:6   state:D stack:0     pid:575   tgid:575   ppid:2      task_flags:0x4208060 flags:0x00004000
[ 1372.521146] Workqueue: async async_run_entry_fn
[ 1372.525646] Call Trace:
[ 1372.528087]  <TASK>
[ 1372.530178]  __schedule+0x1074/0x3000
[ 1372.533821]  ? __pfx___schedule+0x10/0x10
[ 1372.537803]  ? __kasan_check_write+0x14/0x20
[ 1372.542044]  ? do_raw_spin_lock+0x12f/0x270
[ 1372.546199]  ? timerqueue_add+0x160/0x340
[ 1372.550186]  ? __kasan_check_read+0x11/0x20
[ 1372.554339]  schedule+0x78/0x320
[ 1372.557552]  schedule_timeout+0x16c/0x1f0
[ 1372.561534]  ? __pfx_schedule_timeout+0x10/0x10
[ 1372.566034]  ? do_raw_spin_lock+0x12f/0x270
[ 1372.570190]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.574689]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.579189]  ? __kasan_check_read+0x11/0x20
[ 1372.583346]  __wait_for_common+0x344/0x550
[ 1372.587414]  ? __pfx_schedule_timeout+0x10/0x10
[ 1372.591913]  ? __pfx___wait_for_common+0x10/0x10
[ 1372.596500]  ? mutex_unlock+0x83/0xd0
[ 1372.600142]  ? __pfx_mutex_unlock+0x10/0x10
[ 1372.604299]  ? __pfx_mutex_lock+0x10/0x10
[ 1372.608283]  wait_for_completion+0x24/0x30
[ 1372.612350]  dpm_wait_for_superior+0x301/0x430
[ 1372.616762]  device_resume+0xd6/0x7d0
[ 1372.620404]  async_resume+0x1d/0x30
[ 1372.623870]  async_run_entry_fn+0x95/0x520
[ 1372.627938]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1372.632180]  process_one_work+0x640/0xeb0
[ 1372.636162]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.640659]  ? __pfx___timer_delete_sync+0x10/0x10
[ 1372.645418]  worker_thread+0x5ec/0x1050
[ 1372.649232]  ? __pfx_worker_thread+0x10/0x10
[ 1372.653471]  kthread+0x384/0x7e0
[ 1372.656677]  ? __pfx_kthread+0x10/0x10
[ 1372.660401]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1372.664730]  ? calculate_sigpending+0x77/0xa0
[ 1372.669058]  ? __pfx_kthread+0x10/0x10
[ 1372.672781]  ret_from_fork+0x3a/0x80
[ 1372.676336]  ? __pfx_kthread+0x10/0x10
[ 1372.680061]  ret_from_fork_asm+0x1a/0x30
[ 1372.683962]  </TASK>
[ 1372.686152] task:kworker/u57:52  state:D stack:0     pid:630   tgid:630   ppid:2      task_flags:0x4208060 flags:0x00004000
[ 1372.697180] Workqueue: async async_run_entry_fn
[ 1372.701679] Call Trace:
[ 1372.704120]  <TASK>
[ 1372.706211]  __schedule+0x1074/0x3000
[ 1372.709854]  ? __pfx___schedule+0x10/0x10
[ 1372.713835]  ? __kasan_check_write+0x14/0x20
[ 1372.718077]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.722584]  ? schedule+0x232/0x320
[ 1372.726050]  schedule+0x78/0x320
[ 1372.729263]  schedule_preempt_disabled+0x18/0x30
[ 1372.733848]  __mutex_lock.constprop.0+0x989/0x15d0
[ 1372.738605]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
[ 1372.743789]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1372.748118]  ? __pfx_schedule_timeout+0x10/0x10
[ 1372.752616]  ? __pfx___wait_for_common+0x10/0x10
[ 1372.757198]  ? mutex_unlock+0x83/0xd0
[ 1372.760840]  __mutex_lock_slowpath+0x13/0x20
[ 1372.765079]  mutex_lock+0xcd/0xe0
[ 1372.768375]  ? __pfx_mutex_lock+0x10/0x10
[ 1372.772360]  device_resume+0x1d7/0x7d0
[ 1372.776084]  async_resume+0x1d/0x30
[ 1372.779551]  async_run_entry_fn+0x95/0x520
[ 1372.783619]  ? do_raw_spin_unlock+0x59/0x1f0
[ 1372.787859]  process_one_work+0x640/0xeb0
[ 1372.791843]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1372.796341]  ? __pfx___timer_delete_sync+0x10/0x10
[ 1372.801096]  worker_thread+0x5ec/0x1050
[ 1372.804908]  ? __pfx_worker_thread+0x10/0x10
[ 1372.809150]  kthread+0x384/0x7e0
[ 1372.812358]  ? __pfx_kthread+0x10/0x10
[ 1372.816081]  ? _raw_spin_unlock_irq+0x1e/0x40
[ 1372.820408]  ? calculate_sigpending+0x77/0xa0
[ 1372.824738]  ? __pfx_kthread+0x10/0x10
[ 1372.828461]  ret_from_fork+0x3a/0x80
[ 1372.832016]  ? __pfx_kthread+0x10/0x10
[ 1372.835742]  ret_from_fork_asm+0x1a/0x30
[ 1372.839639]  </TASK>

--Em+1iO18oe4Jv6Cs--

