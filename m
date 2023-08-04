Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0C770434
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHDPSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHDPS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 11:18:29 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB2B9;
        Fri,  4 Aug 2023 08:18:26 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447576e24e1so793540137.1;
        Fri, 04 Aug 2023 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162305; x=1691767105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKKeeEZK0k/KmTOB+EfyS2WGuPhrb1ObzYdlQDrh8Qw=;
        b=VseqMOMOF52xs36Vr7h8rASKuNrSTm3AMGO809OGAv988E8KlV/FbDTunvNxNsw8bO
         KEH8RM1whH6Hu3o+9U7BNK7VVshh0r8+DI/ACYaIvGTW5HyMjfJ1cB+dy4KnHV266zts
         nZYJlEVPowwU1GPl+hM9ck4qzBtIlZl2B42TMwnnNHxc/6N9iy5fuVGOVM5kxv+hfQn3
         irjO7nkBPDKq+PHFU+U214NzSSmEjJ9irvHO+tyvjAwrNxFN1lyOIzuxQpEIm1dZCSpX
         k5pZnP1syBvVJdw/oQjs7T5cgi57UoXLMw9yaCoimxHzr8Yz5BVHxJKHcFKgyaLr0EEp
         jrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162305; x=1691767105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKKeeEZK0k/KmTOB+EfyS2WGuPhrb1ObzYdlQDrh8Qw=;
        b=XlaekXqGw10NSsnYhiW5G7AmamI5HPeIfAxCqMzHLwTTcA/O4r1/HJsTbRmyimLFVN
         rnd63+/uHtkGcj2RgZwjKMaQ0zKO9BSMLLmdErNvllIsCfuy+SqyynWPMQ7jPaRJHsG6
         HASFcNSf3Hb4WdCls9Mxad7+z8QwMdweQy9x0CxIde1PY1hngo4R2bikrD7q2cogblxH
         J77UjR4T15n9dVkvIJlaqoYLYTXBxd4Au11vZ1mzkohHlCBM8kGT2S+9UVPDkHvJUaI3
         MQkVw+GhWMi/AfUA0kGx34vxqfoDgOPsAl5K4rLtI1bR1b3y4EUr4FOa0KSQ8ey3U9NS
         iN0A==
X-Gm-Message-State: AOJu0YzitltptPE03zNkosgxt9edXGx+ZDVf9NHh8PbDL3uCRszIHPEI
        nexJT5yJV+CdM1jprn4P5xwtHlmc4G5UIeDLgfw=
X-Google-Smtp-Source: AGHT+IEZdAaMFmJa5KvVOv+x9Hf/VUHR//0YMg0OFNkmFtv9JCuBr/0BawIRf3LcGBrK+LBQ/2JWwgXfDiXFA5zR/DU=
X-Received: by 2002:a05:6102:c7:b0:445:208:3516 with SMTP id
 u7-20020a05610200c700b0044502083516mr1107122vsp.0.1691162305151; Fri, 04 Aug
 2023 08:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801121824.174556-1-alistair.francis@wdc.com>
 <2023080152-disobey-widen-65a4@gregkh> <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
 <20230801170739.000048cb@Huawei.com> <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
 <20230802225248.GA19409@wunner.de>
In-Reply-To: <20230802225248.GA19409@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 4 Aug 2023 11:17:59 -0400
Message-ID: <CAKmqyKNypBUPNK37wby-0_7G2-10BmZ4f8WQbevVn9uX1mZreQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
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

On Wed, Aug 2, 2023 at 6:52=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Tue, Aug 01, 2023 at 02:24:24PM -0400, Alistair Francis wrote:
> > On Tue, Aug 1, 2023 at 12:07???PM Jonathan Cameron <Jonathan.Cameron@hu=
awei.com> wrote:
> > > On Tue, 1 Aug 2023 09:48:13 -0400 Alistair Francis <alistair23@gmail.=
com> wrote:
> > > > On Tue, Aug 1, 2023 at 9:28???AM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> > > > > On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
> > > > > > +What:                /sys/bus/pci/devices/.../doe_proto
>
> The PCISIG published the DOE r1.1 ECN in September 2022.
>
> It replaced all occurrences of the term "protocol" with either "feature"
> or "data object type".  Please adhere to the terms used by the spec so
> that it is easy for an uninitiated reader to make the connection between
> the spec and the implementation.
>
> DOE r1.1 was merged into the PCIe Base Spec r6.1.  It wasn't merged into
> r6.0.1 yet.
>
>
> > > > > > +             This file contains a list of the supported Data O=
bject Exchange (DOE)
> > > > > > +             protocols. The protocols are seperated by newline=
s.
>                                                      ^^^^^^^^^
> s/seperated/separated/
>
>
> > > > > > +             The value comes from the device and specifies the=
 vendor and
> > > > > > +             protocol supported. The lower byte is the protoco=
l and the next
> > > > > > +             two bytes are the vendor ID.
> > > > > > +             The file is read only.
>
> I kind of like the approach of exposing a list which can be grep'ed,
> even though it may go against the rule of having just one datum per
> attribute.  I'd prefer a representation that's human-readable though,
> e.g. "0001:01" for CMA-SPDM.

Yeah, it's my preferred method as well, but it's not going to be
accepted upstream

>
>
> > > > > So this is going to be a lot of data, what is ensuring that you d=
idn't
> > > > > truncate it?  Which again, is the reason why this is not a good i=
dea for
> > > > > sysfs, sorry.
>
> For all practical purposes, the maximum size which can be returned
> by a sysfs attribute (PAGE_SIZE, i.e. 4 kByte on x86) ought to be
> sufficient.  I'd say a mailbox typically doesn't support more than,
> say, 10 protocols.
>
>
> > > > I was hoping to avoid the kernel needing to know the protocols. Thi=
s
> > > > list can include vendor specific protocols, as well as future
> > > > protocols that the running kernel doesn't yet support, so I wanted =
to
> > > > directly pass it to userspace without having to parse it in the
> > > > kernel.
>
> Right, just expose raw numbers and let lspci print them in beautified
> (parsed) form.
>
>
> > A directory per vid and files for each protocol sounds good to me.
> > I'll update the patch to do that. If anyone doesn't like that idea let
> > me know
>
> Since you intend to expose an interface for interacting with mailboxes,
> on top of just exposing a list of supported data types (protocols),
> I think you should first come up with a plan how to do that instead
> of kicking the can down the road.  The sysfs ABI is sort of set in
> stone, you can't easily change it if you realize after the fact
> that it has deficiencies for your use case.

So I think no matter what we want the DOE protocols exposed via sysfs.
That will allow tools like lspci to report the DOE protocols
supported.

Any other features aren't going to use sysfs. The future question of a
DOE mailbox or exposing SPDM bits does seem to be already determined
anyway.

>
> sysfs is not suitable for interaction with DOE mailboxes because the
> filesystem imposes a size restriction of PAGE_SIZE per read.  DOE
> allows up to 1 MByte per request or response, so way bigger than the
> puny 4 kByte PAGE_SIZE on x86.  Splitting response reception into
> multiple reads of the same attribute would be an awful kludge.
> So I think you need to resort to devfs or procfs for mailbox interaction,
> instead of sysfs.

Agreed

>
> Question is, if you use devfs/procfs for mailbox interaction, maybe it
> makes sense to expose the list of supported data types there as well,
> instead of in sysfs?

I do think that listing the protocols in sysfs makes sense, even with
a mailbox somewhere else makes sense. In saying that I don't think we
will end up adding mailbox support anyway.

>
> If you do expose a list of supported protocols, you should definitely
> have one sysfs attribute per mailbox, e.g. "doe_123" or "doe@123" if
> the mailbox is located at offset 123 in config space.
>
>
> > I think we will need to at least expose a few parts of SPDM to
> > userspace. It could either be the kernel passing data back (like the
> > measurements for example) or userspace orchestrating the
> > communication. That's a future problem at the moment though
>
> I envision that we'll provide a higher-level ABI for things like
> measurement retrieval, either through IMA or maybe sysfs, but not
> low-level access to the SPDM session.

That seems like the best approach to me as well.

>
> In fact, I think if you do implement mailbox interaction, you may
> want to blacklist certain data types that are handled in-kernel,
> such as CMA-SPDM.
>
> And you should constrain the whole thing to
> !security_locked_down(LOCKDOWN_PCI_ACCESS).
>
> FWIW, an experimental in-kernel implementation of SPDM measurement
> retrieval already exists (it goes on top of my doe branch that I
> linked to previously):
>
> https://github.com/debox1/spdm/commits/measurement

Awesome! Thank for that

Alistair

>
> Thanks,
>
> Lukas
