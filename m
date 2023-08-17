Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885A77FEA5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbjHQTl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349518AbjHQTlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:41:51 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB410E9;
        Thu, 17 Aug 2023 12:41:50 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44ac6638896so39715137.2;
        Thu, 17 Aug 2023 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692301309; x=1692906109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o4QPTC0x5SDosCyvtrKyF/pyOdwEWIkCSwmSE9crCQ=;
        b=ZMOzeyUouQdyNGHF70N7yntux616ul35ERKtQpaxi4/ijoziRufBFbGkK5Cnr+1mmm
         mN0IFwhWO8bL6B1ZwFsjV/i/847otg+MX4QFluNQ4aUGUdjGUdaPA4dGJZgeeEENWtDt
         hP8iWXKJ/X4EqL0lFL3zw/AQCQG8Yw4Os0ZpeI6Cx2s6dh//loQS4AfdWCYMm7PBM5Z4
         /gbQHBtO3rKeSg9KsyhXXsAda999cPcAFkPUsWlx7sIQI/dr9QSv3SO9ReR5JSZFEEtK
         ClLqtQ3f0BlNqqE5AHJVW8NOAMdazzp7QkfntDJq9zhjR5W1oV0det02Cse1J/bEDhcM
         j00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301309; x=1692906109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4QPTC0x5SDosCyvtrKyF/pyOdwEWIkCSwmSE9crCQ=;
        b=kk+/Qh0z12uZ1Cb7FzsofGE0iYCzBilJg7CWG4SNLV9eGZrg+kfexzEHaNAuDjSj5X
         3Q6ZGOQ89Zsz0yAEON4CwnQA/DjeYmk7wytvetJOXUHo2r2PAgSGcJq1QyYtmjhQsNRN
         qIkxLoMKCvNklCagQAVMm3ejid+XCEZj+9P2FYjYzHpPxDYlyk50z0MLkQck01wo/qUH
         JKhSFrHO8js3auuQBdWktTZTHYi04vupyEo9W/jU2w8fAj/PGnCos8D6y5e0JDsJG3LR
         fqubgzI+vw3GphzwQysxKcIqesuDu0rxRKwDpZGyv0fkEFPqGsD54d3iBXcItmwwi9QZ
         Nptw==
X-Gm-Message-State: AOJu0Yzb/9NYCufeUiEOSS6GAwqu/mhoDlbKT89rYXJLnepPp48+wMI9
        oiWn/jiLX4B1yvHkxJwD7kIlp1N7neYo1jclXD4=
X-Google-Smtp-Source: AGHT+IHHfIA7dxyc20KQfKMQBSbPncIaUu8NMSiMdqRsLKcL2jrE/dIZfWA5GHpJeb5m7s63IJHmhetF85HFlpYgaF0=
X-Received: by 2002:a05:6102:3565:b0:447:6965:7284 with SMTP id
 bh5-20020a056102356500b0044769657284mr896403vsb.8.1692301309467; Thu, 17 Aug
 2023 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de> <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
 <20230812081526.GC9469@wunner.de> <2023081224-famished-devotion-6e0e@gregkh>
 <CAKmqyKPx9Oi-ZF0grdUzkHi5BjyyNQZ2r30vgShR6cOY9xZ9YQ@mail.gmail.com>
 <2023081543-clarify-deniable-8de8@gregkh> <CAKmqyKMHpo8MA9cRAzxWNT+P9poHCKbSpNF4yk8MrVg9+k8=_A@mail.gmail.com>
 <2023081538-grab-alongside-ce24@gregkh>
In-Reply-To: <2023081538-grab-alongside-ce24@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 17 Aug 2023 15:41:23 -0400
Message-ID: <CAKmqyKOmYfWWxf-90k_VY_csehGhGp59HRx4uvO2ej=8XFtOig@mail.gmail.com>
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

On Tue, Aug 15, 2023 at 4:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 15, 2023 at 03:50:31PM -0400, Alistair Francis wrote:
> > On Tue, Aug 15, 2023 at 11:11=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 09:44:32AM -0400, Alistair Francis wrote:
> > > > On Sat, Aug 12, 2023 at 4:26=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Sat, Aug 12, 2023 at 10:15:26AM +0200, Lukas Wunner wrote:
> > > > > > On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrot=
e:
> > > > > > > On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.=
de> wrote:
> > > > > > > > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis =
wrote:
> > > > > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > > > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_fil=
es(struct pci_dev *pdev)
> > > > > > > > >       int i;
> > > > > > > > >       int retval;
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_PCI_DOE
> > > > > > > > > +     retval =3D doe_sysfs_init(pdev);
> > > > > > > > > +     if (retval)
> > > > > > > > > +             return retval;
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > >
> > > > > > > > The preferred way to expose PCI sysfs attributes nowadays i=
s to add them
> > > > > > > > to pci_dev_attr_groups[] and use the ->is_visible callback =
to check
> > > > > > > > whether they're applicable to a particular pci_dev.  The al=
ternative
> > > > > > > > via pci_create_resource_files() has race conditions which I=
 think
> > > > > > > > still haven't been fixed. Bjorn recommended the ->is_visibl=
e approach
> > > > > > > > in response to the most recent attempt to fix the race:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/linux-pci/20230427161458.GA249886@b=
helgaas/
> > > > > > >
> > > > > > > The is_visible doen't seem to work in this case.
> > > > > > >
> > > > > > > AFAIK is_visible only applies to the attributes under the gro=
up. Which
> > > > > > > means that every PCIe device will see a `doe_protos` director=
y, no
> > > > > > > matter if DOE is supported.
> > > > > >
> > > > > > internal_create_group() in fs/sysfs/group.c does this:
> > > > > >
> > > > > >       if (grp->name) {
> > > > > >                       ...
> > > > > >                       kn =3D kernfs_create_dir_ns(kobj->sd, grp=
->name, ...
> > > > > >
> > > > > > So I'm under the impression that if you set the ->name member o=
f
> > > > > > struct attribute_group, the attributes in that group appear und=
er
> > > > > > a directory of that name.
> > > > > >
> > > > > > In fact, the kernel-doc for struct attribute_group claims as mu=
ch:
> > > > > >
> > > > > >  * struct attribute_group - data structure used to declare an a=
ttribute group.
> > > > > >  * @name:     Optional: Attribute group name
> > > > > >  *            If specified, the attribute group will be created=
 in
> > > > > >  *            a new subdirectory with this name.
> > > > > >
> > > > > > So I don't quite understand why you think that "every PCIe devi=
ce will
> > > > > > see a `doe_protos` directory, no matter if DOE is supported"?
> > > > > >
> > > > > > Am I missing something?
> > > > >
> > > > > I think the issue might be that the directory will be created eve=
n if no
> > > > > attributes are present in it due to the is_visable() check not re=
turning
> > > > > any valid files?
> > > >
> > > > Yes, that's what I'm seeing. I see the directory for all PCIe devic=
es
> > > >
> > > > This is a WIP that I had:
> > > > https://github.com/alistair23/linux/commit/61925cd174c31386eaa7e51e=
3a1be606b38f847c
> > > >
> > > > >
> > > > > If so, I had a patch somewhere around here where I was trying to =
fix
> > > > > that up:
> > > > >         https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/dr=
iver-core.git/commit/?h=3Ddebugfs_cleanup&id=3Df670945dfbaf353fe068544c31e3=
fa45575da5b5
> > > > > but it didn't seem to work properly and kept crashing.  I didn't =
spend
> > > > > much time on looking into it, but if this is an issue, I can work=
 on
> > > > > fixing this properly.
> > > >
> > > > That patch sounds like it would fix the issue of empty directories
> > > > that I'm seeing. Do you mind fixing it up properly?
> > >
> > > I am currently unable to do so due to travel and stuff for a few week=
s,
> > > sorry.  Feel free to take it and fix the boot crash that is seen with=
 it
> > > and make it part of your patch series if you can't wait that long.
> >
> > No worries.
> >
> > It's much harder than I first thought though. There are currently lots
> > of users who expect the group to remain even if empty, as they
> > dynamically add/merge properties later. Which is what we end up doing
> > for DOE as well
> >
> > I'll keep looking into this and see if I can figure something out.
>
> Yeah, now that I think about it, that's where stuff fell apart for me as
> well.  We should be able to create the group and then only create the
> file when they are added/merged, so I bet I missed a codepath somewhere.

Yeah, it's tricky.

The documentation for sysfs_merge_group() specifically says

This function returns an error if the group doesn't exist or any of the
files already exist in that group, in which case none of the new files
are created.

as an empty group isn't created with your patch it doesn't work with
sysfs_merge_group().

I'm assuming we don't want to change those public functions by
creating the group in sysfs_merge_group() if it isn't created.

Creating the group is just creating the directory, so I don't see a
way we can create the group without creating the directory

Alistair

>
> > Would an .attr_is_visible() function pointer for struct
> > attribute_group something that the kernel would accept?
>
> Worst case, yes, that would be acceptable.  But try to see where I
> messed up on the original patch, it should be able to be done
> automatically somehow...
>
> thanks,
>
> greg k-h
