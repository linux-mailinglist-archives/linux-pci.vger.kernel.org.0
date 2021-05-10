Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC97379A6B
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhEJW6q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 18:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhEJW6p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 18:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0031761581;
        Mon, 10 May 2021 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620687460;
        bh=NTRA6l2RXVf53003Xt08bZ/H85OwvjJ6Zstq5QNAVO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s/7f2xqr+mYTxz/VJsntbYVA7DFgpH5WFnqTLBIdt0CZqrSuWBwMpA+DVbXpIUVpP
         NvKsmf2sGoHi/uJ9xxQtoW3TiWJwWVqZCbscB7C7/OmpwopJUPiL4GkL2OGKz7wN3I
         b3QH6ZgDuXwlmRF5H2ihkDlWPRSfgU5070ZmtXzmP44Wy3B6M5+FR48qF4lTU3VxI3
         l++SL9HTf91ssKPeZj+L9uzS3h4Acgdhl0aPcbjjlo1o7hc69A8pi6MlAllKj4pvxM
         K5IF9Jn9VH9r6fXfkbm41SZfvdc19RcI046mU8EeDoaHKmxO35gOCQ142Vt3vUfx+z
         V/QLQIDcaaVRw==
Date:   Mon, 10 May 2021 17:57:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Slivka, Danijel" <Danijel.Slivka@amd.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Message-ID: <20210510225733.GA2307664@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5f4f33c3f34830b37cbd70e421023b@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

See https://people.kernel.org/tglx/notes-about-netiquette about
typical style for Linux mailing lists.

On Mon, May 10, 2021 at 03:02:45PM +0000, Slivka, Danijel wrote:
> Hi Bjorn,
> 
> Yes, I get segmentation fault on unloading custom module during the
> check of error handling case.
>
> There is no directly visible access to res_attr fields, as you
> mentioned, other than the one in a call chain after a check in
> pci_remove_resource_files() which seems to cause the issue
> (accessing name).
>
> Load and unload module will invoke pci_enable_sriov() and
> disable_pci_sriov() respectively that are both having a call of
> pci_remove_resource_files() in call chain.
>
> In that function existing check is not behaving as expected since
> memory is freed but pointers left dangling. 
>
> Below is call trace and detail description. 
> 
> During loading of module pci_enable_sriov() is called, I have
> following invoking sequence:
>
> device_create_file
> pci_create_capabilities_sysfs
> pci_create_sysfs_dev_files
> pci_bus_add_device
> pci_iov_add_virtfn
> sriov_enable
> pci_enable_sriov

OK.  For anybody following along, this call path changed in v5.13-rc1,
so pci_create_capabilities_sysfs() longer exists.  But looking at
v5.12, I think the sequence you're seeing is:

  pci_create_sysfs_dev_files
    pci_create_capabilities_sysfs
      retval = device_create_file(&dev->dev, &dev_attr_reset)
      return retval		# I guess this what failed, right?
    if (retval) goto err_rom_file
    err_rom_file:
    ...
    pci_remove_resource_files
      sysfs_remove_bin_file(pdev->res_attr[i])
      kfree(pdev->res_attr[i])
      # pdev->res_attr[i] not set to NULL in v5.12

Later, on module unload, we have this sequence:

  pci_disable_sriov
    sriov_disable
      sriov_del_vfs
        pci_iov_remove_virtfn
          pci_stop_and_remove_bus_device
            pci_stop_bus_device
              pci_stop_dev
                pci_remove_sysfs_dev_files
                  pci_remove_resource_files
                    sysfs_remove_bin_file(pdev->res_attr[i])
                    # pdev->res_attr[i] points to a freed object

Definitely seems like a problem.  Hmmm.  I'm not really a fan of
checking the pointer to see whether it's been freed.  That seems like
a band-aid.

Krzysztof did some really nice work in v5.13-rc1 that removes a lot of
the explicit sysfs file management.  I think he's planning similar
work for pdev->res_attr[], and I suspect that will solve this problem
nicely.  But there are some wrinkles to work out before that's ready.

Any ideas here, Krzysztof?  IIRC some of the wrinkles have to do with
Alpha, which has its own pci_create_resource_files() implementation.
If you have any work-in-progress that works on x86, I'd be curious to
see if it would solve Danijel's problem.

> In case of a failure of device_create_file() for dev_attr_reset case
> (which was the case I tested), it will call
> pci_remove_resource_files(), which will free both, res_attr and
> res_attr_wc array elements (pointers) without setting them to NULL.
>
> Then failure is propagated only up to  pci_create_sysfs_dev_files
> and return value is not checked inside of pci_bus_add_device.
>
> That causes the same behavior as pci_enable_sriov function passed. 
> 
> On unload, during pci_disable_sriov(), pci_remove_resource_files()
> will be regularly called to try to remove the files.
>
> The check segment that currently exist will not prevent calling of
> removal code since pointers are left as dangling pointers, even
> though the resource files and attributes are already freed.
>
> 
> 		res_attr = pdev->res_attr[i];
> 		if (res_attr) {
> 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> 			kfree(res_attr);
> 		}
> 
> Attribute res_attr[i]->name is the one causing segmentation fault
> when strlen() function is called in kernfs_name_hash().

I think the "sysfs_remove_bin_file(pdev->res_attr[i])" is clearly
wrong because we're passing a pointer to memory that has already been
freed.

> Here is the call trace:
> 
> [  991.796300] RIP: 0010:strlen+0x0/0x30
> [  991.807240] Code: f8 48 89 fa 48 89 e5 74 09 48 83 c2 01 80 3a 00 75 f7 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9 88 4a ff 75 ed 5d c3 0f 1f 00 <80> 3f 00 55 48 89 e5 74 14 48 89 f8 48 83 c7 01 80 3f 00 75 f7 48
> [  991.863423] RSP: 0018:ffffc1d68a9ffb80 EFLAGS: 00010246
> [  991.879051] RAX: 0000000000000000 RBX: b5f8d4ce837e84cb RCX: 0000000000000000
> [  991.900395] RDX: 0000000000000000 RSI: 0000000000000000 RDI: b5f8d4ce837e84cb
> [  991.921739] RBP: ffffc1d68a9ffb98 R08: 0000000000000000 R09: ffffffff96964e01
> [  991.943086] R10: ffffc1d68a9ffb78 R11: 0000000000000001 R12: 0000000000000000
> [  991.964432] R13: 0000000000000000 R14: b5f8d4ce837e84cb R15: 0000000000000038
> [  991.985777] FS:  00007f3c278b3740(0000) GS:ffffa0a61f740000(0000) knlGS:0000000000000000
> [  992.009983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  992.027168] CR2: 00007f3c27920340 CR3: 000000074c010004 CR4: 00000000003606e0
> [  992.048516] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  992.069861] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  992.091205] Call Trace:
> [  992.098523]  ? kernfs_name_hash+0x17/0x80
> [  992.110499]  kernfs_find_ns+0x3a/0xc0
> [  992.121448]  kernfs_remove_by_name_ns+0x36/0xa0
> [  992.134994]  sysfs_remove_bin_file+0x17/0x20
> [  992.147760]  pci_remove_resource_files+0x38/0x80
> [  992.161565]  pci_remove_sysfs_dev_files+0x5b/0xc0
> [  992.175631]  pci_stop_bus_device+0x78/0x90
> [  992.187875]  pci_stop_and_remove_bus_device+0x12/0x20
> [  992.202983]  pci_iov_remove_virtfn+0xc3/0x110
> [  992.216006]  sriov_disable+0x43/0x100
> [  992.226953]  pci_disable_sriov+0x23/0x30
> 
> BR,
> Danijel Slivka
> 
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org> 
> Sent: Saturday, May 8, 2021 12:07 AM
> To: Slivka, Danijel <Danijel.Slivka@amd.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI: Fix accessing freed memory in pci_remove_resource_files
> 
> Hi Danijel,
> 
> Thanks for the patch.
> 
> On Fri, May 07, 2021 at 06:27:06PM +0800, Danijel Slivka wrote:
> > This patch fixes segmentation fault during accessing already freed pci 
> > device resource files, as after freeing res_attr and res_attr_wc 
> > elements, in pci_remove_resource_files function, they are left as 
> > dangling pointers.
> > 
> > Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index 
> > f8afd54ca3e1..bbdf6c57fcda 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1130,12 +1130,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
> >  		if (res_attr) {
> >  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> >  			kfree(res_attr);
> > +			pdev->res_attr[i] = NULL;
> >  		}
> >  
> >  		res_attr = pdev->res_attr_wc[i];
> >  		if (res_attr) {
> >  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> >  			kfree(res_attr);
> > +			pdev->res_attr_wc[i] = NULL;
> 
> If this patch fixes something, I would expect to see a test like this
> somewhere:
> 
>   if (pdev->res_attr[i])
>     pdev->res_attr[i]->size = 0;
> 
> But I don't see anything like that, so I can't figure out where we actually use res_attr[i] or res_attr_wc[i], except in
> pci_remove_resource_files() itself.
> 
> Did you actually see a segmentation fault?  If so, where?
> 
> >  		}
> >  	}
> >  }
> > --
> > 2.20.1
> > 
