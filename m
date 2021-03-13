Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3433A1B4
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhCMWgj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 17:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhCMWgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Mar 2021 17:36:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4AC061762
        for <linux-pci@vger.kernel.org>; Sat, 13 Mar 2021 14:36:18 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so3304888otn.10
        for <linux-pci@vger.kernel.org>; Sat, 13 Mar 2021 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2nM0F1OSZDnsayP8DJnmj8gvTm944LA45fG5RJlAR4=;
        b=esIzXz11IK5/xkUIRZWExsywCZP7c0K0xyTCruovMIwohs3QhI9Dkv62TxALgb+ukr
         OyArZWGPm9Na48g4ZMujf+yBV2K2krqMot8Wn9X6IGICiP7RoX5zhMiSUrOmCFsdNwIN
         o31ZMOU5Rpeiw9vVUzQ5TG2qfv3gkm1mXP+iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2nM0F1OSZDnsayP8DJnmj8gvTm944LA45fG5RJlAR4=;
        b=lS9KPPrIbSmi/H6W33kZ2ZcHmNWvl1kOjCgXw78mpdT3bXNpIJCdaVDi5idUOfR78o
         0uHlnJRzGYiP36+asYNyrpaPSHz+H+l6ZnVmqwXSUvZQSemOh+iNCL05j7r5iBvs/sVl
         glsmrYF69sU0Gn2p9WuKDvGZYb6ASY4kYt4mhha6GDXhFRAuO11kr6xypElNCT4vwWlE
         NFF1eA7BUNM9E/fXHTg8jhq7DIGuDLNNdt0jeQpzbzg2gKb9XuTH0JdUP2Y3Iem+pHph
         4z/w/4YKIssFyYCUtrCq1TVMJknMAE4ycfUupUZsJGBTOoN0lWUh5kUqbCd+Sf/dd8DU
         m90g==
X-Gm-Message-State: AOAM530ijqtKrsP09x3HCqUPCEdeiOEjnlKGs1xVZBbwniln5h9WxPVF
        pt5OvOl3rQQBKVXQrCdAi3pN7uHEjeTQyDCqgFb0Yw==
X-Google-Smtp-Source: ABdhPJx+9a30YontWgcNy6nzPQiRyG8JBRoZfcUjE9SPwclc5y9YC+uZVvc9WajnnQVETEW26MKNrTck27mSKqgVcXY=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr8827539oto.281.1615674977323;
 Sat, 13 Mar 2021 14:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20210204165831.2703772-3-daniel.vetter@ffwll.ch> <20210313215747.GA2394467@bjorn-Precision-5520>
In-Reply-To: <20210313215747.GA2394467@bjorn-Precision-5520>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat, 13 Mar 2021 23:36:06 +0100
Message-ID: <CAKMK7uHz3BYxKR6dCHHeP+WYho=WhvYnt=d3=xRfW5kfaP=m8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Revoke mappings like devmem
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 13, 2021 at 10:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Krzysztof, Pali, Oliver]
>
> On Thu, Feb 04, 2021 at 05:58:31PM +0100, Daniel Vetter wrote:
> > Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> > the region") /dev/kmem zaps ptes when the kernel requests exclusive
> > acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> > the default for all driver uses.
> >
> > Except there's two more ways to access PCI BARs: sysfs and proc mmap
> > support. Let's plug that hole.
>
> IIUC, the idea is that if a driver calls request_mem_region() on a PCI
> BAR, we prevent access to the BAR via sysfs.  I guess I'm OK with that
> if it's a real security improvement or something.

Yup.

> But the downside of this implementation is that it depends on
> iomem_get_mapping(), which doesn't work until after fs_initcalls,
> which means the sysfs files cannot be static attributes of devices
> added before that.  PCI devices are typically enumerated in
> subsys_initcall.
>
> Krzysztof is converting PCI sysfs files (config, rom, reset, vpd, etc)
> to static attributes.  This is a major improvement that could get rid
> of pci_create_sysfs_dev_files(), the late_initcall pci_sysfs_init(),
> and the "sysfs_initialized" hack.  This would fix a race reported by
> Pali [1] (thanks to Oliver for the idea [2]).
>
> EXCEPT that this revoke change means the "resource%d", "legacy_io",
> and "legacy_mem" files cannot be static attributes because of
> iomem_get_mapping().
>
> Any ideas on how to deal with this?  Having to keep the
> pci_sysfs_init() initcall just for these few files seems like the tail
> wagging the dog.

It's a bit "pick your ugly". Either we have the late init call (not
pretty), or the sysfs side needs a callback to fish out the
address_space for the mmap at open() time, which didn't stir up much
enthusiams with Greg because we need a new callback just for these
mmio files. Either approach works.
-Daniel

> [1] https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali
> [2] https://lore.kernel.org/r/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKG=
XQzBfqaA@mail.gmail.com
>
> > For revoke_devmem() to work we need to link our vma into the same
> > address_space, with consistent vma->vm_pgoff. ->pgoff is already
> > adjusted, because that's how (io_)remap_pfn_range works, but for the
> > mapping we need to adjust vma->vm_file->f_mapping. The cleanest way is
> > to adjust this at at ->open time:
> >
> > - for sysfs this is easy, now that binary attributes support this. We
> >   just set bin_attr->mapping when mmap is supported
> > - for procfs it's a bit more tricky, since procfs pci access has only
> >   one file per device, and access to a specific resources first needs
> >   to be set up with some ioctl calls. But mmap is only supported for
> >   the same resources as sysfs exposes with mmap support, and otherwise
> >   rejected, so we can set the mapping unconditionally at open time
> >   without harm.
> >
> > A special consideration is for arch_can_pci_mmap_io() - we need to
> > make sure that the ->f_mapping doesn't alias between ioport and iomem
> > space. There's only 2 ways in-tree to support mmap of ioports: generic
> > pci mmap (ARCH_GENERIC_PCI_MMAP_RESOURCE), and sparc as the single
> > architecture hand-rolling. Both approach support ioport mmap through a
> > special pfn range and not through magic pte attributes. Aliasing is
> > therefore not a problem.
> >
> > The only difference in access checks left is that sysfs PCI mmap does
> > not check for CAP_RAWIO. I'm not really sure whether that should be
> > added or not.
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-media@vger.kernel.org
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/pci-sysfs.c | 4 ++++
> >  drivers/pci/proc.c      | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 0c45b4f7b214..f8afd54ca3e1 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -942,6 +942,7 @@ void pci_create_legacy_files(struct pci_bus *b)
> >       b->legacy_io->read =3D pci_read_legacy_io;
> >       b->legacy_io->write =3D pci_write_legacy_io;
> >       b->legacy_io->mmap =3D pci_mmap_legacy_io;
> > +     b->legacy_io->mapping =3D iomem_get_mapping();
> >       pci_adjust_legacy_attr(b, pci_mmap_io);
> >       error =3D device_create_bin_file(&b->dev, b->legacy_io);
> >       if (error)
> > @@ -954,6 +955,7 @@ void pci_create_legacy_files(struct pci_bus *b)
> >       b->legacy_mem->size =3D 1024*1024;
> >       b->legacy_mem->attr.mode =3D 0600;
> >       b->legacy_mem->mmap =3D pci_mmap_legacy_mem;
> > +     b->legacy_io->mapping =3D iomem_get_mapping();
> >       pci_adjust_legacy_attr(b, pci_mmap_mem);
> >       error =3D device_create_bin_file(&b->dev, b->legacy_mem);
> >       if (error)
> > @@ -1169,6 +1171,8 @@ static int pci_create_attr(struct pci_dev *pdev, =
int num, int write_combine)
> >                       res_attr->mmap =3D pci_mmap_resource_uc;
> >               }
> >       }
> > +     if (res_attr->mmap)
> > +             res_attr->mapping =3D iomem_get_mapping();
> >       res_attr->attr.name =3D res_attr_name;
> >       res_attr->attr.mode =3D 0600;
> >       res_attr->size =3D pci_resource_len(pdev, num);
> > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > index 3a2f90beb4cb..9bab07302bbf 100644
> > --- a/drivers/pci/proc.c
> > +++ b/drivers/pci/proc.c
> > @@ -298,6 +298,7 @@ static int proc_bus_pci_open(struct inode *inode, s=
truct file *file)
> >       fpriv->write_combine =3D 0;
> >
> >       file->private_data =3D fpriv;
> > +     file->f_mapping =3D iomem_get_mapping();
> >
> >       return 0;
> >  }
> > --
> > 2.30.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
