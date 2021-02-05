Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FFA3108FC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 11:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBEKYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 05:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhBEKWl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 05:22:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCF064E55;
        Fri,  5 Feb 2021 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612520519;
        bh=vTdK7tqpnai+N4Mr1MYvbIdxctZy8n6ZlIZgJ2TTGIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aw9IX3t8/+kJNRGDZ+eN+AcOe96RKkF8t8qkjRXLa5ntx8zUbf71H7CUidQRP/3oy
         /jYL5MOzNTkXCNVb+pWxV8zK/1XWdVgzZi8nk/3ExJgEbVYSOS32dh8UG2wBx57LbT
         OfJqPh+TzyXNYzzIQJO8xNFIIAvNiGmkVtRk+/nwkolGXcSYv9TH6LThlKK8ci0QPF
         et1/cuIWO6xPGl6ZAON1zoRCnud1K6EP3sTct9KVU3TGucYouiF7zH/V758kBhQQB7
         LyqKl1Z8P4+8ePkkWvfs31Oj9jOtCO+JuKcTd7+EAmVmnnXr+rST7vmtWkEsN6rZhM
         4Y7uHIzJ0CqJQ==
Received: by pali.im (Postfix)
        id 41ADC8A2; Fri,  5 Feb 2021 11:21:57 +0100 (CET)
Date:   Fri, 5 Feb 2021 11:21:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH 1/2] PCI: also set up legacy files only after sysfs init
Message-ID: <20210205102157.n7avchjbzwbfkpdm@pali>
References: <20210204165831.2703772-2-daniel.vetter@ffwll.ch>
 <20210204215019.GA104698@bjorn-Precision-5520>
 <20210204222407.pkx7wvmcvugdwqdd@pali>
 <CAKMK7uFeZpc4oV2GNRdP_EXmYqacg5o3jPegqqaFZZYqqRutFA@mail.gmail.com>
 <20210205100449.w2vzqozgnolxqh4h@pali>
 <CAKMK7uG9NsEzFfapZa4KF6sw0=CuD6Pyk5=7WhjxgFBut4uJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uG9NsEzFfapZa4KF6sw0=CuD6Pyk5=7WhjxgFBut4uJkw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 05 February 2021 11:16:00 Daniel Vetter wrote:
> On Fri, Feb 5, 2021 at 11:04 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 05 February 2021 10:59:50 Daniel Vetter wrote:
> > > On Thu, Feb 4, 2021 at 11:24 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Thursday 04 February 2021 15:50:19 Bjorn Helgaas wrote:
> > > > > [+cc Oliver, Pali, Krzysztof]
> > > >
> > > > Just to note that extending or using sysfs_initialized introduces
> > > > another race condition into kernel code which results in PCI fatal
> > > > errors. Details are in email discussion which Bjorn already sent.
> > >
> > > Yeah I wondered why this doesn't race.
> >
> > It races, but with smaller probability. I have not seen this race
> > condition on x86. But I was able to reproduce it with native PCIe
> > drivers on ARM64 (Marvell Armada 3720; pci-aardvark). In mentioned
> > discussion I wrote when this race condition happen. But I understand
> > that it is hard to simulate it.
> 
> btw I looked at your patch, and isn't that just reducing the race window?

I probably have not wrote reply to that thread and only to Krzysztof on
IRC, but my "hack" really does not solve that race condition. And as you
wrote it only reduced occurrence on tested HW.

Krzysztof wrote that would look at this issue and try to solve it
properly. So I have not doing more investigation on that my "hack"
patch, race conditions are hard to catch and solve...

> I think we have a very similar problem in drm, where the
> drm_dev_register() for the overall device (which also registers all
> drm_connector) can race with the hotplug of an individual connector in
> drm_connector_register() which is hotplugged at runtime.
> 
> I went with a per-connector registered boolean + a lock to make sure
> that really only one of the two call paths can end up registering the
> connector. Part of registering connectors is setting up sysfs files,
> so I think it's exactly the same problem as here.
> 
> Cheers, Daniel
> 
> >
> > > but since the history goes back
> > > to pre-git times I figured it would have been addressed somehow
> > > already if it indeed does race.
> > > -Daniel
> > >
> > > > > s/also/Also/ in subject
> > > > >
> > > > > On Thu, Feb 04, 2021 at 05:58:30PM +0100, Daniel Vetter wrote:
> > > > > > We are already doing this for all the regular sysfs files on PCI
> > > > > > devices, but not yet on the legacy io files on the PCI buses. Thus far
> > > > > > now problem, but in the next patch I want to wire up iomem revoke
> > > > > > support. That needs the vfs up an running already to make so that
> > > > > > iomem_get_mapping() works.
> > > > >
> > > > > s/now problem/no problem/
> > > > > s/an running/and running/
> > > > > s/so that/sure that/ ?
> > > > >
> > > > > iomem_get_mapping() doesn't exist; I don't know what that should be.
> > > > >
> > > > > > Wire it up exactly like the existing code. Note that
> > > > > > pci_remove_legacy_files() doesn't need a check since the one for
> > > > > > pci_bus->legacy_io is sufficient.
> > > > >
> > > > > I'm not sure exactly what you mean by "the existing code."  I could
> > > > > probably figure it out, but it would save time to mention the existing
> > > > > function here.
> > > > >
> > > > > This looks like another instance where we should really apply Oliver's
> > > > > idea of converting these to attribute_groups [1].
> > > > >
> > > > > The cover letter mentions options discussed with Greg in [2], but I
> > > > > don't think the "sysfs_initialized" hack vs attribute_groups was part
> > > > > of that discussion.
> > > > >
> > > > > It's not absolutely a show-stopper, but it *is* a shame to extend the
> > > > > sysfs_initialized hack if attribute_groups could do this more cleanly
> > > > > and help solve more than one issue.
> > > > >
> > > > > Bjorn
> > > > >
> > > > > [1] https://lore.kernel.org/r/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com
> > > > > [2] https://lore.kernel.org/dri-devel/CAKMK7uGrdDrbtj0OyzqQc0CGrQwc2F3tFJU9vLfm2jjufAZ5YQ@mail.gmail.com/
> > > > >
> > > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > > > Cc: Jérôme Glisse <jglisse@redhat.com>
> > > > > > Cc: Jan Kara <jack@suse.cz>
> > > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: linux-mm@kvack.org
> > > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > > Cc: linux-samsung-soc@vger.kernel.org
> > > > > > Cc: linux-media@vger.kernel.org
> > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > Cc: linux-pci@vger.kernel.org
> > > > > > ---
> > > > > >  drivers/pci/pci-sysfs.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > > index fb072f4b3176..0c45b4f7b214 100644
> > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > @@ -927,6 +927,9 @@ void pci_create_legacy_files(struct pci_bus *b)
> > > > > >  {
> > > > > >     int error;
> > > > > >
> > > > > > +   if (!sysfs_initialized)
> > > > > > +           return;
> > > > > > +
> > > > > >     b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
> > > > > >                            GFP_ATOMIC);
> > > > > >     if (!b->legacy_io)
> > > > > > @@ -1448,6 +1451,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> > > > > >  static int __init pci_sysfs_init(void)
> > > > > >  {
> > > > > >     struct pci_dev *pdev = NULL;
> > > > > > +   struct pci_bus *pbus = NULL;
> > > > > >     int retval;
> > > > > >
> > > > > >     sysfs_initialized = 1;
> > > > > > @@ -1459,6 +1463,9 @@ static int __init pci_sysfs_init(void)
> > > > > >             }
> > > > > >     }
> > > > > >
> > > > > > +   while ((pbus = pci_find_next_bus(pbus)))
> > > > > > +           pci_create_legacy_files(pbus);
> > > > > > +
> > > > > >     return 0;
> > > > > >  }
> > > > > >  late_initcall(pci_sysfs_init);
> > > > > > --
> > > > > > 2.30.0
> > > > > >
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-arm-kernel mailing list
> > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
