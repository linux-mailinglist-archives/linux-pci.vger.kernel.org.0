Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3215749341
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 03:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGFBol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 21:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFBol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 21:44:41 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2D122;
        Wed,  5 Jul 2023 18:44:40 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-47e4d002e0bso71757e0c.0;
        Wed, 05 Jul 2023 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688607878; x=1691199878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmpRLvUfTZLqM9ZpnuCqFVQ58lvwiT3vQOsEDk5km+Q=;
        b=I6YVQfUIj8lzt2fI/bCphHtVJqPy+UEQnTUAx680BWERE7g2HDrvFDgd/a05U30Ea/
         //FQmw9oENUhQalC+JVW5IsBJO3zWCGDHtmIvqPRwtszxGTfUbuX5PEmYkXYl3MF3qbP
         jPAzqiLwMD3mCLsZ1O8I7GJjzzJAAPVfOEvFvIIYEkIPTnIeJis8gPv/q0V9zrVq8VZ1
         swNVPf8Z2FJNMaQ9AA/lQ5gaI+dsl5AcQ6/JYpiAZwBf+NFw1l3XkQPWFTkAtboToY46
         cI97pCPU2ZLHWZKkcyy/WCNygcDDlq3AXEMbP/yE6pD3bCj4cs8vGyoJyI92+/bwfibZ
         kE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688607878; x=1691199878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmpRLvUfTZLqM9ZpnuCqFVQ58lvwiT3vQOsEDk5km+Q=;
        b=lShq5VHRFXgHBv1fAbshHIvAx07iiBFRk6FntAz0HyulGAxLJ7wbJa/LDOit59esNm
         0ogumcqXzHQu8HPzAn4zlF9q7h/Fvx1x5p4ghhWoS3TY7TsY7GDhcioZ1MRo7Hs+VBEN
         7IH2EsO0YW5I8AtRVaozeSvEgtTa6QGsDSHImC1BpEijgj5zpMP/WJ/arKcXlkqvFleM
         6tj2+qk/3NnbSQDh2iEu1gQR6aDNVUUrYpF63hc84AvvLtwGRG7LmSD4walAKC8MbS/c
         KbvM6xCgFkAlVasLnK8lE3DJFizE/SeXpfWok7P2NHpEy2JM5tjN4xR5inhdgGEpL+3b
         WF0w==
X-Gm-Message-State: ABy/qLbLRkPQZor+Bucci2XKvPwrYzjthInrqZOLDiZ/HQeCSnyllR5n
        EpU9g6fI+cvj61PwZDoq+QQQNWwF2dSZHcH+tMo=
X-Google-Smtp-Source: APBJJlE9Tu0UPfz3oRm/JkfoD6KT1ISbqyHuA8pDYvoTeRAt1Apah1qLl/63M9RDKErndIEIYOrPLXcxwsOk92fjuoo=
X-Received: by 2002:a1f:ecc1:0:b0:471:1b41:dbb2 with SMTP id
 k184-20020a1fecc1000000b004711b41dbb2mr696948vkh.10.1688607878592; Wed, 05
 Jul 2023 18:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230705104824.174396-1-alistair@alistair23.me>
 <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org> <20230705114443.GA3555378@rocinante>
 <CAKmqyKMD99cDwfyY8BJ0_ExB+VXytT3VdeENwuw5ZyqAKq3X0w@mail.gmail.com> <20230705131546.GA333066@rocinante>
In-Reply-To: <20230705131546.GA333066@rocinante>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 6 Jul 2023 11:44:12 +1000
Message-ID: <CAKmqyKP_nBHHqgB5Zf1JcXNNMJCZ-nFsUmWYvcidB_u1Sqe7NQ@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 11:15=E2=80=AFPM Krzysztof Wilczy=C5=84ski <kw@linux=
.com> wrote:
>
> Hello,
>
> > > > > pci-epc.h doesn't define the members of the pci_epf_header struct=
, so
> > > > > trying to access them results in errors like this:
> > > > >
> > > > >     error: invalid use of undefined type 'struct pci_epf_header'
> > > > >       167 |                 val =3D hdr->vendorid;
> > > > >
> > > > > Instead let's include pci-epf.h which not only defines the
> > > > > pci_epf_header but also includes pci-epc.h.
> > >
> > > [...]
> > > > It is odd that the the build bot did not detect this...
> > >
> > > This is a bit of a surprise to me too, especially since none of the u=
sual
> > > bots pick this up, and I can't seem to find such a failure in the nig=
htly
> > > CI logs either.
> > >
> > > Alistair, how did you stumble into this issue?  Also, which version o=
r
> > > a tree would that be?
> >
> > I was building the kernel with this defconfig [1] inside OpenEmbedded.
> > It was the 6.4-rc7 kernel, specifically this one [2].
> >
> > 1: https://github.com/damien-lemoal/buildroot/blob/rockpro64_ep_v23/boa=
rd/pine64/rockpro64_ep/linux.config
> > 2: https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v23
>
> Thank you!  Much appreciated.
>
> So, the vanilla kernel does not have headers arranged like this custom tr=
ee
> that Damien maintains for his own needs, per:
>
>   - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-ep=
c.h
>   - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-ep=
f.h
>
> I suppose, there are some changes that break it for you, for example:
>
>   https://github.com/damien-lemoal/linux/commit/c7aa8ddd76a141b975a097532=
050a76c6a58c436
>
> So, I cannot take this patch as it would break vanilla kernel for us. :)

Urgh! Sorry about that. I should have double checked if it was an
issue upstream. Thanks for looking into it though

Alistair

>
> Try building using vanilla kernel, and see if that helps.
>
>         Krzysztof
