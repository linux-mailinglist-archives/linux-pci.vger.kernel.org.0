Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577AB769ABD
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGaPZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGaPZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 11:25:20 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8B170E;
        Mon, 31 Jul 2023 08:25:18 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4866429924eso1306620e0c.2;
        Mon, 31 Jul 2023 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690817117; x=1691421917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHGiH0Y/XU9lOWGZKB3T39hEuq3FAiU2ZA2eIS3MSx8=;
        b=b9bV3yKC5azKbDWNCvGXL4wpE9JoAn8qjJmNnXR01vT/bNCI1uY1SDtigjwFcvC2Lp
         Vg5oVssmBSgrOHv9AGn6nCPdxMLSzWjQujB1yNqohaCtmcFmu7wt9jRxIWIPCfK/IUS6
         sKLfdsiK9jKf4BlRrdQDam7UTq4C/6hh+Ef6dgG1dVfLSk63iJNSOJLS+v996xpK5xlm
         GBzappGfsbj9tfO8SRoHpTAJVRbEjjjP8GwQqpVNZIPzUM10qvrVhvjmiVPtczahYGlj
         JlDn4OGBgLRHbQTcZKAraWus6xsSOvVEWGt5Dpywrm/IV++ruJpfznoVyPElvWOJbpUp
         H69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690817117; x=1691421917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHGiH0Y/XU9lOWGZKB3T39hEuq3FAiU2ZA2eIS3MSx8=;
        b=Y4dQd53Rd3ZNP+cFGRAc3DhYcP/hgRMv/SVvvmMtxVPHRSJbUjrh0nHY6WlqKv95AP
         RX3sXGVeaPSoYnGNxZt5FTQe+V+RmPVAYvKlADAwRPzw1hcApfO/eZ8gT/nUGEK/Vl0J
         D7sTp7MlM6MS+uJz5XJh2nHJGgl0YuxMEbHYeWiLnRM4omaTtx6ZHjM5D3fAsEQC70gN
         StsbiVrhzWSPn/4ruY9R1NCcZJuDTstJrLo2BKHo5A1NTTPq4o6An5wiPidMBdbf5uNy
         LSUhLP7+R6eMZaaeXkBxNxC3ylakLlCoZEGnuicfZIzwG+iS/DQHcov/9SF6eWcbDyGl
         Qbng==
X-Gm-Message-State: ABy/qLaHlGOIWHj+TMIK85mn1lEsxWSNJVibfrFvcWWWpi4qGc7LbsLh
        YqHOLtSNDpAkyZow6biXmNr4XLAVj2t/acZ87CE=
X-Google-Smtp-Source: APBJJlEYoidmPfKXVSyPBODxKApbxYJcrZ86qcbAbLN5OUTM4k2/pg+lhaA+wIWzzdjxBdlyM8GUfx1x8cv7xIvKi84=
X-Received: by 2002:a67:ff09:0:b0:443:6397:250f with SMTP id
 v9-20020a67ff09000000b004436397250fmr248518vsp.27.1690817117446; Mon, 31 Jul
 2023 08:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230725035755.2621507-1-alistair.francis@wdc.com> <20230725160034.00005774@Huawei.com>
In-Reply-To: <20230725160034.00005774@Huawei.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 31 Jul 2023 11:24:51 -0400
Message-ID: <CAKmqyKMfgTGqkfJQV569_t_sRnsQFKUWs+A2i+sR3fswmn0vow@mail.gmail.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Tue, Jul 25, 2023 at 11:00=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 25 Jul 2023 13:57:55 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
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
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> Hi Alistair,
>
> Needs documentation.
> Documentation/ABI/testing/sys-bus-pci probably the right place.

Ok, I'll add some

>
> Also, I wonder if we want to associate each DOE with the protocols
> it supports rather than clumping them together in one file...

In the future there could be vendor IDs or even standardised IDs that
the current kernel doesn't support/understand. So my thinking was that
by exposing all of the supported protocols userspace can use that
information as it wishes.

Then I wanted to work on supporting specific DOE protocols in the
kernel and exposing that to userspace. But I think a single sysfs
makes sense as a base point to convey information.

> Otherwise we'll loose information on sharing + we may well see
> repeated entries as it's fine to have more than one instance of
> given protocol.
>
> A few more comments inline about what happens when we do run out
> of space in the buffer.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/pci/doe.c       | 28 ++++++++++++++++++++++++++++
> >  drivers/pci/pci-sysfs.c | 27 +++++++++++++++++++++++++++
> >  include/linux/pci-doe.h |  2 ++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 1b97a5ab71a9..cc1c23c78ac1 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -563,6 +563,34 @@ static bool pci_doe_supports_prot(struct pci_doe_m=
b *doe_mb, u16 vid, u8 type)
> >       return false;
> >  }
> >
> > +/**
> > + * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
> > + *                        to a sysfs buffer
> > + * @doe_mb: DOE mailbox capability to query
> > + * @buf: buffer to store the sysfs strings
> > + * @offset: offset in buffer to store the sysfs strings
> > + *
> > + * RETURNS: The number of bytes written, 0 means an error occured
> > + */
> > +unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> > +                                        char *buf, ssize_t offset)
> > +{
> > +     unsigned long index;
> > +     ssize_t ret =3D offset, r;
>
> I find that hard to parse.  Maybe
>
>         ssize_t ret =3D offset;
>         ssize_t r;
>
>
>
> > +     void *entry;
> > +
> > +     xa_for_each(&doe_mb->prots, index, entry) {
> > +             r =3D sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(en=
try));
> > +
> > +             if (r =3D=3D 0)
> > +                     return 0;
>
> return ret here? Otherwise we aren't outputting everything that we have
> managed to print before the buffer fills up.
> It's also inconsistent because if the last entry happens to partly print
> we'll let it through whereas, if it doesn't fit at all we will drop
> all the info about this DOE instance.

Good point, I'll update this and the variable declarations

Alistair

>
>
> > +
> > +             ret +=3D r;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * pci_doe_submit_task() - Submit a task to be processed by the state =
machine
> >   *
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index ab32a91f287b..df93051e65bf 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/sched.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <linux/stat.h>
> >  #include <linux/export.h>
> >  #include <linux/topology.h>
> > @@ -290,6 +291,29 @@ static ssize_t modalias_show(struct device *dev, s=
truct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(modalias);
> >
> > +#ifdef CONFIG_PCI_DOE
> > +static ssize_t doe_proto_show(struct device *dev, struct device_attrib=
ute *attr,
> > +                          char *buf)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     unsigned long index;
> > +     ssize_t ret =3D 0, r;
>
> As above.
>
> > +     struct pci_doe_mb *doe_mb;
> > +
> > +     xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> > +             r =3D pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> > +
> > +             if (r =3D=3D 0)
> > +                     return 0;
>
> As above, return ret here I think makes more sense than 0.
>
>
> > +
> > +             ret +=3D r;
> > +     }
> > +
> > +     return ret;
> > +}
> > +static DEVICE_ATTR_RO(doe_proto);
> > +#endif
> > +
> >  static ssize_t enable_store(struct device *dev, struct device_attribut=
e *attr,
> >                            const char *buf, size_t count)
> >  {
> > @@ -603,6 +627,9 @@ static struct attribute *pci_dev_attrs[] =3D {
> >       &dev_attr_local_cpus.attr,
> >       &dev_attr_local_cpulist.attr,
> >       &dev_attr_modalias.attr,
> > +#ifdef CONFIG_PCI_DOE
> > +     &dev_attr_doe_proto.attr,
> > +#endif
> >  #ifdef CONFIG_NUMA
> >       &dev_attr_numa_node.attr,
> >  #endif
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index 1f14aed4354b..066494a4dba3 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -21,5 +21,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_de=
v *pdev, u16 vendor,
> >  int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> >           const void *request, size_t request_sz,
> >           void *response, size_t response_sz);
> > +unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> > +                                        char *buf, ssize_t offset);
> >
> >  #endif
>
