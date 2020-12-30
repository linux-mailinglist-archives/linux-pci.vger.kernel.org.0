Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD12E770D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 09:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL3IfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 03:35:19 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41086 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3IfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 03:35:19 -0500
Received: by mail-oi1-f180.google.com with SMTP id 15so18054746oix.8;
        Wed, 30 Dec 2020 00:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z1iQbzuKLwpLBU+2lS/Y5rQU9Azo11dSvRoqmQzzyCY=;
        b=HEjaIQW87dYHmJ/+oRkwjpcziYdlUYgZEftt9S8dRQ/A0Pcw5uktuk+qZNBPJvPORp
         c3UyiNs9hCd2ijr+xtFibHOple4wthyxICI2OtMq6LzE13Hg0l0LyaALy2RHAvyCcsJf
         Cisdx+1j06cCPf5zCPuom/aqTVgIfPV57d6viXRSSi48awBbLBU8fU52czwMxiKNl4E2
         Y1552GEV93+P88ZH/RsqQroFq0dTSDM6K3eeSQ9PA/tH/Rn+egb6tJKQi6GNjCGalERP
         kj7jgnhoKiKhz8mWWNGSRQTJoRLUsMT7jAZCI8Tb56wuVEYIa1YrLbV4KgUzkSeE+Yxy
         QoCQ==
X-Gm-Message-State: AOAM531vy5R8+q5E4yR+HLkBbcWvwoCYJr/vm35y1S2yMuAWq1xxb6yA
        BS3Yp/5FKL1gPusP6My52gNaxSKdwk0LgA8rwHx77rt3EaM=
X-Google-Smtp-Source: ABdhPJziLAtMMd1xAk/x2HeOkbfzMp78tJaD1UWG/xGDsAlfXQahkJDB/nkE3kb5qavHITasgTt1BQxGnZUTa+H27Zo=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr4690899oih.153.1609317277661;
 Wed, 30 Dec 2020 00:34:37 -0800 (PST)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Dec 2020 09:34:26 +0100
Message-ID: <CAMuHMdX_ksY_AnaGyL0Z4HjUv72ndRM7XsRHkSKaBP7J-xmN1A@mail.gmail.com>
Subject: pcie-rcar: rcu stall during s2ram
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek, Shimoda-san,

I got the following rcu stall on Salvator-X with R-Car M3-W ES1.0 during
resume from s2idle:

    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    rcu:     1-....: (524 ticks this GP) idle=ffa/1/0x4000000000000000
softirq=23053/23053 fqs=2437
     (detected by 3, t=6505 jiffies, g=39321, q=46)
    Task dump for CPU 1:
    task:kworker/u12:0   state:R  running task     stack:    0 pid:
943 ppid:     2 flags:0x0000000a
    Workqueue: events_unbound async_run_entry_fn
    Call trace:
     __switch_to+0xa8/0x10c
     0x0
    watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/u12:0:943]
    Modules linked in:
    irq event stamp: 0
    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
    hardirqs last disabled at (0): [<ffffffc010074960>]
copy_process+0x54c/0x12b8
    softirqs last  enabled at (0): [<ffffffc010074960>]
copy_process+0x54c/0x12b8
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    CPU: 1 PID: 943 Comm: kworker/u12:0 Not tainted
5.11.0-rc1-salvator-x-00727-g2e798beeefcc #877
    Hardware name: Renesas Salvator-X board based on r8a77960 (DT)
    Workqueue: events_unbound async_run_entry_fn
    pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
    pc : arch_local_irq_restore+0x4/0x8
    lr : _raw_spin_unlock_irqrestore+0x58/0x80
    sp : ffffffc013963b10
    x29: ffffffc013963b10 x28: 0000000000000000
    x27: ffffffc010f3f938 x26: 0000000000000000
    x25: 0000000000000000 x24: 0000000000000000
    x23: ffffffc013963bd4 x22: 0000000000000000
    x21: 0000000000000ffc x20: ffffffc0110da208
    x19: 0000000000000000 x18: 0000000000000000
    x17: 0000000000000000 x16: 0000000000000000
    x15: 000000000000000a x14: 7265776f70206567
    x13: 6e6168632074276e x12: 6f683344206d6f72
    x11: 6620657461747320 x10: 206769666e6f6328
    x9 : 203044206f742074 x8 : 0000000000000000
    x7 : 0000000000000001 x6 : 0000000000000000
    x5 : ffffffc013963b30 x4 : 0000000000000001
    x3 : ffffffc013bf7fb0 x2 : 0000000000000000
    x1 : 0000000000000027 x0 : 0000000000000000
    Call trace:
     arch_local_irq_restore+0x4/0x8
     pci_bus_read_config_dword+0x8c/0xc8
     pci_read_config_dword+0x38/0x40
     pci_find_next_ext_capability+0xc0/0xe0
     pci_find_ext_capability+0x14/0x1c
     pci_restore_aspm_l1ss_state+0x24/0x74
     pci_restore_state+0x80/0x2dc
     pci_pm_resume_noirq+0x8c/0xf8
     dpm_run_callback+0x64/0xd4
     device_resume_noirq+0xc8/0x174
     async_resume_noirq+0x24/0x54
     async_run_entry_fn+0x4c/0x124
     process_one_work+0x2f8/0x490
     worker_thread+0x1d0/0x274
     kthread+0xfc/0x10c
     ret_from_fork+0x10/0x18
    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    rcu:     1-....: (2094 ticks this GP)
idle=ffa/1/0x4000000000000000 softirq=23053/23053 fqs=9936
     (detected by 5, t=26010 jiffies, g=39321, q=90)
    Task dump for CPU 1:
    task:kworker/u12:0   state:R  running task     stack:    0 pid:
943 ppid:     2 flags:0x0000000a
    Workqueue: events_unbound async_run_entry_fn
    Call trace:
     __switch_to+0xa8/0x10c
     0x0

This is a board with an Intel E1000 Ethernet card installed, and
firmware including the L1 link state fix (else s2idle would crash
always).

Tree is based on renesas-drivers-2020-12-29-v5.11-rc1 with the following
patches applied:

    PCI: rcar: Always allocate MSI addresses in 32bit space
    PCI: rcar: Add L1 link state fix into data abort hook (shouldn't matter as

Compared with v5.11-rc1, above are the only changes to drivers/pci.
The second one shouldn't matter, as all code changes are protected by
#ifdef CONFIG_ARM, while this report is on arm64, which handles that
inside ATF.

This happened once, I couldn't reproduce it.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
