Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D998B7A75C1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjITIWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITIW3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 04:22:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79250131
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 01:22:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C191066003AA;
        Wed, 20 Sep 2023 09:22:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695198125;
        bh=jJeYxZR4NWNB5Hzn7t6mAWXZqowRaWbWG6MdBNpxg6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J7zRjDpRsXRc6Rcj79hetqcgyEuMxvMJkf3M4UyK/PEyPn0VjRrmRbrUtYjHifyUw
         1DKydh/iwgAC9Ge7ZNEJUNuhpC+FQcr3/EoGJf7lKlfoytdwQxFJ0b3/beLIYQk+T4
         Vz7kBDlhNkJ8qaoYGw1TUcznsAXAYFnfxZYKOm9jliQ5coLHpfCGlYNLafVv/a1miw
         QlM73gBxkH+c8yzMrpAY2Q8blyOLEbAaxci3NKAP44q30NUTv9QSRLNwoF7llIFZ0S
         nFnb2Oit6vg1qtmuAwSxWqvB/6IHJbqKk5mMdp6WVRCS0VRUuxUY7WPHcomt6bk1mw
         KmNf6f/Dt4IPQ==
Message-ID: <600bf03e-3be3-e675-1d59-ecc5aaa2aefd@collabora.com>
Date:   Wed, 20 Sep 2023 10:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: mtk_pcie_suspend_noirq sleep hang breaking suspend on
 MT8192 Asurada Spherion
Content-Language: en-US
To:     Leonard Lausen <leonard@lausen.nl>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <dd299e87-1e69-40a2-a429-fbcd2b48d2ee@lausen.nl>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dd299e87-1e69-40a2-a429-fbcd2b48d2ee@lausen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 20/09/23 03:28, Leonard Lausen ha scritto:
> Dear AngeloGioacchino, Dear Maintainers,
> 
> on MT8192 Asurada Spherion (Acer 514), I observe the following sleep hang, causing 
> a failure to suspend the system. The hang looks related to the deadlock you fixed 
> for MT8195 Tomato Chromebook in the past, thus I'm including you in the To: line. 
> The sleep hang happens with both v6.5.4 as well as v6.5.4 with 
> tags/mediatek-drm-next-6.6 merged in. (I'm unable to validate v6.6-rc2 currently, 
> as there's a regression breaking boot.) Please let me know if I can provide any 
> additional information to help debug this issue or if you have any ideas how to 
> address this bug.
> 

Looks like the issue is not related to the PCIe driver, but to something else not
going to sleep (and the ChromeOS EC detecting that, and preventing the kernel to
believe that the platform actually went to sleep).

I'll try to check what's going on with MT8192 sleep ASAP.

Anyway, as for the v6.6-rc2 regression, that's happening on MT8195 as well.. and
I have solved it with this commit:

https://lore.kernel.org/lkml/20230918150043.403250-1-angelogioacchino.delregno@collabora.com/

Regards,
Angelo

> [   42.539500] Freezing user space processes
> [   42.547466] Freezing user space processes completed (elapsed 0.003 seconds)
> [   42.554563] OOM killer disabled.
> [   42.557800] Freezing remaining freezable tasks
> [   42.563843] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   42.571243] printk: Suspending console(s) (use no_console_suspend to debug)
> [   42.655255] queueing ieee80211 work while going to suspend
> [   42.791520]
> [   42.791528] ========================================================
> [   42.791530] WARNING: possible irq lock inversion dependency detected
> [   42.791533] 6.5.4-cos-mt9 #1 Tainted: G        W
> [   42.791538] --------------------------------------------------------
> [   42.791540] systemd-sleep/1138 just changed the state of lock:
> [   42.791544] ffff676344fc1560 (&pcie->irq_lock){+...}-{2:2}, at: 
> mtk_pcie_suspend_noirq+0xd0/0x14c
> [   42.791568] but this lock was taken by another, HARDIRQ-safe lock in the past:
> [   42.791571]  (&irq_desc_lock_class){-.-.}-{2:2}
> [   42.791576]
> [   42.791576]
> [   42.791576] and interrupts could create inverse lock ordering between them.
> [   42.791576]
> [   42.791578]
> [   42.791578] other info that might help us debug this:
> [   42.791580]  Possible interrupt unsafe locking scenario:
> [   42.791580]
> [   42.791582]        CPU0                    CPU1
> [   42.791583]        ----                    ----
> [   42.791585]   lock(&pcie->irq_lock);
> [   42.791589]                                local_irq_disable();
> [   42.791591]                                lock(&irq_desc_lock_class);
> [   42.791595]                                lock(&pcie->irq_lock);
> [   42.791599]   <Interrupt>
> [   42.791601]     lock(&irq_desc_lock_class);
> [   42.791604]
> [   42.791604]  *** DEADLOCK ***
> [   42.791604]
> [   42.791606] 4 locks held by systemd-sleep/1138:
> [   42.791609]  #0: ffff6763486953e8 (sb_writers#6){.+.+}-{0:0}, at: 
> vfs_write+0xa4/0x2e4
> [   42.791628]  #1: ffff67636def1288 (&of->mutex){+.+.}-{3:3}, at: 
> kernfs_fop_write_iter+0xf0/0x1b0
> [   42.791643]  #2: ffff676340a89158 (kn->active#114){.+.+}-{0:0}, at: 
> kernfs_fop_write_iter+0xf8/0x1b0
> [   42.791658]  #3: ffffc5a79f9624a8 (system_transition_mutex){+.+.}-{3:3}, at: 
> pm_suspend+0x98/0x330
> [   42.791673]
> [   42.791673] the shortest dependencies between 2nd lock and 1st lock:
> [   42.791677]  -> (&irq_desc_lock_class){-.-.}-{2:2} {
> [   42.791685]     IN-HARDIRQ-W at:
> [   42.791688]                       lock_acquire+0x11c/0x324
> [   42.791698]                       _raw_spin_lock+0x48/0x60
> [   42.791705]                       handle_fasteoi_irq+0x2c/0x234
> [   42.791714]                       generic_handle_domain_irq+0x2c/0x44
> [   42.791719]                       gic_handle_irq+0x180/0x2c0
> [   42.791724]                       call_on_irq_stack+0x24/0x4c
> [   42.791730]                       do_interrupt_handler+0x80/0x84
> [   42.791736]                       el1_interrupt+0x48/0xac
> [   42.791741]                       el1h_64_irq_handler+0x18/0x24
> [   42.791747]                       el1h_64_irq+0x78/0x7c
> [   42.791750]                       default_idle_call+0xa0/0x14c
> [   42.791756]                       do_idle+0x270/0x2d0
> [   42.791762]                       cpu_startup_entry+0x24/0x2c
> [   42.791767]                       rest_init+0x118/0x1a8
> [   42.791773]                       arch_post_acpi_subsys_init+0x0/0x8
> [   42.791781]                       start_kernel+0x5b8/0x6ac
> [   42.791785]                       __primary_switched+0xbc/0xc4
> [   42.791790]     IN-SOFTIRQ-W at:
> [   42.791793]                       lock_acquire+0x11c/0x324
> [   42.791801]                       _raw_spin_lock+0x48/0x60
> [   42.791805]                       handle_fasteoi_irq+0x2c/0x234
> [   42.791811]                       generic_handle_domain_irq+0x2c/0x44
> [   42.791816]                       gic_handle_irq+0x180/0x2c0
> [   42.791820]                       do_interrupt_handler+0x50/0x84
> [   42.791826]                       el1_interrupt+0x48/0xac
> [   42.791830]                       el1h_64_irq_handler+0x18/0x24
> [   42.791835]                       el1h_64_irq+0x78/0x7c
> [   42.791839]                       _nohz_idle_balance.isra.0+0x280/0x384
> [   42.791847]                       run_rebalance_domains+0x64/0x74
> [   42.791854]                       __do_softirq+0x148/0x51c
> [   42.791858]                       ____do_softirq+0x10/0x1c
> [   42.791863]                       call_on_irq_stack+0x24/0x4c
> [   42.791868]                       do_softirq_own_stack+0x1c/0x2c
> [   42.791873]                       __irq_exit_rcu+0x144/0x160
> [   42.791881]                       irq_exit_rcu+0x10/0x38
> [   42.791887]                       el1_interrupt+0x4c/0xac
> [   42.791892]                       el1h_64_irq_handler+0x18/0x24
> [   42.791897]                       el1h_64_irq+0x78/0x7c
> [   42.791900]                       default_idle_call+0xa0/0x14c
> [   42.791906]                       do_idle+0x270/0x2d0
> [   42.791910]                       cpu_startup_entry+0x24/0x2c
> [   42.791915]                       rest_init+0x118/0x1a8
> [   42.791921]                       arch_post_acpi_subsys_init+0x0/0x8
> [   42.791926]                       start_kernel+0x5b8/0x6ac
> [   42.791931]                       __primary_switched+0xbc/0xc4
> [   42.791935]     INITIAL USE at:
> [   42.791938]                      lock_acquire+0x11c/0x324
> [   42.791945]                      _raw_spin_lock_irqsave+0x68/0xbc
> [   42.791950]                      __irq_get_desc_lock+0x58/0x98
> [   42.791955]                      irq_modify_status+0x38/0x140
> [   42.791962]                      irq_set_percpu_devid+0x70/0x94
> [   42.791967]                      gic_irq_domain_alloc+0x208/0x248
> [   42.791976]                      irq_domain_alloc_irqs_locked+0xf8/0x358
> [   42.791981]                      __irq_domain_alloc_irqs+0x6c/0xc0
> [   42.791986]                      gic_init_bases+0x34c/0x6bc
> [   42.791992]                      gic_of_init+0x290/0x314
> [   42.791997]                      of_irq_init+0x304/0x390
> [   42.792004]                      irqchip_init+0x18/0x24
> [   42.792008]                      init_IRQ+0xb4/0x15c
> [   42.792014]                      start_kernel+0x26c/0x6ac
> [   42.792019]                      __primary_switched+0xbc/0xc4
> [   42.792022]   }
> [   42.792024]   ... key      at: [<ffffc5a7a0780f60>] irq_desc_lock_class+0x0/0x10
> [   42.792034]   ... acquired at:
> [   42.792036]    _raw_spin_lock_irqsave+0x68/0xbc
> [   42.792041]    mtk_msi_bottom_irq_unmask+0x30/0x70
> [   42.792047]    irq_chip_unmask_parent+0x1c/0x28
> [   42.792054]    mtk_pcie_msi_irq_unmask+0x20/0x30
> [   42.792060]    irq_enable+0x40/0x8c
> [   42.792067]    __irq_startup+0x78/0xa4
> [   42.792074]    irq_startup+0xfc/0x164
> [   42.792081]    __setup_irq+0x43c/0x784
> [   42.792087]    request_threaded_irq+0xec/0x1a4
> [   42.792093]    pcie_pme_probe+0xf4/0x1bc
> [   42.792101]    pcie_port_probe_service+0x38/0x64
> [   42.792107]    really_probe+0x148/0x2ac
> [   42.792115]    __driver_probe_device+0x78/0x12c
> [   42.792122]    driver_probe_device+0x3c/0x160
> [   42.792128]    __device_attach_driver+0xb8/0x138
> [   42.792135]    bus_for_each_drv+0x80/0xdc
> [   42.792141]    __device_attach+0x9c/0x188
> [   42.792148]    device_initial_probe+0x14/0x20
> [   42.792155]    bus_probe_device+0xac/0xb0
> [   42.792161]    device_add+0x5bc/0x778
> [   42.792166]    device_register+0x20/0x30
> [   42.792171]    pcie_portdrv_probe+0x340/0x5c4
> [   42.792176]    local_pci_probe+0x40/0xa4
> [   42.792183]    pci_device_probe+0xac/0x1e0
> [   42.792189]    really_probe+0x148/0x2ac
> [   42.792195]    __driver_probe_device+0x78/0x12c
> [   42.792202]    driver_probe_device+0x3c/0x160
> [   42.792208]    __device_attach_driver+0xb8/0x138
> [   42.792215]    bus_for_each_drv+0x80/0xdc
> [   42.792221]    __device_attach+0x9c/0x188
> [   42.792227]    device_attach+0x14/0x20
> [   42.792234]    pci_bus_add_device+0x64/0xd4
> [   42.792239]    pci_bus_add_devices+0x3c/0x88
> [   42.792243]    pci_host_probe+0x44/0xbc
> [   42.792249]    mtk_pcie_probe+0x288/0x47c
> [   42.792255]    platform_probe+0x68/0xc4
> [   42.792260]    really_probe+0x148/0x2ac
> [   42.792266]    __driver_probe_device+0x78/0x12c
> [   42.792272]    driver_probe_device+0x3c/0x160
> [   42.792279]    __device_attach_driver+0xb8/0x138
> [   42.792285]    bus_for_each_drv+0x80/0xdc
> [   42.792291]    __device_attach+0x9c/0x188
> [   42.792298]    device_initial_probe+0x14/0x20
> [   42.792304]    bus_probe_device+0xac/0xb0
> [   42.792311]    deferred_probe_work_func+0x8c/0xc8
> [   42.792317]    process_one_work+0x2d0/0x598
> [   42.792324]    worker_thread+0x70/0x434
> [   42.792329]    kthread+0xfc/0x100
> [   42.792333]    ret_from_fork+0x10/0x20
> [   42.792338]
> [   42.792340] -> (&pcie->irq_lock){+...}-{2:2} {
> [   42.792347]    HARDIRQ-ON-W at:
> [   42.792350]                     lock_acquire+0x11c/0x324
> [   42.792357]                     _raw_spin_lock+0x48/0x60
> [   42.792361]                     mtk_pcie_suspend_noirq+0xd0/0x14c
> [   42.792367]                     dpm_run_callback+0x34/0x9c
> [   42.792376]                     __device_suspend_noirq+0x68/0x1f0
> [   42.792384]                     dpm_noirq_suspend_devices+0x1b8/0x24c
> [   42.792391]                     dpm_suspend_noirq+0x24/0x98
> [   42.792395]                     suspend_devices_and_enter+0x3b0/0x65c
> [   42.792401]                     pm_suspend+0x1fc/0x330
> [   42.792406]                     state_store+0x80/0xec
> [   42.792411]                     kobj_attr_store+0x18/0x2c
> [   42.792418]                     sysfs_kf_write+0x4c/0x78
> [   42.792425]                     kernfs_fop_write_iter+0x120/0x1b0
> [   42.792431]                     vfs_write+0x1a4/0x2e4
> [   42.792437]                     ksys_write+0x6c/0x100
> [   42.792443]                     __arm64_sys_write+0x1c/0x28
> [   42.792449]                     invoke_syscall+0x48/0x114
> [   42.792456]                     el0_svc_common.constprop.0+0x64/0x138
> [   42.792464]                     do_el0_svc+0x38/0x98
> [   42.792471]                     el0_svc+0x40/0xe0
> [   42.792475]                     el0t_64_sync_handler+0x100/0x12c
> [   42.792480]                     el0t_64_sync+0x1a4/0x1a8
> [   42.792484]    INITIAL USE at:
> [   42.792487]                    lock_acquire+0x11c/0x324
> [   42.792494]                    _raw_spin_lock_irqsave+0x68/0xbc
> [   42.792499]                    mtk_msi_bottom_irq_unmask+0x30/0x70
> [   42.792505]                    irq_chip_unmask_parent+0x1c/0x28
> [   42.792512]                    mtk_pcie_msi_irq_unmask+0x20/0x30
> [   42.792518]                    irq_enable+0x40/0x8c
> [   42.792525]                    __irq_startup+0x78/0xa4
> [   42.792532]                    irq_startup+0xfc/0x164
> [   42.792539]                    __setup_irq+0x43c/0x784
> [   42.792545]                    request_threaded_irq+0xec/0x1a4
> [   42.792550]                    pcie_pme_probe+0xf4/0x1bc
> [   42.792557]                    pcie_port_probe_service+0x38/0x64
> [   42.792563]                    really_probe+0x148/0x2ac
> [   42.792569]                    __driver_probe_device+0x78/0x12c
> [   42.792576]                    driver_probe_device+0x3c/0x160
> [   42.792582]                    __device_attach_driver+0xb8/0x138
> [   42.792589]                    bus_for_each_drv+0x80/0xdc
> [   42.792595]                    __device_attach+0x9c/0x188
> [   42.792601]                    device_initial_probe+0x14/0x20
> [   42.792608]                    bus_probe_device+0xac/0xb0
> [   42.792614]                    device_add+0x5bc/0x778
> [   42.792619]                    device_register+0x20/0x30
> [   42.792624]                    pcie_portdrv_probe+0x340/0x5c4
> [   42.792630]                    local_pci_probe+0x40/0xa4
> [   42.792635]                    pci_device_probe+0xac/0x1e0
> [   42.792640]                    really_probe+0x148/0x2ac
> [   42.792647]                    __driver_probe_device+0x78/0x12c
> [   42.792653]                    driver_probe_device+0x3c/0x160
> [   42.792660]                    __device_attach_driver+0xb8/0x138
> [   42.792666]                    bus_for_each_drv+0x80/0xdc
> [   42.792672]                    __device_attach+0x9c/0x188
> [   42.792679]                    device_attach+0x14/0x20
> [   42.792685]                    pci_bus_add_device+0x64/0xd4
> [   42.792690]                    pci_bus_add_devices+0x3c/0x88
> [   42.792694]                    pci_host_probe+0x44/0xbc
> [   42.792700]                    mtk_pcie_probe+0x288/0x47c
> [   42.792706]                    platform_probe+0x68/0xc4
> [   42.792710]                    really_probe+0x148/0x2ac
> [   42.792716]                    __driver_probe_device+0x78/0x12c
> [   42.792723]                    driver_probe_device+0x3c/0x160
> [   42.792729]                    __device_attach_driver+0xb8/0x138
> [   42.792736]                    bus_for_each_drv+0x80/0xdc
> [   42.792742]                    __device_attach+0x9c/0x188
> [   42.792748]                    device_initial_probe+0x14/0x20
> [   42.792755]                    bus_probe_device+0xac/0xb0
> [   42.792761]                    deferred_probe_work_func+0x8c/0xc8
> [   42.792767]                    process_one_work+0x2d0/0x598
> [   42.792773]                    worker_thread+0x70/0x434
> [   42.792778]                    kthread+0xfc/0x100
> [   42.792782]                    ret_from_fork+0x10/0x20
> [   42.792787]  }
> [   42.792788]  ... key      at: [<ffffc5a7a07bdfa0>] __key.1+0x0/0x10
> [   42.792794]  ... acquired at:
> [   42.792796]    __lock_acquire+0x73c/0x1970
> [   42.792803]    lock_acquire+0x11c/0x324
> [   42.792810]    _raw_spin_lock+0x48/0x60
> [   42.792814]    mtk_pcie_suspend_noirq+0xd0/0x14c
> [   42.792821]    dpm_run_callback+0x34/0x9c
> [   42.792828]    __device_suspend_noirq+0x68/0x1f0
> [   42.792835]    dpm_noirq_suspend_devices+0x1b8/0x24c
> [   42.792842]    dpm_suspend_noirq+0x24/0x98
> [   42.792846]    suspend_devices_and_enter+0x3b0/0x65c
> [   42.792852]    pm_suspend+0x1fc/0x330
> [   42.792857]    state_store+0x80/0xec
> [   42.792862]    kobj_attr_store+0x18/0x2c
> [   42.792868]    sysfs_kf_write+0x4c/0x78
> [   42.792874]    kernfs_fop_write_iter+0x120/0x1b0
> [   42.792880]    vfs_write+0x1a4/0x2e4
> [   42.792886]    ksys_write+0x6c/0x100
> [   42.792892]    __arm64_sys_write+0x1c/0x28
> [   42.792898]    invoke_syscall+0x48/0x114
> [   42.792905]    el0_svc_common.constprop.0+0x64/0x138
> [   42.792912]    do_el0_svc+0x38/0x98
> [   42.792919]    el0_svc+0x40/0xe0
> [   42.792923]    el0t_64_sync_handler+0x100/0x12c
> [   42.792928]    el0t_64_sync+0x1a4/0x1a8
> [   42.792932]
> [   42.792933]
> [   42.792933] stack backtrace:
> [   42.792936] CPU: 4 PID: 1138 Comm: systemd-sleep Tainted: G        W         
> 6.5.4-cos-mt9 #1
> [   42.792942] Hardware name: Google Spherion (rev0 - 3) (DT)
> [   42.792945] Call trace:
> [   42.792947]  dump_backtrace+0x98/0xf0
> [   42.792951]  show_stack+0x18/0x24
> [   42.792955]  dump_stack_lvl+0xb8/0x118
> [   42.792960]  dump_stack+0x18/0x24
> [   42.792964]  print_irq_inversion_bug.part.0+0x1ec/0x27c
> [   42.792971]  mark_lock+0x300/0x720
> [   42.792978]  __lock_acquire+0x73c/0x1970
> [   42.792985]  lock_acquire+0x11c/0x324
> [   42.792993]  _raw_spin_lock+0x48/0x60
> [   42.792996]  mtk_pcie_suspend_noirq+0xd0/0x14c
> [   42.793003]  dpm_run_callback+0x34/0x9c
> [   42.793010]  __device_suspend_noirq+0x68/0x1f0
> [   42.793017]  dpm_noirq_suspend_devices+0x1b8/0x24c
> [   42.793025]  dpm_suspend_noirq+0x24/0x98
> [   42.793028]  suspend_devices_and_enter+0x3b0/0x65c
> [   42.793033]  pm_suspend+0x1fc/0x330
> [   42.793039]  state_store+0x80/0xec
> [   42.793043]  kobj_attr_store+0x18/0x2c
> [   42.793050]  sysfs_kf_write+0x4c/0x78
> [   42.793056]  kernfs_fop_write_iter+0x120/0x1b0
> [   42.793062]  vfs_write+0x1a4/0x2e4
> [   42.793068]  ksys_write+0x6c/0x100
> [   42.793073]  __arm64_sys_write+0x1c/0x28
> [   42.793079]  invoke_syscall+0x48/0x114
> [   42.793086]  el0_svc_common.constprop.0+0x64/0x138
> [   42.793093]  do_el0_svc+0x38/0x98
> [   42.793100]  el0_svc+0x40/0xe0
> [   42.793105]  el0t_64_sync_handler+0x100/0x12c
> [   42.793110]  el0t_64_sync+0x1a4/0x1a8
> [   42.796314] Disabling non-boot CPUs ...
> [   42.799859] IRQ273: set affinity failed(-22).
> [   42.799921] IRQ290: set affinity failed(-22).
> [   42.800023] psci: CPU1 killed (polled 0 ms)
> [   42.803929] IRQ273: set affinity failed(-22).
> [   42.803982] IRQ290: set affinity failed(-22).
> [   42.804336] psci: CPU2 killed (polled 1 ms)
> [   42.807855] IRQ273: set affinity failed(-22).
> [   42.807907] IRQ290: set affinity failed(-22).
> [   42.807992] psci: CPU3 killed (polled 0 ms)
> [   42.809756] IRQ273: set affinity failed(-22).
> [   42.809775] IRQ290: set affinity failed(-22).
> [   42.809829] psci: CPU4 killed (polled 0 ms)
> [   42.813594] IRQ273: set affinity failed(-22).
> [   42.813616] IRQ290: set affinity failed(-22).
> [   42.813672] psci: CPU5 killed (polled 0 ms)
> [   42.816944] psci: CPU6 killed (polled 0 ms)
> [   42.818815] psci: CPU7 killed (polled 0 ms)
> [   42.821422] Enabling non-boot CPUs ...
> [   42.822247] Detected VIPT I-cache on CPU1
> [   42.822306] GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
> [   42.822376] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> [   42.824953] CPU1 is up
> [   42.825773] Detected VIPT I-cache on CPU2
> [   42.825822] GICv3: CPU2: found redistributor 200 region 0:0x000000000c080000
> [   42.825880] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> [   42.828463] CPU2 is up
> [   42.829162] Detected VIPT I-cache on CPU3
> [   42.829206] GICv3: CPU3: found redistributor 300 region 0:0x000000000c0a0000
> [   42.829256] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> [   42.831963] CPU3 is up
> [   42.832750] CPU features: detected: Hardware dirty bit management
> [   42.832778] Detected PIPT I-cache on CPU4
> [   42.832799] GICv3: CPU4: found redistributor 400 region 0:0x000000000c0c0000
> [   42.832824] CPU4: Booted secondary processor 0x0000000400 [0x414fd0b0]
> [   42.834001] CPU4 is up
> [   42.834870] Detected PIPT I-cache on CPU5
> [   42.834895] GICv3: CPU5: found redistributor 500 region 0:0x000000000c0e0000
> [   42.834920] CPU5: Booted secondary processor 0x0000000500 [0x414fd0b0]
> [   42.836053] CPU5 is up
> [   42.836871] Detected PIPT I-cache on CPU6
> [   42.836897] GICv3: CPU6: found redistributor 600 region 0:0x000000000c100000
> [   42.836921] CPU6: Booted secondary processor 0x0000000600 [0x414fd0b0]
> [   42.838100] CPU6 is up
> [   42.838936] Detected PIPT I-cache on CPU7
> [   42.838962] GICv3: CPU7: found redistributor 700 region 0:0x000000000c120000
> [   42.838986] CPU7: Booted secondary processor 0x0000000700 [0x414fd0b0]
> [   42.840235] CPU7 is up
> [   42.978808] ------------[ cut here ]------------
> [   42.978823] EC detected sleep transition timeout. Total sleep transitions: 0
> [   42.978919] WARNING: CPU: 0 PID: 1138 at drivers/platform/chrome/cros_ec.c:142 
> cros_ec_sleep_event.isra.0+0xf8/0x104
> [   42.978952] Modules linked in: rfcomm qrtr bnep btusb btrtl btintel mt7921e 
> btmtk btbcm mt7921_common mt76_connac_lib mt76 bluetooth mtk_vcodec_dec_hw 
> ecdh_generic mac80211 ecc mtk_vcodec_dec uvcvideo uvc v4l2_vp9 videobuf2_vmalloc 
> cfg80211 mtk_vcodec_enc v4l2_h264 mtk_vcodec_dbgfs mtk_vcodec_common mtk_vpu 
> elants_i2c rfkill elan_i2c tpm_tis_spi cros_usbpd_logger tpm_tis_core 
> cros_usbpd_charger sbs_battery coreboot_table fuse ip_tables x_tables ipv6
> [   42.979171] CPU: 0 PID: 1138 Comm: systemd-sleep Tainted: G        W         
> 6.5.4-cos-mt9 #1
> [   42.979184] Hardware name: Google Spherion (rev0 - 3) (DT)
> [   42.979191] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   42.979203] pc : cros_ec_sleep_event.isra.0+0xf8/0x104
> [   42.979219] lr : cros_ec_sleep_event.isra.0+0xf8/0x104
> [   42.979233] sp : ffff8000831fba40
> [   42.979239] x29: ffff8000831fba40 x28: ffff676363e38000 x27: ffffc5a79f1cd938
> [   42.979261] x26: ffffc5a79fc8ac38 x25: ffffc5a79f968abc x24: 0000000000000010
> [   42.979282] x23: ffffc5a7a07c7fe0 x22: ffff676340e2f080 x21: ffffc5a79e866dc4
> [   42.979303] x20: 0000000000000002 x19: ffff676343034480 x18: ffffffffffffffff
> [   42.979323] x17: 0000000000000000 x16: 0000000000000001 x15: ffffffffffffffff
> [   42.979343] x14: ffffc5a7a07520a1 x13: ffffc5a7a075209f x12: 736e617274207065
> [   42.979364] x11: 656c73206c61746f x10: 54202e74756f656d x9 : 6d6974206e6f6974
> [   42.979384] x8 : ffffc5a79f49c008 x7 : 0000000000000000 x6 : ffffc5a79db3df70
> [   42.979404] x5 : ffff67647ee9ec08 x4 : ffffa1bcdfa00000 x3 : ffff676363e38000
> [   42.979424] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff676363e38000
> [   42.979444] Call trace:
> [   42.979449]  cros_ec_sleep_event.isra.0+0xf8/0x104
> [   42.979464]  cros_ec_resume+0x3c/0xec
> [   42.979479]  cros_ec_spi_resume+0x14/0x20
> [   42.979489]  dpm_run_callback+0x34/0x9c
> [   42.979505]  device_resume+0x8c/0x198
> [   42.979519]  dpm_resume+0x12c/0x258
> [   42.979529]  dpm_resume_end+0x18/0x30
> [   42.979539]  suspend_devices_and_enter+0xbc/0x65c
> [   42.979554]  pm_suspend+0x1fc/0x330
> [   42.979566]  state_store+0x80/0xec
> [   42.979576]  kobj_attr_store+0x18/0x2c
> [   42.979592]  sysfs_kf_write+0x4c/0x78
> [   42.979607]  kernfs_fop_write_iter+0x120/0x1b0
> [   42.979621]  vfs_write+0x1a4/0x2e4
> [   42.979635]  ksys_write+0x6c/0x100
> [   42.979647]  __arm64_sys_write+0x1c/0x28
> [   42.979659]  invoke_syscall+0x48/0x114
> [   42.979677]  el0_svc_common.constprop.0+0x64/0x138
> [   42.979691]  do_el0_svc+0x38/0x98
> [   42.979704]  el0_svc+0x40/0xe0
> [   42.979716]  el0t_64_sync_handler+0x100/0x12c
> [   42.979727]  el0t_64_sync+0x1a4/0x1a8
> [   42.979739] irq event stamp: 66299
> [   42.979745] hardirqs last  enabled at (66299): [<ffffc5a79eb89890>] 
> __schedule+0xab8/0xbe8
> [   42.979761] hardirqs last disabled at (66298): [<ffffc5a79eb891d0>] 
> __schedule+0x3f8/0xbe8
> [   42.979776] softirqs last  enabled at (65704): [<ffffc5a79da10794>] 
> __do_softirq+0x424/0x51c
> [   42.979788] softirqs last disabled at (65699): [<ffffc5a79da16af0>] 
> ____do_softirq+0x10/0x1c
> [   42.979803] ---[ end trace 0000000000000000 ]---
> [   45.407309] OOM killer enabled.
> [   45.410445] Restarting tasks ... done.
> [   45.414855] random: crng reseeded on system resumption
> [   45.423237] PM: suspend exit
> 
> Please also find the CrOS EC log starting with the first message printed after 
> "suspend" begins:
> 
> [651878.494408 HC 0x400b err 1]
> [651878.497188 HC 0x8d err 1]
> [651878.501734 HC 0x2b err 1]
> [651878.505423 HC 0x134 err 1]
> [651878.510886 HC 0x26 err 3]
> [651878.917783 Handle sleep: 0]
> [651878.931282 HC 0x67 err 9]
> [651891.650633 Unhandled VB reg 11]
> [651891.654386 Unhandled VB reg 11]
> [651891.688083 Unhandled VB reg 11]
> [651891.690206 Unhandled VB reg 11]
> [651891.865486 Unhandled VB reg 11]
> [651891.867628 Unhandled VB reg 11]
> [651891.953322 Unhandled VB reg 11]
> [651891.957136 Unhandled VB reg 11]
> [651892.034630 Unhandled VB reg 11]
> [651892.038440 Unhandled VB reg 11]
> [651892.073436 Unhandled VB reg 11]
> [651892.075545 Unhandled VB reg 11]
> [651892.097180 Unhandled VB reg 11]
> [651892.099232 Unhandled VB reg 11]
> [651892.314986 Unhandled VB reg 11]
> [651892.319744 Unhandled VB reg 11]
> [651892.327483 Unhandled VB reg 11]
> [651892.350593 Unhandled VB reg 11]
> [651892.355511 Unhandled VB reg 11]
> [651892.371166 Unhandled VB reg 11]
> [651892.374825 Unhandled VB reg 11]
> [651892.411053 Unhandled VB reg 11]
> [651892.415335 Unhandled VB reg 11]
> [651892.479204 Unhandled VB reg 11]
> [651892.481260 Unhandled VB reg 11]
> [651892.500444 Unhandled VB reg 11]
> [651892.504106 Unhandled VB reg 11]
> [651918.803375 Handle sleep: 1]
> [651928.805549 Warning: Detected sleep hang! Waking host up!]
> [651928.806288 event set 0x0000000000080000]
> [651928.966033 Handle sleep: 2]
> [651928.970547 HC 0x67 err 9]
> 

