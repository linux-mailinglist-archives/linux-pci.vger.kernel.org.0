Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9E279FD6
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgI0JKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0JKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 05:10:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50023C0613CE;
        Sun, 27 Sep 2020 02:10:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so1872034pjb.0;
        Sun, 27 Sep 2020 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6+smWil3kBNxCFTdFa+PJ+ViuAN+orlSM8DpJ8wbXw=;
        b=kFc9l+XKStoxrLpeZvZyhCoUKzgG5A9nIzD9kDxli3idsmsHF9D9waqGJmUns+ijpQ
         tIje17NLGjBAaXD5FAYGdh9E5NSKjnyrDpRCQx1LScP7zmz+251XFIEp608OscL/GKNz
         nna+sVo/RyRmagLYdKDy+m7Pla91rX1GYZjlTgBw1CgRvtOIzfUWdT4uEY7EDehZYJxM
         TW34wKyVrPVI7ItR7iP1xvsW/b8EnT2Izj+FdT81KBSxSiwL7kfByLlr/8ZvFjx2OZtQ
         mhoWbH6f4iY0jWLhLs1EBwNaWTzcCE0XxQelGwbk95dkBvpDv8ZtFbm/qana5NTQ9jrI
         aamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6+smWil3kBNxCFTdFa+PJ+ViuAN+orlSM8DpJ8wbXw=;
        b=msqqjNUIogjCpCN26MhU/30rYIJspsCc9viqr6GSyzxrikRjhWJOcYoXBivTt7KY14
         oiWiVjg+YnveflNHEUgX6WazDKSfEMHTUm0p3jHxjSocFcLHEzb75hnKGe8J3Sye8hUK
         lVUcBER+92MGeF/wXrxUECyAChXsmZDOG7ruC216+w8FnjcfOFyb0ZjGJdOjHEOMC/b2
         k7yNJBSe7mmtqwlui203Rju/1seigKARIODiIdAZ9wxfuFeL/WRYle1bUbGWhQVIS07V
         ejE6PF6NPHCZOms7npTc3Vk9Jz/Nxjj7JEVpKBS1YLi93ZfqzuCRYBtj5UQLE5Ly32GD
         r4LA==
X-Gm-Message-State: AOAM531NDS0oQOIWV5rtyjjJDZdd/sJa3Gv+jsxP7KjhAHonHg3iL0d2
        V/5BF6r+jBlH5bNrie5j05lbjArzky9MXYTKajc=
X-Google-Smtp-Source: ABdhPJzjdUhN6mVzovLJfS7ySNocdboBiixufGJ1Rx5uClBpm69LYwO/Nhpu2h6SlrfC0Bb94JDl3zJHC74mJ3cvoxY=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr4701864pjb.181.1601197820806;
 Sun, 27 Sep 2020 02:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082736.14633-1-haifeng.zhao@intel.com> <20200927082736.14633-3-haifeng.zhao@intel.com>
In-Reply-To: <20200927082736.14633-3-haifeng.zhao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Sep 2020 12:10:04 +0300
Message-ID: <CAHp75VdnwfcNFZ3puPcKSyQk1WbtJJefVDMSC=o8r016nHEgcA@mail.gmail.com>
Subject: Re: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Ethan Zhao <haifeng.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 11:31 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:
>
> When root port has DPC capability and it is enabled, then triggered by
> errors, DPC DLLSC and PDC interrupts will be sent to DPC driver, pciehp
> driver at the same time.
> That will cause following result:
>
> 1. Link and device are recovered by hardware DPC and software DPC driver,
>    device
>    isn't removed, but the pciehp might treat it as device was hot removed.
>
> 2. Race condition happens bettween pciehp_unconfigure_device() called by
>    pciehp_ist() in pciehp driver and pci_do_recovery() called by
>    dpc_handler in DPC driver. no luck, there is no lock to protect
>    pci_stop_and_remove_bus_device()
>    against pci_walk_bus(), they hold different samphore and mutex,
>    pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and
>    pci_walk_bus() holds pci_bus_sem.
>
> This race condition is not purely code analysis, it could be triggered by
> following command series:
>
>   # setpci -s 64:02.0 0x196.w=000a // 64:02.0 rootport has DPC capability
>   # setpci -s 65:00.0 0x04.w=0544  // 65:00.0 NVMe SSD populated in port
>   # mount /dev/nvme0n1p1 nvme
>
> One shot will cause system panic and NULL pointer reference happened.
> (tested on stable 5.8 & ICS(Ice Lake SP platform, see
> https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))
>
>    Buffer I/O error on dev nvme0n1p1, logical block 3328, async page read
>    BUG: kernel NULL pointer dereference, address: 0000000000000050
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0

Seems like you randomly did something about the series and would like
it to be applied?! It's no go!
Please, read my comments again v1 one more time and carefully comment
or address.

Why do you still have these (some above, some below this comment)
non-relevant lines of oops?

>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0 el8.x86_64+ #1
>    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
>    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d3
>    65 ff ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50
>    50 48 83 3a 00 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
>    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
>    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
>    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
>    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
>    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
>    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knl
>    GS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
>    ? report_normal_detected+0x20/0x20
>    report_frozen_detected+0x16/0x20
>    pci_walk_bus+0x75/0x90
>    ? dpc_irq+0x90/0x90
>    pcie_do_recovery+0x157/0x201
>    ? irq_finalize_oneshot.part.47+0xe0/0xe0
>    dpc_handler+0x29/0x40
>    irq_thread_fn+0x24/0x60
>    irq_thread+0xea/0x170
>    ? irq_forced_thread_fn+0x80/0x80
>    ? irq_thread_check_affinity+0xf0/0xf0
>    kthread+0x124/0x140
>    ? kthread_park+0x90/0x90
>    ret_from_fork+0x1f/0x30
>    Modules linked in: nft_fib_inet.........
>    CR2: 0000000000000050

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

And no, this is not how the tags are being applied.


-- 
With Best Regards,
Andy Shevchenko
