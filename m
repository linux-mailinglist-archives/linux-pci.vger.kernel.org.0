Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83974839A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGEL6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGEL6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 07:58:03 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B81989;
        Wed,  5 Jul 2023 04:57:57 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-47e06acce3bso1938358e0c.2;
        Wed, 05 Jul 2023 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688558277; x=1691150277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAcI9i2cZxQlI6EuMbQdWc0nRtDRpPblQMafL4coHB4=;
        b=WF0x/83oDsjWichye2yQHfBvncEPG7sdjJ/uwvD/ItEHEckSOAgNqosa/fJ/XPXp9R
         hqqdJW9ALV062S+EycufZlPKlTlY76EOkDoa3WW5zY4Qspw80tPmWPeEhHJ+qLuANg6s
         c3l+vdmYM57OgfmTLSNi+UEsJ/zpmmdikXLDtIhGPU4VcjKtnMBvf8CW6iFE0JD5lNe5
         /6OJML9iQ33Grt+vqFWqSvylrJLd3HcuS+jlr0Yb1QD/Br/69cFEYeM1u3tt0XuUhSdG
         AVNANruKjy/y2mIKnTrlvQrDq6R/uHWgtG+F8K3dZyxBsI1mlYEwvR+/Jz/3pqxH9Q+T
         dtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688558277; x=1691150277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAcI9i2cZxQlI6EuMbQdWc0nRtDRpPblQMafL4coHB4=;
        b=bpy0knVKYz7G+CfZr3AJjYa7zhgLje/sp5aPO7CnDmganJAMwaSS0o1KH2qqmW5AFs
         6uFzDKjorjr+EdC4XkgMh9194CtcdXTPnmniJr0kEKpioAyAQea5krvC+H0ZGs6oMUJ9
         eHbW8zleMB6onWDg9UmtMBsPDa0No2r/T5LyhbgN3HZyS34moTyMcOEvXT9iZ3x/WWk0
         xunLvbglMvbTDpqeUuzspdmroY12E0DYNbORUw5toqE0X5X08ZYopMH9bymxFPNu4cPo
         H3zmr/EXlAF58z68OGYL4C3/Ec6gZw8gaGj9lrKduzk6Mocro8LFFCgvLSwrRM0lZmY8
         55Ow==
X-Gm-Message-State: ABy/qLbq6FFjw4z1EAyBS8tss9tUAL5shWlrdhuFciUBHRfph6NQX69X
        Fc3eMDSFco4ofnG/W4RnV4UNt26qoKG9zyOaIo0=
X-Google-Smtp-Source: APBJJlEWpW2/lDv/3oWUv9u+0XTwFH/XqJMSRJuCOhPcEbsjFvhEgXGLibg1HV3y4eCCDIgooPhCKJrebmZV7eHXscA=
X-Received: by 2002:a1f:3fcc:0:b0:46d:d5c1:8c2a with SMTP id
 m195-20020a1f3fcc000000b0046dd5c18c2amr7597217vka.16.1688558276555; Wed, 05
 Jul 2023 04:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230705104824.174396-1-alistair@alistair23.me>
 <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org> <20230705114443.GA3555378@rocinante>
In-Reply-To: <20230705114443.GA3555378@rocinante>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 5 Jul 2023 21:57:30 +1000
Message-ID: <CAKmqyKMD99cDwfyY8BJ0_ExB+VXytT3VdeENwuw5ZyqAKq3X0w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of linux/pci-epc.h
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 5, 2023 at 9:44=E2=80=AFPM Krzysztof Wilczy=C5=84ski <kw@linux.=
com> wrote:
>
> Hello,
>
> > > pci-epc.h doesn't define the members of the pci_epf_header struct, so
> > > trying to access them results in errors like this:
> > >
> > >     error: invalid use of undefined type 'struct pci_epf_header'
> > >       167 |                 val =3D hdr->vendorid;
> > >
> > > Instead let's include pci-epf.h which not only defines the
> > > pci_epf_header but also includes pci-epc.h.
>
> [...]
> > It is odd that the the build bot did not detect this...
>
> This is a bit of a surprise to me too, especially since none of the usual
> bots pick this up, and I can't seem to find such a failure in the nightly
> CI logs either.
>
> Alistair, how did you stumble into this issue?  Also, which version or
> a tree would that be?

I was building the kernel with this defconfig [1] inside OpenEmbedded.
It was the 6.4-rc7 kernel, specifically this one [2].

1: https://github.com/damien-lemoal/buildroot/blob/rockpro64_ep_v23/board/p=
ine64/rockpro64_ep/linux.config
2: https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v23

Alistair

>
>   Thank you!
>
>         Krzysztof
