Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D87777C3F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHJPek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjHJPej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 11:34:39 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5C26B6;
        Thu, 10 Aug 2023 08:34:38 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79a83720538so361119241.1;
        Thu, 10 Aug 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681678; x=1692286478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tihTno5XeSiFetFIyi6mKGVAA9ZCtZ/0LDpcRqn3+k4=;
        b=sobhWLN51zeRcoI/8qIlVl1KZUP5Z42X9LOdSgOQ3GymRk6q0amWlitl5EoqP8vldE
         ry9tOb4v3YJrzSpSaCxoyXi7Gy50QtErrxiu+d7WpVov5cXn9wRbxtsjAaICTg/+VCjt
         hqvkYK7ONXI9C18FKWHR1Fl+Lxj4i3OsjXoz0akq8iQuwKzjWjRLfSLUZm6QXjwtKGML
         QjYud0mJtjdvvQZVGRrBRtbPvnLZoIP4h3KhzP6CjNV2NLfdR2LIBC348zwEfV759pOw
         F0V9YCheG5O/3ikqdvWBT/RjvhtcdwGC2Ar7+8IaK2If+7KGz2a7OC4IkFI88yNH50Lx
         ImLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681678; x=1692286478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tihTno5XeSiFetFIyi6mKGVAA9ZCtZ/0LDpcRqn3+k4=;
        b=OwDRZReFP7StgcE9lh8EINlclCevJ5u09Qrf35+TxLEBHkrZnTETvLmJTKZnRFTtrf
         dA/D5e7hpaBwfWdI+urrzQNSKk6BAW/TVlM6VRW7VSzqrkvNWyoLyee3IjhTlphoIW2G
         0r5WHAksOBNTgibzXHh8Hz/05iTC+zERaoyKMFbZ2Wsn4ZN8kIkvYoBKVAGZcaUc+hAs
         wfKjpr197rRlg+9uDAjKeMGNY9jbgK1o8RJ84Iz6Vs6O6GS8a/KhjZbm5Fs22CVrnCQV
         QFzlOZhnZm2rvD9Wpl51g5Hb/iDqRSgz5PP1sp2bpvAReaClZiii+HwYVNLJtSj6wxjI
         AwJw==
X-Gm-Message-State: AOJu0YxIaYr47t6/+i4edQz5t7FMZCjtdmb46qvbgUMQZnBZexebqDaG
        37MPWXMG0AZDIR3r9xfyUUZoBmMaSHAplgwYBCE=
X-Google-Smtp-Source: AGHT+IE5aL+l4nJ2KMF3oazoFkwT4cVlHQujRWvkJFtRki+tPCLi9du2iAsM7S06+sv46G20UhLJiYhSVPoLjDLZsF4=
X-Received: by 2002:a67:f8d8:0:b0:443:6e7b:ab8 with SMTP id
 c24-20020a67f8d8000000b004436e7b0ab8mr2158168vsp.5.1691681677830; Thu, 10 Aug
 2023 08:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230809232851.1004023-1-alistair.francis@wdc.com> <20230810073457.GA26246@wunner.de>
In-Reply-To: <20230810073457.GA26246@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 10 Aug 2023 11:34:11 -0400
Message-ID: <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
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

On Thu, Aug 10, 2023 at 3:34=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_=
dev *pdev)
> >       int i;
> >       int retval;
> >
> > +#ifdef CONFIG_PCI_DOE
> > +     retval =3D doe_sysfs_init(pdev);
> > +     if (retval)
> > +             return retval;
> > +#endif
> > +
>
> The preferred way to expose PCI sysfs attributes nowadays is to add them
> to pci_dev_attr_groups[] and use the ->is_visible callback to check
> whether they're applicable to a particular pci_dev.  The alternative
> via pci_create_resource_files() has race conditions which I think
> still haven't been fixed. Bjorn recommended the ->is_visible approach
> in response to the most recent attempt to fix the race:
>
> https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/

The is_visible doen't seem to work in this case.

AFAIK is_visible only applies to the attributes under the group. Which
means that every PCIe device will see a `doe_protos` directory, no
matter if DOE is supported.

On top of that is_visible() is only called
(fs/sysfs/group.c:create_files()) if there are sub attrs, which we
don't have. We will possibly end up with some attributes, but all of
them are dynamic. So we still end up needing to call doe_sysfs_init()
anyway.

Alistair

>
> To avoid (most of) the #ifdefs, you may want to consider adding a
> doe-sysfs.c file like I've done for cma in this commit:
>
> https://github.com/l1k/linux/commit/b057e2fb0ee0
>
> Thanks,
>
> Lukas
