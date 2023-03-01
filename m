Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B006A75C4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 22:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCAVBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 16:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCAVBC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 16:01:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EDD521CD;
        Wed,  1 Mar 2023 13:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD885B80EE1;
        Wed,  1 Mar 2023 21:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742DBC4339E;
        Wed,  1 Mar 2023 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677704458;
        bh=Ijy28NfIAolHq1kijXKPv1A9Prn6Z4PgPnz0SF2ZvmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwnNOgDopWNiUb4dKzA0Y6sT0gASegFoNl0l1oHhxaeFwidRVACqKvo9Zw4Lq2uLa
         DkRPAf51+Vr8EEyQ7IwC/Bj5H1tJVAjANsJyJLagfb6dQBIR+9OsGjhNPWRat2SOtH
         5jiteysKnyeBDdmsXExcQfoBUuLwKJRarM2/PpsDCzlFSlDaYiuiIN6Yn50f7C1yat
         Kl5hMVdu4kXvgesUhxebkvb/oOudYsbAKXyirkpGD3xB/LvTXAtTlhB/h40wU7a9WI
         X+6tPt1WSw58XL3OkDSeUjRPC3OEETL51n26pr7wfG3C7UJmYklBJjZHN6oNtzMzrG
         H1pgP6Xi9fu0w==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-53852143afcso389451967b3.3;
        Wed, 01 Mar 2023 13:00:58 -0800 (PST)
X-Gm-Message-State: AO0yUKUkNco2rq4K5o5XxG7Qrs1MolodYnCt0+yadl9+JyNaMT4qDo7m
        2DczIbGS4CB2Hvw33a1Rv2MKLhdYuXOfAeUKqg==
X-Google-Smtp-Source: AK7set/B7w4SIUVUY+fuTrfn39/aDxu+LSL+nDi5aDHHQnm81UFIS2ScAXvxaj+SUvgnwt845OQ2PIVb1st0BjISJs0=
X-Received: by 2002:a05:6102:3ca9:b0:41e:bccf:5669 with SMTP id
 c41-20020a0561023ca900b0041ebccf5669mr6637793vsv.2.1677704437053; Wed, 01 Mar
 2023 13:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20230301185209.274134-1-jjhiblot@traphandler.com> <20230301185209.274134-4-jjhiblot@traphandler.com>
In-Reply-To: <20230301185209.274134-4-jjhiblot@traphandler.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 1 Mar 2023 15:00:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvYnBtaOwaRbNo5Eqp51yxhJpnSYQWEGfKjtZKjm7R4g@mail.gmail.com>
Message-ID: <CAL_JsqJvYnBtaOwaRbNo5Eqp51yxhJpnSYQWEGfKjtZKjm7R4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: irq: release the node after looking up for "interrupts-extended"
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     saravanak@google.com, clement.leger@bootlin.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 1, 2023 at 12:53=E2=80=AFPM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> When of_parse_phandle_with_args() succeeds, a get() is performed on
> out_irq->np. And another get() is performed in of_irq_parse_raw(),
> resulting in the refcount being incremented twice.
> Fixing this by calling put() after of_irq_parse_raw().

This looks like a band-aid to me. It only makes sense that the caller
of of_irq_parse_raw() already holds a ref to out_irq->np. So the first
of_node_get() in it looks wrong. It looks like the refcounting was
originally balanced, but commit 2f53a713c4b6 ("of/irq: Fix device_node
refcount in of_irq_parse_raw()") dropped the put on exit after 'got
it!'. I'm not sure if just adding it back would be correct or not
though.

All this needs some test cases to be sure we get things right...

Rob
