Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F86A7C13
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 08:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCBHud convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 2 Mar 2023 02:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCBHuc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 02:50:32 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE95303DD;
        Wed,  1 Mar 2023 23:50:18 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-172afa7bee2so17227289fac.6;
        Wed, 01 Mar 2023 23:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9NdTpfDEMV32UTE9lZbQp6kQQhUJVdsU2kqbFsl+ZA=;
        b=tsmDfvCtJ9Aqml+rjvoBdolA55BW0s8ZxrfanyNdpKTbzx1b/2Gsc8g4BBBxCwTmMS
         88/CyZgPpGniroEjeZ1nCocMcTRvhWbvuWWh1vEsYYJyn+I4htZfeJ8+l6ak7IPwnrMN
         OUzUoTrAj0Rzu9/0c9ZS+SbZ00patwiEPYFtlMNoPdK4VsyKmtxnPvo7FJhuGn9sLVat
         y5udvpN/0cLELUluNjR8NoyxRdGchGRGSDg0Tbx3VDViXK3/qOBD/zHmbsWYtdqeuuN2
         o4/GSVWrZy+/khK7H7Ui+NZd5fZqkVLkDkvbRCuo1egOZhmGpGi+4l5MeRkXLOHBQ8X+
         vbFQ==
X-Gm-Message-State: AO0yUKWYxhaabFvVMNGMkZvySXZPceWN1bCFyoRhm/wNQlwNP5eh/nGp
        DPR1VKuKS2qDF61WvVyW440ORCh+1zV3kQ==
X-Google-Smtp-Source: AK7set8c9joX8ey0qbKnqu7pgCE8rSUDqWoyXNHH1uUotJKnAAQXnNfkwOhnn6pSu88jbBpjT8w8EA==
X-Received: by 2002:a05:6870:d202:b0:176:4a5b:10a6 with SMTP id g2-20020a056870d20200b001764a5b10a6mr655719oac.24.1677743418034;
        Wed, 01 Mar 2023 23:50:18 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id eg41-20020a05687098a900b001724742cfcesm5170181oab.38.2023.03.01.23.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 23:50:17 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q15so12854064oiw.11;
        Wed, 01 Mar 2023 23:50:17 -0800 (PST)
X-Received: by 2002:a81:ad1b:0:b0:52f:1c23:ef1 with SMTP id
 l27-20020a81ad1b000000b0052f1c230ef1mr5784211ywh.5.1677743396691; Wed, 01 Mar
 2023 23:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20230301185209.274134-1-jjhiblot@traphandler.com> <20230301185209.274134-3-jjhiblot@traphandler.com>
In-Reply-To: <20230301185209.274134-3-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Mar 2023 08:49:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVF337k+zyjpbzoDtWWDnYhM6eM3+As6UuZ7FCgASsMQg@mail.gmail.com>
Message-ID: <CAMuHMdVF337k+zyjpbzoDtWWDnYhM6eM3+As6UuZ7FCgASsMQg@mail.gmail.com>
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

Thanks for your patch!

On Wed, Mar 1, 2023 at 7:53 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> of_irq_parse_one() does a get() on the device node returned in out_irq->np.
> Callers of of_irq_parse_one() must do a put() when they are done with it.

What does "be done with it" really mean here?

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> @@ -184,6 +184,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>                         kfree(quirk);
>                         continue;
>                 }
> +               of_node_put(argsa->np);

The quirk object, which is a container of argsa, is still used below,
and stored in a linked list.  I agree argsa->np is not dereferenced,
but the pointer itself is still compared to other pointers.
IIUIC, calling of_node_put() might cause the reference count to drop to
zero, and the underlying struct node object to be deallocated.
So when a future reference to the same DT node will be taken, a new
struct node object will be allocated, and the pointer comparison below
will fail?

Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
