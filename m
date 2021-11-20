Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981D457C02
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 07:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhKTGVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 01:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhKTGV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Nov 2021 01:21:29 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB251C061574
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 22:18:25 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id n6so25743179uak.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 22:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pvOc4dl3L4FNez6jpHuUc5lOXfbyBzqt5qXJyy8weNE=;
        b=K0Jomm+wS/N3xDIl4q9GSqtGDq/swgibrKC9tkf0m2986RVTYVhRTyIw5QCDz96z4l
         AL6gblF/Tfn9dnEVOt49teZpobGpp4pK0/X992Ex+zuYvcIda1TDWmyuCDMzj9Z3hqRf
         igN74TzD29OpurZAcylEtmqKkL7NmMm01mp64ftPporMDaF+7XP8QdNUY/0qg46eLYK0
         qIXb8qofM4SalEEFOxkFsLrHjBQChzrmoKqWxT/isLIJ11eG2zhEr/XiPannEuMxLd8y
         x9wU3HjcYvKrP7RS5yRJXWWTPkcuyg5Oam9IYZw3DS4sOqEiM8Jx0mz/1GRzHp5AWcUX
         Y0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pvOc4dl3L4FNez6jpHuUc5lOXfbyBzqt5qXJyy8weNE=;
        b=iWY1lCFDF4paF5T+8y8e3/H1EUkJef/gMjFV7VUK56zCqSDEPk/GUbpWG5tpuZvSYV
         Qx78iQ7b8Y0uFP9qbCa14b/ZS3rhcyXq9fXAhiugVyoqFMkGo/o76t7qu0+yklmo7RVx
         hl0acR0Irhc2jjUhQKyRT5PMnpWBHCA5F+OJFjSk88fny+j2XBtOXIcCDGYoFALFoJEz
         /JTtxkhbjEC8nYFJagxFaSHbN/dm9i91VF3bUTh/nqMrLxACZUVwlnvPJlnnFAk2zyeX
         /yvRc4OoVIsa4pCc5884AahgUlKnw1MJdHlYXvTBKnHuxHLNF74xO2xiHr/tQERwtBlp
         u6iA==
X-Gm-Message-State: AOAM532zRHVKGSyXIh0C8V+H/u9kwS5g2VIRnaXDERRZAS90X9afV/if
        79D0L9YGbRUApFV830KXrS6eU660pwXKjv8rx/bEEpkLcok=
X-Google-Smtp-Source: ABdhPJw/Sr8KMAZeqvicMU9HG/K9x6QXQ0Ql7IG0I29ZrN7Bvrte0H1EfLAksb6dXRR5Up2dpMGgiR497O44bXl0j4w=
X-Received: by 2002:ab0:3349:: with SMTP id h9mr59554287uap.111.1637389104633;
 Fri, 19 Nov 2021 22:18:24 -0800 (PST)
MIME-Version: 1.0
From:   Rich <rincebrain@gmail.com>
Date:   Sat, 20 Nov 2021 01:18:15 -0500
Message-ID: <CAOeNLur-w2LEPqPWQHXC1nhsq=m-mBbmB0z-LB01MA4fHxaUyA@mail.gmail.com>
Subject: Panic on boot on T5140 since 7d5ec3d3
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I recently booted Linux on a SPARC Enterprise T5140, and much to my
surprise, Linux 5.14 panicked on boot, every time:

[   52.668746] NON-RESUMABLE ERROR: Reporting on cpu 39
[   52.668893] NON-RESUMABLE ERROR: TPC [0x000000000093798c]
<__pci_enable_msix_range+0x38c/0x6c0>
[   52.669062] NON-RESUMABLE ERROR: RAW
[0271000000000001:000000227ebd18ff:0000000202000080:ffffffffffffffff
[   52.669220] NON-RESUMABLE ERROR:
0000000800000000:0000000000000000:0000000000000000:0000000000000000]
[   52.669338] NON-RESUMABLE ERROR: handle [0x0271000000000001] stick
[0x000000227ebd18ff]
[   52.669413] NON-RESUMABLE ERROR: type [precise nonresumable]
[   52.669474] NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
[   52.669566] NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
[   52.669629] NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
[   52.669694] NON-RESUMABLE ERROR: size [0x8]
[   52.669738] NON-RESUMABLE ERROR: asi [0x00]
[   52.669784] CPU: 39 PID: 1906 Comm: insmod Tainted: G            E
   5.14.0-4-sparc64-smp #1  Debian 5.14.16-1
[   52.669888] TSTATE: 0000004411001607 TPC: 000000000093798c TNPC:
0000000000937990 Y: 00000000    Tainted: G            E
[   52.669986] TPC: <__pci_enable_msix_range+0x38c/0x6c0>
[   52.670055] g0: 0000000000000001 g1: 0000000000000020 g2:
000000c500200000 g3: 0000000000000000
[   52.670132] g4: ffff800024cf3d80 g5: ffff8007fc8d8000 g6:
ffff80003036c000 g7: 00000000000000e2
[   52.670210] o0: ffff8007fe6b0f00 o1: 0000000000000001 o2:
0000000000000000 o3: 000000c50020000c
[   52.670286] o4: 000000000000002a o5: ffff800016c650c8 sp:
ffff80003036e3c1 ret_pc: 0000000000008080
[   52.670363] RPC: <0x8080>
[   52.670410] l0: ffff80003036ee14 l1: ffff800016c652f0 l2:
ffff8007fe6b0f00 l3: 0000000000000000
[   52.670487] l4: 00000000ffffffff l5: 0000000000000000 l6:
ffff800016c650c8 l7: ffff800016c65000
[   52.670563] i0: 000000000000000d i1: ffff80003036ee10 i2:
0000000000000001 i3: 000000000000000d
[   52.670638] i4: 0000000000000000 i5: 000000c500200000 i6:
ffff80003036e4b1 i7: 0000000000937ce0
[   52.670713] I7: <pci_enable_msix_range+0x20/0x40>
[   52.670767] Call Trace:
[   52.670807] [<0000000000937ce0>] pci_enable_msix_range+0x20/0x40
[   52.670879] [<00000000108a7a08>] niu_try_msix+0xc8/0x1a0 [niu]
[   52.671008] [<00000000108af1f8>] niu_get_invariants+0x478/0x28a0 [niu]
[   52.671133] [<00000000108b1878>] niu_pci_init_one+0x258/0x420 [niu]
[   52.671258] [<000000000092dfcc>] pci_device_probe+0xcc/0x180
[   52.671335] [<00000000009cd404>] really_probe+0xc4/0x480
[   52.671404] [<00000000009cd8e4>] __driver_probe_device+0x124/0x180
[   52.671474] [<00000000009cd968>] driver_probe_device+0x28/0xe0
[   52.671545] [<00000000009ce1c4>] __driver_attach+0xc4/0x200
[   52.671614] [<00000000009caa98>] bus_for_each_dev+0x58/0xa0
[   52.671698] [<00000000009cca3c>] driver_attach+0x1c/0x40
[   52.671778] [<00000000009cc450>] bus_add_driver+0x1d0/0x240
[   52.671858] [<00000000009cee28>] driver_register+0x88/0x140
[   52.671929] [<000000000092c528>] __pci_register_driver+0x48/0x60
[   52.672001] [<00000000108be070>] niu_init+0x70/0x94 [niu]
[   52.672123] [<0000000000427cf0>] do_one_initcall+0x30/0x220
[   52.672202] Kernel panic - not syncing: Non-resumable error.
[   52.672264] CPU: 39 PID: 1906 Comm: insmod Tainted: G            E
   5.14.0-4-sparc64-smp #1  Debian 5.14.16-1
[   52.672362] Call Trace:
[   52.672400] [<0000000000c878e0>] dump_stack+0x8/0x18
[   52.672471] [<0000000000c839d8>] panic+0xf4/0x350
[   52.672540] [<000000000042a740>] sun4v_nonresum_error+0xe0/0x100
[   52.672616] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[   52.672699] [<000000000093798c>] __pci_enable_msix_range+0x38c/0x6c0
[   52.672770] [<0000000000937ce0>] pci_enable_msix_range+0x20/0x40
[   52.672840] [<00000000108a7a08>] niu_try_msix+0xc8/0x1a0 [niu]
[   52.672962] [<00000000108af1f8>] niu_get_invariants+0x478/0x28a0 [niu]
[   52.673087] [<00000000108b1878>] niu_pci_init_one+0x258/0x420 [niu]
[   52.673211] [<000000000092dfcc>] pci_device_probe+0xcc/0x180
[   52.673284] [<00000000009cd404>] really_probe+0xc4/0x480
[   52.673351] [<00000000009cd8e4>] __driver_probe_device+0x124/0x180
[   52.673422] [<00000000009cd968>] driver_probe_device+0x28/0xe0
[   52.673493] [<00000000009ce1c4>] __driver_attach+0xc4/0x200
[   52.673564] [<00000000009caa98>] bus_for_each_dev+0x58/0xa0
[   52.673645] [<00000000009cca3c>] driver_attach+0x1c/0x40
[   52.677868] Press Stop-A (L1-A) from sun keyboard or send break
[   52.677868] twice on console to return to the boot prom
[   52.677967] ---[ end Kernel panic - not syncing: Non-resumable error. ]---


I bisected this (since it didn't happen on 5.10), and ultimately found
that it came from 7d5ec3d3 - in particular, the readl() here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/pci/msi.c?h=v5.14#n748

I found that if you just substitute the readl() for an unconditional
1, the driver (and the rest of the system, in my limited testing)
functions as expected, instead.

I also observed, with a debug printk right above the call, that one
readl() call attempt happens without the system dying before the one
which panics.

I saw that section of code was shuffled a bit in the upcoming 5.16, so
I tried that, and got approximately the same stacktrace panic.

The system boots normally with the niu driver either in the module
blacklist or otherwise unavailable, (so other hardware, like the ixgbe
NIC I put in, don't have this issue), but still panics if you load
"niu" after boot.

Interestingly, if you boot the system from a pre-7d5ec3d3 kernel, and
then warm reboot it, even post-7d5ec3d3 kernels work without complaint
until cold power cycle.

I'm not sure what's going wrong here, other than "niu is special and
strange". But I assumed that this is probably not the only hardware
with a failure mode like this, even if nobody else was running one of
this particular model any more.

- Rich
