Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD80A62A1DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKOT1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 14:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKOT1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 14:27:33 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020630552;
        Tue, 15 Nov 2022 11:27:32 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id v8so10182986qkg.12;
        Tue, 15 Nov 2022 11:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2NvVNdD7dZaC9v1I7hoHtnivglaUbfouXXKtq0NaSo=;
        b=r1xBI6uUFvWU+xhFtUhnV+soUTbhUSyX6grsIRtoIOOr15t2vqe2SRU9jLodL0RpuU
         h/wkg0ERG0q1b/5HziPSPvzrc5ecpogjHaaEImuSSTnYAZ3GXkkc8pfX9zgSQWAgZEPe
         5Ti5jlgllGg36d4S8n+GtO6NZhQaCM72GGOObm/lPlnGMWFf3VEGupWmdCTkeQgOOSGx
         XK4oBzVO38UKbusljM58OBlbfnxnIjpmBr5JrHFPcmnSAHpIGx2WZTAv8HDWEf86HDuR
         deqepKHB4lKSzylphk0IUiRltjaTKGnXJIhSDyviMl1cZ5a6plFcH+zsgPilre2gTx+e
         8jeg==
X-Gm-Message-State: ANoB5pmOA088QsRBSM2/MdrmpMpQTCEiss3+WoDoqonT6+Vo4uGybsI2
        KkaCWdbmfshwd4o7DH5PFdvBNgkRr7ZSdg==
X-Google-Smtp-Source: AA0mqf7B8Vc4EhwkUT1knnQe4m+eH6D5Njg3bIUoLKcl7UR7HYAMmQQICnfJDPBBOZRCSdLFO7y6LA==
X-Received: by 2002:a05:620a:16d1:b0:6fa:156e:44c0 with SMTP id a17-20020a05620a16d100b006fa156e44c0mr16411458qkn.293.1668540451104;
        Tue, 15 Nov 2022 11:27:31 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006f9f3c0c63csm8687025qkb.32.2022.11.15.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 11:27:30 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-367cd2807f2so146925267b3.1;
        Tue, 15 Nov 2022 11:27:30 -0800 (PST)
X-Received: by 2002:a81:4dc3:0:b0:370:61f5:b19e with SMTP id
 a186-20020a814dc3000000b0037061f5b19emr18493380ywb.316.1668540450246; Tue, 15
 Nov 2022 11:27:30 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdVnJZGqwnC0fZTwyb1GT5Nu+4K9LND4CXU96cvYG+qEgg@mail.gmail.com>
 <20221115180734.GA999206@bhelgaas>
In-Reply-To: <20221115180734.GA999206@bhelgaas>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 20:27:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4FKDnAN8DNsBG0jRF0rUxTVwDa9=AmMR4FTrdnJErrQ@mail.gmail.com>
Message-ID: <CAMuHMdX4FKDnAN8DNsBG0jRF0rUxTVwDa9=AmMR4FTrdnJErrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Nov 15, 2022 at 7:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 15, 2022 at 04:56:10PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Oct 25, 2022 at 9:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Many drivers depend on OF interfaces, so they won't be functional if
> > > CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
> > > the OF dependencies so we can at least compile-test the drivers.
>
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -8,7 +8,6 @@ config PCI_MVEBU
> > >         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> > >         depends on MVEBU_MBUS
> > >         depends on ARM
> > > -       depends on OF
> >
> > This is exactly why we have the COMPILE_TEST symbol.
> > There is no point in bothering all users who configure kernels with
> > questions about drivers that won't function anyway due to missing
> > dependencies, unless the user explicitly wants to do compile-testing.
> >
> > So all of these should become:
> >
> >     depends on OF || COMPILE_TEST
>
> Oh, yes, thanks for pointing this out, I totally blew it here.  I
> dropped this while we figure it out.
>
> Do you have a preference between this:
>
>   depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>   depends on OF || COMPILE_TEST
>
> and this:
>
>   depends on ((ARCH_MVEBU || ARCH_DOVE) && OF) || COMPILE_TEST
>
> The latter seems more common and doesn't repeat "COMPILE_TEST", but I
> can see advantages to the former.

Personally, I prefer the former, as it is easier to parse for a human.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
