Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930AC76B634
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjHANso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 09:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjHANsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 09:48:41 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BA1FC9;
        Tue,  1 Aug 2023 06:48:40 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-486556dea4dso2327650e0c.1;
        Tue, 01 Aug 2023 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690897719; x=1691502519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8myyv9UtQpaVEl1JHFNQCZbgpelNRhntKZL1KtZAYE0=;
        b=fbizwoBnK0zi2k8mw38HFdIbjEt0SViqTMpdYPhRuQIoh/1Iq6Wb1bukGuQkJCrqyL
         lPntnQJdjhyaABquOs/XeOsIN1HeL69Ta/htXwUDRVX2NlNUSaSwx/LjgLiRO1vbuWbb
         hy6AagszQvfdcWGoGHMC9RhOspPjNYJ2jPRfdtyg+qZangBQbkgGhFMiEXIIWbU+bWOw
         lJ3VJJuzlWcf3aePo+qJ0Tqbg9KhWnJhufdKmW9MuWssl86OoI0QBUiG+1oDI0RdhzvX
         Q2BdCglsLuuQV4zTR1GIbaWv7LNp+giVKYeXlEcQfPz/TTP5FQ8mGVoRkLDCDxJckHCa
         mw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690897719; x=1691502519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8myyv9UtQpaVEl1JHFNQCZbgpelNRhntKZL1KtZAYE0=;
        b=JBseIBRxqlEWik6OMnLwo7lt3wRL2/ifSgYUdmYT4Y/CJsvWjVdgsujpYZOQ9juwC4
         F0544BWot9LeNMmpAfaz66cHvCToEh88UONVWirqI4go67EiIJxSTcBFCteRJt6HlMPv
         cPXlpOc8Rbk6xDRtUWoR6QV2VSY/LawM2y2frrDfNNIxh4g5iBMT9Xb1R7lLuJuqLHYj
         cFWQq/0XkxAkLJe7kxtwPuSiOvYi6xN44EX2GElP+b/b+RyaoaBHUIbh4IjGDYXdcTe0
         GWiLhA8ArDSlqf2ilvncYGoXZkEuCKcnyq6/v1umf0vTivStgDh3wJvpEFSd6xIJsV/g
         Jiag==
X-Gm-Message-State: ABy/qLar6TMf0F20THF6QlMXB30UjYt6XMUSZCIPuE4aPSfvtPzCenWm
        Pl006vJEhuDw2dGg+QpvnEXFcUQoKepGVExvXJU=
X-Google-Smtp-Source: APBJJlFah66TQQxX06YQDLzPSKMwRTGdfNAgAL+0resdS58kA0oRIwOiMTzBtE3nlgtf9lO5i+fiN9CZQxjbacglirY=
X-Received: by 2002:a1f:bf4d:0:b0:486:4188:48c9 with SMTP id
 p74-20020a1fbf4d000000b00486418848c9mr2513134vkf.3.1690897719185; Tue, 01 Aug
 2023 06:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230801121824.174556-1-alistair.francis@wdc.com> <2023080152-disobey-widen-65a4@gregkh>
In-Reply-To: <2023080152-disobey-widen-65a4@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 1 Aug 2023 09:48:13 -0400
Message-ID: <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
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

On Tue, Aug 1, 2023 at 9:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object Exchange (DO=
E).
> > When DOE is supported the Discovery Data Object Protocol must be
> > implemented. The protocol allows a requester to obtain information abou=
t
> > the other DOE protocols supported by the device.
> >
> > The kernel is already querying the DOE protocols supported and cacheing
> > the values. This patch exposes the values via sysfs. This will allow
> > userspace to determine which DOE protocols are supported by the PCIe
> > device.
> >
> > By exposing the information to userspace tools like lspci can relay the
> > information to users. By listing all of the supported protocols we can
> > allow userspace to parse and support the list, which might include
> > vendor specific protocols as well as yet to be supported protocols.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
> >  drivers/pci/doe.c                       | 52 +++++++++++++++++++++++++
> >  drivers/pci/pci-sysfs.c                 |  8 ++++
> >  include/linux/pci-doe.h                 |  2 +
> >  4 files changed, 73 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index ecf47559f495..ae969bbfa631 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -500,3 +500,14 @@ Description:
> >               console drivers from the device.  Raw users of pci-sysfs
> >               resourceN attributes must be terminated prior to resizing=
.
> >               Success of the resizing operation is not guaranteed.
> > +
> > +What:                /sys/bus/pci/devices/.../doe_proto
> > +Date:                July 2023
> > +Contact:     Linux PCI developers <linux-pci@vger.kernel.org>
> > +Description:
> > +             This file contains a list of the supported Data Object Ex=
change (DOE)
> > +             protocols. The protocols are seperated by newlines.
> > +             The value comes from the device and specifies the vendor =
and
> > +             protocol supported. The lower byte is the protocol and th=
e next
> > +             two bytes are the vendor ID.
> > +             The file is read only.
>
> Sorry, but sysfs files are "one value per file", you can't have a "list
> of protocols with new lines" in a one value-per-file rule.
>
>
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 1b97a5ab71a9..70900b79b239 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -563,6 +563,58 @@ static bool pci_doe_supports_prot(struct pci_doe_m=
b *doe_mb, u16 vid, u8 type)
> >       return false;
> >  }
> >
> > +#ifdef CONFIG_SYSFS
> > +/**
> > + * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
> > + *                        to a sysfs buffer
> > + * @doe_mb: DOE mailbox capability to query
> > + * @buf: buffer to store the sysfs strings
> > + * @offset: offset in buffer to store the sysfs strings
> > + *
> > + * RETURNS: The number of bytes written, 0 means an error occured
> > + */
> > +static unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *d=
oe_mb,
> > +                                               char *buf, ssize_t offs=
et)
> > +{
> > +     unsigned long index;
> > +     ssize_t ret =3D offset;
> > +     ssize_t r;
> > +     void *entry;
> > +
> > +     xa_for_each(&doe_mb->prots, index, entry) {
> > +             r =3D sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(en=
try));
> > +
>
> No need for a blank line.
>
> > +             if (r =3D=3D 0)
> > +                     return ret;
>
>
>
> > +
> > +             ret +=3D r;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +ssize_t doe_proto_show(struct device *dev, struct device_attribute *at=
tr,
> > +                    char *buf)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     unsigned long index;
> > +     ssize_t ret =3D 0;
> > +     ssize_t r;
> > +     struct pci_doe_mb *doe_mb;
> > +
> > +     xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> > +             r =3D pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> > +
> > +             if (r =3D=3D 0)
> > +                     return ret;
> > +
> > +             ret +=3D r;
> > +     }
>
> So this is going to be a lot of data, what is ensuring that you didn't
> truncate it?  Which again, is the reason why this is not a good idea for
> sysfs, sorry.

Hmm... That's a pain.

I was hoping to avoid the kernel needing to know the protocols. This
list can include vendor specific protocols, as well as future
protocols that the running kernel doesn't yet support, so I wanted to
directly pass it to userspace without having to parse it in the
kernel.

Does anyone have any thoughts on a better way to expose the information?

>
> What userspace tool wants this information?

pciutils (lspci) is the first user [1], but I suspect more userspace
tools will want to query the DOE protocols as SPDM catches on more.
Eventually I would like to expose the DOE mailboxes to userspace (but
that's a separate issue).

1: https://github.com/pciutils/pciutils/pull/152

>
> thanks,
>
> greg k-h
