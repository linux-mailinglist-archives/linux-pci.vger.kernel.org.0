Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AEA57E29
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfF0IWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 04:22:03 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46368 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0IWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 04:22:03 -0400
Received: by mail-io1-f54.google.com with SMTP id i10so2803506iol.13
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2019 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VGZUBZaPWyvbPRUNJ5VcmA2c3aQZgvI+cFZmURKvaYU=;
        b=Mw6hNMg4OM6tS3vIxxmoSoVpIqJTbCvQk9lx9deY0QreiB4EdXZyBTSbpEG0Xj71CZ
         w0Fi0+FGe1e7w2vIARhrsowE3oe/dd/Yykw0gwqtbVS4g8KxxmnLg5BEr2Imo13LGXRn
         t5pFkwHQKTMpYrMnH4RD+PCOZ6ZUT6SodpPvJ60CKvad7h2THdj610c3usjU8bqtvavt
         cS3WQ/AvaAeZmuO0sQaO8EnP2VyRJw98/l7P3AoAIZdYGWCnDccZFGD7GuDD3Paz7ENK
         4pEiF7xbIUzA4qcXRkMmTEgDJVG0f+VdZqFR+toIiT1Bn3Kba6wC867wrHXm+PuUSZsp
         baxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VGZUBZaPWyvbPRUNJ5VcmA2c3aQZgvI+cFZmURKvaYU=;
        b=l07CsPwaE1ZfsP56cENY1VPBuMAKKUKmx0aB3L7Sc0OTUYLxvmOS7+3485MNmJaYQ1
         HONMz+5qT1abtHpKYnjAdZ6Le6TnxkcdLZI4Hn9SHWbD6DMy4QsLDS2afcYPPvbej5oV
         4zF03/CiRa9x2Wj4gLVMQs5QcV3h/WCAlNbdaItVjr0ZwwzFd8mgOLPr1v7iuvGSvf7Y
         Yl9qNjzWrO2AKEOF4OhbZDH2LHQUjs+kZXWqgOBnmYS5H3+/nYe+Bb3xIsDgEAb1nBu6
         izTCC+evAcxGBiDPrOY4QI8JoG9TGmJ+FJnfNa3RKM6+COlxfkZjY6xZr/zQC0ZYreIW
         lTig==
X-Gm-Message-State: APjAAAU5AntfkTXbRd5oEfd/JSpX8vwFbN09pEMonGtppPpHR1qnsmzT
        cOCC4EWRUf+lfhz4tU9S4eKrg8r9V+HSz+5J48HsRFba
X-Google-Smtp-Source: APXvYqyXGA87GTe9Z1T1VnkEEemVrvEiDnakbiw7w4IpoxYJF0uYYR2E2YWrRFA4U6s2BXRT90vqcIRFV0hMqz8aUsg=
X-Received: by 2002:a5e:9401:: with SMTP id q1mr3077762ioj.276.1561623721614;
 Thu, 27 Jun 2019 01:22:01 -0700 (PDT)
MIME-Version: 1.0
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 27 Jun 2019 18:21:50 +1000
Message-ID: <CAOSf1CGnYaGUTZQHbgy39dC47XNZRi4At2aTWRK0MeBvupKrxg@mail.gmail.com>
Subject: pciehp lockdep splat on 5.2-rc6
To:     linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I've been re-working the powerpc pci code to make it possible to use
pciehp on powernv. While testing I'm consistently seeing this lockdep
splat when hot-adding a U.2 NVMe drive. This might be my bug, but all
my changes are contained in arch/powerpc/ and the stack traces point
entirely at generic code, so maybe not. Does this look like a real
issue?

Oliver

[  169.920642][ T1952] pcieport 0020:02:02.0: pciehp: Slot(0-3): Card present
[  169.924806][ T1952] pcieport 0020:02:02.0: pciehp: Slot(0-3): Link Up
[  170.083951][ T1952] pci 0020:08:00.0: [1344:5192] type 00 class 0x010802
[  170.088307][ T1952] pci 0020:08:00.0: reg 0x10: [mem
0x00000000-0x00003fff 64bit]
[  170.092711][ T1952] pci 0020:08:00.0: reg 0x30: [mem
0x00000000-0x0001ffff pref]
[  170.096839][ T1952] pci 0020:08:00.0: Max Payload Size set to 256
(was 128, max 256)
[  170.100973][ T1952] pci 0020:08:00.0: enabling Extended Tags
[  170.105323][ T1952] pci 0020:08:00.0: BAR0 [mem size 0x00004000
64bit]: requesting alignment to 0x10000
[  170.111719][ T1952] pci 0020:08:00.0: Adding to iommu group 8
[  170.142333][ T1952] pcieport 0020:02:02.0: bridge window [io
0x1000-0x0fff] to [bus 08] add_size 1000
[  170.145079][ T1952] pcieport 0020:02:02.0: BAR 7: no space for [io
size 0x1000]
[  170.147783][ T1952] pcieport 0020:02:02.0: BAR 7: failed to assign
[io  size 0x1000]
[  170.150524][ T1952] pcieport 0020:02:02.0: BAR 7: no space for [io
size 0x1000]
[  170.153292][ T1952] pcieport 0020:02:02.0: BAR 7: failed to assign
[io  size 0x1000]
[  170.156078][ T1952] pci 0020:08:00.0: BAR 6: assigned [mem
0x3fe800800000-0x3fe80081ffff pref]
[  170.158897][ T1952] pci 0020:08:00.0: BAR 0: assigned [mem
0x3fe800820000-0x3fe800823fff 64bit]
[  170.161761][ T1952] 0020:08:00.0: No device node associated with device !
[  170.164607][ T1952] pcieport 0020:02:02.0: PCI bridge to [bus 08]
[  170.167478][ T1952] pcieport 0020:02:02.0:   bridge window [mem
0x3fe800800000-0x3fe800ffffff]
[  170.170386][ T1952] pcieport 0020:02:02.0:   bridge window [mem
0x240100000000-0x2401ffffffff 64bit pref]
[  170.173389][ T1952] pnv_pcibios_bus_add_device: EEH: Setting up
device 0020:08:00.0.
[  170.176372][ T1952] EEH: Adding device 0020:08:00.0
[  170.179352][ T1952] pnv_eeh_probe_pdev: probing 0020:08:00.0
[  170.182597][ T1952] EEH: Add 0020:08:00.0 to Device PE#fd, Parent PE#0
[  170.185783][ T1952] pnv_eeh_probe_pdev: EEH enabled on 08:00.0 PHB#20-PE#fd
[  170.189244][ T1952] nvme 0020:08:00.0: runtime IRQ mapping not
provided by arch
[  170.192617][ T1952]
[  170.194049][  T656] nvme nvme1: pci function 0020:08:00.0
[  170.195732][ T1952] ======================================================
[  170.195743][ T1952] WARNING: possible circular locking dependency detected
[  170.201813][ T1947] nvme 0020:08:00.0: enabling device (0000 -> 0002)
[  170.205419][ T1952] 5.2.0-rc6-00074-g99d8de2-dirty #225 Tainted: G        W
[  170.205422][ T1952] ------------------------------------------------------
[  170.205425][ T1952] irq/251-pciehp/1952 is trying to acquire lock:
[  170.205428][ T1952] 00000000c71b3eb9
((work_completion)(&wfc.work)){+.+.}, at: __flush_work+0x68/0x120
[  170.205443][ T1952]
[  170.205443][ T1952] but task is already holding lock:
[  170.205445][ T1952] 00000000788e6539
(pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x2c/0x40
[  170.205456][ T1952]
[  170.205456][ T1952] which lock already depends on the new lock.
[  170.205456][ T1952]
[  170.205458][ T1952]
[  170.205458][ T1952] the existing dependency chain (in reverse order) is:
[  170.205460][ T1952]
[  170.205460][ T1952] -> #2 (pci_rescan_remove_lock){+.+.}:
[  170.211487][ T1947] nvme 0020:08:00.0: enabling bus mastering
[  170.215287][ T1952]        validate_chain.isra.12+0x520/0x780
[  170.215292][ T1952]        __lock_acquire+0x358/0x7c0
[  170.215297][ T1952]        lock_acquire+0xd4/0x230
[  170.215303][ T1952]        __mutex_lock+0x8c/0xa30
[  170.215308][ T1952]        pci_lock_rescan_remove+0x2c/0x40
[  170.215313][ T1952]        pciehp_unconfigure_device+0x54/0x1a0
[  170.215318][ T1952]        remove_board+0x28/0x90
[  170.215329][ T1952]        __pciehp_disable_slot+0x64/0xb0
[  170.292060][ T1952]        pciehp_disable_slot+0x58/0xc0
[  170.295062][ T1952]        pciehp_handle_presence_or_link_change+0x94/0x2a0
[  170.298064][ T1952]        pciehp_ist+0x1fc/0x280
[  170.300988][ T1952]        irq_thread_fn+0x4c/0xa0
[  170.303878][ T1952]        irq_thread+0xdc/0x150
[  170.306740][ T1952]        kthread+0x15c/0x1a0
[  170.309584][ T1952]        ret_from_kernel_thread+0x5c/0x78
[  170.312445][ T1952]
[  170.312445][ T1952] -> #1 (&ctrl->reset_lock){.+.+}:
[  170.318025][ T1952]        validate_chain.isra.12+0x520/0x780
[  170.320822][ T1952]        __lock_acquire+0x358/0x7c0
[  170.323589][ T1952]        lock_acquire+0xd4/0x230
[  170.326324][ T1952]        down_read+0x44/0x130
[  170.329053][ T1952]        pciehp_check_presence+0x3c/0x110
[  170.331737][ T1952]        pciehp_probe+0x94/0x1c0
[  170.334374][ T1952]        pcie_port_probe_service+0x60/0xb0
[  170.337014][ T1952]        really_probe+0x2c4/0x500
[  170.339616][ T1952]        driver_probe_device+0x124/0x150
[  170.342197][ T1952]        bus_for_each_drv+0x80/0xe0
[  170.344742][ T1952]        __device_attach+0x130/0x200
[  170.347246][ T1952]        bus_probe_device+0xe4/0xf0
[  170.349730][ T1952]        device_add+0x294/0x4a0
[  170.352174][ T1952]        pcie_device_init+0x124/0x170
[  170.354644][ T1952]        pcie_port_device_register+0x130/0x160
[  170.357053][ T1952]        pcie_portdrv_probe+0x74/0x130
[  170.359421][ T1952]        local_pci_probe+0x6c/0x110
[  170.361756][ T1952]        work_for_cpu_fn+0x38/0x60
[  170.364059][ T1952]        process_one_work+0x21c/0x6a0
[  170.366312][ T1952]        process_scheduled_works+0x50/0x80
[  170.368514][ T1952]        worker_thread+0x15c/0x2d0
[  170.370708][ T1952]        kthread+0x15c/0x1a0
[  170.372831][ T1952]        ret_from_kernel_thread+0x5c/0x78
[  170.374913][ T1952]
[  170.374913][ T1952] -> #0 ((work_completion)(&wfc.work)){+.+.}:
[  170.379010][ T1952]        check_prevs_add+0x160/0x1a0
[  170.381126][ T1952]        validate_chain.isra.12+0x520/0x780
[  170.383246][ T1952]        __lock_acquire+0x358/0x7c0
[  170.385334][ T1952]        lock_acquire+0xd4/0x230
[  170.387410][ T1952]        __flush_work+0x8c/0x120
[  170.389457][ T1952]        work_on_cpu+0xb8/0xe0
[  170.391483][ T1952]        pci_call_probe+0x124/0x160
[  170.393508][ T1952]        pci_device_probe+0x68/0xd0
[  170.395530][ T1952]        really_probe+0x2c4/0x500
[  170.397615][ T1952]        driver_probe_device+0x124/0x150
[  170.399647][ T1952]        bus_for_each_drv+0x80/0xe0
[  170.401676][ T1952]        __device_attach+0x130/0x200
[  170.403703][ T1952]        pci_bus_add_device+0x78/0x100
[  170.405731][ T1952]        pci_bus_add_devices+0x60/0xd0
[  170.407734][ T1952]        pciehp_configure_device+0xf4/0x1f0
[  170.409737][ T1952]        board_added+0xa0/0x190
[  170.411712][ T1952]        __pciehp_enable_slot+0x64/0x100
[  170.413707][ T1952]        pciehp_enable_slot+0x4c/0x130
[  170.415718][ T1952]        pciehp_handle_presence_or_link_change+0x120/0x2a0
[  170.417783][ T1952]        pciehp_ist+0x1fc/0x280
[  170.419816][ T1952]        irq_thread_fn+0x4c/0xa0
[  170.421840][ T1952]        irq_thread+0xdc/0x150
[  170.423851][ T1952]        kthread+0x15c/0x1a0
[  170.425839][ T1952]        ret_from_kernel_thread+0x5c/0x78
[  170.427835][ T1952]
[  170.427835][ T1952] other info that might help us debug this:
[  170.427835][ T1952]
[  170.433742][ T1952] Chain exists of:
[  170.433742][ T1952]   (work_completion)(&wfc.work) -->
&ctrl->reset_lock --> pci_rescan_remove_lock
[  170.433742][ T1952]
[  170.439873][ T1952]  Possible unsafe locking scenario:
[  170.439873][ T1952]
[  170.444014][ T1952]        CPU0                    CPU1
[  170.446158][ T1952]        ----                    ----
[  170.448228][ T1952]   lock(pci_rescan_remove_lock);
[  170.450316][ T1952]                                lock(&ctrl->reset_lock);
[  170.452454][ T1952]
lock(pci_rescan_remove_lock);
[  170.454592][ T1952]   lock((work_completion)(&wfc.work));
[  170.456728][ T1952]
[  170.456728][ T1952]  *** DEADLOCK ***
[  170.456728][ T1952]
[  170.462943][ T1952] 3 locks held by irq/251-pciehp/1952:
[  170.465064][ T1952]  #0: 000000006b79c00e
(&ctrl->reset_lock){.+.+}, at: pciehp_ist+0xd0/0x280
[  170.467301][ T1952]  #1: 00000000788e6539
(pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x2c/0x40
[  170.469621][ T1952]  #2: 00000000af82701a (&dev->mutex){....}, at:
__device_attach+0x44/0x200
[  170.471965][ T1952]
[  170.471965][ T1952] stack backtrace:
[  170.476487][ T1952] CPU: 54 PID: 1952 Comm: irq/251-pciehp Tainted:
G        W         5.2.0-rc6-00074-g99d8de2-dirty #225
[  170.480804][ T1952] Call Trace:
[  170.484966][ T1952] [c000000005493110] [c000000000e22dd8]
__dump_stack+0x2c/0x40 (unreliable)
[  170.493286][ T1952] [c000000005493130] [c000000000e22ec0]
dump_stack+0xd4/0x144
[  170.500222][ T1952] [c000000005493180] [c000000000195da0]
print_circular_bug+0x160/0x170
[  170.508537][ T1952] [c000000005493210] [c000000000197640]
check_prev_add+0x6f0/0xef0
[  170.515472][ T1952] [c000000005493300] [c000000000197fa0]
check_prevs_add+0x160/0x1a0
[  170.523793][ T1952] [c000000005493360] [c000000000198500]
validate_chain.isra.12+0x520/0x780
[  170.532113][ T1952] [c000000005493420] [c000000000199d58]
__lock_acquire+0x358/0x7c0
[  170.540427][ T1952] [c0000000054934f0] [c00000000019ab94]
lock_acquire+0xd4/0x230
[  170.547366][ T1952] [c0000000054935b0] [c000000000135a9c]
__flush_work+0x8c/0x120
[  170.554299][ T1952] [c000000005493690] [c0000000001376f8]
work_on_cpu+0xb8/0xe0
[  170.562616][ T1952] [c000000005493730] [c00000000074c514]
pci_call_probe+0x124/0x160
[  170.569555][ T1952] [c000000005493780] [c00000000074cfc8]
pci_device_probe+0x68/0xd0
[  170.577868][ T1952] [c0000000054937c0] [c00000000087a274]
really_probe+0x2c4/0x500
[  170.584806][ T1952] [c000000005493850] [c00000000087a964]
driver_probe_device+0x124/0x150
[  170.593123][ T1952] [c0000000054938c0] [c000000000877120]
bus_for_each_drv+0x80/0xe0
[  170.601442][ T1952] [c000000005493910] [c00000000087a6b0]
__device_attach+0x130/0x200
[  170.608375][ T1952] [c0000000054939a0] [c000000000739eb8]
pci_bus_add_device+0x78/0x100
[  170.616694][ T1952] [c000000005493a10] [c000000000739fa0]
pci_bus_add_devices+0x60/0xd0
[  170.625014][ T1952] [c000000005493a50] [c00000000076a094]
pciehp_configure_device+0xf4/0x1f0
[  170.633339][ T1952] [c000000005493ad0] [c0000000007691b0]
board_added+0xa0/0x190
[  170.640268][ T1952] [c000000005493b50] [c000000000769304]
__pciehp_enable_slot+0x64/0x100
[  170.648588][ T1952] [c000000005493bd0] [c0000000007693ec]
pciehp_enable_slot+0x4c/0x130
[  170.656907][ T1952] [c000000005493c10] [c000000000769a10]
pciehp_handle_presence_or_link_change+0x120/0x2a0
[  170.666610][ T1952] [c000000005493c90] [c00000000076baec]
pciehp_ist+0x1fc/0x280
[  170.673549][ T1952] [c000000005493d20] [c0000000001b015c]
irq_thread_fn+0x4c/0xa0
[  170.680482][ T1952] [c000000005493d60] [c0000000001b10cc]
irq_thread+0xdc/0x150
[  170.688796][ T1952] [c000000005493db0] [c000000000140b6c] kthread+0x15c/0x1a0
[  170.695731][ T1952] [c000000005493e20] [c00000000000bb84]
ret_from_kernel_thread+0x5c/0x78
[  174.904923][ T1947] nvme nvme1: Shutdown timeout set to 10 seconds
[  174.993798][ T1947] nvme nvme1: 128/0/0 default/read/poll queues
