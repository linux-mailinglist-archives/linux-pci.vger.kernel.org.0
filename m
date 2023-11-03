Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78B7DFDBE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377758AbjKCB1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 21:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377759AbjKCB1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 21:27:36 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F661A5;
        Thu,  2 Nov 2023 18:27:30 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49618e09f16so661260e0c.2;
        Thu, 02 Nov 2023 18:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698974849; x=1699579649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vANmfjhWuefo3Bjt/ORHTu0IFPxRZHx59I967LHWjE8=;
        b=bF0W6U8y+YNyyIbpr8h6Q4lcJcbyR4nQ9twhtPDse2tfVS2cY7YHhAcTJ5h8qu8Q7o
         NH7WwVsHMB7dzim9RCBFf1t/m/QbVykX+wwhcGtMHLGRhCl4oeWh/VKLg8t7WxblKV0p
         CQLLy06jytdHSmFcrMkVc4eQZ9ieKqQs5OCMAN6HoUhwlNH2lftY8HWGOEPlfLoMFe8O
         jL1Ru2EeYHyV21UCxEfsdh/h6OyOb7nMegKOfO2C1t/PnRDNLcpDrtooES1uqyzQAKWl
         QILKNj2tz+CanrLiWxD7ePDnFmne2LtBAybandf3tIqfwP+Kkj+JIoy7PgvoXZLqqVyF
         tJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698974849; x=1699579649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vANmfjhWuefo3Bjt/ORHTu0IFPxRZHx59I967LHWjE8=;
        b=P3jb3qcRbpWms9aciDP+nVe2n/PjCtMvkeyfXBbRNu8piTxwhETrbBEkkyP/oWQbUG
         nC0SPYaLCRtBaIoaarvSB9oZpJSMetUqeNqOL3unrRLvCNH71Z4f+C1Mkzck0AO1bBKD
         fvcGLi2PTGm4KrSnw39wgAk0O1WVMa7ICm18XZp+1/QpZF5lSe9XWcyYkflG1+gl87ha
         xGDd9Hs+oA6LUO7AYOKsjl6zMR9RQZPpWbDh7UYxE+I+s8JS0Oy2VRxCcYoW1kxQ2WEU
         XTd2NbPViOUg4BmPlQZbG/NtHqCGiPByAX+vB+PEed1ZX/TRB8Ty+fiRpVmagib5YJZP
         u1xg==
X-Gm-Message-State: AOJu0Yy11NE4Hvhq0RLyTjA4iykCoJfsBtd3UBY4OFxjjXKFPhpP+S7u
        j22+E/u7sqVrDbd93UwjuMs3qWE0rQ+tKJfC7t1c53urfmFGKg==
X-Google-Smtp-Source: AGHT+IFtAeEM4YTW0SixCLfBT5fi7k4RC7WGa+X0R8vOVJUuMIEdds2RZqVK7As5sjdnk9GO/usuR/tO+99wuSDmG/c=
X-Received: by 2002:a1f:ab0b:0:b0:4a4:680:bfad with SMTP id
 u11-20020a1fab0b000000b004a40680bfadmr18856423vke.7.1698974849633; Thu, 02
 Nov 2023 18:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231013034158.2745127-1-alistair.francis@wdc.com>
 <20231013034158.2745127-2-alistair.francis@wdc.com> <20231017083421.GA23168@wunner.de>
In-Reply-To: <20231017083421.GA23168@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 3 Nov 2023 11:27:02 +1000
Message-ID: <CAKmqyKM5AtH=b_Twt2FY6+dwxgjDwsk6K1mJ88x0i9T9EAbK5w@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
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

On Tue, Oct 17, 2023 at 6:34=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> > +#ifdef CONFIG_SYSFS
> > +static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
> > +                                          struct attribute *a, int n)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     void *entry;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->feats, j, entry)
> > +                     return a->mode;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Out of curiosity:  Does this method prevent creation of a
> "doe_features" directory for devices which don't have any
> DOE mailboxes?

It does once this patch (or something similar) is applied:

https://lkml.org/lkml/2022/8/24/607

GKH and I are working on getting a patch like that working and merged

Alistair

>
> (If it does, a code comment explaining that might be helpful.)
>
>
> > +const struct attribute_group pci_dev_doe_feature_group =3D {
> > +     .name   =3D "doe_features",
> > +     .attrs  =3D pci_dev_doe_feature_attrs,
> > +     .is_visible =3D pci_doe_sysfs_attr_is_visible,
> > +};
>
> Nit:  Wondering why the "=3D" is aligned for .name and .attrs
> but not for .is_visible?
>
>
> > +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> > +                                      struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs =3D doe_mb->sysfs_attrs;
> > +     unsigned long i;
> > +     void *entry;
>
> Nit:  Inverse Christmas tree?
>
>
> > +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> > +                                       struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs;
> > +     unsigned long num_features =3D 0;
> > +     unsigned long vid, type;
> > +     unsigned long i;
> > +     void *entry;
> > +     int ret;
> > +
> > +     xa_for_each(&doe_mb->feats, i, entry)
> > +             num_features++;
> > +
> > +     attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENOMEM;
> > +
> > +     doe_mb->sysfs_attrs =3D attrs;
> > +     xa_for_each(&doe_mb->feats, i, entry) {
> > +             sysfs_attr_init(&attrs[i].attr);
> > +             vid =3D xa_to_value(entry) >> 8;
> > +             type =3D xa_to_value(entry) & 0xFF;
> > +             attrs[i].attr.name =3D kasprintf(GFP_KERNEL,
> > +                                            "0x%04lX:%02lX", vid, type=
);
>
> Nit:  Capital X conversion specifier will result in upper case hex
> characters in filename and contents, whereas existing sysfs attributes
> such as "vendor", "device" contain lower case hex characters.
>
> Might want to consider lower case x for consistency.
>
>
> > +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> > +{
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             pci_doe_sysfs_feature_remove(pdev, doe_mb);
> > +     }
>
> Nit:  Curly braces not necessary.
>
>
> > @@ -1153,6 +1154,10 @@ static void pci_remove_resource_files(struct pci=
_dev *pdev)
> >  {
> >       int i;
> >
> > +     if (IS_ENABLED(CONFIG_PCI_DOE)) {
> > +             pci_doe_sysfs_teardown(pdev);
> > +     }
>
> Nit:  Curly braces not necessary.
>
>
> > @@ -1230,6 +1235,12 @@ static int pci_create_resource_files(struct pci_=
dev *pdev)
> >       int i;
> >       int retval;
> >
> > +     if (IS_ENABLED(CONFIG_PCI_DOE)) {
> > +             retval =3D pci_doe_sysfs_init(pdev);
> > +             if (retval)
> > +                     return retval;
> > +     }
> > +
> >       /* Expose the PCI resources from this device as files */
> >       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>
> I think this needs to be added to pci_create_sysfs_dev_files() instead.
>
> pci_create_resource_files() only deals with creation of resource files,
> as the name implies, which is unrelated to DOE features.
>
> Worse, pci_create_resource_files() is also called from
> pci_dev_resource_resize_attr(), i.e. every time user space
> writes to the "resource##n##_resize" attributes.
>
> Similarly, the call to pci_doe_sysfs_teardown() belongs in
> pci_remove_sysfs_dev_files().
>
> Thanks,
>
> Lukas
