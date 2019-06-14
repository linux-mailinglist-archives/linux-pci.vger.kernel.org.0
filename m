Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0845088
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNA3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 20:29:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:22235 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfFNA3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 20:29:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 17:29:46 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2019 17:29:46 -0700
Date:   Thu, 13 Jun 2019 17:31:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: dev_pagemap related cleanups
Message-ID: <20190614003107.GC783@iweiny-DESK2.sc.intel.com>
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190613204043.GD22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613204043.GD22062@mellanox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 08:40:46PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi Dan, Jérôme and Jason,
> > >
> > > below is a series that cleans up the dev_pagemap interface so that
> > > it is more easily usable, which removes the need to wrap it in hmm
> > > and thus allowing to kill a lot of code
> > >
> > > Diffstat:
> > >
> > >  22 files changed, 245 insertions(+), 802 deletions(-)
> > 
> > Hooray!
> > 
> > > Git tree:
> > >
> > >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup
> > 
> > I just realized this collides with the dev_pagemap release rework in
> > Andrew's tree (commit ids below are from next.git and are not stable)
> > 
> > 4422ee8476f0 mm/devm_memremap_pages: fix final page put race
> > 771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not globally
> > af37085de906 lib/genalloc: introduce chunk owners
> > e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
> > 0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
> > 216475c7eaa8 drivers/base/devres: introduce devm_release_action()
> > 
> > CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap.c
> > CONFLICT (content): Merge conflict in mm/hmm.c
> > CONFLICT (content): Merge conflict in kernel/memremap.c
> > CONFLICT (content): Merge conflict in include/linux/memremap.h
> > CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
> > CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
> > CONFLICT (content): Merge conflict in drivers/dax/device.c
> > CONFLICT (content): Merge conflict in drivers/dax/dax-private.h
> > 
> > Perhaps we should pull those out and resend them through hmm.git?
> 
> It could be done - but how bad is the conflict resolution?
> 
> I'd be more comfortable to take a PR from you to merge into hmm.git,
> rather than raw patches, then apply CH's series on top. I think.
> 
> That way if something goes wrong you can send your PR to Linus
> directly.
> 
> > It also turns out the nvdimm unit tests crash with this signature on
> > that branch where base v5.2-rc3 passes:
> > 
> >     BUG: kernel NULL pointer dereference, address: 0000000000000008
> >     [..]
> >     CPU: 15 PID: 1414 Comm: lt-libndctl Tainted: G           OE
> > 5.2.0-rc3+ #3399
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> >     RIP: 0010:percpu_ref_kill_and_confirm+0x1e/0x180
> >     [..]
> >     Call Trace:
> >      release_nodes+0x234/0x280
> >      device_release_driver_internal+0xe8/0x1b0
> >      bus_remove_device+0xf2/0x160
> >      device_del+0x166/0x370
> >      unregister_dev_dax+0x23/0x50
> >      release_nodes+0x234/0x280
> >      device_release_driver_internal+0xe8/0x1b0
> >      unbind_store+0x94/0x120
> >      kernfs_fop_write+0xf0/0x1a0
> >      vfs_write+0xb7/0x1b0
> >      ksys_write+0x5c/0xd0
> >      do_syscall_64+0x60/0x240
> 
> Too bad the trace didn't say which devm cleanup triggered it.. Did
> dev_pagemap_percpu_exit get called with a NULL pgmap->ref ?

I would guess something like that.  I did not fully wrap my head around the ref
counting there but I don't think the patch is correct.  See my review.

Ira

> 
> Jason
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
