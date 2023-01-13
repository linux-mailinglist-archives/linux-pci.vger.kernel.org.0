Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF962669256
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjAMJJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbjAMJJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:09:28 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74141CB2E;
        Fri, 13 Jan 2023 01:07:03 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id a25so11443883qto.10;
        Fri, 13 Jan 2023 01:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyDICis6TMtpYbxnbEUxD/J66AveFuMFSuvndGIvxTA=;
        b=eaM1Y2rEA5oMh8Yq7/LQ+pEhBboeNIJdCjzbjdUNKQCMRtJgIY46wnj0Huqz52gUfk
         rMntPBbgMV44HviMcgF8kClLAuLEp0z2xpIkqnYMjx93quW44M7VnkmDN7ZqB/U1RRC1
         3kiZFWmdYWmaQmhl5q9niCsqYE9NmockIs1mEP5kgrTigAiBIbCIbvR5SsB2oA64fs41
         1bno/9gB15kYFbbzBRe19/kxFghOmNfpZYy0+1phSCDS6c9zN6bU7rlVbemXwbwbGsBH
         uF2WI73iSr+yCqkLSmFREGm1upEY/JBn1ibvr8uoO1S0O9NcXu09WN0W59xMh7VtxaJu
         o+fA==
X-Gm-Message-State: AFqh2kr5vmPSWOM6sjkS233KpMzP2GjxNY3N1r/ITEyt6GRDs69H49uU
        QY7o7E1JRF2Njw/XuXIj5ju65qWNYSeLwQ==
X-Google-Smtp-Source: AMrXdXsOjaPqSvnVCeToCh6Nbex/Y412O0T6mH60se0C7EC+zNd83nU9Wz0VaxD5GNjW8+44U/eM1Q==
X-Received: by 2002:ac8:7205:0:b0:3ad:841d:e65b with SMTP id a5-20020ac87205000000b003ad841de65bmr25096777qtp.7.1673600796323;
        Fri, 13 Jan 2023 01:06:36 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm12473249qkp.28.2023.01.13.01.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:06:35 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4c24993965eso269397537b3.12;
        Fri, 13 Jan 2023 01:06:35 -0800 (PST)
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr3504559ywb.47.1673600795403; Fri, 13
 Jan 2023 01:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20230113084516.31888-1-lukas.bulwahn@gmail.com> <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 10:06:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8r58Daj0sjFgumx+RwzPM04h71XXeA37ZQSM=D99eYg@mail.gmail.com>
Message-ID: <CAMuHMdV8r58Daj0sjFgumx+RwzPM04h71XXeA37ZQSM=D99eYg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 10:05 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jan 13, 2023 at 9:52 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> > that are introduced in a Kconfig file.
> >
> > Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> > CONFIG_SEND_ENABLE.
> >
> > Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> > prefixed with "CONFIG".
> >
> > No functional change.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Thanks for your patch!
>
> > --- a/drivers/pci/controller/pcie-rcar.h
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -11,7 +11,7 @@
> >
> >  #define PCIECAR                        0x000010
> >  #define PCIECCTLR              0x000018
> > -#define  CONFIG_SEND_ENABLE    BIT(31)
> > +#define  CONFIGURE_SEND_ENABLE BIT(31)
>
> The R-Car Gen3 rev. 2.30 Hardware User's Manual calls the bit "CCIE".
>
> Hence if I would have written the driver, I would have used
>
>     #define PCIECCTLR_CCIE     BIT(31)   /* Configuration Send Enable */

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
