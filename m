Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBA26CFF1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 02:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIQA2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQA17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 20:27:59 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:27:59 EDT
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881FC06174A;
        Wed, 16 Sep 2020 17:22:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so282387ota.8;
        Wed, 16 Sep 2020 17:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YRVR66T1JllHvULe65eBcG34RMx0s6duNjPy9GYn8E=;
        b=uF0zWUq4tKO+fSzmEYQEsRiwoHrEheDLSl9VnIzegWQyc/4kpmLvwO/NxFNom6iNF4
         uIXzG3RpIJ+XCrITjdKiNNvuQVUZ0F8uYHfVkSPN/N1zqVWW8zfHZqHZrZ4SDwHyrwfU
         +QKFCM3HUNxqkR/15BJOSS/ON5AFYlnBS6/6FkYxYBF5rVDbK9DF6u0D1HSCOolgDWVP
         IaPEGre3KQRZva0qgsuYGnr3t8nzM7b8qFK5ug78SX4beJ9pDkVCCXl8mKMjmunMi1b8
         K35PvYfSVz6shENDYzCN3g5k2kliys3NSl1h0y27uHIxDZD1QGvLqpqbb4EiFc5VO/en
         gVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YRVR66T1JllHvULe65eBcG34RMx0s6duNjPy9GYn8E=;
        b=InpE7CDEFjr68QDjHjzKP8Av0wyBzq34mMqXv+0IXl90PMJgpqHoA4+E1vmC950Vts
         6bBPVrzT1iXbgvCml36fAvlPsdn7PLnO150spTewChmNk+Xy1ZIdeN/wq/pfeyyHnISL
         i0j9QMcbBWu2edYv6IXc5oIy5UKCtab3K2nUTlqeQ14qJIGFS9Sa1yiqqtxTbhrClao4
         M7Mn0mqNAqJaDUIaanxQLhjxucSXElnQS+vvFLSH3RR9k5kItrax/YRCrgliVWHjqaUo
         seLBHCaQQBjOZ+Jz+lcvoipHn9W/DgHFRKoTyfxOFxq4q4vTbqVbNDCvys1cXqDmFVyw
         p6gw==
X-Gm-Message-State: AOAM532PasdLvg24DwA5JcdWM8KhtdJBo1gD7deidmGRdAYBxMfrEw7p
        jq1ciLOgehJC5VgTBY3/kdEaZVC833VeRDd11bxXTDSi
X-Google-Smtp-Source: ABdhPJyx0w+fgmpxIatduwNtiSHyAAGmCdaHBgOweyb0IY5VwUUsBXJ2mX4u1sDV/vAbg2PCk1V2jS4mj235xfFFjIQ=
X-Received: by 2002:a9d:3ca:: with SMTP id f68mr16794063otf.330.1600302150022;
 Wed, 16 Sep 2020 17:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJCdBngxwYdc-CEfSabTAdAXCdnG424Qa2BS47+xcV2wDvJCA@mail.gmail.com>
 <20200916165605.GA1554766@bjorn-Precision-5520>
In-Reply-To: <20200916165605.GA1554766@bjorn-Precision-5520>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 17 Sep 2020 08:22:19 +0800
Message-ID: <CAPJCdB=D37hit-q8L8t_fC=qUCyi84oneOnYizp39a_TjdS2-A@mail.gmail.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in pci_read_config
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, 17 Sep 2020 at 00:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Sep 13, 2020 at 12:27:09PM +0800, Jiang Biao wrote:
> > On Thu, 10 Sep 2020 at 09:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Sep 10, 2020 at 09:54:02AM +0800, Jiang Biao wrote:
> > > > On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > > > > > From: Jiang Biao <benbjiang@tencent.com>
> > > > > >
> > > > > > pci_read_config() could block several ms in kernel space, mainly
> > > > > > caused by the while loop to call pci_user_read_config_dword().
> > > > > > Singel pci_user_read_config_dword() loop could consume 130us+,
> > > > > >               |    pci_user_read_config_dword() {
> > > > > >               |      _raw_spin_lock_irq() {
> > > > > > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > > > > > ! 137.582 us  |      }
> > > > > >               |      pci_read() {
> > > > > >               |        raw_pci_read() {
> > > > > >               |          pci_conf1_read() {
> > > > > >   0.230 us    |            _raw_spin_lock_irqsave();
> > > > > >   0.035 us    |            _raw_spin_unlock_irqrestore();
> > > > > >   8.476 us    |          }
> > > > > >   8.790 us    |        }
> > > > > >   9.091 us    |      }
> > > > > > ! 147.263 us  |    }
> > > > > > and dozens of the loop could consume ms+.
> > > > > >
> > > > > > If we execute some lspci commands concurrently, ms+ scheduling
> > > > > > latency could be detected.
> > > > > >
> > > > > > Add scheduling chance in the loop to improve the latency.
> > > > >
> > > > > Thanks for the patch, this makes a lot of sense.
> > > > >
> > > > > Shouldn't we do the same in pci_write_config()?
> > > >
> > > > Yes, IMHO, that could be helpful too.
> > >
> > > If it's feasible, it would be nice to actually verify that it makes a
> > > difference.  I know config writes should be faster than reads, but
> > > they're certainly not as fast as a CPU can pump out data, so there
> > > must be *some* mechanism that slows the CPU down.
> > >
> > We failed to build a test case to produce the latency by setpci command,
> > AFAIU, setpci could be much less frequently realistically used than lspci.
> > So, the latency from pci_write_config() path could not be verified for now,
> > could we apply this patch alone to erase the verified latency introduced
> > by pci_read_config() path? :)
>
> Thanks for trying!  I'll apply the patch as-is.  I'd like to include a
Thanks. :)

> note in the commit log about the user-visible effect of this.  I
> looked through recent similar commits:
>
>   928da37a229f ("RDMA/umem: Add a schedule point in ib_umem_get()")
>   47aaabdedf36 ("fanotify: Avoid softlockups when reading many events")
>   9f47eb5461aa ("fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls")
>   0a3b3c253a1e ("mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls")
>   b7e3debdd040 ("mm/memory_hotplug.c: fix false softlockup during pfn range removal")
>   d35bd764e689 ("dm writecache: add cond_resched to loop in persistent_memory_claim()")
>   da97f2d56bbd ("mm: call cond_resched() from deferred_init_memmap()")
>   ab8b65be1831 ("KVM: PPC: Book3S: Fix some RCU-list locks")
>   48c963e31bc6 ("KVM: arm/arm64: Release kvm->mmu_lock in loop to prevent starvation")
>   e84fe99b68ce ("mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()")
>   4005f5c3c9d0 ("wireguard: send/receive: cond_resched() when processing worker ringbuffers")
>   3fd44c86711f ("io_uring: use cond_resched() in io_ring_ctx_wait_and_kill()")
>   7979457b1d3a ("net: bridge: vlan: Add a schedule point during VLAN processing")
>   2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
>   1edaa447d958 ("dm writecache: add cond_resched to avoid CPU hangs")
>   ce9a4186f9ac ("macvlan: add cond_resched() during multicast processing")
>   7be1b9b8e9d1 ("drm/mm: Break long searches in fragmented address spaces")
>   bb699a793110 ("drm/i915/gem: Break up long lists of object reclaim")
>   9424ef56e13a ("ext4: add cond_resched() to __ext4_find_entry()")
>
> and many of them mention softlockups, RCU CPU stall warnings, or
> watchdogs triggering.  Are you seeing one of those, or are you
No softlockup or RCU stall warnings.

> measuring latency some other way?
We test the scheduling latency by cyclictest benchmark, the max
latency could be more than 5ms without this patch. The ftrace log
shows pci_read_config is the main cause, and the 5ms+ latency
disappeared with this patch applied.

Thanks a lot.
Regards,
Jiang
