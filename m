Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908DC288A99
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgJIOTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbgJIOTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 10:19:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAE6C0613D7
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 07:19:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so9100887ota.10
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MM70QuqTQsUBVq7gYXvXBZty2HeYwYo1AwlGqBndKzc=;
        b=TXHPzxH9Da/xVr/PCQoDGy8c0zPWy+ggD3CN9+uIIarhuboqtJeD+WQppuYxHsd6Lw
         Y7BHU63LYKcn8Q19C0ojPAIbHvLgUU7idHjBxl/cqvgWdtq9sYwq7aJadM3ewUTikvYS
         Or+ZtapYPyo5QGIWg5F96VAf0fQY9D81hLV+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MM70QuqTQsUBVq7gYXvXBZty2HeYwYo1AwlGqBndKzc=;
        b=aCpBvXSRNIShG7czSt2awA/AnlJWSDhKGB9CzzEwGIP9g0vTJc7JWBYxV+uw1UXHR/
         XK2kjCjzx4x2xnxQX1yAjP6QoBAbE29BhKBQtgf4WHqNnHNaGwLd29MR8QY8nVNaYfVp
         BGRgSB+YDDYKhA6jjN3Scs6RxT48C73/99dJWC66ufx/f8a5Bm76BBnHp6+MVYJtWvRy
         m6GIs/36khy+3qG1ZC972q4NSLTp0LkNVOcU+ByjiaHoJ2XNcc4wL/nMDT/UjH+Y9ope
         /0ORgJold9kiIsqAF4VYUFvBOsJjScp+RCipOHoHy0uXUwXq8BXzeuUTxPLIT5ammJoG
         BWfg==
X-Gm-Message-State: AOAM531wg/aEQ4bCAoZthYf7E/J25BEx5Huq9Svs2NkWnwbE7b3KwaIV
        3hVr5qj9VlNYkLBY393cVBIsJyF4gCwhOHsKZROHPg==
X-Google-Smtp-Source: ABdhPJzNidxPOYe2uXf9i2kyX3nO4EFb7XRxsxlaQUOxC+n0ejMSsQdbIKmUu2me6/FBsUnaPi9FuwTaAIvXBztd7mE=
X-Received: by 2002:a05:6830:1c3c:: with SMTP id f28mr9534834ote.188.1602253144991;
 Fri, 09 Oct 2020 07:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-18-daniel.vetter@ffwll.ch> <20201009094750.GQ6112@intel.com>
 <CAKMK7uH3o3hnRkTDqr93PR=wuRejpty+AbyMacoEFDDb6OgJeQ@mail.gmail.com> <20201009104154.GR6112@intel.com>
In-Reply-To: <20201009104154.GR6112@intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 9 Oct 2020 16:18:53 +0200
Message-ID: <CAKMK7uEp71+B3EVTezog8U3VY=DUYAbe1QeqZH9NEG8T37M_Cw@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] drm/i915: Properly request PCI BARs
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        KVM list <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 9, 2020 at 12:42 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Oct 09, 2020 at 12:01:39PM +0200, Daniel Vetter wrote:
> > On Fri, Oct 9, 2020 at 11:47 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Fri, Oct 09, 2020 at 09:59:34AM +0200, Daniel Vetter wrote:
> > > > When trying to test my CONFIG_IO_STRICT_DEVMEM changes I realized t=
hey
> > > > do nothing for i915. Because i915 doesn't request any regions, like
> > > > pretty much all drm pci drivers. I guess this is some very old
> > > > remnants from the userspace modesetting days, when we wanted to
> > > > co-exist with the fbdev driver. Which usually requested these
> > > > resources.
> > > >
> > > > But makes me wonder why the pci subsystem doesn't just request
> > > > resource automatically when we map a bar and a pci driver is bound?
> > > >
> > > > Knowledge about which pci bars we need kludged together from
> > > > intel_uncore.c and intel_gtt.c from i915 and intel-gtt.c over in th=
e
> > > > fake agp driver.
> > > >
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-samsung-soc@vger.kernel.org
> > > > Cc: linux-media@vger.kernel.org
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > ---
> > > >  drivers/gpu/drm/i915/intel_uncore.c | 25 +++++++++++++++++++++++--
> > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/=
i915/intel_uncore.c
> > > > index 54e201fdeba4..ce39049d8919 100644
> > > > --- a/drivers/gpu/drm/i915/intel_uncore.c
> > > > +++ b/drivers/gpu/drm/i915/intel_uncore.c
> > > > @@ -1692,10 +1692,13 @@ static int uncore_mmio_setup(struct intel_u=
ncore *uncore)
> > > >       struct pci_dev *pdev =3D i915->drm.pdev;
> > > >       int mmio_bar;
> > > >       int mmio_size;
> > > > +     int bar_selection;
> > >
> > > Signed bitmasks always make me uneasy. But looks like
> > > that's what it is in the pci api. So meh.
> >
> > Yeah it's surprising.
> >
> > > > +     int ret;
> > > >
> > > >       mmio_bar =3D IS_GEN(i915, 2) ? 1 : 0;
> > > > +     bar_selection =3D BIT (2) | BIT(mmio_bar);
> > >                            ^
> > > spurious space
> > >
> > > That's also not correct for gen2 I think.
> > >
> > > gen2:
> > > 0 =3D GMADR
> > > 1 =3D MMADR
> > > 2 =3D IOBAR
> > >
> > > gen3:
> > > 0 =3D MMADR
> > > 1 =3D IOBAR
> > > 2 =3D GMADR
> > > 3 =3D GTTADR
> > >
> > > gen4+:
> > > 0+1 =3D GTTMMADR
> > > 2+3 =3D GMADR
> > > 4 =3D IOBAR
> > >
> > > Maybe we should just have an explicit list of bars like that in a
> > > comment?
> > >
> > > I'd also suggest sucking this bitmask calculation into a small helper
> > > so you can reuse it for the release.
> >
> > tbh I just hacked this up for testing. Given how almost no other drm
> > driver does this, I'm wondering whether we should or not.
> >
> > Also the only reason why I didn't just use the pci_request_regions
> > helper is to avoid the vga ioport range, since that's managed by
> > vgaarbiter.
>
> VGA io range isn't part of any bar. Or do you mean just the io decode
> enable bit in the pci command register? That should be just a matter
> or pci_enable_device() vs. pci_enable_device_mem() I think. So nothing
> to do with which bars we've requested IIRC.
>
> >
> > So I think if we go for this for real we should:
> > - register the vga ioport range in the vgaarbiter
> > - have a pci_request_iomem_regions helper that grabs all mem bars
> > - roll that out to all drm pci drivers
> >
> > Or something like that. The other complication is when we resize the
> > iobar. So not really sure what to do here.
>
> We resize it?

By default I thought firmware puts everything (well, squeezes) into
the lower 32bit. Maybe they stopped doing that. So when we want the
full bar (for discrete at least) we need to resize it and put it
somewhere in the 64bit range above end of system memory.

So I guess correct phrasing is "we will resize it" :-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
