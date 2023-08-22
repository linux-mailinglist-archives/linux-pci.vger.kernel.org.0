Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EB784B46
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHVUUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHVUUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 16:20:36 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12E10B;
        Tue, 22 Aug 2023 13:20:33 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44d5a0d2d86so620606137.2;
        Tue, 22 Aug 2023 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692735633; x=1693340433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQtJXi3F+i99xiwqSCAoKM13D0n/dmbUDefeS2PhlRY=;
        b=WX75mqYmY08FSk3SR9ksXOgxo6tGhQ/fQ5nHo9Y7BLR+b9EbIXB6swGacQ9OQ9S52u
         KBSUAzWuQ8hNhRscn2m050ayJGnh/J11HRUOPZHt0BKMxcK1EpKquPgthcE0BAKyScKb
         R2Pd76yp5QjUEtkXCxZc1rNep9gRUUbo48iyfdTguQYDw8qtZS79GxN3Dzu7ft7f3tjI
         Xpm3mb7knIJnF4BjLZ+dmEdQIsC16bmKDTxa7Wadv453AmeXXw28LjNGBD2Q7qNVsV57
         iSLOTXvXYu2oki6rVkYX2jA8vsuitML2EJ1c2dVFySTr/BQ3jBFx587TgfuNs/Xu/LAx
         8e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735633; x=1693340433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQtJXi3F+i99xiwqSCAoKM13D0n/dmbUDefeS2PhlRY=;
        b=ZdPGCO525LhGmT+ti7xp86bJJ5PVSz/YlqXGZXehLfFPeHyH/8mkaq6m83NKfwH8iS
         rcpDk+Sin6DTBCiUB94S2NhmJcyJf0OTEasAOrM+Jl0rdYPiSxWGP+RePViT4uLfXjh+
         OR7x83sK3dT/udE4vMVX7BV7VyxmqJtVObXVRZ2dVC3ranU8z5OYar8Wy6WH+4OAEjas
         HeLi6vjoZjYsVOHEnartxySEyr4EYCsykYSGUzzl6dQikLIdXwegxPFh3wL4Al1NrTSk
         LIqEChaZ+qTBF+cfbL6VefUpYZSoGVh4kzu4Ax4H3d9DP965nSDcgEtyoHz/syKaD2jb
         0PGA==
X-Gm-Message-State: AOJu0Yx2k2gbo/3AzlT+tldtZ5ngJV1kLPXr1nlFKO4+JmUX6joV2Umf
        MBmr9HByeO6qJ1LZmB0foSaHeJWnV1yqaDkQJQg=
X-Google-Smtp-Source: AGHT+IG9ENWzHKTallWnPKk3i5XT8EFozdYnHSMnV8DZYRAGj42nLh/vhMZrRzF0ur81UeciYaJiZacHzeh8I3zTDh4=
X-Received: by 2002:a05:6102:3679:b0:443:571d:c947 with SMTP id
 bg25-20020a056102367900b00443571dc947mr6074783vsb.24.1692735633016; Tue, 22
 Aug 2023 13:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com> <2023081959-spinach-cherisher-b025@gregkh>
In-Reply-To: <2023081959-spinach-cherisher-b025@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 22 Aug 2023 16:20:06 -0400
Message-ID: <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
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

On Sat, Aug 19, 2023 at 6:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> > The documentation for sysfs_merge_group() specifically says
> >
> >     This function returns an error if the group doesn't exist or any of=
 the
> >     files already exist in that group, in which case none of the new fi=
les
> >     are created.
> >
> > So just not adding the group if it's empty doesn't work, at least not
> > with the code we currently have. The code can be changed to support
> > this, but it is difficult to determine how this will affect existing us=
e
> > cases.
>
> Did you try?  I'd really really really prefer we do it this way as it's
> much simpler overall to have the sysfs core "do the right thing
> automatically" than to force each and every bus/subsystem to have to
> manually add this type of attribute.
>
> Also, on a personal level, I want this function to work as it will allow
> us to remove some code in some busses that don't really need to be there
> (dynamic creation of some device attributes), which will then also allow
> me to remove some apis in the driver core that should not be used at all
> anymore (but keep creeping back in as there is still a few users.)
>
> So I'll be selfish here and say "please try to get my proposed change to
> work, it's really the correct thing to do here."

I did try!

This is an attempt:
https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b6eb8a5692b1b5e=
2f81a9a9

It is based on your original patch with a bunch of:

if (!parent) {
    parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
                  S_IRWXU | S_IRUGO | S_IXUGO,
                  uid, gid, kobj, NULL);
    ...
    }


added throughout the code base.

Very basic testing shows that it does what I need it to do and I don't
see any kernel oops on boot.

I prefer the approach I have in this mailing list patch. But if you
like the commit mentioned above I can tidy and clean it up and then
use that instead

Alistair

>
> thanks,
>
> greg k-h
