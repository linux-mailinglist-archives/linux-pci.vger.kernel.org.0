Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5518477CD7A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjHONpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbjHONpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 09:45:01 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9781986;
        Tue, 15 Aug 2023 06:44:59 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4871e5dd7ebso1656349e0c.3;
        Tue, 15 Aug 2023 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692107099; x=1692711899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WblyutNp33S229/zIZJPyXVBU1XRv+8u1otRBaxdntI=;
        b=Oyjj7U5CclMg5Pz4u81j8aDDCdnEpGVhJrAXYcdyhsmoS3UXI0ZY2RmAqNLxGagS54
         Bn/fPY/gq4YoY7VS8TACO4EgSOB9ntGEb+RzKAJWexRtbdrO1Is8nuMjqDrQAoN0NVJY
         53UHd8GxEqh5MQ2aWy2EVbbVt7nZ8loMmsw2XruL794EbKwsNf/urpIhwJGugiNUU6OX
         k8jbsn7yF9ez77fmp6TiHHDT6ib2u0LMUT5+w4CO52Yg4hN1zxY/WItjWuDnjXg63Zvm
         R0ghDtUegSzJsPaqtbY0CeqB6BoGYm3KDnXaKmi+ROJR0YjaZLo/P1ESd0SMdb47AXxf
         WlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692107099; x=1692711899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WblyutNp33S229/zIZJPyXVBU1XRv+8u1otRBaxdntI=;
        b=CHJMoouxxExOpH4ZJOsoI16NL3XGovFn+PYM0OC29CNiqtnMeU4I7VLDmjKCUhFBb5
         Nkx1ZBcKvKQcg8ecUAk82hBiF9ezaak0v0JOp8k/KrIdjZzDNm4s811rGHxv/cfxqmpE
         Uzvnx/Xxr1jcW5EVa+DqRRF1SZ3nLVo3QupBM/za9J+dLPNyuXtQOTetiUX1/E/VJtgd
         +KkRqQ8Ar/VwBD5X+nwwZNvZPVBUs454NEigIe9AL6xWrbbP67mhdspZOKv9KwCjtmSb
         88Gce+MhX1+wNSiueHDKEfTe4nMznDE4q21uPejmW/K+XaPeTX2iXxRDVrWRVjEqZkHY
         +Fmg==
X-Gm-Message-State: AOJu0Ywo2u89tNGLw+m655ikBYizrHEElMvFkwIBPsl3AJe3fa22Xzjo
        KiJbl//fYQD+PRMbzZlXN3ckPbrbmyi+odgwM7Q1X3OKeJbgOHnz0iM=
X-Google-Smtp-Source: AGHT+IHn8Jmamqj0py2syUKvxiqwXjlm6ujhhP3NVdE9Y/5QrTeOKAbRNnGCs+99DF+wRpfPL0C5EF+u56pPfmc0TKg=
X-Received: by 2002:a67:fc0a:0:b0:447:60f4:cc51 with SMTP id
 o10-20020a67fc0a000000b0044760f4cc51mr10404664vsq.28.1692107098888; Tue, 15
 Aug 2023 06:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de> <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
 <20230812081526.GC9469@wunner.de> <2023081224-famished-devotion-6e0e@gregkh>
In-Reply-To: <2023081224-famished-devotion-6e0e@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 15 Aug 2023 09:44:32 -0400
Message-ID: <CAKmqyKPx9Oi-ZF0grdUzkHi5BjyyNQZ2r30vgShR6cOY9xZ9YQ@mail.gmail.com>
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

On Sat, Aug 12, 2023 at 4:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Aug 12, 2023 at 10:15:26AM +0200, Lukas Wunner wrote:
> > On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrote:
> > > On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.de> wrot=
e:
> > > > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struc=
t pci_dev *pdev)
> > > > >       int i;
> > > > >       int retval;
> > > > >
> > > > > +#ifdef CONFIG_PCI_DOE
> > > > > +     retval =3D doe_sysfs_init(pdev);
> > > > > +     if (retval)
> > > > > +             return retval;
> > > > > +#endif
> > > > > +
> > > >
> > > > The preferred way to expose PCI sysfs attributes nowadays is to add=
 them
> > > > to pci_dev_attr_groups[] and use the ->is_visible callback to check
> > > > whether they're applicable to a particular pci_dev.  The alternativ=
e
> > > > via pci_create_resource_files() has race conditions which I think
> > > > still haven't been fixed. Bjorn recommended the ->is_visible approa=
ch
> > > > in response to the most recent attempt to fix the race:
> > > >
> > > > https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/
> > >
> > > The is_visible doen't seem to work in this case.
> > >
> > > AFAIK is_visible only applies to the attributes under the group. Whic=
h
> > > means that every PCIe device will see a `doe_protos` directory, no
> > > matter if DOE is supported.
> >
> > internal_create_group() in fs/sysfs/group.c does this:
> >
> >       if (grp->name) {
> >                       ...
> >                       kn =3D kernfs_create_dir_ns(kobj->sd, grp->name, =
...
> >
> > So I'm under the impression that if you set the ->name member of
> > struct attribute_group, the attributes in that group appear under
> > a directory of that name.
> >
> > In fact, the kernel-doc for struct attribute_group claims as much:
> >
> >  * struct attribute_group - data structure used to declare an attribute=
 group.
> >  * @name:     Optional: Attribute group name
> >  *            If specified, the attribute group will be created in
> >  *            a new subdirectory with this name.
> >
> > So I don't quite understand why you think that "every PCIe device will
> > see a `doe_protos` directory, no matter if DOE is supported"?
> >
> > Am I missing something?
>
> I think the issue might be that the directory will be created even if no
> attributes are present in it due to the is_visable() check not returning
> any valid files?

Yes, that's what I'm seeing. I see the directory for all PCIe devices

This is a WIP that I had:
https://github.com/alistair23/linux/commit/61925cd174c31386eaa7e51e3a1be606=
b38f847c

>
> If so, I had a patch somewhere around here where I was trying to fix
> that up:
>         https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-cor=
e.git/commit/?h=3Ddebugfs_cleanup&id=3Df670945dfbaf353fe068544c31e3fa45575d=
a5b5
> but it didn't seem to work properly and kept crashing.  I didn't spend
> much time on looking into it, but if this is an issue, I can work on
> fixing this properly.

That patch sounds like it would fix the issue of empty directories
that I'm seeing. Do you mind fixing it up properly?

Then I just need to address the race condition and we can switch to
using .is_visible()

Alistair

>
> thanks,
>
> greg k-h
