Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C726CC31
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIPUk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgIPRFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:05:42 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122B620731;
        Wed, 16 Sep 2020 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600275366;
        bh=JZn7jl83lNE5bzNJDZn1/gldMHkDPgWZGzZpS962Up8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xODPVpEu4xL+5KyHse9gke9V6IKkl5QzO5r0OKUYNHwVYmEEo/Q3UQGDjcPOk58pB
         jefneoej000eFtsElcudZcsrXpdmlV7mtZSe1Olbg1b99MrPaL8wsu9h+JVP1Ej1gQ
         W1K1gIsk/JSXsPWv9hG1/NTjt6ackZlqc+qKRCMs=
Date:   Wed, 16 Sep 2020 11:56:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in
 pci_read_config
Message-ID: <20200916165605.GA1554766@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPJCdBngxwYdc-CEfSabTAdAXCdnG424Qa2BS47+xcV2wDvJCA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 13, 2020 at 12:27:09PM +0800, Jiang Biao wrote:
> On Thu, 10 Sep 2020 at 09:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Sep 10, 2020 at 09:54:02AM +0800, Jiang Biao wrote:
> > > On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > > > > From: Jiang Biao <benbjiang@tencent.com>
> > > > >
> > > > > pci_read_config() could block several ms in kernel space, mainly
> > > > > caused by the while loop to call pci_user_read_config_dword().
> > > > > Singel pci_user_read_config_dword() loop could consume 130us+,
> > > > >               |    pci_user_read_config_dword() {
> > > > >               |      _raw_spin_lock_irq() {
> > > > > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > > > > ! 137.582 us  |      }
> > > > >               |      pci_read() {
> > > > >               |        raw_pci_read() {
> > > > >               |          pci_conf1_read() {
> > > > >   0.230 us    |            _raw_spin_lock_irqsave();
> > > > >   0.035 us    |            _raw_spin_unlock_irqrestore();
> > > > >   8.476 us    |          }
> > > > >   8.790 us    |        }
> > > > >   9.091 us    |      }
> > > > > ! 147.263 us  |    }
> > > > > and dozens of the loop could consume ms+.
> > > > >
> > > > > If we execute some lspci commands concurrently, ms+ scheduling
> > > > > latency could be detected.
> > > > >
> > > > > Add scheduling chance in the loop to improve the latency.
> > > >
> > > > Thanks for the patch, this makes a lot of sense.
> > > >
> > > > Shouldn't we do the same in pci_write_config()?
> > >
> > > Yes, IMHO, that could be helpful too.
> >
> > If it's feasible, it would be nice to actually verify that it makes a
> > difference.  I know config writes should be faster than reads, but
> > they're certainly not as fast as a CPU can pump out data, so there
> > must be *some* mechanism that slows the CPU down.
> >
> We failed to build a test case to produce the latency by setpci command,
> AFAIU, setpci could be much less frequently realistically used than lspci.
> So, the latency from pci_write_config() path could not be verified for now,
> could we apply this patch alone to erase the verified latency introduced
> by pci_read_config() path? :)

Thanks for trying!  I'll apply the patch as-is.  I'd like to include a
note in the commit log about the user-visible effect of this.  I
looked through recent similar commits:

  928da37a229f ("RDMA/umem: Add a schedule point in ib_umem_get()")
  47aaabdedf36 ("fanotify: Avoid softlockups when reading many events")
  9f47eb5461aa ("fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls")
  0a3b3c253a1e ("mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls")
  b7e3debdd040 ("mm/memory_hotplug.c: fix false softlockup during pfn range removal")
  d35bd764e689 ("dm writecache: add cond_resched to loop in persistent_memory_claim()")
  da97f2d56bbd ("mm: call cond_resched() from deferred_init_memmap()")
  ab8b65be1831 ("KVM: PPC: Book3S: Fix some RCU-list locks")
  48c963e31bc6 ("KVM: arm/arm64: Release kvm->mmu_lock in loop to prevent starvation")
  e84fe99b68ce ("mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()")
  4005f5c3c9d0 ("wireguard: send/receive: cond_resched() when processing worker ringbuffers")
  3fd44c86711f ("io_uring: use cond_resched() in io_ring_ctx_wait_and_kill()")
  7979457b1d3a ("net: bridge: vlan: Add a schedule point during VLAN processing")
  2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
  1edaa447d958 ("dm writecache: add cond_resched to avoid CPU hangs")
  ce9a4186f9ac ("macvlan: add cond_resched() during multicast processing")
  7be1b9b8e9d1 ("drm/mm: Break long searches in fragmented address spaces")
  bb699a793110 ("drm/i915/gem: Break up long lists of object reclaim")
  9424ef56e13a ("ext4: add cond_resched() to __ext4_find_entry()")

and many of them mention softlockups, RCU CPU stall warnings, or
watchdogs triggering.  Are you seeing one of those, or are you
measuring latency some other way?

Bjorn
