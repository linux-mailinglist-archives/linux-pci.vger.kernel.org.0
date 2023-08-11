Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B677972E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHKSlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKSlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 14:41:13 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412330E6;
        Fri, 11 Aug 2023 11:41:12 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79ab8d0f2bdso640571241.1;
        Fri, 11 Aug 2023 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691779272; x=1692384072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Txw5qdn3A1rXqLZtAYIOF7l2tOVq3UV4dMWGF0Bb2hM=;
        b=H7VbxDZJT6pjW4hIp69ZoJdwa2zpDrfmUMNQhYwHoCAqynGTAuiX/qZFIwFUmz8Bch
         0kUI73aj2zLf468srsA63yNXRDfm6PU/RzmeGK5SPD7O6H7Rn4G1Gvs6/1sD2FtAt52Y
         kYpLQhPFyoik9Ben3GBlB2X9K1mfWRgHJ2+UGbByx1kZBvyaEi+9TE4Ka+4do3sWlAiW
         /FanVfbfbUQZyU1taePtBPksCeOQO1R7iGTCE8Zb4hZSjh9psHr40ejzKS5/WaltZiki
         cr3ZxCicsr1+Ps0ZufSXaKIKCCz+umnKoyMrz+nvCeZVHo2vEV5kX4wkq1Uv+XleaiZR
         gv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779272; x=1692384072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Txw5qdn3A1rXqLZtAYIOF7l2tOVq3UV4dMWGF0Bb2hM=;
        b=XqZbWSk19Px5ZnzxnaBqIotPUc8qbyoRWShga+1zCZcOUNq44QaAyyJk6EzLJX6SvF
         QDDztnJS0t74b7q6OdvNduy5GgtQtYjWZA7xJi4DAdjx/qBamvdI/IgfaV0blBHa+lCq
         jpqIv7YqKdp+kgXZyhtc3UpuHYLtZl9doEIUUfZvviNyMqL6J9T5uIBFhJX2GjGdc26a
         qmELsFnJMg46FQYI52HaFT8QIFgKOm5kSqqlvrtVC7uu4aNkY2dkNzqpWkeStk73075g
         frEPg7y/XEeNz6yPrV+cHg+C8KEzy06xnX+cysh/H+51sWMweqgQmELYirN8QFFYLQf+
         11ZQ==
X-Gm-Message-State: AOJu0YwTQ8ZDWw+wY1Sgpg1saxrHKg0pK8QI6bp+Vr+Vgv9pos+K1TdI
        2OYailSNh0BVuSD+VFdGHqgcKc2x6wFxrHgg4jM=
X-Google-Smtp-Source: AGHT+IEeAcUgCIOkFGtim/PuJ1518Pk3s73kDWwIRWdjcUTI+rvOvgTVDnHlhwENRgdE6XPyOSFRYqyhF+FvSV51a68=
X-Received: by 2002:a67:f348:0:b0:443:a4d2:86b9 with SMTP id
 p8-20020a67f348000000b00443a4d286b9mr2674614vsm.0.1691779271633; Fri, 11 Aug
 2023 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230810163342.1059509-1-alistair.francis@wdc.com> <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
In-Reply-To: <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 11 Aug 2023 14:40:45 -0400
Message-ID: <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 9:04=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 8/11/23 01:33, Alistair Francis wrote:
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
> > Each DOE feature is exposed as a single file. The files are empty and
> > the information is contained in the file name.
>
> s/feature/protocol ?

Fixed

>
> Personally, I would still have each file content repeat the same informat=
ion as
> the file name specifies. That is, file value =3D=3D file name. That will =
avoid
> people getting confused as empty sysfs files are rather uncommon.

I don't see an obvious way to implement that with the .show()
function. I don't see a clear way to know what file the user accessed.

Plus I don't see a need to. The files exist and provide the
information, do we really need to duplicate it?

>
> >
> > This uses pci_sysfs_init() instead of the ->is_visible() function as
> > is_visible only applies to the attributes under the group. Which
> > means that every PCIe device will see a `doe_protos` directory, no
> > matter if DOE is supported at all on the device.
> >
> > On top of that ->is_visible() is only called
> > (fs/sysfs/group.c:create_files()) if there are sub attrs, which we
> > don't necessary have. There are no static attrs, instead they are
> > all generated dynamically.
>
> You said that the kernel caches the protocols supported. So it should not=
 be
> hard to allocate one attribute for each of the supported protocols when t=
hese
> are discovered, no ?

I couldn't figure out a way to get this to work. You end up with a
race between the sysfs group being created and the attributes being
created. The DOE features are probed before the sysfs init creates the
group.

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v4:
> >  - Fixup typos in the documentation
> >  - Make it clear that the file names contain the information
> >  - Small code cleanups
> >  - Remove most #ifdefs
> >  - Remove extra NULL assignment
> > v3:
> >  - Expose each DOE feature as a separate file
> > v2:
> >  - Add documentation
> >  - Code cleanups
> >
> > We did talk about exposing DOE types under DOE vendor IDs, but I couldn=
't
> > figure out a simple way to do that
> >
> >  Documentation/ABI/testing/sysfs-bus-pci |  10 +++
> >  drivers/pci/doe.c                       | 104 ++++++++++++++++++++++++
> >  drivers/pci/pci-sysfs.c                 |   7 ++
> >  include/linux/pci-doe.h                 |   1 +
> >  4 files changed, 122 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index ecf47559f495..e09c51449284 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -500,3 +500,13 @@ Description:
> >               console drivers from the device.  Raw users of pci-sysfs
> >               resourceN attributes must be terminated prior to resizing=
.
> >               Success of the resizing operation is not guaranteed.
> > +
> > +What:                /sys/bus/pci/devices/.../doe_protos
> > +Date:                August 2023
> > +Contact:     Linux PCI developers <linux-pci@vger.kernel.org>
> > +Description:
> > +             This directory contains a list of the supported Data Obje=
ct Exchange (DOE)
> > +             features. The feature values are in the file name; the fi=
les have no contents.
> > +             The value comes from the device and specifies the vendor =
and
> > +             data object type supported. The lower byte is the data ob=
ject type and the next
> > +             two bytes are the vendor ID.
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 1b97a5ab71a9..918872152fb6 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -56,6 +56,8 @@ struct pci_doe_mb {
> >       wait_queue_head_t wq;
> >       struct workqueue_struct *work_queue;
> >       unsigned long flags;
> > +
> > +     struct device_attribute *sysfs_attrs;
> >  };
> >
> >  struct pci_doe_protocol {
> > @@ -92,6 +94,108 @@ struct pci_doe_task {
> >       struct pci_doe_mb *doe_mb;
> >  };
> >
> > +#ifdef CONFIG_SYSFS
> > +static struct attribute *pci_dev_doe_proto_attrs[] =3D {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group pci_dev_doe_proto_group =3D {
> > +     .name   =3D "doe_protos",
>
> Why is this a static variable instead of being a member of the pci doe_mb=
 struct
> ?d Devices without DOE support would always have that as NULL and only th=
e

I don't follow. Do you mean define the name as part of the struct
pci_doe_mb *doe_mb?

> devices that support it would get the group and array of attributes that =
you
> allocate in pci_doe_sysfs_proto_supports(). That would also remove the ne=
ed for
> the attrs array being a static variable as well.
>
> An let's spell things out to be clear and avoid confusions: s/protos/prot=
ocols

I can change the name

>
> > +     .attrs  =3D pci_dev_doe_proto_attrs,
> > +};
> > +
> > +static void pci_doe_sysfs_remove_desc(struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device_attribute *attrs =3D doe_mb->sysfs_attrs;
> > +     unsigned long i;
> > +     void *entry;
> > +
> > +     if (!doe_mb->sysfs_attrs)
> > +             return;
> > +
> > +     doe_mb->sysfs_attrs =3D NULL;
> > +     xa_for_each(&doe_mb->prots, i, entry)
> > +             kfree(attrs[i].attr.name);
> > +
> > +     kfree(attrs);
> > +}
> > +
> > +static int pci_doe_sysfs_proto_supports(struct pci_dev *pdev, struct p=
ci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs;
> > +     unsigned long num_protos =3D 0;
> > +     unsigned long vid, type;
> > +     unsigned long i;
> > +     void *entry;
> > +     int ret;
> > +
> > +     xa_for_each(&doe_mb->prots, i, entry)
> > +             num_protos++;
> > +
> > +     attrs =3D kcalloc(num_protos, sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENOMEM;
> > +
> > +     doe_mb->sysfs_attrs =3D attrs;
> > +     xa_for_each(&doe_mb->prots, i, entry) {
> > +             sysfs_attr_init(&attrs[i].attr);
> > +             vid =3D xa_to_value(entry) >> 8;
> > +             type =3D xa_to_value(entry) & 0xFF;
> > +             attrs[i].attr.name =3D kasprintf(GFP_KERNEL, "0x%04lX:%02=
lX", vid, type);
> > +             if (!attrs[i].attr.name) {
> > +                     ret =3D -ENOMEM;
> > +                     goto fail;
> > +             }
> > +
> > +             attrs[i].attr.mode =3D 0444;
> > +
> > +             ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].att=
r,
> > +                                           pci_dev_doe_proto_group.nam=
e);
> > +             if (ret)
> > +                     goto fail;
> > +     }
> > +
> > +     return 0;
> > +
> > +fail:
> > +     pci_doe_sysfs_remove_desc(doe_mb);
> > +     return ret;
> > +}
> > +
> > +int doe_sysfs_init(struct pci_dev *pdev)
> > +{
> > +     unsigned long total_protos =3D 0;
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     void *entry;
> > +     int ret;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->prots, j, entry)
> > +                     total_protos++;
> > +     }
> > +
> > +     if (total_protos =3D=3D 0)
> > +             return 0;
> > +
> > +     ret =3D devm_device_add_group(&pdev->dev, &pci_dev_doe_proto_grou=
p);
> > +     if (ret) {
> > +             pci_err(pdev, "can't create DOE goup: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             ret =3D pci_doe_sysfs_proto_supports(pdev, doe_mb);
> > +
>
> Remove this blank line.
>
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> >  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeo=
ut)
> >  {
> >       if (wait_event_timeout(doe_mb->wq,
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index ab32a91f287b..ad621850a3e2 100644
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
> > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_=
dev *pdev)
> >       int i;
> >       int retval;
> >
> > +     if (IS_ENABLED(CONFIG_PCI_DOE)) {
> > +             retval =3D doe_sysfs_init(pdev);
> > +             if (retval)
> > +                     return retval;
> > +     }
> > +
> >       /* Expose the PCI resources from this device as files */
> >       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> >
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index 1f14aed4354b..4cc13d9ccb50 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -22,4 +22,5 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8=
 type,
> >           const void *request, size_t request_sz,
> >           void *response, size_t response_sz);
> >
> > +int doe_sysfs_init(struct pci_dev *pci_dev);
> >  #endif
>
> --
> Damien Le Moal
> Western Digital Research
>
