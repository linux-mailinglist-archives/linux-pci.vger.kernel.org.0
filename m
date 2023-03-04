Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE66AAA80
	for <lists+linux-pci@lfdr.de>; Sat,  4 Mar 2023 15:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCDOrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 4 Mar 2023 09:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCDOrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Mar 2023 09:47:46 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D512F12;
        Sat,  4 Mar 2023 06:47:44 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id z6so6108053qtv.0;
        Sat, 04 Mar 2023 06:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677941263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeKbxzDZy3GcKkrGUofgHv5MAh6MoP5a08Lg7rMsvMk=;
        b=S3qNnTfaGG8dWVsorNdGIUyak/GpcZUpktOkv6gyxtw3XAcFdhL/CEPTnxawlQEyNf
         ahJg6xrVKof9Ba8qj4jmw8QWAUQHq5sg8lZVrnFFXNh2e6FSXM8aN92iCBHMkyHyhFOW
         pF5M9IbKRWk6kueY6GrPeTRsBtYQnAJ+bqHZJg2WQdnDvJo82uZG4w76/sYjAQcpPvj5
         X3PdR7+eBUj3v3V5VGL6SUaQt75AyLPdgwuQKZZZXmKfQaf0t6b+z4rxR4EzF95nhetG
         mkUGP6pbLyZPqZlct7Y+mkWH0S8etn2r4am3ttLR2fi3LMB2kL6kUnxO0X/vIDvBZFe5
         5UKQ==
X-Gm-Message-State: AO0yUKVzoLn4IAtoBJaDXBH/SlyIWWFCRfWfBdJsVlpAKhiY40HLN8OC
        Olj/cAkGxTOPQq8Y+JsX6KiYQ9LQxU20VA==
X-Google-Smtp-Source: AK7set8iJFGfogd8HyTfcNNFYdWDx6zvwpzg4FmQZW+Si0Gg/ZbY1ExyzEf60dMofx6GBE4kRARcwA==
X-Received: by 2002:ac8:7f14:0:b0:3bf:c407:10c5 with SMTP id f20-20020ac87f14000000b003bfc40710c5mr10006171qtk.26.1677941263461;
        Sat, 04 Mar 2023 06:47:43 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r15-20020ac867cf000000b003bfc2fc3235sm3817779qtp.67.2023.03.04.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 06:47:43 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-536cb25982eso96915597b3.13;
        Sat, 04 Mar 2023 06:47:43 -0800 (PST)
X-Received: by 2002:a81:b723:0:b0:536:38b4:f51 with SMTP id
 v35-20020a81b723000000b0053638b40f51mr3187721ywh.5.1677941242747; Sat, 04 Mar
 2023 06:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20230301185209.274134-1-jjhiblot@traphandler.com>
 <20230301185209.274134-3-jjhiblot@traphandler.com> <CAMuHMdVF337k+zyjpbzoDtWWDnYhM6eM3+As6UuZ7FCgASsMQg@mail.gmail.com>
 <7fa7f07f-d1e1-1e43-992c-4981c5810284@traphandler.com>
In-Reply-To: <7fa7f07f-d1e1-1e43-992c-4981c5810284@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 4 Mar 2023 15:47:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdZatMYsc=367OuGotzYuo2-XVe5MAZdzh+kBs31=t5A@mail.gmail.com>
Message-ID: <CAMuHMdVdZatMYsc=367OuGotzYuo2-XVe5MAZdzh+kBs31=t5A@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: irq: make callers of of_irq_parse_one() release
 the device node
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     saravanak@google.com, clement.leger@bootlin.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        zajec5@gmail.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marc Zyngier <maz@kernel.org>, afaerber@suse.de,
        Manivannan Sadhasivam <mani@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nishanth Menon <nm@ti.com>, ssantosh@kernel.org,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Jacques,

On Sat, Mar 4, 2023 at 11:34 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 02/03/2023 08:49, Geert Uytterhoeven wrote:
> > On Wed, Mar 1, 2023 at 7:53 PM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> >> of_irq_parse_one() does a get() on the device node returned in out_irq->np.
> >> Callers of of_irq_parse_one() must do a put() when they are done with it.
> >
> > What does "be done with it" really mean here?
> >
> >> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> >
> >> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> >> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> >> @@ -184,6 +184,7 @@ static int __init rcar_gen2_regulator_quirk(void)
> >>                          kfree(quirk);
> >>                          continue;
> >>                  }
> >> +               of_node_put(argsa->np);
> >
> > The quirk object, which is a container of argsa, is still used below,
> > and stored in a linked list.  I agree argsa->np is not dereferenced,
> > but the pointer itself is still compared to other pointers.
>
> I fail to see when the pointers are compared. It looks to me that only
> the args are compared. Am I missing something ?

You're right, in upstream, there is no such check.
In my local tree, I have converted the comparisons below to use a new
helper of_phandle_args_eq() (which does compare the np member, too),
but that change never went upstream, as the other user of that helper
was rejected.

> In any case, looking more closely at the code, I guess that indeed the
> of_node_put() shouldn't be added here because this code expects that the
> nodes never go away. That is probably a good assertion in case of PMICs

OK.

> > IIUIC, calling of_node_put() might cause the reference count to drop to
> > zero, and the underlying struct node object to be deallocated.
> > So when a future reference to the same DT node will be taken, a new
> > struct node object will be allocated, and the pointer comparison below
> > will fail?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
