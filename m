Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673576BC50
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjHASZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHASYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 14:24:54 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779A2130;
        Tue,  1 Aug 2023 11:24:52 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4476a2a5bc9so1859647137.2;
        Tue, 01 Aug 2023 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690914291; x=1691519091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eERMSYYSDZt1sQe+bzSLdAZ0mwIc+3+1BsSvv7e7c+4=;
        b=NiQRMykLF7Xs03uvpZSQYP57Q2FAKzBabRjCDbaR6+D7iwTRr/qTjc4g8+EBnH2Oyd
         niVG03ra41M2z/KQ+3UG6CzvGgEVfociw5nwNt0iulsKK9UpFHGw0Xg3ZkAd4qCNaGAZ
         gdwUfo51ha1whi4dE9w/4kM6UhalP+3mRH6Bx0PwwbHTnb5zf4XIy7eupSv+yY+5AB7E
         Qz/Hr3WeKz+rbFyE1YVG8MkhMMVsamGrtw3sCv5jVBqZ4/APDjEssOOmLzBQj8MqgsqS
         FOyIoOYE2FAg7SKuXvZnNdd8NXnE9y1LuTmGUewPMAT1FPuPjpXLTgTVPR0cXf5yLwmn
         P9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914291; x=1691519091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eERMSYYSDZt1sQe+bzSLdAZ0mwIc+3+1BsSvv7e7c+4=;
        b=gCl9f083FnSQaopgO2czRqkTWTZWW8ujBX3OhDmO8oA3OdOoeNP+ovbeDhIPCS0bAo
         OIV80BFNFFp9+uVkocZbOFqUv+vm4qFKiMpCJsSskTQKURdmbSnu9dSAIDtCvJZyMtUm
         DmSAD13o5zEPE86goiUm5LNHhD5rhImrK8f6xOiNgM3ZWdtnVjNpYXgXSfiVoskkXSc6
         +MF8Kyxeb4aUsoAE5Y1qo2xEEr7Wx+ROrqd4gZL66+LwEYkTcdoapIK6uQsBD0q5SGm9
         QEzbHUIFoARXUpQRG/kHQ5f0VF90MHnwEbKCuGH2LabToX74Co9C0pLNMX3/AELhs3IK
         NWyA==
X-Gm-Message-State: ABy/qLbIgRD4uHEJ6o3OuztXAopFBwvw3rDEfl0q/x9iC0jkV6X4AOXC
        eDZZX/4iwkwa3Z0415fkl1F9mDLddLoNPIBr4QXdWT/8TH5mO6QF
X-Google-Smtp-Source: APBJJlEdO5COyGhE1YTvksy27njVOcMwd/97iTtuAOQfdC/FX5Zppd1JUyFaJ999ov9ZQHyvV/uZlBnt57A1s29vOAA=
X-Received: by 2002:a05:6102:9cf:b0:447:7cb1:3148 with SMTP id
 g15-20020a05610209cf00b004477cb13148mr2948071vsi.33.1690914291157; Tue, 01
 Aug 2023 11:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230801121824.174556-1-alistair.francis@wdc.com>
 <2023080152-disobey-widen-65a4@gregkh> <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
 <20230801170739.000048cb@Huawei.com>
In-Reply-To: <20230801170739.000048cb@Huawei.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 1 Aug 2023 14:24:24 -0400
Message-ID: <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 1, 2023 at 12:07=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 1 Aug 2023 09:48:13 -0400
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Tue, Aug 1, 2023 at 9:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
> > > > The PCIe 6 specification added support for the Data Object Exchange=
 (DOE).
> > > > When DOE is supported the Discovery Data Object Protocol must be
> > > > implemented. The protocol allows a requester to obtain information =
about
> > > > the other DOE protocols supported by the device.
> > > >
> > > > The kernel is already querying the DOE protocols supported and cach=
eing
> > > > the values. This patch exposes the values via sysfs. This will allo=
w
> > > > userspace to determine which DOE protocols are supported by the PCI=
e
> > > > device.
> > > >
> > > > By exposing the information to userspace tools like lspci can relay=
 the
> > > > information to users. By listing all of the supported protocols we =
can
> > > > allow userspace to parse and support the list, which might include
> > > > vendor specific protocols as well as yet to be supported protocols.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
> > > >  drivers/pci/doe.c                       | 52 +++++++++++++++++++++=
++++
> > > >  drivers/pci/pci-sysfs.c                 |  8 ++++
> > > >  include/linux/pci-doe.h                 |  2 +
> > > >  4 files changed, 73 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentatio=
n/ABI/testing/sysfs-bus-pci
> > > > index ecf47559f495..ae969bbfa631 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > > @@ -500,3 +500,14 @@ Description:
> > > >               console drivers from the device.  Raw users of pci-sy=
sfs
> > > >               resourceN attributes must be terminated prior to resi=
zing.
> > > >               Success of the resizing operation is not guaranteed.
> > > > +
> > > > +What:                /sys/bus/pci/devices/.../doe_proto
> > > > +Date:                July 2023
> > > > +Contact:     Linux PCI developers <linux-pci@vger.kernel.org>
> > > > +Description:
> > > > +             This file contains a list of the supported Data Objec=
t Exchange (DOE)
> > > > +             protocols. The protocols are seperated by newlines.
> > > > +             The value comes from the device and specifies the ven=
dor and
> > > > +             protocol supported. The lower byte is the protocol an=
d the next
> > > > +             two bytes are the vendor ID.
> > > > +             The file is read only.
> > >
> > > Sorry, but sysfs files are "one value per file", you can't have a "li=
st
> > > of protocols with new lines" in a one value-per-file rule.
> > >
> > >
> > > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > > index 1b97a5ab71a9..70900b79b239 100644
> > > > --- a/drivers/pci/doe.c
> > > > +++ b/drivers/pci/doe.c
> > > > @@ -563,6 +563,58 @@ static bool pci_doe_supports_prot(struct pci_d=
oe_mb *doe_mb, u16 vid, u8 type)
> > > >       return false;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_SYSFS
> > > > +/**
> > > > + * pci_doe_sysfs_proto_supports() - Write the supported DOE protoc=
ols
> > > > + *                        to a sysfs buffer
> > > > + * @doe_mb: DOE mailbox capability to query
> > > > + * @buf: buffer to store the sysfs strings
> > > > + * @offset: offset in buffer to store the sysfs strings
> > > > + *
> > > > + * RETURNS: The number of bytes written, 0 means an error occured
> > > > + */
> > > > +static unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_m=
b *doe_mb,
> > > > +                                               char *buf, ssize_t =
offset)
> > > > +{
> > > > +     unsigned long index;
> > > > +     ssize_t ret =3D offset;
> > > > +     ssize_t r;
> > > > +     void *entry;
> > > > +
> > > > +     xa_for_each(&doe_mb->prots, index, entry) {
> > > > +             r =3D sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_valu=
e(entry));
> > > > +
> > >
> > > No need for a blank line.
> > >
> > > > +             if (r =3D=3D 0)
> > > > +                     return ret;
> > >
> > >
> > >
> > > > +
> > > > +             ret +=3D r;
> > > > +     }
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +ssize_t doe_proto_show(struct device *dev, struct device_attribute=
 *attr,
> > > > +                    char *buf)
> > > > +{
> > > > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > > > +     unsigned long index;
> > > > +     ssize_t ret =3D 0;
> > > > +     ssize_t r;
> > > > +     struct pci_doe_mb *doe_mb;
> > > > +
> > > > +     xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> > > > +             r =3D pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> > > > +
> > > > +             if (r =3D=3D 0)
> > > > +                     return ret;
> > > > +
> > > > +             ret +=3D r;
> > > > +     }
> > >
> > > So this is going to be a lot of data, what is ensuring that you didn'=
t
> > > truncate it?  Which again, is the reason why this is not a good idea =
for
> > > sysfs, sorry.
> >
> > Hmm... That's a pain.
> >
> > I was hoping to avoid the kernel needing to know the protocols. This
> > list can include vendor specific protocols, as well as future
> > protocols that the running kernel doesn't yet support, so I wanted to
> > directly pass it to userspace without having to parse it in the
> > kernel.
> >
> > Does anyone have any thoughts on a better way to expose the information=
?
>
> File per protocol or better yet a directory per protocol vid and prot as =
files?

A directory per vid and files for each protocol sounds good to me.
I'll update the patch to do that. If anyone doesn't like that idea let
me know

> Files are cheap(ish) :) + expectation is probably a few protocols at
> most per DOE and a few DOEs per device.

I agree that's my expectation as well.

>
> Bit similar to listing out end points for USB devices.
>
> >
> > >
> > > What userspace tool wants this information?
> >
> > pciutils (lspci) is the first user [1], but I suspect more userspace
> > tools will want to query the DOE protocols as SPDM catches on more.
> > Eventually I would like to expose the DOE mailboxes to userspace (but
> > that's a separate issue).
>
> You may find it tricky to get anyone to move on that as I think we
> had a fairly strong consensus behind a per protocol interface only.
> One of the early DOE patch sets had a generic interface but we ripped
> it out based on discussions at the time.

Fair enough, thanks for letting me know

>
> One avenue discussed (after SPDM lands in kernel) was to provide some
> hooks for some parts of the exchange to be pushed to userspace, but
> it was never totally clear to me which bits make sense.  If this

I think we will need to at least expose a few parts of SPDM to
userspace. It could either be the kernel passing data back (like the
measurements for example) or userspace orchestrating the
communication. That's a future problem at the moment though

Alistair

> happens it will probably be the AMD SEV-SNP or similar usecase that
> drives it with a tightly defined interface for this purpose (not
> a generic DOE one).
>
> >
> > 1: https://github.com/pciutils/pciutils/pull/152
> >
> > >
> > > thanks,
> > >
> > > greg k-h
>
