Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B534769ACE
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGaPa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGaPa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 11:30:57 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492521706;
        Mon, 31 Jul 2023 08:30:56 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-486556dea4dso1842097e0c.1;
        Mon, 31 Jul 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690817455; x=1691422255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa+EHVPYFxWshTbLbd58AgbMzRqBuVXOS26vxhPYpwM=;
        b=aEV5sjsMUnvoV0E+toEisFDZLy6/QMeYxuDPnT/Vw27FABa8voo+HdsTEbNIYnZmOR
         h86Z/LMWOnhzXgajV3lTCKqtEv2aYPRsTlBj6N21gRv5yPx50wWQ3Qdk4udsykD/vNay
         NvvXuj7HowxR4I73FaUTnakDGrfZqimt+xez7RQpYkvSfRfJLqQYcmqYv+p70fJIIcp7
         Fwp1x7D6iZgvbAB1xGQBUqIjLm0ROR1rv29QG1iytQBOhwDzeStiB1Jjm/jqIxUi2SoR
         dT+UGw4s+VUrqTYDMSHuS7BhaY5X96WaZGjA+Z6DVOUZv2YaUE2KRAloQnKKU5SdT0ff
         Khyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690817455; x=1691422255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa+EHVPYFxWshTbLbd58AgbMzRqBuVXOS26vxhPYpwM=;
        b=LEPuOOztfIVWMN9ycPUPUmTg+tAOQwe/MlWBm04AuD9H0s00+IuHtNtA0JIicy5sFA
         t82l1fjoshYi0ARzEH3ad6dau+iec6WdDVNH8fIoVCVn1SlvFfDt0azekvOSn7m+Szat
         Y0ujgAXzGE0+pV1lGdlyHQnlfHBvvCBPnEo6SlJRdY+GIbF1iiaF0lqHoY9YU5e8hqn3
         xhlvJatM9RiAe2ucQA0eP30Qh6KjspzPxfkw3ayaFDJwuzJiLs52TmjXSN+Ake8r4/k0
         9Hv6/Qjju3VGIz/kR5wYnShJkNi/zTPSfm1czaLSi+GhdBtP6Hh3Ba8eldsUx21dKn8O
         LDrQ==
X-Gm-Message-State: ABy/qLaZcjNCrD03cC5sU5oWHGhqMrtXKzn9hZzOXLFctUtEttaI8cMz
        hjRMY3T69yjk+VRvhm02cIy97wukPT92RtUqO5c=
X-Google-Smtp-Source: APBJJlH3j3Ls1d2b/Us99EP4gh0TrfPemGSqonWkJRVdaJP421w1azcanGu5I4Swj3YjLKlnMuRSaivchB262YmhD9I=
X-Received: by 2002:a1f:c1d4:0:b0:481:2dec:c27 with SMTP id
 r203-20020a1fc1d4000000b004812dec0c27mr359840vkf.1.1690817455219; Mon, 31 Jul
 2023 08:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
 <20230725163046.GA23990@wunner.de> <20230727093857.000017aa@Huawei.com>
In-Reply-To: <20230727093857.000017aa@Huawei.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 31 Jul 2023 11:30:29 -0400
Message-ID: <CAKmqyKOj9JxKcGbEEiTv_nxQSh+7cM-4uz6Z5uGFYdZyjeQ_5Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Jul 27, 2023 at 4:39=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 25 Jul 2023 18:30:46 +0200
> Lukas Wunner <lukas@wunner.de> wrote:
>
> > On Tue, Jul 25, 2023 at 01:57:55PM +1000, Alistair Francis wrote:
> > > The PCIe 6 specification added support for the Data Object Exchange (=
DOE).
> > > When DOE is supported the Discovery Data Object Protocol must be
> > > implemented. The protocol allows a requester to obtain information ab=
out
> > > the other DOE protocols supported by the device.
> > >
> > > The kernel is already querying the DOE protocols supported and cachei=
ng
> > > the values. This patch exposes the values via sysfs. This will allow
> > > userspace to determine which DOE protocols are supported by the PCIe
> > > device.
> >
> > Just dumping the list of supported protocols into dmesg might be simple=
r,
> > unless you intend to add mechanisms to actually use certain DOE mailbox=
es
> > from user space or expose the information in lspci.  Do have plans for
> > either of that or what's the motivation to use sysfs?
> >
>
> I can answer this one in rather than waiting for Alastair to see it
> (given I was involved in shooting down the earlier proposal :(
>
> At least partly motivated by providing the info for lspci which
> I agree with being a useful addition for debug etc.
> https://github.com/pciutils/pciutils/pull/152

Yep, a big benefit is lspci or other userspace tools to be able to see
what DOE protocols are supported.

I also have plans to expose DOE mailboxes to userspace. That way we
can run the SPDM requester code (using libspdm) in userspace to
communicate with devices using SPDM. That will allow device
authentication for example.

>
> I can see it would also be useful for things that will poke from
> userspace because they aren't expected to run in production (and hence
> hopefully don't care about potential races etc). CXL compliance
> comes to mind - I don't think we ever want to carry kernel code for that.

That too!

>
> Jonathan
>
>
>
> > I think I'd rather want everything in doe.c (#ifdef'ed to CONFIG_SYSFS)
> > and only make dev_attr_doe_proto public.

It seemed like all of the sysf was in this file, which is why I added
it there. I'm happy to move it if that's preferred though

Alistair

> >
> > Thanks,
> >
> > Lukas
> >
>
