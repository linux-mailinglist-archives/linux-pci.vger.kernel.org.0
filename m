Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FBE7C7BBD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJMC4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMC4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 22:56:17 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AAB7;
        Thu, 12 Oct 2023 19:56:13 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-457bac7c3f5so379514137.2;
        Thu, 12 Oct 2023 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697165772; x=1697770572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdy8fAHPbtDdnhV62u5A/DdaX86JrOuLKTeJAWRWD7c=;
        b=Q3MuVzU/Jwf68SVy6Bq+FXV4vktlrZdwFsfzwp5y0yg010sEd8vhTWDU41+bbmPOuO
         fwqrTn9q+BfDOg821BBye43Z4CKoNbhBsPHTlR4S6y12TZzCFenTwQsE71KMzRGXsl6f
         KXe7GyKYgHQkwxgxtaduu/xIf4BoD/q1rLmuBSB/VA3E8lMfnjZIaco0It0TL7kjyUsb
         7LK4wJh5goI5a/pU3gRTeGTomrwXgE1L0CWI8DbSmXUoM64zEkMCoDf9LuT8fWN53bBz
         vYAh+ff+IiWv5Q07DmjWVqNr+E57DKngXQedXUtfYrG9m3h+K/9a2eBy+s2Z8wcSRLiE
         wn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697165772; x=1697770572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdy8fAHPbtDdnhV62u5A/DdaX86JrOuLKTeJAWRWD7c=;
        b=LjUjNal0jURElTnVgFyVCwokTCZoAdvwFGK9Z3XPjVUBAYXcuR08hEZTCe48HIsWbU
         t/AQPYQM2gQAz4+grH0Qsd2KBiBjkHAW6pS55iZMxSIK2Qgt+U8SODtUL+pS9EUqZ0TE
         dAWuQKRviBnDNtqGqnOW98zpcaJldzBo4TihR91K4piI1mis7nS4GR9U8L9j4NTb/TAg
         IBkTFk2d3hC8U8v0AekM1omzc4jsiqhQ4zxriChjwHed8tznj5+bueUNUL/03q1zlqjb
         7eNZW5BuQ1v1ca80tQHK8vFpar3bf8qaM0WOov9zez9asR2HVXMllD8Q+OyUppPSU/OA
         vF2g==
X-Gm-Message-State: AOJu0YxZdYECAMTWN7uYKwZ0zJr3veU59nkpi40Q2BenGR7GEQiDYpJI
        aDcalmzOiolEp4ZFVCRN+QZ/KEiXpC9KOC29+RQ=
X-Google-Smtp-Source: AGHT+IHugiI2+XqFHWSUtcPZ+D35j75VhcvIiqFSzQ4AmgFaEiUlO/5E+LUxseKM190f8BT9JrvgcpMvzMZn4FaAti4=
X-Received: by 2002:a67:ffd3:0:b0:452:607d:8603 with SMTP id
 w19-20020a67ffd3000000b00452607d8603mr23873393vsq.1.1697165772493; Thu, 12
 Oct 2023 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
 <20230921055531.2028834-2-alistair.francis@wdc.com> <20231001175331.GA13453@wunner.de>
In-Reply-To: <20231001175331.GA13453@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 13 Oct 2023 12:55:45 +1000
Message-ID: <CAKmqyKP_duRdpxdDXJAxVuHfDWm1t8ZGZbtzzJBkMGXVSR4KYQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI/DOE: Expose the DOE features via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
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

On Mon, Oct 2, 2023 at 3:53=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Thu, Sep 21, 2023 at 03:55:30PM +1000, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object Exchange (DO=
E).
> > When DOE is supported the Discovery Data Object Protocol must be
>
> "... the DOE Discovery *Feature* must be implemented per PCIe r6.1
> sec 6.30.1.1"
>
>
> > implemented. The protocol allows a requester to obtain information abou=
t
> > the other DOE features supported by the device.
> >
> > The kernel is already querying the DOE features supported and cacheing
> > the values. This patch exposes the values via sysfs. This will allow
>
> Instead of "This patch ...", prefer imperative mood, i.e.:
> "Expose the values in sysfs to allow user space to ..."
>
>
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -500,3 +500,26 @@ Description:
> >               console drivers from the device.  Raw users of pci-sysfs
> >               resourceN attributes must be terminated prior to resizing=
.
> >               Success of the resizing operation is not guaranteed.
> > +
> > +What:                /sys/bus/pci/devices/.../doe_features
> > +Date:                August 2023
>
> Date says August but patch submission is from September.
>
>
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -47,6 +47,7 @@
> >   * @wq: Wait queue for work item
> >   * @work_queue: Queue of pci_doe_work items
> >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> > + * @sysfs_attrs: Array of sysfs device attributes
>
> What's the purpose of this pointer?  It's set in
> pci_doe_sysfs_feature_supports() but never used for anything.
>
> I'm guessing that you meant to use it to tear down the added attributes
> on device removal, but that's missing in the patch.

Yeah, the tear down got lost in one of the revisions. I have added it
back and reworked the patch to use the teardown.

>
> The attributes are added with sysfs_add_file_to_group(), but it seems
> to me they're not automatically removed by sysfs_remove_groups() on
> device teardown.  Am I missing something?
>
>
> > +static int pci_doe_sysfs_feature_supports(struct pci_dev *pdev,
> > +                                       struct pci_doe_mb *doe_mb)
>
> I don't quite understand the meaning of the function name:
> It sounds as if its purpose is to determine whether a feature
> is supported.  Maybe something like pci_doe_sysfs_add_features()
> instead?

I changed it to pci_doe_sysfs_feature_populate() which should be clear
and matches some similar functions in the kernel.

Alistair

>
>
> > +     doe_mb->sysfs_attrs =3D attrs;
>
> Set this after the xa_for_each() loop to avoid having to reset it
> to NULL on error.
>
>
> > +             attrs[i].show =3D pci_doe_sysfs_feature_show;
> > +
> > +             ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].att=
r,
> > +                                           pci_dev_doe_feature_group.n=
ame);
> > +             if (ret) {
> > +                     attrs[i].show =3D NULL;
> > +                     goto fail;
> > +             }
>
> The purpose of resetting attrs[i].show to NULL in the error path
> seems to be that you want to skip over features which haven't
> been created as attributes yet.
>
> It seems more straightforward to just iterate over the elements
> in attrs[] until you reach one whose mode is 0.
>
> Alternatively, use xa_for_each_range(&doe_mb->feats, i, entry, 0, i - 1).
>
>
> > +int doe_sysfs_init(struct pci_dev *pdev)
>
> Rename to pci_doe_sysfs_init() for consistency.
>
>
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -186,6 +186,9 @@ extern const struct attribute_group *pci_dev_groups=
[];
> >  extern const struct attribute_group *pcibus_groups[];
> >  extern const struct device_type pci_dev_type;
> >  extern const struct attribute_group *pci_bus_groups[];
> > +#ifdef CONFIG_SYSFS
> > +extern const struct attribute_group pci_dev_doe_feature_group;
> > +#endif
>
> No #ifdef necessary.
>
> Thanks,
>
> Lukas
