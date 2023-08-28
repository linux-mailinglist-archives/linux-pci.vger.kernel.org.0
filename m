Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71C78A515
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjH1FGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 01:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjH1FGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 01:06:12 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28520126;
        Sun, 27 Aug 2023 22:06:09 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-48faba23f51so1301502e0c.1;
        Sun, 27 Aug 2023 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693199168; x=1693803968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/pSq1i+7Vky2mfFmzDC2kFRTCQCCg5yxL/yk3DrIZI=;
        b=pgdYadLgaqukrduplhsmEpOvaQ9OD0Iv5RxSivNTi+Kh+GpheAXgTCPbrm1ADOwxOd
         eOnTo0ShJ5LXME9sfZ4IePXKh2XfLeqT6vg5+g22S43xRl6iz6MOxf8BuQuoe7d6ljYe
         VdUwiV6XbMyoUEmvweKIUpHMcYopI30zsRCbHu0nI6RIu/ngmKDOj+uJDA3C0VRtqCxh
         7yLqrjdMSh5SHfnc2m6iVWDAXQbPb4Ovj46/TbboSSFB6zVXmOIvdaIQq3BAd33iuwTf
         /9i0Id2Vzq/jzT2RR0wr8U+iwyFzdckzURyu6uUh1YKgmTjIfrFg0i/DQuO3JQJOCOoK
         E+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693199168; x=1693803968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/pSq1i+7Vky2mfFmzDC2kFRTCQCCg5yxL/yk3DrIZI=;
        b=DX1o4juiZtETjOyJls7lfuEM5Vi4B4qduoE1S/cfFE903yRcCJs+rUmPh1R4FQbx0V
         1cvPpvPceZv7i7B1RRM4PWTOl32qfnaaehAt7ODx18LZ3KaAXmeoireEmACP/jItTOlh
         kUwOVt44jF18y7Yl+Ajn7mbCikhQWc0hSKVAP2dJCVpRJGWy+fye6b4K8NfrpIsqOuPb
         ljpU/TB8Kphs+tgd1iGvuXDMFcNkM1UfnIcUtEVuP4AW+QjUDU0z1+bcasMuFQ0bp8OO
         g1U71R77/W6GaQ/fWrrSQm9StLFERot1sAzYFqyabz4Qj+TLxnZRLBjZifsqCzcTDYM3
         zpkw==
X-Gm-Message-State: AOJu0YwuFBJkdg3bf/OOiMS2CQ/obqtya6Cp480oryQy92SMZG5wL3P9
        usABXynnUU8+SsiyKeM8BKlNdvuVAuQ8NqRyk04=
X-Google-Smtp-Source: AGHT+IFlklTckG5JobNti7eCbRo67iBpqZJEPfZK0o1n/ElWq3d9wAakhv5WQwqmXeb1eB/FVrWsNrtV79HZ7Bvb3gc=
X-Received: by 2002:a67:f4d6:0:b0:44d:3f96:6c61 with SMTP id
 s22-20020a67f4d6000000b0044d3f966c61mr18744053vsn.30.1693199168226; Sun, 27
 Aug 2023 22:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com> <2023081959-spinach-cherisher-b025@gregkh>
 <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com> <2023082325-cognitive-dispose-1180@gregkh>
In-Reply-To: <2023082325-cognitive-dispose-1180@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 28 Aug 2023 15:05:41 +1000
Message-ID: <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to attribute_group
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
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

On Wed, Aug 23, 2023 at 5:02=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis wrote:
> > On Sat, Aug 19, 2023 at 6:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> > > > The documentation for sysfs_merge_group() specifically says
> > > >
> > > >     This function returns an error if the group doesn't exist or an=
y of the
> > > >     files already exist in that group, in which case none of the ne=
w files
> > > >     are created.
> > > >
> > > > So just not adding the group if it's empty doesn't work, at least n=
ot
> > > > with the code we currently have. The code can be changed to support
> > > > this, but it is difficult to determine how this will affect existin=
g use
> > > > cases.
> > >
> > > Did you try?  I'd really really really prefer we do it this way as it=
's
> > > much simpler overall to have the sysfs core "do the right thing
> > > automatically" than to force each and every bus/subsystem to have to
> > > manually add this type of attribute.
> > >
> > > Also, on a personal level, I want this function to work as it will al=
low
> > > us to remove some code in some busses that don't really need to be th=
ere
> > > (dynamic creation of some device attributes), which will then also al=
low
> > > me to remove some apis in the driver core that should not be used at =
all
> > > anymore (but keep creeping back in as there is still a few users.)
> > >
> > > So I'll be selfish here and say "please try to get my proposed change=
 to
> > > work, it's really the correct thing to do here."
> >
> > I did try!
> >
> > This is an attempt:
> > https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b6eb8a5692b=
1b5e2f81a9a9
> >
> > It is based on your original patch with a bunch of:
> >
> > if (!parent) {
> >     parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> >                   S_IRWXU | S_IRUGO | S_IXUGO,
> >                   uid, gid, kobj, NULL);
> >     ...
> >     }
> >
> >
> > added throughout the code base.
> >
> > Very basic testing shows that it does what I need it to do and I don't
> > see any kernel oops on boot.
>
> Nice!
>
> Mind if I take it and clean it up a bit and test with it here?  Again, I
> need this functionality for other stuff as well, so getting it merged
> for your feature is fine with me.

Sure! Go ahead. Sorry I was travelling last week.

>
> > I prefer the approach I have in this mailing list patch. But if you
> > like the commit mentioned above I can tidy and clean it up and then
> > use that instead
>
> I would rather do it this way.  I can work on this on Friday if you want
> me to.

Yeah, that's fine with me. If you aren't able to let me know and I can
finish up the patch and send it with this series

Alistair

>
> thanks,
>
> greg k-h
