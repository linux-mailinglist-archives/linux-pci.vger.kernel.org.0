Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3433B159ECE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 02:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBLB4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 20:56:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46993 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBLB4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 20:56:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id e21so417005qtp.13
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2020 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=hlrdd1FktZHFolcXE5A6FSyjnZ51tnFP3ib+hsN1CAQ=;
        b=QJZaLXrGisJyodAXmhhD8lur3gX+qjAjmDRYN6NEZ0+TQDTNpkAXCAxWn4mt+d4BZI
         mNt9YSA9eur/AfNJdEOi9O+KHcS1GVrQ5VDTHSJEJifj1CkTPBE663Vnp14tRdwIr6qP
         PUzvEHE16w6I7KZRWWPaSBhYwgX6pUhg3f5/azMreLelIfdj474m7WoWwsHwCRB5ZJD2
         /fkqXPPbeRPQB+7psa/T3CwiQGiqGUg3dyQ+DpEW9o92ZEvLZDuennEj/USqyqBA7vj9
         G8Y4zVSHkQTZWAVN+PVcnLtOf72JsLR973e9zcvyW05YhOiSJaauBJtjIEljnv+/nJBv
         m9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=hlrdd1FktZHFolcXE5A6FSyjnZ51tnFP3ib+hsN1CAQ=;
        b=OgdJeZjc428D2Aml8Ji7YeBOTvvFMejFKzFhNZWtBqTrkpx08E4bsO7QVmgTQ4FGIQ
         fzRAHnGbRBjPT8cFXBNWx5bsnUZcBTfEkQk8/OAwRs+N5x7OeM9Iy9cZGDDEH4RUUPnn
         JPTnmfJYGplCykAfAZ+RKMEpRSCNMX0ocIIDdVfTjYxjLtF9TtzPPoiHslLJ9j3muJhf
         OqAobO2xNG0npIqloDSxh3HZPTLy/GMHbIZBUQ0b2xSY8D3Zo5I3MEmAvJK+zSDOZ3Xb
         hUqx2PpFQGTnosWnA5L55B6bydG41oHduXfjzJclmzPvtaQ2/5WQkdKV0E8KHx8k1pyd
         ro+Q==
X-Gm-Message-State: APjAAAWUNw/3p9wAoj6pJrlYho4mVVHh15v2Yi0vpo089Bb0BEnoVx63
        /awKlbVlivqD24tDqc6So+PjBw==
X-Google-Smtp-Source: APXvYqxD+RDv6BMnIQHk5qzYSIMni4Yt+LkEy6RySdKCNzSyPlfMpvkOpTvI8mS2EvKGWWrLh1xHZQ==
X-Received: by 2002:aed:29a2:: with SMTP id o31mr5092861qtd.279.1581472597886;
        Tue, 11 Feb 2020 17:56:37 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c184sm3000441qke.118.2020.02.11.17.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 17:56:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: "Plug non-maskable MSI affinity race" triggers a warning with CPU
 hotplugs
Message-Id: <FE2AA412-40A7-4FA2-A9E8-C7FA2919BD1D@lca.pw>
Date:   Tue, 11 Feb 2020 20:56:35 -0500
Cc:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The linux-next commit 6f1a4891a592 (=E2=80=9Cx86/apic/msi: Plug =
non-maskable MSI affinity race=E2=80=9D)
Introduced a bug which is always triggered during the CPU hotplugs on =
this server. See
the trace and line numbers below.

[30801.862014][ T5760] LTP: starting hugeshmget05 (hugeshmget05 -i 10)=20=

[30803.097105][ T5760] LTP: starting cpuhotplug02 (cpuhotplug02.sh -c 1 =
-l 1)=20
[30809.441006][   T16] IRQ 104: no longer affine to CPU1=20
[30809.466544][   T16] IRQ 125: no longer affine to CPU1=20
[30809.492799][   T16] process 21134 (cpuhotplug_do_s) no longer affine =
to cpu1=20
[30809.494344][T21112] smpboot: CPU 1 is now offline=20
[30811.071179][T21112] x86: Booting SMP configuration:=20
[30811.097476][T21112] smpboot: Booting Node 0 Processor 1 APIC 0x2=20
[30813.213453][ T5760] LTP: starting cpuhotplug03 (cpuhotplug03.sh -c 1 =
-l 1)=20
[30817.456909][T21146] smpboot: CPU 1 is now offline=20
[30828.916751][T21146] x86: Booting SMP configuration:=20
[30828.942396][T21146] smpboot: Booting Node 0 Processor 1 APIC 0x2=20
[-- MARK -- Tue Feb 11 22:40:00 2020]=20
[30855.147353][ T5760] LTP: starting cpuhotplug04 (cpuhotplug04.sh -l 1)=20=

[30859.353961][   T16] IRQ 119: no longer affine to CPU1=20
[30859.381931][T22008] smpboot: CPU 1 is now offline=20
[30859.557430][   T21] IRQ 106: no longer affine to CPU2=20
[30859.582708][T22008] smpboot: CPU 2 is now offline=20
[30860.042902][   T26] IRQ 113: no longer affine to CPU3=20
[30860.069520][T22008] smpboot: CPU 3 is now offline=20
[30860.464752][T22008] smpboot: CPU 4 is now offline=20
[30860.987206][   T36] IRQ 124: no longer affine to CPU5=20
[30861.015866][T22008] smpboot: CPU 5 is now offline=20
[30861.632409][T22008] smpboot: CPU 6 is now offline=20
[30862.051962][   T46] IRQ 125: no longer affine to CPU7=20
[30862.076156][T22008] smpboot: CPU 7 is now offline=20
[30862.577746][T22008] smpboot: CPU 8 is now offline=20
[30863.014959][   T56] IRQ 123: no longer affine to CPU9=20
[30863.040760][T22008] smpboot: CPU 9 is now offline=20
[30863.494227][T22008] smpboot: CPU 10 is now offline=20
[30863.922548][   T66] IRQ 121: no longer affine to CPU11=20
[30863.949053][T22008] smpboot: CPU 11 is now offline=20
[30865.734181][T22008] smpboot: CPU 12 is now offline=20
[30867.883120][T22008] smpboot: CPU 13 is now offline=20
[30870.013237][T22008] smpboot: CPU 14 is now offline=20
[30872.123324][T22008] smpboot: CPU 15 is now offline=20
[30875.003486][T22008] smpboot: CPU 16 is now offline=20
[30877.233482][T22008] smpboot: CPU 17 is now offline=20
[30879.383349][T22008] smpboot: CPU 18 is now offline=20
[30881.233183][T22008] smpboot: CPU 19 is now offline=20
[30883.473628][T22008] smpboot: CPU 20 is now offline=20
[30886.093474][T22008] smpboot: CPU 21 is now offline=20
[30888.085684][T22008] smpboot: CPU 22 is now offline=20
[30890.165790][T22008] smpboot: CPU 23 is now offline=20
[30890.556773][  T132] IRQ 122: no longer affine to CPU24=20
[30890.582921][T22008] smpboot: CPU 24 is now offline=20
[30890.803132][  T137] IRQ 119: no longer affine to CPU25=20
[30890.833943][T22008] smpboot: CPU 25 is now offline=20
[30891.252422][  T142] IRQ 109: no longer affine to CPU26=20
[30891.275535][  T142] IRQ 116: no longer affine to CPU26=20
[30891.302447][T22008] smpboot: CPU 26 is now offline=20
[30891.580237][  T147] IRQ 115: no longer affine to CPU27=20
[30891.607772][  T147] IRQ fixup: irq 123 move in progress, old vector =
34=20
[30891.642439][T22008] smpboot: CPU 27 is now offline=20
[30891.893758][  T152] IRQ 107: no longer affine to CPU28=20
[30891.917209][  T152] IRQ 114: no longer affine to CPU28=20
[30891.940381][  T152] IRQ fixup: irq 121 move in progress, old vector =
34=20
[30891.971105][T22008] smpboot: CPU 28 is now offline=20
[30892.245251][  T157] IRQ 108: no longer affine to CPU29=20
[30892.272343][  T157] IRQ 113: no longer affine to CPU29=20
[30892.300690][T22008] smpboot: CPU 29 is now offline=20
[30892.574296][  T162] IRQ 106: no longer affine to CPU30=20
[30892.598705][T22008] smpboot: CPU 30 is now offline=20
[30892.801901][T22008] smpboot: CPU 31 is now offline=20
[30893.246486][T22008] smpboot: CPU 32 is now offline=20
[30893.549519][T22008] smpboot: CPU 33 is now offline=20
[30893.908288][T22008] smpboot: CPU 34 is now offline=20
[30894.091385][T22008] smpboot: CPU 35 is now offline=20
[30894.472537][ T2794] ------------[ cut here ]------------=20
[30894.498223][ T2794] WARNING: CPU: 0 PID: 2794 at =
arch/x86/kernel/apic/msi.c:103 msi_set_affinity+0x278/0x330=20
[30894.543016][ T2794] Modules linked in: brd ext4 crc16 mbcache jbd2 =
loop nls_iso8859_1 nls_cp437 vfat fat kvm_intel kvm irqbypass =
intel_cstate intel_uncore dax_pmem dax_pmem_core intel_rapl_perf efivars =
ip_tables x_tables xfs sd_mod ahci libahci libata igb hpsa i2c_algo_bit =
scsi_transport_sas i2c_core tg3 firmware_class libphy dm_mirror =
dm_region_hash dm_log dm_mod efivarfs [last unloaded: binfmt_misc]=20
[30894.709559][ T2794] CPU: 0 PID: 2794 Comm: irqbalance Tainted: G      =
       L    5.6.0-rc1-next-20200211 #1=20
[30894.753946][ T2794] Hardware name: HP ProLiant XL450 Gen9 =
Server/ProLiant XL450 Gen9 Server, BIOS U21 05/05/2016=20
[30894.799739][ T2794] RIP: 0010:msi_set_affinity+0x278/0x330=20
[30894.824950][ T2794] Code: 49 c7 44 05 00 00 00 00 00 44 89 f0 48 8b =
4d d0 65 48 33 0c 25 28 00 00 00 75 6b 48 83 ec 80 5b 41 5c 41 5d 41 5e =
41 5f 5d c3 <0f> 0b 4c 89 e6 48 89 df e8 9b fc ff ff eb bd 48 8d 7b 18 =
e8 20 05=20
[30894.912256][ T2794] RSP: 0018:ffffc90005e4fa58 EFLAGS: 00010093=20
[30894.939043][ T2794] RAX: 0000000000000000 RBX: ffff88836f0b0428 RCX: =
ffffffffa5e8ef91=20
[30894.974228][ T2794] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: =
ffff88836dfe8c40=20
[30895.009472][ T2794] RBP: ffffc90005e4fb00 R08: fffffbfff4e98461 R09: =
fffffbfff4e98461=20
[30895.044982][ T2794] R10: fffffbfff4e98460 R11: ffffffffa74c2303 R12: =
ffff88836dfe8c40=20
[30895.080170][ T2794] R13: 1ffff92000bc9f4f R14: 0000000000000000 R15: =
ffff88836dfe8c44=20
[30895.115503][ T2794] FS:  00007f30e37a3e80(0000) =
GS:ffff888452600000(0000) knlGS:0000000000000000=20
[30895.160815][ T2794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20=

[30895.189818][ T2794] CR2: 00007ffdac9e4f20 CR3: 00000007268d0002 CR4: =
00000000001606f0=20
[30895.225606][ T2794] Call Trace:=20
[30895.239777][ T2794]  ? irq_msi_update_msg+0xe0/0xe0=20
[30895.261672][ T2794]  ? rwlock_bug.part.1+0x60/0x60=20
[30895.284071][ T2794]  irq_do_set_affinity+0x75/0x180=20
irq_do_set_affinity+0x75/0x180:
irq_do_set_affinity at kernel/irq/manage.c:259
[30895.306065][ T2794]  irq_setup_affinity+0x167/0x250=20
irq_setup_affinity at kernel/irq/manage.c:474
[30895.328157][ T2794]  irq_select_affinity_usr+0x30/0x50=20
irq_select_affinity_usr at kernel/irq/manage.c:496
[30895.351507][ T2794]  write_irq_affinity.isra.0+0x137/0x1e0=20
[30895.376891][ T2794]  ? irq_node_proc_show+0x50/0x50=20
[30895.398821][ T2794]  ? match_held_lock+0x35/0x250=20
[30895.419982][ T2794]  irq_affinity_proc_write+0x19/0x20=20
[30895.444225][ T2794]  proc_reg_write+0x12e/0x190=20
[30895.464538][ T2794]  ? proc_reg_read+0x190/0x190=20
[30895.485249][ T2794]  ? rcu_read_lock_held+0xc0/0xc0=20
[30895.507212][ T2794]  __vfs_write+0x50/0xa0=20
[30895.526323][ T2794]  vfs_write+0x105/0x280=20
[30895.545621][ T2794]  ksys_write+0xc6/0x160=20
[30895.564993][ T2794]  ? __x64_sys_read+0x50/0x50=20
[30895.585337][ T2794]  ? do_syscall_64+0x79/0xaec=20
[30895.605686][ T2794]  ? do_syscall_64+0x79/0xaec=20
[30895.626066][ T2794]  __x64_sys_write+0x43/0x50=20
[30895.648476][ T2794]  do_syscall_64+0xcc/0xaec=20
[30895.671473][ T2794]  ? trace_hardirqs_on_thunk+0x1a/0x1c=20
[30895.696452][ T2794]  ? syscall_return_slowpath+0x580/0x580=20
[30895.721226][ T2794]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe=20
[30895.748025][ T2794]  ? trace_hardirqs_off_caller+0x3a/0x150=20
[30895.773033][ T2794]  ? trace_hardirqs_off_thunk+0x1a/0x1c=20
[30895.797308][ T2794]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=20
[30895.823118][ T2794] RIP: 0033:0x7f30e23a1e4f=20
[30895.842371][ T2794] Code: 00 00 00 41 54 49 89 d4 55 48 89 f5 53 89 =
fb 48 83 ec 10 e8 23 ca 01 00 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 =
00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 5c ca =
01 00 48=20
[30895.930359][ T2794] RSP: 002b:00007ffdac9e1760 EFLAGS: 00000293 =
ORIG_RAX: 0000000000000001=20
[30895.967557][ T2794] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: =
00007f30e23a1e4f=20
[30896.002786][ T2794] RDX: 0000000000000011 RSI: 0000556488e3d310 RDI: =
0000000000000007=20
[30896.038063][ T2794] RBP: 0000556488e3d310 R08: 0000000000000000 R09: =
0000556486f3b200=20
[30896.073471][ T2794] R10: 0000000000000000 R11: 0000000000000293 R12: =
0000000000000011=20
[30896.108344][ T2794] R13: 0000000000000011 R14: 00007f30e266e740 R15: =
0000000000000011=20
[30896.143550][ T2794] irq event stamp: 378868746=20
[30896.165644][ T2794] hardirqs last  enabled at (378868745): =
[<ffffffffa6210123>] quarantine_put+0x73/0x270=20
[30896.214017][ T2794] hardirqs last disabled at (378868746): =
[<ffffffffa6892748>] _raw_spin_lock_irqsave+0x18/0x50=20
[30896.261385][ T2794] softirqs last  enabled at (378868364): =
[<ffffffffa6c00447>] __do_softirq+0x447/0x766=20
[30896.303183][ T2794] softirqs last disabled at (378867251): =
[<ffffffffa5ed1da6>] irq_exit+0xd6/0xf0=20
[30896.343633][ T2794] ---[ end trace a0a160876a02c150 ]---=20
[30897.964246][T22008] smpboot: CPU 36 is now offline=20
[30906.533125][T22008] smpboot: CPU 37 is now offline=20
[30914.823295][T22008] smpboot: CPU 38 is now offline=20
[30920.594545][T22008] smpboot: CPU 39 is now offline=20
[30926.504299][T22008] smpboot: CPU 40 is now offline=20
[30931.962884][T22008] smpboot: CPU 41 is now offline=20
[30937.492970][T22008] smpboot: CPU 42 is now offline=20
[30942.822984][T22008] smpboot: CPU 43 is now offline=20
[30948.543231][T22008] smpboot: CPU 44 is now offline=20
[30954.005524][T22008] smpboot: CPU 45 is now offline=20
[30962.765295][T22008] smpboot: CPU 46 is now offline=20
[30963.112374][  T247] irq_migrate_all_off_this_cpu: 10 callbacks =
suppressed=20
[30963.112380][  T247] IRQ 3: no longer affine to CPU47


