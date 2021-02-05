Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4CB3107EA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBEJcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 04:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBEJYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 04:24:01 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F9C06178B
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 01:23:21 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v1so6229212ott.10
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 01:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sS/Xd09oO/Yz7Hj4c1pMXiQx4PAyc9TbJHEWESq/zdk=;
        b=F2M9IQ0Mcwqf9L0EvHG8jvCxSS3P6nZN7xpdji0YW2Vb0bIMHJ0EICfSmJXH13+OEm
         krPXGvlWcY44Pt7pUr/D3V+F0v5YY7w63OxZE08ttweY89J8zqB7lHIAILmCZ9ny2YqN
         9zo+EbKF4hd8YpcfyTU2+f4zh7/eT3IqgIEvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sS/Xd09oO/Yz7Hj4c1pMXiQx4PAyc9TbJHEWESq/zdk=;
        b=Lm8wHJi8sR2Z1AIyVn52+DPSWzJVMlXJtEYWZv5KrhmWHITGNL4CZP6HnVF8oIEA6w
         B8Qd7iZ/Tiqku5NBrFG9VjyYClP9N7nkNOcxH+XX7BrRFvmRfBJmuQO3XClwSWpOBm/U
         /nrJziZvyTYxlhD7iFfANoxfXPJIQnWS9WJQn3UKyJVoJo4gcMORjh1EiwI9MHX5qb3G
         kvDZJwLkYYKGwUAVPgq97M41VncD0u3sM6/8cBs2NrBXa9vTolWlK6thdsk7zHsSfo+v
         PaNoCtOgG8JQa6sJfSwLl1ZtIvzdVLfGmq3v/bS7gXS4UlZ38HUQlQxQJ++jl8V2rgMh
         1Qyg==
X-Gm-Message-State: AOAM531sNr26inCdG4TTLRtEjqJ9978+cOAbGcQo82VNzgLBL4/V/Mnv
        yai/FlVg+7miaHM8cM0TOZzZ4KErxjvyR/a+fv96OA==
X-Google-Smtp-Source: ABdhPJyvqwxmtXpTV9ZKIAiLz9FmmOsfNWEZVdMA32uQT+RmaGjI6VWxp+i56z1wSxB5hntfBMxUSK7fieqhiVOdzSE=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr2681535otr.303.1612517000615;
 Fri, 05 Feb 2021 01:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20210204165831.2703772-2-daniel.vetter@ffwll.ch> <20210204215019.GA104698@bjorn-Precision-5520>
In-Reply-To: <20210204215019.GA104698@bjorn-Precision-5520>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Feb 2021 10:23:09 +0100
Message-ID: <CAKMK7uFczzNCDmakn1mxdjpeFaTcdayG4pVedq_f11gYnPbMRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: also set up legacy files only after sysfs init
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 4, 2021 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Oliver, Pali, Krzysztof]
>
> s/also/Also/ in subject
>
> On Thu, Feb 04, 2021 at 05:58:30PM +0100, Daniel Vetter wrote:
> > We are already doing this for all the regular sysfs files on PCI
> > devices, but not yet on the legacy io files on the PCI buses. Thus far
> > now problem, but in the next patch I want to wire up iomem revoke
> > support. That needs the vfs up an running already to make so that
> > iomem_get_mapping() works.
>
> s/now problem/no problem/
> s/an running/and running/
> s/so that/sure that/ ?
>
> iomem_get_mapping() doesn't exist; I don't know what that should be.

Series is based on top of linux-next, where iomem_get_mapping exists.
This patch fixes the 2nd patch in this series, which I had to take out
of my branch because it failed.

> > Wire it up exactly like the existing code. Note that
> > pci_remove_legacy_files() doesn't need a check since the one for
> > pci_bus->legacy_io is sufficient.
>
> I'm not sure exactly what you mean by "the existing code."  I could
> probably figure it out, but it would save time to mention the existing
> function here.

Sorry, I meant the existing code in pci_create_sysfs_dev_files().

> This looks like another instance where we should really apply Oliver's
> idea of converting these to attribute_groups [1].
>
> The cover letter mentions options discussed with Greg in [2], but I
> don't think the "sysfs_initialized" hack vs attribute_groups was part
> of that discussion.

Hm not sure the attribute_groups works. The problem is that I cant set
up the attributes before the vfs layer is initialized, because before
that point the iomem_get_mapping function doesn't return anything
useful (well it crashes), because it needs to have an inode available.

So if you want to set up the attributes earlier, we'd need some kind
of callback, which Greg didn't like.

> It's not absolutely a show-stopper, but it *is* a shame to extend the
> sysfs_initialized hack if attribute_groups could do this more cleanly
> and help solve more than one issue.

So I think I have yet another init ordering problem here, but not sure.
-Daniel

>
> Bjorn
>
> [1] https://lore.kernel.org/r/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKG=
XQzBfqaA@mail.gmail.com
> [2] https://lore.kernel.org/dri-devel/CAKMK7uGrdDrbtj0OyzqQc0CGrQwc2F3tFJ=
U9vLfm2jjufAZ5YQ@mail.gmail.com/
>
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
> >  drivers/pci/pci-sysfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index fb072f4b3176..0c45b4f7b214 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -927,6 +927,9 @@ void pci_create_legacy_files(struct pci_bus *b)
> >  {
> >       int error;
> >
> > +     if (!sysfs_initialized)
> > +             return;
> > +
> >       b->legacy_io =3D kcalloc(2, sizeof(struct bin_attribute),
> >                              GFP_ATOMIC);
> >       if (!b->legacy_io)
> > @@ -1448,6 +1451,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *p=
dev)
> >  static int __init pci_sysfs_init(void)
> >  {
> >       struct pci_dev *pdev =3D NULL;
> > +     struct pci_bus *pbus =3D NULL;
> >       int retval;
> >
> >       sysfs_initialized =3D 1;
> > @@ -1459,6 +1463,9 @@ static int __init pci_sysfs_init(void)
> >               }
> >       }
> >
> > +     while ((pbus =3D pci_find_next_bus(pbus)))
> > +             pci_create_legacy_files(pbus);
> > +
> >       return 0;
> >  }
> >  late_initcall(pci_sysfs_init);
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
