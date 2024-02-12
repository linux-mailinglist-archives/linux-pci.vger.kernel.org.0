Return-Path: <linux-pci+bounces-3334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C855850CBD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 02:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811561C22D84
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182AA110A;
	Mon, 12 Feb 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="ubyqtIz8"
X-Original-To: linux-pci@vger.kernel.org
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C710E5
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707702065; cv=none; b=agI1/ytj6sYNorNYb21VmHQqk0CEE0YHJ/TEZAsaqQIXzjQ/8yOpSpn5dtrorelJUYtWjoyPKhTkpbsOVXobnH0wNjzgu2GOS4GUwHpsDdGLSNgeqoZ7r2zue9vPBEjBs8X6MY9mQ4B2Yo+5g5L9oNxzDVbUP2+V701XWDYNwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707702065; c=relaxed/simple;
	bh=M8GEIEm2VlAvjrIvQ13DGAWlvecfvS13fTGUQcOb+70=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=URD+lD7GiJYsvjU+yMNEW5VfHHtS9BnNU9968D5Y09k9CJk4UvOkH9ldCJv1N1l6YRO0LdyrN6g4i5uK8uy0ZnUd9y4WEfUtEWJbME0r4V4IxFxyPxqB7tOj6Igm2oGrlNvTPk4hvCfsh8WfC0f5rQEVJ3IVZKraEwHt4JG/Nec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=fail (0-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=ubyqtIz8 reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: (qmail 28490 invoked by uid 990); 12 Feb 2024 01:34:17 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Feb 2024 02:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Feb 2024 01:34:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <d568b479ec0592815915ecadbd76ff10f5ec9158@lausen.nl>
TLS-Required: No
Subject: Re: PROBLEM: mtk_pcie_suspend_noirq sleep hang breaking suspend on
 MT8192 Asurada Spherion
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Ryder Lee" <ryder.lee@mediatek.com>, "Jianjun Wang"
 <jianjun.wang@mediatek.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <600bf03e-3be3-e675-1d59-ecc5aaa2aefd@collabora.com>
References: <600bf03e-3be3-e675-1d59-ecc5aaa2aefd@collabora.com>
 <dd299e87-1e69-40a2-a429-fbcd2b48d2ee@lausen.nl>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from;
	bh=M8GEIEm2VlAvjrIvQ13DGAWlvecfvS13fTGUQcOb+70=;
	b=ubyqtIz8cFmwp+DevUeoMzAt2YMRooxgD5HkHPWRqI9SQ5ykeaSAk1uoVywItGtmD8IWyrLT0O
	dLmjIpVinTWX/XSoLXOnS5I7XelwwJWtFuqNH0jPTWgF14ExjfijzGHPMpWhpTngmJcKZZTi9L2P
	6KmSYy+ShKSAOEV73+nuXl59VZRhdl+3oIWWKPAXWxyWi4pbbsOJEi/gZt8m+z1MqLgP7raP/RPo
	pIGnnV4wF/xGV7VJYqvuMzOx5HocqfnFuZJGnA6cOHvJ+oMpt+SYPBetmCzn1RPHTCJ6I9rw2PsJ
	LEk9BfMcz6eVLvkHzFyYsLEa7QqsIqW3TSUJRyNoFVEj4chDMsthMz6mbH8pks6m+mPAGrWNOt8m
	59ygXzQbePky8z2NrFhF5C+TjK+likAKU1Upnq3XebEljyby+n1jBdyMWJPYdMKgvKuCo+PtnZGo
	jDknCC3IhiWrtW6GTY+2T/Qk+VstVLA8AITYBIzBUrCbWMjRNlL6w/pG6igiiCp1QQB4v5ci3bHg
	BDeqRkfCPaSPlKMCJelRsSARlLjWxld8PjXBJZHTkokf+LjvzikD8oLi9q9MiRI7MB3c3g9GipdM
	BDzxuaaTSaZK1IoQKkvsjdZt4T21xsGsFVEjNsUSQWza196GCqZVifyRdwENllgxTorTam6YneG8
	E=

Dear Angelo, Dear Maintainers,

thank you for your help supporting MT8192 platform. Unfortunataly, the is=
sue with Asurada Spherion discussed in this thread persists with v6.8-rc4=
. I'm including an updated dmesg snippet below. Please let me know if I c=
an provide any further information to help debug this issue.

Thank you
Leonard

[  688.910709] PM: suspend entry (deep)
[  688.978833] Filesystems sync: 0.064 seconds
[  688.987422] Freezing user space processes
[  688.999288] Freezing user space processes completed (elapsed 0.007 sec=
onds)
[  689.006391] OOM killer disabled.
[  689.009632] Freezing remaining freezable tasks
[  689.016980] Freezing remaining freezable tasks completed (elapsed 0.00=
2 seconds)
[  689.024376] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
[  689.181542] queueing ieee80211 work while going to suspend

[  689.301195] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  689.301197] WARNING: possible irq lock inversion dependency detected
[  689.301199] 6.8.0-rc4-cos-mt9 #1 Not tainted
[  689.301203] --------------------------------------------------------
[  689.301204] systemd-sleep/4626 just changed the state of lock:
[  689.301208] ffff610985759560 (&pcie->irq_lock){+...}-{2:2}, at: mtk_pc=
ie_suspend_noirq+0xd0/0x14c
[  689.301228] but this lock was taken by another, HARDIRQ-safe lock in t=
he past:
[  689.301230]  (&irq_desc_lock_class){-.-.}-{2:2}
[  689.301234]=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20              and interrupts could create inverse lock ordering betwee=
n them.

[  689.301236]=20
=20              other info that might help us debug this:
[  689.301238]  Possible interrupt unsafe locking scenario:

[  689.301240]        CPU0                    CPU1
[  689.301241]        ----                    ----
[  689.301242]   lock(&pcie->irq_lock);
[  689.301246]                                local_irq_disable();
[  689.301247]                                lock(&irq_desc_lock_class);
[  689.301251]                                lock(&pcie->irq_lock);
[  689.301254]   <Interrupt>
[  689.301255]     lock(&irq_desc_lock_class);
[  689.301258]=20
=20               *** DEADLOCK ***

[  689.301259] 4 locks held by systemd-sleep/4626:
[  689.301262]  #0: ffff610987c133f8 (sb_writers#6){.+.+}-{0:0}, at: vfs_=
write+0x2ac/0x340
[  689.301278]  #1: ffff610a2d9a4688 (&of->mutex){+.+.}-{3:3}, at: kernfs=
_fop_write_iter+0xf0/0x1b0
[  689.301289]  #2: ffff610980b74158 (kn->active#115){.+.+}-{0:0}, at: ke=
rnfs_fop_write_iter+0xf8/0x1b0
[  689.301300]  #3: ffffd2e4d5792cc0 (system_transition_mutex){+.+.}-{3:3=
}, at: pm_suspend+0x98/0x330
[  689.301313]=20
=20              the shortest dependencies between 2nd lock and 1st lock:
[  689.301315]  -> (&irq_desc_lock_class){-.-.}-{2:2} {
[  689.301321]     IN-HARDIRQ-W at:
[  689.301324]                       lock_acquire+0x11c/0x324
[  689.301329]                       _raw_spin_lock+0x48/0x60
[  689.301337]                       handle_fasteoi_irq+0x2c/0x23c
[  689.301342]                       generic_handle_domain_irq+0x2c/0x44
[  689.301348]                       gic_handle_irq+0x16c/0x29c
[  689.301352]                       call_on_irq_stack+0x24/0x4c
[  689.301357]                       do_interrupt_handler+0x80/0x84
[  689.301362]                       el1_interrupt+0x44/0x98
[  689.301368]                       el1h_64_irq_handler+0x18/0x24
[  689.301374]                       el1h_64_irq+0x78/0x7c
[  689.301377]                       default_idle_call+0xa0/0x14c
[  689.301381]                       do_idle+0x270/0x2d0
[  689.301387]                       cpu_startup_entry+0x38/0x3c
[  689.301392]                       rest_init+0x118/0x1a8
[  689.301395]                       arch_post_acpi_subsys_init+0x0/0x8
[  689.301403]                       start_kernel+0x5b8/0x6ac
[  689.301407]                       __primary_switched+0xb8/0xc0
[  689.301411]     IN-SOFTIRQ-W at:
[  689.301414]                       lock_acquire+0x11c/0x324
[  689.301418]                       _raw_spin_lock+0x48/0x60
[  689.301423]                       handle_fasteoi_irq+0x2c/0x23c
[  689.301427]                       generic_handle_domain_irq+0x2c/0x44
[  689.301432]                       gic_handle_irq+0x16c/0x29c
[  689.301435]                       do_interrupt_handler+0x50/0x84
[  689.301439]                       el1_interrupt+0x44/0x98
[  689.301445]                       el1h_64_irq_handler+0x18/0x24
[  689.301451]                       el1h_64_irq+0x78/0x7c
[  689.301454]                       _nohz_idle_balance.isra.0+0xd4/0x388
[  689.301458]                       run_rebalance_domains+0x64/0x74
[  689.301462]                       __do_softirq+0x148/0x518
[  689.301465]                       ____do_softirq+0x10/0x1c
[  689.301469]                       call_on_irq_stack+0x24/0x4c
[  689.301473]                       do_softirq_own_stack+0x1c/0x2c
[  689.301477]                       __irq_exit_rcu+0x12c/0x148
[  689.301484]                       irq_exit_rcu+0x10/0x38
[  689.301489]                       el1_interrupt+0x48/0x98
[  689.301495]                       el1h_64_irq_handler+0x18/0x24
[  689.301500]                       el1h_64_irq+0x78/0x7c
[  689.301503]                       default_idle_call+0xa0/0x14c
[  689.301507]                       do_idle+0x270/0x2d0
[  689.301511]                       cpu_startup_entry+0x38/0x3c
[  689.301517]                       rest_init+0x118/0x1a8
[  689.301520]                       arch_post_acpi_subsys_init+0x0/0x8
[  689.301525]                       start_kernel+0x5b8/0x6ac
[  689.301529]                       __primary_switched+0xb8/0xc0
[  689.301533]     INITIAL USE at:
[  689.301536]                      lock_acquire+0x11c/0x324
[  689.301540]                      _raw_spin_lock_irqsave+0x68/0xbc
[  689.301545]                      __irq_get_desc_lock+0x58/0x98
[  689.301551]                      irq_modify_status+0x38/0x140
[  689.301555]                      irq_set_percpu_devid+0x70/0x94
[  689.301561]                      gic_irq_domain_alloc+0x208/0x248
[  689.301568]                      irq_domain_alloc_irqs_locked+0xf8/0x3=
58
[  689.301573]                      __irq_domain_alloc_irqs+0x6c/0xc0
[  689.301578]                      gic_init_bases+0x358/0x6a4
[  689.301585]                      gic_of_init+0x290/0x31c
[  689.301589]                      of_irq_init+0x304/0x390
[  689.301596]                      irqchip_init+0x18/0x24
[  689.301601]                      init_IRQ+0xb4/0x12c
[  689.301606]                      start_kernel+0x26c/0x6ac
[  689.301610]                      __primary_switched+0xb8/0xc0
[  689.301614]   }
[  689.301615]   ... key      at: [<ffffd2e4d65b8bc0>] irq_desc_lock_clas=
s+0x0/0x10
[  689.301621]   ... acquired at:
[  689.301623]    _raw_spin_lock_irqsave+0x68/0xbc
[  689.301629]    mtk_msi_bottom_irq_unmask+0x30/0x70
[  689.301633]    irq_chip_unmask_parent+0x1c/0x28
[  689.301637]    mtk_pcie_msi_irq_unmask+0x20/0x30
[  689.301642]    irq_enable+0x40/0x8c
[  689.301645]    __irq_startup+0x78/0xa4
[  689.301649]    irq_startup+0xfc/0x164
[  689.301653]    __setup_irq+0x3f0/0x6bc
[  689.301656]    request_threaded_irq+0xec/0x1a4
[  689.301659]    pcie_pme_probe+0xf4/0x1bc
[  689.301666]    pcie_port_probe_service+0x38/0x64
[  689.301670]    really_probe+0x148/0x2ac
[  689.301676]    __driver_probe_device+0x78/0x12c
[  689.301680]    driver_probe_device+0x3c/0x160
[  689.301683]    __device_attach_driver+0xb8/0x138
[  689.301687]    bus_for_each_drv+0x80/0xdc
[  689.301691]    __device_attach+0x9c/0x188
[  689.301695]    device_initial_probe+0x14/0x20
[  689.301699]    bus_probe_device+0xac/0xb0
[  689.301702]    device_add+0x5ac/0x768
[  689.301708]    device_register+0x20/0x30
[  689.301714]    pcie_portdrv_probe+0x340/0x5c4
[  689.301718]    local_pci_probe+0x40/0xa4
[  689.301722]    pci_device_probe+0xac/0x1f0
[  689.301727]    really_probe+0x148/0x2ac
[  689.301730]    __driver_probe_device+0x78/0x12c
[  689.301734]    driver_probe_device+0x3c/0x160
[=20 689.301738]    __device_attach_driver+0xb8/0x138
[  689.301742]    bus_for_each_drv+0x80/0xdc
[  689.301745]    __device_attach+0x9c/0x188
[  689.301748]    device_attach+0x14/0x20
[  689.301752]    pci_bus_add_device+0x64/0xd4
[  689.301756]    pci_bus_add_devices+0x3c/0x88
[  689.301760]    pci_host_probe+0x44/0xbc
[  689.301764]    mtk_pcie_probe+0x288/0x47c
[  689.301768]    platform_probe+0x68/0xc0
[  689.301773]    really_probe+0x148/0x2ac
[  689.301777]    __driver_probe_device+0x78/0x12c
[  689.301781]    driver_probe_device+0x3c/0x160
[  689.301784]    __device_attach_driver+0xb8/0x138
[  689.301788]    bus_for_each_drv+0x80/0xdc
[  689.301791]    __device_attach+0x9c/0x188
[  689.301795]    device_initial_probe+0x14/0x20
[  689.301799]    bus_probe_device+0xac/0xb0
[  689.301802]    deferred_probe_work_func+0x8c/0xc8
[  689.301806]    process_one_work+0x1ec/0x4dc
[  689.301812]    worker_thread+0x1dc/0x3d4
[  689.301817]    kthread+0xfc/0x100
[  689.301821]    ret_from_fork+0x10/0x20

[  689.301826] -> (&pcie->irq_lock){+...}-{2:2} {
[  689.301832]    HARDIRQ-ON-W at:
[  689.301835]                     lock_acquire+0x11c/0x324
[  689.301839]                     _raw_spin_lock+0x48/0x60
[  689.301844]                     mtk_pcie_suspend_noirq+0xd0/0x14c
[  689.301849]                     dpm_run_callback+0x34/0x9c
[  689.301854]                     __device_suspend_noirq+0x68/0x1f0
[  689.301859]                     dpm_noirq_suspend_devices+0x1d8/0x274
[  689.301864]                     dpm_suspend_noirq+0x24/0x98
[  689.301868]                     suspend_devices_and_enter+0x3b0/0x65c
[  689.301874]                     pm_suspend+0x1fc/0x330
[  689.301880]                     state_store+0x80/0xec
[  689.301885]                     kobj_attr_store+0x18/0x2c
[  689.301889]                     sysfs_kf_write+0x4c/0x78
[  689.301893]                     kernfs_fop_write_iter+0x120/0x1b0
[  689.301896]                     vfs_write+0x224/0x340
[  689.301902]                     ksys_write+0x6c/0x100
[  689.301908]                     __arm64_sys_write+0x1c/0x28
[  689.301914]                     invoke_syscall+0x48/0x114
[  689.301920]                     el0_svc_common.constprop.0+0x40/0xe0
[  689.301926]                     do_el0_svc+0x1c/0x28
[  689.301932]                     el0_svc+0x50/0x108
[  689.301937]                     el0t_64_sync_handler+0x100/0x12c
[  689.301943]                     el0t_64_sync+0x1a4/0x1a8
[  689.301946]    INITIAL USE at:
[  689.301948]                    lock_acquire+0x11c/0x324
[  689.301952]                    _raw_spin_lock_irqsave+0x68/0xbc
[  689.301957]                    mtk_msi_bottom_irq_unmask+0x30/0x70
[  689.301962]                    irq_chip_unmask_parent+0x1c/0x28
[  689.301966]                    mtk_pcie_msi_irq_unmask+0x20/0x30
[  689.301970]                    irq_enable+0x40/0x8c
[  689.301974]                    __irq_startup+0x78/0xa4
[  689.301978]                    irq_startup+0xfc/0x164
[  689.301982]                    __setup_irq+0x3f0/0x6bc
[  689.301984]                    request_threaded_irq+0xec/0x1a4
[  689.301987]                    pcie_pme_probe+0xf4/0x1bc
[  689.301993]                    pcie_port_probe_service+0x38/0x64
[  689.301997]                    really_probe+0x148/0x2ac
[  689.302001]                    __driver_probe_device+0x78/0x12c
[  689.302004]                    driver_probe_device+0x3c/0x160
[  689.302008]                    __device_attach_driver+0xb8/0x138
[  689.302012]                    bus_for_each_drv+0x80/0xdc
[  689.302015]                    __device_attach+0x9c/0x188
[  689.302018]                    device_initial_probe+0x14/0x20
[  689.302022]                    bus_probe_device+0xac/0xb0
[  689.302026]                    device_add+0x5ac/0x768
[  689.302031]                    device_register+0x20/0x30
[  689.302037]                    pcie_portdrv_probe+0x340/0x5c4
[  689.302041]                    local_pci_probe+0x40/0xa4
[  689.302044]                    pci_device_probe+0xac/0x1f0
[  689.302048]                    really_probe+0x148/0x2ac
[  689.302052]                    __driver_probe_device+0x78/0x12c
[  689.302056]                    driver_probe_device+0x3c/0x160
[  689.302059]                    __device_attach_driver+0xb8/0x138
[  689.302063]                    bus_for_each_drv+0x80/0xdc
[  689.302066]                    __device_attach+0x9c/0x188
[  689.302070]                    device_attach+0x14/0x20
[  689.302074]                    pci_bus_add_device+0x64/0xd4
[  689.302077]                    pci_bus_add_devices+0x3c/0x88
[  689.302080]                    pci_host_probe+0x44/0xbc
[  689.302083]                    mtk_pcie_probe+0x288/0x47c
[  689.302088]                    platform_probe+0x68/0xc0
[  689.302093]                    really_probe+0x148/0x2ac
[  689.302096]                    __driver_probe_device+0x78/0x12c
[  689.302100]                    driver_probe_device+0x3c/0x160
[  689.302104]                    __device_attach_driver+0xb8/0x138
[  689.302108]                    bus_for_each_drv+0x80/0xdc
[  689.302111]                    __device_attach+0x9c/0x188
[  689.302115]                    device_initial_probe+0x14/0x20
[  689.302119]                    bus_probe_device+0xac/0xb0
[  689.302122]                    deferred_probe_work_func+0x8c/0xc8
[  689.302125]                    process_one_work+0x1ec/0x4dc
[  689.302130]                    worker_thread+0x1dc/0x3d4
[  689.302135]                    kthread+0xfc/0x100
[  689.302139]                    ret_from_fork+0x10/0x20
[  689.302143]  }
[  689.302144]  ... key      at: [<ffffd2e4d65f8690>] __key.1+0x0/0x10
[  689.302150]  ... acquired at:
[  689.302151]    __lock_acquire+0x374/0x1a10
[  689.302155]    lock_acquire+0x11c/0x324
[  689.302159]    _raw_spin_lock+0x48/0x60
[  689.302163]    mtk_pcie_suspend_noirq+0xd0/0x14c
[  689.302168]    dpm_run_callback+0x34/0x9c
[  689.302172]    __device_suspend_noirq+0x68/0x1f0
[  689.302177]    dpm_noirq_suspend_devices+0x1d8/0x274
[  689.302181]    dpm_suspend_noirq+0x24/0x98
[  689.302186]    suspend_devices_and_enter+0x3b0/0x65c
[  689.302191]    pm_suspend+0x1fc/0x330
[  689.302197]    state_store+0x80/0xec
[  689.302202]    kobj_attr_store+0x18/0x2c
[  689.302205]    sysfs_kf_write+0x4c/0x78
[  689.302209]    kernfs_fop_write_iter+0x120/0x1b0
[  689.302213]    vfs_write+0x224/0x340
[  689.302218]    ksys_write+0x6c/0x100
[  689.302224]    __arm64_sys_write+0x1c/0x28
[  689.302230]    invoke_syscall+0x48/0x114
[  689.302235]    el0_svc_common.constprop.0+0x40/0xe0
[  689.302241]    do_el0_svc+0x1c/0x28
[  689.302246]    el0_svc+0x50/0x108
[  689.302252]    el0t_64_sync_handler+0x100/0x12c
[  689.302257]    el0t_64_sync+0x1a4/0x1a8

[  689.302261]=20
=20              stack backtrace:
[  689.302264] CPU: 4 PID: 4626 Comm: systemd-sleep Not tainted 6.8.0-rc4=
-cos-mt9 #1
[  689.302268] Hardware name: Google Spherion (rev0 - 3) (DT)
[  689.302271] Call trace:
[  689.302272]  dump_backtrace+0x98/0xf0
[  689.302276]  show_stack+0x18/0x24
[  689.302279]  dump_stack_lvl+0xb8/0x118
[  689.302285]  dump_stack+0x18/0x24
[  689.302290]  print_irq_inversion_bug.part.0+0x1ec/0x27c
[  689.302294]  mark_lock+0x300/0x720
[  689.302298]  __lock_acquire+0x374/0x1a10
[  689.302301]  lock_acquire+0x11c/0x324
[  689.302305]  _raw_spin_lock+0x48/0x60
[  689.302310]  mtk_pcie_suspend_noirq+0xd0/0x14c
[  689.302315]  dpm_run_callback+0x34/0x9c
[  689.302319]  __device_suspend_noirq+0x68/0x1f0
[  689.302324]  dpm_noirq_suspend_devices+0x1d8/0x274
[  689.302328]  dpm_suspend_noirq+0x24/0x98
[  689.302332]  suspend_devices_and_enter+0x3b0/0x65c
[  689.302338]  pm_suspend+0x1fc/0x330
[  689.302343]  state_store+0x80/0xec
[  689.302348]  kobj_attr_store+0x18/0x2c
[  689.302352]  sysfs_kf_write+0x4c/0x78
[  689.302355]  kernfs_fop_write_iter+0x120/0x1b0
[  689.302359]  vfs_write+0x224/0x340
[  689.302364]  ksys_write+0x6c/0x100
[  689.302370]  __arm64_sys_write+0x1c/0x28
[=20=20689.302376]  invoke_syscall+0x48/0x114
[  689.302381]  el0_svc_common.constprop.0+0x40/0xe0
[  689.302387]  do_el0_svc+0x1c/0x28
[  689.302392]  el0_svc+0x50/0x108
[  689.302398]  el0t_64_sync_handler+0x100/0x12c
[  689.302403]  el0t_64_sync+0x1a4/0x1a8
[  689.305522] Disabling non-boot CPUs ...
[  689.309813] IRQ273: set affinity failed(-22).
[  689.309868] IRQ288: set affinity failed(-22).
[  689.309993] psci: CPU1 killed (polled 0 ms)
[  689.314674] IRQ273: set affinity failed(-22).
[  689.314725] IRQ288: set affinity failed(-22).
[  689.314832] psci: CPU2 killed (polled 0 ms)
[  689.318738] IRQ273: set affinity failed(-22).
[  689.318781] IRQ288: set affinity failed(-22).
[  689.318904] psci: CPU3 killed (polled 0 ms)
[  689.320721] IRQ273: set affinity failed(-22).
[  689.320733] IRQ288: set affinity failed(-22).
[  689.320809] psci: CPU4 killed (polled 0 ms)
[  689.322718] IRQ273: set affinity failed(-22).
[  689.322738] IRQ288: set affinity failed(-22).
[  689.322852] psci: CPU5 killed (polled 0 ms)
[  689.326646] psci: CPU6 killed (polled 0 ms)
[  689.328620] psci: CPU7 killed (polled 0 ms)
[  689.331564] Enabling non-boot CPUs ...
[  689.332951] Detected VIPT I-cache on CPU1
[  689.333012] GICv3: CPU1: found redistributor 100 region 0:0x000000000c=
060000
[  689.333079] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[  689.335992] CPU1 is up
[  689.336956] Detected VIPT I-cache on CPU2
[  689.337006] GICv3: CPU2: found redistributor 200 region 0:0x000000000c=
080000
[  689.337063] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[  689.339991] CPU2 is up
[  689.341081] Detected VIPT I-cache on CPU3
[  689.341127] GICv3: CPU3: found redistributor 300 region 0:0x000000000c=
0a0000
[  689.341179] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[  689.344328] CPU3 is up
[  689.345125] Detected PIPT I-cache on CPU4
[  689.345146] GICv3: CPU4: found redistributor 400 region 0:0x000000000c=
0c0000
[  689.345167] CPU4: Booted secondary processor 0x0000000400 [0x414fd0b0]
[  689.346438] CPU4 is up
[  689.347212] Detected PIPT I-cache on CPU5
[  689.347231] GICv3: CPU5: found redistributor 500 region 0:0x000000000c=
0e0000
[  689.347251] CPU5: Booted secondary processor 0x0000000500 [0x414fd0b0]
[  689.348409] CPU5 is up
[  689.349783] Detected PIPT I-cache on CPU6
[  689.349803] GICv3: CPU6: found redistributor 600 region 0:0x000000000c=
100000
[  689.349822] CPU6: Booted secondary processor 0x0000000600 [0x414fd0b0]
[  689.351051] CPU6 is up
[  689.351810] Detected PIPT I-cache on CPU7
[  689.351830] GICv3: CPU7: found redistributor 700 region 0:0x000000000c=
120000
[  689.351849] CPU7: Booted secondary processor 0x0000000700 [0x414fd0b0]
[  689.353144] CPU7 is up
[  691.492453] OOM killer enabled.
[  691.495588] Restarting tasks ... done.
[  691.501402] random: crng reseeded on system resumption
[  691.504932] PM: suspend exit


September 20, 2023 at 4:22 AM, "AngeloGioacchino Del Regno" <angelogioacc=
hino.delregno@collabora.com> wrote:=20
>=20Il 20/09/23 03:28, Leonard Lausen ha scritto:
>=20
>=20>=20
>=20> Dear AngeloGioacchino, Dear Maintainers,
> >=20
>=20>  on MT8192 Asurada Spherion (Acer 514), I observe the following sle=
ep hang, causing > a failure to suspend the system. The hang looks relate=
d to the deadlock you fixed > for MT8195 Tomato Chromebook in the past, t=
hus I'm including you in the To: line. > The sleep hang happens with both=
 v6.5.4 as well as v6.5.4 with > tags/mediatek-drm-next-6.6 merged in. (I=
'm unable to validate v6.6-rc2 currently, > as there's a regression break=
ing boot.) Please let me know if I can provide any > additional informati=
on to help debug this issue or if you have any ideas how to > address thi=
s bug.
> >=20
>=20
> Looks like the issue is not related to the PCIe driver, but to somethin=
g else not
>=20
>=20going to sleep (and the ChromeOS EC detecting that, and preventing th=
e kernel to
>=20
>=20believe that the platform actually went to sleep).
>=20
>=20I'll try to check what's going on with MT8192 sleep ASAP.
>=20
>=20Anyway, as for the v6.6-rc2 regression, that's happening on MT8195 as=
 well.. and
>=20
>=20I have solved it with this commit:
>=20
>=20https://lore.kernel.org/lkml/20230918150043.403250-1-angelogioacchino=
.delregno@collabora.com/
>=20
>=20Regards,
>=20
>=20Angelo

