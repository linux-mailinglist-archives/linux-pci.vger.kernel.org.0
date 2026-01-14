Return-Path: <linux-pci+bounces-44721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC2D1DAFD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2286730184DA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1534D4F9;
	Wed, 14 Jan 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vO8aHnkC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C553344053
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384012; cv=none; b=PgaLVU6IA4kQh1wK0RYBMzGKVKVDxw25mv8CbpM7nfvMYzOFvAeYO4d/l7uECGS3wVQJq0Mr98vusFdHSchI+qRnkBJslWG+CGmVcbidtortmVG2KomxIqKo6ckwMIs0lVPfJzVWmxFRxOgVxKVTwVZBMNmZUalE+dbFRG0/vTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384012; c=relaxed/simple;
	bh=YoUzpjiwSHQHKnLQhRNFBZjqwf6KbjGHbhPpygEEd4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=a0a9kHjGLcyW889ocXsWusZwu7VacjD/f4KgupEbWtOfgr9zdnEPGZPEhB6nrId52o2JYmGvmoq9qV/nS3TIw86qAvLcDRjE3loq0mgyusZGHeEM5AV3ExhxOHF0U6LxOCPY6A7BCFTESCzctYTS5BUcLn6w/5I66lpUTBSiFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vO8aHnkC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260114094643euoutp023507a54ed957fdfccc631b7be3098ff5~Kj_HCdm320490004900euoutp02o
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 09:46:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260114094643euoutp023507a54ed957fdfccc631b7be3098ff5~Kj_HCdm320490004900euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768384003;
	bh=vcbw9FAPfHKSX7Cf5g6n+Cat1FIS/UsHz6bh5ekBT7A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vO8aHnkCQkucBPRhQrIWXuLaX7/NZl4vD7p/o+RBLywwA+2jKMRH2beMQujSYR2dM
	 bQn4JiwCdE6sxggWfjthgok1TeayKob5WQVEq5vzFaIN2kHUwIUDtZiP2rMjVMmsjs
	 OSJU0Dzof1gFGrz4yHp+rrVjEOY3L26vwqSqUqN0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8~Kj_G018ql2551525515eucas1p1x;
	Wed, 14 Jan 2026 09:46:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260114094642eusmtip1f045e967704be91047301f2e9531c9f7~Kj_GIgECU2432024320eusmtip1g;
	Wed, 14 Jan 2026 09:46:42 +0000 (GMT)
Message-ID: <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
Date: Wed, 14 Jan 2026 10:46:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Bjorn Helgaas <helgaas@kernel.org>, Brian Norris
	<briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260106222715.GA381397@bhelgaas>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
X-EPHeader: CA
X-CMS-RootMailID: 20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8
References: <20260106222715.GA381397@bhelgaas>
	<CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>

On 06.01.2026 23:27, Bjorn Helgaas wrote:
> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
>> Today, it's possible for a PCI device to be created and
>> runtime-suspended before it is fully initialized. When that happens, the
>> device will remain in D0, but the suspend process may save an
>> intermediate version of that device's state -- for example, without
>> appropriate BAR configuration. When the device later resumes, we'll
>> restore invalid PCI state and the device may not function.
>>
>> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
>> until we've fully initialized the device.
>>
>> More details on how exactly this may occur:
>>
>> 1. PCI device is created by pci_scan_slot() or similar
>> 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
>>     device starts "active" and we initially prevent (pm_runtime_forbid())
>>     suspend -- but see [*] footnote
>> 3. Underlying 'struct device' is added to the system (device_add());
>>     runtime PM can now be configured by user space
>> 4. PCI device receives BAR configuration
>>     (pci_assign_unassigned_bus_resources(), etc.)
>> 5. PCI device is added to the system in pci_bus_add_device()
>>
>> The device may potentially suspend between #3 and #4.
>>
>> [*] By default, pm_runtime_forbid() prevents suspending a device; but by
>> design [**], this can be overridden by user space policy via
>>
>>    echo auto > /sys/bus/pci/devices/.../power/control
>>
>> Thus, the above #3/#4 sequence is racy with user space (udev or
>> similar).
>>
>> Notably, many PCI devices are enumerated at subsys_initcall time and so
>> will not race with user space. However, there are several scenarios
>> where PCI devices are created later on, such as with hotplug or when
>> drivers (pwrctrl or controller drivers) are built as modules.
>>
>>    ---
>>
>> [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
>> /sys/.../power/control, and the runtime PM usage counter can be subtle.
>> It appears that the intention of pm_runtime_forbid() /
>> pm_runtime_allow() is twofold:
>>
>> 1. Allow the user to disable runtime_pm (force device to always be
>>     powered on) through sysfs.
>> 2. Allow the driver to start with runtime_pm disabled (device forced
>>     on) and user space could later enable runtime_pm.
>>
>> This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
>> specifically the section starting "The user space can effectively
>> disallow".
>>
>> This means that while pm_runtime_forbid() does technically increase the
>> runtime PM usage counter, this usage counter is not a guarantee of
>> functional correctness, because sysfs can decrease that count again.
>>
>>    ---
>>
>> Note that we also move pm_runtime_set_active(), but leave
>> pm_runtime_forbid() in place earlier in the initialization sequence, to
>> avoid confusing user space. From Documentation/power/runtime_pm.rst:
>>
>>    "It should be noted, however, that if the user space has already
>>    intentionally changed the value of /sys/devices/.../power/control to
>>    "auto" to allow the driver to power manage the device at run time, the
>>    driver may confuse it by using pm_runtime_forbid() this way."
>>
>> Thus, we should ensure pm_runtime_forbid() is called before the device
>> is available to user space.
>>
>> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Cc: <stable@vger.kernel.org>
>> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Applied to pci/pm for v6.20, thanks!  I tried to simplify the commit
> log so the issue isn't hidden by details.  Happy to restore things if
> I trimmed too much:
>
>      PCI/PM: Prevent runtime suspend until devices are fully initialized
>
>      Previously, it was possible for a PCI device to be runtime-suspended before
>      it was fully initialized. When that happened, the suspend process could
>      save invalid device state, for example, before BAR assignment. Restoring
>      the invalid state during resume may leave the device non-functional.
>
>      Prevent runtime suspend for PCI devices until they are fully initialized by
>      deferring pm_runtime_enable().
>
>      More details on how exactly this may occur:
>
>        1. PCI device is created by pci_scan_slot() or similar
>
>        2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
>           prevents runtime suspend prevented via pm_runtime_forbid()
>
>        3. pci_device_add() adds the underlying 'struct device' via device_add(),
>           which means user space can allow runtime suspend, e.g.,
>
>             echo auto > /sys/bus/pci/devices/.../power/control
>
>        4. PCI device receives BAR configuration
>           (pci_assign_unassigned_bus_resources(), etc.)
>
>        5. pci_bus_add_device() applies final fixups, saves device state, and
>           tries to attach a driver
>
>      The device may potentially be suspended between #3 and #5, so this is racy
>      with user space (udev or similar).
>
>      Many PCI devices are enumerated at subsys_initcall time and so will not
>      race with user space, but devices created later by hotplug or modular
>      pwrctrl or host controller drivers are susceptible to this race.
>
>      More runtime PM details at the first Link: below.
>
>      Signed-off-by: Brian Norris <briannorris@chromium.org>
>      [bhelgaas: simplify commit log]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>      Cc: stable@vger.kernel.org
>      Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
>      Link: https://patch.msgid.link/20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid

This patch landed recently in linux-next as commit c796513dc54e 
("PCI/PM: Prevent runtime suspend until devices are fully initialized"). 
In my tests I found that it sometimes causes the "pci 0000:01:00.0: 
runtime PM trying to activate child device 0000:01:00.0 but parent 
(0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board 
(arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a 
lockdep warning about console lock, but this is just a consequence of 
the runtime pm warning. Reverting $subject patch on top of current 
linux-next hides this warning.

Here is a kernel log:

pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 
GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s 
PCIe x1 link)
pci 0000:01:00.0: Adding to iommu group 13
pci 0000:01:00.0: ASPM: default states L0s L1
pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
pci 0000:01:00.0: runtime PM trying to activate child device 
0000:01:00.0 but parent (0000:00:00.0) is not active

======================================================
WARNING: possible circular locking dependency detected
6.19.0-rc1+ #16398 Not tainted
------------------------------------------------------
kworker/3:0/33 is trying to acquire lock:
ffffcd182ff1ae98 (console_owner){..-.}-{0:0}, at: 
console_lock_spinning_enable+0x44/0x78

but task is already holding lock:
ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
__pm_runtime_set_status+0x240/0x384

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&dev->power.lock/1){....}-{3:3}:
        _raw_spin_lock_nested+0x44/0x5c
        __pm_runtime_set_status+0x240/0x384
        arm_smmu_device_probe+0xbe0/0xe5c
        platform_probe+0x5c/0xac
        really_probe+0xbc/0x298
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0x40/0x164
        __driver_attach+0x9c/0x1ac
        bus_for_each_dev+0x74/0xd0
        driver_attach+0x24/0x30
        bus_add_driver+0xe4/0x208
        driver_register+0x60/0x128
        __platform_driver_register+0x24/0x30
        arm_smmu_driver_init+0x20/0x2c
        do_one_initcall+0x64/0x308
        kernel_init_freeable+0x284/0x500
        kernel_init+0x20/0x1d8
        ret_from_fork+0x10/0x20

-> #2 (&dev->power.lock){-...}-{3:3}:
        _raw_spin_lock_irqsave+0x60/0x88
        __pm_runtime_resume+0x4c/0xbc
        __uart_start+0x4c/0x114
        uart_write+0x98/0x278
        n_tty_write+0x1dc/0x4f0
        file_tty_write.constprop.0+0x12c/0x2bc
        redirected_tty_write+0xc0/0x108
        do_iter_readv_writev+0xdc/0x1c0
        vfs_writev+0xf0/0x280
        do_writev+0x74/0x13c
        __arm64_sys_writev+0x20/0x2c
        invoke_syscall+0x48/0x10c
        el0_svc_common.constprop.0+0x40/0xe8
        do_el0_svc+0x20/0x2c
        el0_svc+0x50/0x2e8
        el0t_64_sync_handler+0xa0/0xe4
        el0t_64_sync+0x198/0x19c

-> #1 (&port_lock_key){-.-.}-{3:3}:
        _raw_spin_lock_irqsave+0x60/0x88
        qcom_geni_serial_console_write+0x50/0x344
        console_flush_one_record+0x33c/0x474
        console_unlock+0x80/0x14c
        vprintk_emit+0x258/0x3d0
        vprintk_default+0x38/0x44
        vprintk+0x28/0x34
        _printk+0x5c/0x84
        register_console+0x278/0x510
        serial_core_register_port+0x6cc/0x79c
        serial_ctrl_register_port+0x10/0x1c
        uart_add_one_port+0x10/0x1c
        qcom_geni_serial_probe+0x2c0/0x448
        platform_probe+0x5c/0xac
        really_probe+0xbc/0x298
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0x40/0x164
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1b0
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        device_add+0x540/0x720
        of_device_add+0x44/0x60
        of_platform_device_create_pdata+0x90/0x11c
        of_platform_bus_create+0x17c/0x394
        of_platform_populate+0x58/0xf8
        devm_of_platform_populate+0x58/0xbc
        geni_se_probe+0xdc/0x164
        platform_probe+0x5c/0xac
        really_probe+0xbc/0x298
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0x40/0x164
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1b0
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        deferred_probe_work_func+0x8c/0xc8
        process_one_work+0x208/0x604
        worker_thread+0x244/0x388
        kthread+0x150/0x228
        ret_from_fork+0x10/0x20

-> #0 (console_owner){..-.}-{0:0}:
        __lock_acquire+0x1408/0x2254
        lock_acquire+0x1c8/0x354
        console_lock_spinning_enable+0x68/0x78
        console_flush_one_record+0x300/0x474
        console_unlock+0x80/0x14c
        vprintk_emit+0x258/0x3d0
        dev_vprintk_emit+0xd8/0x1a0
        dev_printk_emit+0x58/0x80
        __dev_printk+0x3c/0x88
        _dev_err+0x60/0x88
        __pm_runtime_set_status+0x28c/0x384
        pci_bus_add_device+0xa4/0x18c
        pci_bus_add_devices+0x3c/0x88
        pci_bus_add_devices+0x68/0x88
        pci_rescan_bus+0x30/0x44
        rescan_work_func+0x28/0x3c
        process_one_work+0x208/0x604
        worker_thread+0x244/0x388
        kthread+0x150/0x228
        ret_from_fork+0x10/0x20

other info that might help us debug this:

Chain exists of:
   console_owner --> &dev->power.lock --> &dev->power.lock/1

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dev->power.lock/1);
                                lock(&dev->power.lock);
lock(&dev->power.lock/1);
   lock(console_owner);

  *** DEADLOCK ***

7 locks held by kworker/3:0/33:
  #0: ffff00008000d948 ((wq_completion)events){+.+.}-{0:0}, at: 
process_one_work+0x18c/0x604
  #1: ffff8000802a3de0 ((work_completion)(&pwrctrl->work)){+.+.}-{0:0}, 
at: process_one_work+0x1b4/0x604
  #2: ffffcd18301138e8 (pci_rescan_remove_lock){+.+.}-{4:4}, at: 
pci_lock_rescan_remove+0x1c/0x28
  #3: ffff00008ac8a238 (&dev->power.lock){-...}-{3:3}, at: 
__pm_runtime_set_status+0x1d4/0x384
  #4: ffff0000835c5238 (&dev->power.lock/1){....}-{3:3}, at: 
__pm_runtime_set_status+0x240/0x384
  #5: ffffcd182ff1ac78 (console_lock){+.+.}-{0:0}, at: 
dev_vprintk_emit+0xd8/0x1a0
  #6: ffffcd182ff1acd8 (console_srcu){....}-{0:0}, at: 
console_flush_one_record+0x0/0x474

stack backtrace:
CPU: 3 UID: 0 PID: 33 Comm: kworker/3:0 Not tainted 6.19.0-rc1+ #16398 
PREEMPT
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events rescan_work_func
Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  print_circular_bug+0x298/0x37c
  check_noncircular+0x15c/0x170
  __lock_acquire+0x1408/0x2254
  lock_acquire+0x1c8/0x354
  console_lock_spinning_enable+0x68/0x78
  console_flush_one_record+0x300/0x474
  console_unlock+0x80/0x14c
  vprintk_emit+0x258/0x3d0
  dev_vprintk_emit+0xd8/0x1a0
  dev_printk_emit+0x58/0x80
  __dev_printk+0x3c/0x88
  _dev_err+0x60/0x88
  __pm_runtime_set_status+0x28c/0x384
  pci_bus_add_device+0xa4/0x18c
  pci_bus_add_devices+0x3c/0x88
  pci_bus_add_devices+0x68/0x88
  pci_rescan_bus+0x30/0x44
  rescan_work_func+0x28/0x3c
  process_one_work+0x208/0x604
  worker_thread+0x244/0x388
  kthread+0x150/0x228
  ret_from_fork+0x10/0x20

This looks a bit similar to the issue reported some time ago on a 
different board:

https://lore.kernel.org/all/6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com/

Let me know if I can somehow help debugging this.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


