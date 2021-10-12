Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D6429B4E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJLCMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 22:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhJLCMB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 22:12:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1EAF60FD7;
        Tue, 12 Oct 2021 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634004601;
        bh=PFH6YMgh1NPjnBVcknJcRHHylsiinxs1uiD5pC8d1SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HKcwpp0l2/B9vrHV+Phur4+YFVNsjD4593zfz0D40rHbQI8DT5gWVX9odVSswJl4R
         Qlfg0JqJ/FwwnLxdxuGTbt40d6JoE/0xCo4d193JLwWJ4/1/CVKGJ+n7ptn7HbpqrY
         dtfzoj2kH6Hvo1wiZ8kW3Rp7r2yftFnEZjcnosgB5NGtSmnl3JjBJSDCjBEnjtYsyU
         7DX0vcasbp0mRk/dwq67z44iNSDBj8W6VE7qXXDxKDq0Jqatw6aZLAAq+x4ZyvhXHP
         4R/qpalbPi6TGeA0QDmrR/vMyReZQQf36NDzEHDyayWnIHk8jYE/lCVhK5VhkepwCd
         D7A96ODS/BbqQ==
Date:   Mon, 11 Oct 2021 21:09:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: fix page fault when msi_populate_sysfs() failed
Message-ID: <20211012020959.GA1708781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fc860b4-ec4e-3415-a58b-9099f164b607@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 09:59:40AM +0800, wanghai (M) wrote:
> 
> 在 2021/10/12 1:11, Bjorn Helgaas 写道:
> > For v2, please note "git log --oneline drivers/pci/msi.c" and make
> > your patch follow the style, including capitalization.
> > 
> > On Mon, Oct 11, 2021 at 05:15:28PM +0800, wanghai (M) wrote:
> > > 在 2021/10/11 16:52, Barry Song 写道:
> > > > On Mon, Oct 11, 2021 at 9:24 PM Wang Hai <wanghai38@huawei.com> wrote:
> > > > > I got a page fault report when doing fault injection test:
> > When you send v2, can you include information about how you injected
> > the fault?  If it's easy, others can reproduce the failure that way.
> Sorry, the reproduction needs to be based on the fault injection framework
> provided by Hulk Robot. I don't know how the framework is implemented.
> 
> The way to reproduce this is to do a fault injection to make
> 'msi_attrs = kcalloc() in msi_populate_sysfs()' fail when insmod
> 9pnet_virtio.ko.
> 
> I sent v2 yesterday, can you help review it?
> https://lore.kernel.org/linux-pci/20211011130837.766323-1-wanghai38@huawei.com/
> > > > > BUG: unable to handle page fault for address: fffffffffffffff4
> > > > > ...
> > > > > RIP: 0010:sysfs_remove_groups+0x25/0x60
> > > > > ...
> > > > > Call Trace:
> > > > >    msi_destroy_sysfs+0x30/0xa0
> > > > >    free_msi_irqs+0x11d/0x1b0
> > > > >    __pci_enable_msix_range+0x67f/0x760
> > > > >    pci_alloc_irq_vectors_affinity+0xe7/0x170
> > > > >    vp_find_vqs_msix+0x129/0x560
> > > > >    vp_find_vqs+0x52/0x230
> > > > >    vp_modern_find_vqs+0x47/0xb0
> > > > >    p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
> > > > >    virtio_dev_probe+0x1ed/0x2e0
> > > > >    really_probe+0x1c7/0x400
> > > > >    __driver_probe_device+0xa4/0x120
> > > > >    driver_probe_device+0x32/0xe0
> > > > >    __driver_attach+0xbf/0x130
> > > > >    bus_for_each_dev+0xbb/0x110
> > > > >    driver_attach+0x27/0x30
> > > > >    bus_add_driver+0x1d9/0x270
> > > > >    driver_register+0xa9/0x180
> > > > >    register_virtio_driver+0x31/0x50
> > > > >    p9_virtio_init+0x3c/0x1000 [9pnet_virtio]
> > > > >    do_one_initcall+0x7b/0x380
> > > > >    do_init_module+0x5f/0x21e
> > > > >    load_module+0x265c/0x2c60
> > > > >    __do_sys_finit_module+0xb0/0xf0
> > > > >    __x64_sys_finit_module+0x1a/0x20
> > > > >    do_syscall_64+0x34/0xb0
> > > > >    entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > 
> > > > > When populating msi_irqs sysfs failed in msi_capability_init() or
> > > > > msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
> > > > > This will cause a page fault when destroying the wrong
> > > > > dev->msi_irq_groups in free_msi_irqs().
> > > > > 
> > > > > Fix this by setting dev->msi_irq_groups to NULL when msi_populate_sysfs()
> > > > > failed.
> > > > > 
> > > > > Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
> > > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > What exactly was reported by the Hulk Robot?  Did it really do the
> > fault injection and report the page fault?
> Yes, it reported the error and provided a way to reproduce it

Great, can you include a link to that report then?
