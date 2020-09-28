Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2727A9C4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1ImW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1ImW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:42:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB6C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 01:42:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so346616pfk.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LbSvS6xucv6qQU6kb4xODer9d183a3qn9bjDS4gtIws=;
        b=aeknpsxF7DM72WJ/40+nFkB1xu/WjrmEb3jnEFVekimZREQwycQGZO4FBj6+IVsoc2
         pH6CcQllUExMB/3NCvXJHnIuNIKs9DZh9Pfcs9W/b8zQdzMuLoc88VgERYclatJBEAS6
         DANJZ5EjMLcrH16VmO33MJdw5Yd+3kJC9Eg+yJeYDcJBY9Co+D+KAzekBs5r3jbkMsfg
         14knf7ZSH+NAyyO9knr6HXzYi5EqZFU4yN9zk1rqM3iUWKsfkyk7KU+M5J4PPHtrp0W5
         uSj73PhaVAKqTcGz+BZAkZFTNKMAXhyKSm4iBBb/P1CQPOEwN72sPGrL49ZnOUjfL1tF
         Qycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LbSvS6xucv6qQU6kb4xODer9d183a3qn9bjDS4gtIws=;
        b=eTAqRCY2X61huCLR4ZAOtJ0jqNW4pb2ApsEVU0iexKvge6ibP+z4XqKTrOySIBHzbb
         io8+wF9+bKRhndujn9JUQPNw0w2L5kBQbN+j/h5B52tW22pS+9SGsQsGzPsuNwykMSV5
         RlX+DZi/DoFC5q60MoQvTRUOIyJ/zVFr+Hb37yp2gk49BO7wCPoo/hpASmrYL3/gqe9O
         h+k/Y1fDdePIo1LzdUVdKhLC5IN2AmNWt0SVztjS/kyk2X1TORmszMZ3u3mMP+f3xx2Q
         5uvCXgH26ehrwoALRy4Siwu6snAKX11V03GUhlyh21QhWGfBKEr4kbIrocotOw9U+dsa
         l1IA==
X-Gm-Message-State: AOAM532PWn9qPQlz04d7maVj/tofUFZx/MVeReas2vy792hwdntIBJhm
        Nrz6lD/UGabFqpAgPRY7ZHVB5AQ8zF5263wK/mc=
X-Google-Smtp-Source: ABdhPJyAp7m6nKyLgfxEk6lztleswMiQDjDSM/xir4ism+bljlVXOLh2HDwBhf/2/gQugZ7RbfHmXkXnzq8mzjvYl4E=
X-Received: by 2002:a63:d648:: with SMTP id d8mr399965pgj.4.1601282541848;
 Mon, 28 Sep 2020 01:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
 <20200927082736.14633-3-haifeng.zhao@intel.com> <CAHp75VdnwfcNFZ3puPcKSyQk1WbtJJefVDMSC=o8r016nHEgcA@mail.gmail.com>
 <MWHPR11MB1696B1DF37BE8F323E67FEE497350@MWHPR11MB1696.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1696B1DF37BE8F323E67FEE497350@MWHPR11MB1696.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Sep 2020 11:42:03 +0300
Message-ID: <CAHp75Ve7fQpRweq9dQ_gnU37X5qzz2vZZv++m+_M1SV-W9ou3A@mail.gmail.com>
Subject: Re: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     "Zhao, Haifeng" <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 5:24 AM Zhao, Haifeng <haifeng.zhao@intel.com> wrot=
e:
>
> Andy,
>     May I ask what you think that's not relevant in the oops ?  any rules=
 ?

First of all, please don't send private messages on OSS development
matters (partially returned Cc list).
Second, stop top postings.

Now to the question, the rule is simple =E2=80=94 it's called "common sense=
".
See below the examples, but you may cut even more. So, don't pollute
commit messages with unrelated information.

> On Sun, Sep 27, 2020 at 11:31 AM Ethan Zhao <haifeng.zhao@intel.com> wrot=
e:

...

> >    Buffer I/O error on dev nvme0n1p1, logical block 3328, async page re=
ad
> >    BUG: kernel NULL pointer dereference, address: 0000000000000050

The below...

> >    #PF: supervisor read access in kernel mode
> >    #PF: error_code(0x0000) - not-present page
> >    PGD 0
>
> Seems like you randomly did something about the series and would like it =
to be applied?! It's no go!
> Please, read my comments again v1 one more time and carefully comment or =
address.
>
> Why do you still have these (some above, some below this comment) non-rel=
evant lines of oops?

..

> >    Oops: 0000 [#1] SMP NOPTI

...is anybody getting new information from the above? I don't think so.

> >    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0 el8.x86_64+=
 #1
> >    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
> >    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8=
 d3
> >    65 ff ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b =
50
> >    50 48 83 3a 00 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
> >    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
> >    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
> >    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
> >    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
> >    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
> >    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
> >    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knl
> >    GS:0000000000000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
> >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    PKRU: 55555554
> >    Call Trace:
> >    ? report_normal_detected+0x20/0x20
> >    report_frozen_detected+0x16/0x20
> >    pci_walk_bus+0x75/0x90
> >    ? dpc_irq+0x90/0x90
> >    pcie_do_recovery+0x157/0x201
> >    ? irq_finalize_oneshot.part.47+0xe0/0xe0
> >    dpc_handler+0x29/0x40
> >    irq_thread_fn+0x24/0x60

The below, for example, does it affect anyhow the meaning of the crash
log? I don't think so, can be cut.

> >    irq_thread+0xea/0x170
> >    ? irq_forced_thread_fn+0x80/0x80
> >    ? irq_thread_check_affinity+0xf0/0xf0
> >    kthread+0x124/0x140
> >    ? kthread_park+0x90/0x90
> >    ret_from_fork+0x1f/0x30
> >    Modules linked in: nft_fib_inet.........
> >    CR2: 0000000000000050


--
With Best Regards,
Andy Shevchenko
