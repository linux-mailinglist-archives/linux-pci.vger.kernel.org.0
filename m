Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36531090E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 11:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBEK2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 05:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBEKQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 05:16:52 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB816C06178C
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 02:16:11 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w124so6897452oia.6
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2yuIYIxM1r0vjPBHPxM2y+AxnaXi3F039H0I6fPXB2Y=;
        b=A9phunMoX2b9Gt5n9T0V20jIQdwPW9aWuFUt+j26fGARowppocLfwynGYKZKR1TvHP
         oDYM6GO84zr2GTWpNTRjpDKbTn3MIDB8fM+hrnpLGfiUf/l+iVMugdoRIPgQX8kZ1Hta
         jlDlzgJ4kNiRVRoNbZAav0p3u3jbhCwhdDh2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2yuIYIxM1r0vjPBHPxM2y+AxnaXi3F039H0I6fPXB2Y=;
        b=HETXQ7JXqKEOwyS9K8g+9aaSHz2mIxGAWuIZBPpt84VsRwA2x+o0i713/b2xTKyyp6
         sQVZXEoX4Ie7JeFV4AeKcbS9VRLvF5+GxPrUtxHKILG6hLnjGigivwj9nFwBdkaALnss
         s4ZbG/4V8wI90Ue7dA7X/HlaSM5Ng6QT5MzOv+djAU1MDuG1PUl9Yq64H+i/RmH1xiYT
         C04+Iy2eRq0ktrnKz+tTspLxS6aVDhbL6c/VgDudrTCA0Y2KRcJY4avC0XOiZQepA586
         BAaPRTlvssCgxaRUjVYgjtJw+veQf6hh46DtUvZOTOhd+V12symL3Fe4ZImYTjZJBkTw
         5M4Q==
X-Gm-Message-State: AOAM530xoBl23RR5lsHD2w8TKHdgRcctqa8vVJfjA9/E+/ivp7sbXdO0
        QJVOyJSDTEHgj3G418ZUnndSOJoJFpT1d7yxvSi79g==
X-Google-Smtp-Source: ABdhPJyS7NBg6dpmgk+Mh+fuNgultS8ddwgsrdcEebMQvTNVbqaUOfhJ/OSI2TaI7qoinESzj+/7j2RvKfsoe9fAFGc=
X-Received: by 2002:aca:df42:: with SMTP id w63mr2582638oig.128.1612520171119;
 Fri, 05 Feb 2021 02:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20210204165831.2703772-2-daniel.vetter@ffwll.ch>
 <20210204215019.GA104698@bjorn-Precision-5520> <20210204222407.pkx7wvmcvugdwqdd@pali>
 <CAKMK7uFeZpc4oV2GNRdP_EXmYqacg5o3jPegqqaFZZYqqRutFA@mail.gmail.com> <20210205100449.w2vzqozgnolxqh4h@pali>
In-Reply-To: <20210205100449.w2vzqozgnolxqh4h@pali>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Feb 2021 11:16:00 +0100
Message-ID: <CAKMK7uG9NsEzFfapZa4KF6sw0=CuD6Pyk5=7WhjxgFBut4uJkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: also set up legacy files only after sysfs init
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 5, 2021 at 11:04 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 05 February 2021 10:59:50 Daniel Vetter wrote:
> > On Thu, Feb 4, 2021 at 11:24 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > On Thursday 04 February 2021 15:50:19 Bjorn Helgaas wrote:
> > > > [+cc Oliver, Pali, Krzysztof]
> > >
> > > Just to note that extending or using sysfs_initialized introduces
> > > another race condition into kernel code which results in PCI fatal
> > > errors. Details are in email discussion which Bjorn already sent.
> >
> > Yeah I wondered why this doesn't race.
>
> It races, but with smaller probability. I have not seen this race
> condition on x86. But I was able to reproduce it with native PCIe
> drivers on ARM64 (Marvell Armada 3720; pci-aardvark). In mentioned
> discussion I wrote when this race condition happen. But I understand
> that it is hard to simulate it.

btw I looked at your patch, and isn't that just reducing the race window?

I think we have a very similar problem in drm, where the
drm_dev_register() for the overall device (which also registers all
drm_connector) can race with the hotplug of an individual connector in
drm_connector_register() which is hotplugged at runtime.

I went with a per-connector registered boolean + a lock to make sure
that really only one of the two call paths can end up registering the
connector. Part of registering connectors is setting up sysfs files,
so I think it's exactly the same problem as here.

Cheers, Daniel

>
> > but since the history goes back
> > to pre-git times I figured it would have been addressed somehow
> > already if it indeed does race.
> > -Daniel
> >
> > > > s/also/Also/ in subject
> > > >
> > > > On Thu, Feb 04, 2021 at 05:58:30PM +0100, Daniel Vetter wrote:
> > > > > We are already doing this for all the regular sysfs files on PCI
> > > > > devices, but not yet on the legacy io files on the PCI buses. Thu=
s far
> > > > > now problem, but in the next patch I want to wire up iomem revoke
> > > > > support. That needs the vfs up an running already to make so that
> > > > > iomem_get_mapping() works.
> > > >
> > > > s/now problem/no problem/
> > > > s/an running/and running/
> > > > s/so that/sure that/ ?
> > > >
> > > > iomem_get_mapping() doesn't exist; I don't know what that should be=
.
> > > >
> > > > > Wire it up exactly like the existing code. Note that
> > > > > pci_remove_legacy_files() doesn't need a check since the one for
> > > > > pci_bus->legacy_io is sufficient.
> > > >
> > > > I'm not sure exactly what you mean by "the existing code."  I could
> > > > probably figure it out, but it would save time to mention the exist=
ing
> > > > function here.
> > > >
> > > > This looks like another instance where we should really apply Olive=
r's
> > > > idea of converting these to attribute_groups [1].
> > > >
> > > > The cover letter mentions options discussed with Greg in [2], but I
> > > > don't think the "sysfs_initialized" hack vs attribute_groups was pa=
rt
> > > > of that discussion.
> > > >
> > > > It's not absolutely a show-stopper, but it *is* a shame to extend t=
he
> > > > sysfs_initialized hack if attribute_groups could do this more clean=
ly
> > > > and help solve more than one issue.
> > > >
> > > > Bjorn
> > > >
> > > > [1] https://lore.kernel.org/r/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704=
ZEwLKGXQzBfqaA@mail.gmail.com
> > > > [2] https://lore.kernel.org/dri-devel/CAKMK7uGrdDrbtj0OyzqQc0CGrQwc=
2F3tFJU9vLfm2jjufAZ5YQ@mail.gmail.com/
> > > >
> > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > > Cc: Jan Kara <jack@suse.cz>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: linux-mm@kvack.org
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > Cc: linux-samsung-soc@vger.kernel.org
> > > > > Cc: linux-media@vger.kernel.org
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: linux-pci@vger.kernel.org
> > > > > ---
> > > > >  drivers/pci/pci-sysfs.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > index fb072f4b3176..0c45b4f7b214 100644
> > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > @@ -927,6 +927,9 @@ void pci_create_legacy_files(struct pci_bus *=
b)
> > > > >  {
> > > > >     int error;
> > > > >
> > > > > +   if (!sysfs_initialized)
> > > > > +           return;
> > > > > +
> > > > >     b->legacy_io =3D kcalloc(2, sizeof(struct bin_attribute),
> > > > >                            GFP_ATOMIC);
> > > > >     if (!b->legacy_io)
> > > > > @@ -1448,6 +1451,7 @@ void pci_remove_sysfs_dev_files(struct pci_=
dev *pdev)
> > > > >  static int __init pci_sysfs_init(void)
> > > > >  {
> > > > >     struct pci_dev *pdev =3D NULL;
> > > > > +   struct pci_bus *pbus =3D NULL;
> > > > >     int retval;
> > > > >
> > > > >     sysfs_initialized =3D 1;
> > > > > @@ -1459,6 +1463,9 @@ static int __init pci_sysfs_init(void)
> > > > >             }
> > > > >     }
> > > > >
> > > > > +   while ((pbus =3D pci_find_next_bus(pbus)))
> > > > > +           pci_create_legacy_files(pbus);
> > > > > +
> > > > >     return 0;
> > > > >  }
> > > > >  late_initcall(pci_sysfs_init);
> > > > > --
> > > > > 2.30.0
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
