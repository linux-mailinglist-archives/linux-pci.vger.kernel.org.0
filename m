Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01D77D3A0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjHOTvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjHOTvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 15:51:13 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851C210D;
        Tue, 15 Aug 2023 12:51:00 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4477a8ea6d7so2478657137.3;
        Tue, 15 Aug 2023 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692129059; x=1692733859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQFmA5x3v4QCbx5pPKGXhcQ3QF+tDKXwq5gJcyBoqeY=;
        b=TsYXJs7LFVJ7FHvFM9fUGh2sjUvNfz9AjBWBH9gurpCjd026B2GwaKGV1XGYC5Zlvt
         amccZ5nUEyazGOeHToxdgF+S50a9+sccS9TcZd4W/IFQz2d86KtzaE9odzhW5NAGp/Qc
         Iljm0lJs+mI4xOR9wsLjP8/i1fPwBAcQAjMeKtUC0YblvwBEuVj0YGl1SROooepUcaSd
         sJ+koU37KnKRmuyeGjeO26d1JBMSe3yD/NUiUeuXe/QZvmUh6TEdmE/WV2OEYXT1sL28
         0FpNN0Fq+E3k8ARaYjZUaxitORtEx2hb+BRpA4VJI3aXVRxbkS3vQf6x19wn7cr4tdSe
         a1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692129059; x=1692733859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQFmA5x3v4QCbx5pPKGXhcQ3QF+tDKXwq5gJcyBoqeY=;
        b=ikYPbSW6Mdx5CB774DNhZiHT7YTnAVcF8d4/GgwwVNSYyWU2nukMBK1CfbQmg0Qtlb
         b1fpGA/awo5HxeId2Hj3wx6d2sGY3AP9rZ4BAGybfcrkmQ2AaCa0QFKLkpcTYlMQq07z
         0p9bUVpAu0+LeP93LVStN2Q1U0bloRhp9DdMmoCTq6HXdyJZ9kgrmbKCSFmf1wmcE3N+
         GQlFSzxhtJ5fSyZx/TwH0RegPx5log0WYWKIXuFBoxYjWq7R8m9sWMZjkLiX55gRNqy9
         1hW3OuMivfVjxqQDVK3OmD/FrXpXeVj+fUw6o9t+Glc0kaWlvciwOsPLgsYuWoorahKe
         /toQ==
X-Gm-Message-State: AOJu0YzW/J+ZEkTHi2nb0niP4UfFxrC4r0FGckm6yZzKIVBxivbNI8Vc
        c5lotv5l63Ka4TTw0C6pvLGJzSoABKZrnVVnb2U=
X-Google-Smtp-Source: AGHT+IHsLH16Oh/Va8Nf8CWqnOSIHX+sZn5I+Qc7I1W8GkFWveCgy/PICIao9FZ8piHL8B32Y9fA83uqlA22yim1y18=
X-Received: by 2002:a67:f686:0:b0:443:895d:1b53 with SMTP id
 n6-20020a67f686000000b00443895d1b53mr12125652vso.10.1692129059341; Tue, 15
 Aug 2023 12:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de> <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
 <20230812081526.GC9469@wunner.de> <2023081224-famished-devotion-6e0e@gregkh>
 <CAKmqyKPx9Oi-ZF0grdUzkHi5BjyyNQZ2r30vgShR6cOY9xZ9YQ@mail.gmail.com> <2023081543-clarify-deniable-8de8@gregkh>
In-Reply-To: <2023081543-clarify-deniable-8de8@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 15 Aug 2023 15:50:31 -0400
Message-ID: <CAKmqyKMHpo8MA9cRAzxWNT+P9poHCKbSpNF4yk8MrVg9+k8=_A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 11:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Aug 15, 2023 at 09:44:32AM -0400, Alistair Francis wrote:
> > On Sat, Aug 12, 2023 at 4:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Aug 12, 2023 at 10:15:26AM +0200, Lukas Wunner wrote:
> > > > On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrote:
> > > > > On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.de> =
wrote:
> > > > > > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrot=
e:
> > > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(s=
truct pci_dev *pdev)
> > > > > > >       int i;
> > > > > > >       int retval;
> > > > > > >
> > > > > > > +#ifdef CONFIG_PCI_DOE
> > > > > > > +     retval =3D doe_sysfs_init(pdev);
> > > > > > > +     if (retval)
> > > > > > > +             return retval;
> > > > > > > +#endif
> > > > > > > +
> > > > > >
> > > > > > The preferred way to expose PCI sysfs attributes nowadays is to=
 add them
> > > > > > to pci_dev_attr_groups[] and use the ->is_visible callback to c=
heck
> > > > > > whether they're applicable to a particular pci_dev.  The altern=
ative
> > > > > > via pci_create_resource_files() has race conditions which I thi=
nk
> > > > > > still haven't been fixed. Bjorn recommended the ->is_visible ap=
proach
> > > > > > in response to the most recent attempt to fix the race:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelg=
aas/
> > > > >
> > > > > The is_visible doen't seem to work in this case.
> > > > >
> > > > > AFAIK is_visible only applies to the attributes under the group. =
Which
> > > > > means that every PCIe device will see a `doe_protos` directory, n=
o
> > > > > matter if DOE is supported.
> > > >
> > > > internal_create_group() in fs/sysfs/group.c does this:
> > > >
> > > >       if (grp->name) {
> > > >                       ...
> > > >                       kn =3D kernfs_create_dir_ns(kobj->sd, grp->na=
me, ...
> > > >
> > > > So I'm under the impression that if you set the ->name member of
> > > > struct attribute_group, the attributes in that group appear under
> > > > a directory of that name.
> > > >
> > > > In fact, the kernel-doc for struct attribute_group claims as much:
> > > >
> > > >  * struct attribute_group - data structure used to declare an attri=
bute group.
> > > >  * @name:     Optional: Attribute group name
> > > >  *            If specified, the attribute group will be created in
> > > >  *            a new subdirectory with this name.
> > > >
> > > > So I don't quite understand why you think that "every PCIe device w=
ill
> > > > see a `doe_protos` directory, no matter if DOE is supported"?
> > > >
> > > > Am I missing something?
> > >
> > > I think the issue might be that the directory will be created even if=
 no
> > > attributes are present in it due to the is_visable() check not return=
ing
> > > any valid files?
> >
> > Yes, that's what I'm seeing. I see the directory for all PCIe devices
> >
> > This is a WIP that I had:
> > https://github.com/alistair23/linux/commit/61925cd174c31386eaa7e51e3a1b=
e606b38f847c
> >
> > >
> > > If so, I had a patch somewhere around here where I was trying to fix
> > > that up:
> > >         https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver=
-core.git/commit/?h=3Ddebugfs_cleanup&id=3Df670945dfbaf353fe068544c31e3fa45=
575da5b5
> > > but it didn't seem to work properly and kept crashing.  I didn't spen=
d
> > > much time on looking into it, but if this is an issue, I can work on
> > > fixing this properly.
> >
> > That patch sounds like it would fix the issue of empty directories
> > that I'm seeing. Do you mind fixing it up properly?
>
> I am currently unable to do so due to travel and stuff for a few weeks,
> sorry.  Feel free to take it and fix the boot crash that is seen with it
> and make it part of your patch series if you can't wait that long.

No worries.

It's much harder than I first thought though. There are currently lots
of users who expect the group to remain even if empty, as they
dynamically add/merge properties later. Which is what we end up doing
for DOE as well

I'll keep looking into this and see if I can figure something out.

Would an .attr_is_visible() function pointer for struct
attribute_group something that the kernel would accept?

Alistair

>
> thanks,
>
> greg k-h
