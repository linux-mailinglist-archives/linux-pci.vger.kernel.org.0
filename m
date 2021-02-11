Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85E7318DD5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKPEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhBKO5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 09:57:30 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B217C0613D6
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 06:56:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l23so5343608otn.10
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RmVDQyx+Ndcv5SeblotXpQRe27Egv2RqGDvlo6R5U8w=;
        b=E2yi8Dzo7qq3E3/flljC3xH7tiHdegmynb0SA7JlYIz5EM1sj6y32R7tM/aX9DYRic
         K+hqQA0/ECrgtm5QdSQmTLpcu8HZWUSLZuquZhonvDmxHXsor2V3Ekd730+4qyLBylcH
         5EHSAuBOoS1VnBHeezqtR3TIZEBKmUAZXQNaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RmVDQyx+Ndcv5SeblotXpQRe27Egv2RqGDvlo6R5U8w=;
        b=iZNKVhEDp4zCUrhpiQfeiHpeLPc/dxZMBjzeqtNRsUZoryVgd1qpagnYRKn9+Iftmk
         3UTjCwPW3naw0SocQ6dMFV0CA7cQDhMZ7zUjLX4yURE1hmMCnwimoyRW2QdtTWpY5p9P
         r/EU99n6Wq8XhMeG0aYqEEHnjLd5d7UH7E4ngDqXRCcp8JjDx8kWsL6EqwSOLj5fhtZ9
         zSJ1VNoam7IcbtOGEqjoP1Er1lQtLNFlu3QW6e4Qyl0CgtUUeaz4fm4LRzZJsEUO9Q1g
         UC8faDaRN8A3mIs0eckRnXb7V1MCdLDLaSXNzOM0IlpD9H02S2mIeQCF0dz3m48k/lKQ
         u7LA==
X-Gm-Message-State: AOAM532DKzM3ydbW23Gv3C6QtLgtmwxcp5zLRubHuO23dIsZU/ML8eh7
        bl/PVeDDnejpMo2zRDIK+YtLZdkkBUL0Qt4TUUiBsA==
X-Google-Smtp-Source: ABdhPJw3fjkRP9gLP7q/RDjMJ5TKsouRdxxZLHu0I2VLcTiQg1aD1zxxpNTCk8c6mMpxWvFuDBl3KNzaOyf4zVs07lM=
X-Received: by 2002:a9d:2270:: with SMTP id o103mr5794245ota.303.1613055403311;
 Thu, 11 Feb 2021 06:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20210205133632.2827730-1-daniel.vetter@ffwll.ch> <20210210214053.GA610964@bjorn-Precision-5520>
In-Reply-To: <20210210214053.GA610964@bjorn-Precision-5520>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 11 Feb 2021 15:56:30 +0100
Message-ID: <CAKMK7uHi3Uvze3epTPC4613UzbT24LSO2GP8EkU8nxaKxOQBSA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Also set up legacy files only after sysfs init
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
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 10:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 02:36:32PM +0100, Daniel Vetter wrote:
> > We are already doing this for all the regular sysfs files on PCI
> > devices, but not yet on the legacy io files on the PCI buses. Thus far
> > no problem, but in the next patch I want to wire up iomem revoke
> > support. That needs the vfs up and running already to make sure that
> > iomem_get_mapping() works.
> >
> > Wire it up exactly like the existing code in
> > pci_create_sysfs_dev_files(). Note that pci_remove_legacy_files()
> > doesn't need a check since the one for pci_bus->legacy_io is
> > sufficient.
> >
> > An alternative solution would be to implement a callback in sysfs to
> > set up the address space from iomem_get_mapping() when userspace calls
> > mmap(). This also works, but Greg didn't really like that just to work
> > around an ordering issue when the kernel loads initially.
> >
> > v2: Improve commit message (Bjorn)
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I wish we weren't extending a known-racy mechanism to do this, but at
> least we're not *adding* a brand new race.

Yeah it's not great. Thanks for looking at both again, I'll fix up the
typos on the 2nd one and merge them both.

Cheers, Daniel

>
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
