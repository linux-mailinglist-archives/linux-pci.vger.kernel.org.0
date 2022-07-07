Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6B56A590
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiGGOgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGGOgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 10:36:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5122130F63;
        Thu,  7 Jul 2022 07:36:16 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MbSXf-1ncahT0pa5-00bruD; Thu, 07 Jul 2022 16:36:14 +0200
Received: by mail-yb1-f181.google.com with SMTP id n74so3186785yba.3;
        Thu, 07 Jul 2022 07:36:13 -0700 (PDT)
X-Gm-Message-State: AJIora+7XjcN0A9VqOGxgcMrZGmvZ1orltDVH8rwKdTK5HJNCFxvi4K6
        kA8Smnd5+NqQoMVh/JsAEmvATtClVhJb4lgSys8=
X-Google-Smtp-Source: AGRyM1sHO0vLH5lK7prAzcvvwHxD+arEX2LzrQE6vcetrOrIovZ6/GAY1MqKVLA47Mf3l6xqB5z1R2OI4jP17F1EQlE=
X-Received: by 2002:a81:f8f:0:b0:31c:bd9f:31ce with SMTP id
 137-20020a810f8f000000b0031cbd9f31cemr19094869ywp.347.1657201076632; Thu, 07
 Jul 2022 06:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220622225822.2166305-1-mail@conchuod.ie> <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
In-Reply-To: <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 15:37:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04WLx4Me_=hm9v+Kpq31i3ZCDfPiDhT64RyE_pZZPDVg@mail.gmail.com>
Message-ID: <CAK8P3a04WLx4Me_=hm9v+Kpq31i3ZCDfPiDhT64RyE_pZZPDVg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock drivers
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, Cyril.Jean@microchip.com,
        Daire McNamara <Daire.McNamara@microchip.com>,
        Lewis Hanly <Lewis.Hanly@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Boyd <sboyd@kernel.org>, Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QWoM2sjcc/Ov3bhjeHTkVkhf5NvG6Oq+ia1j/GsIqsUZ78Xbcca
 kzsnt0CWR8JZREjXEXIKmhLfe1YvdbP0grxZpvIEFieuPMe7nZlkAQ/PBCVTkQ0kIVpAFWB
 6qQ7qfAb5Z+C4ekAtrucs8T3pYs5K00kRyKq0WMZV979c8YXRHidsNAwFVcQ1bwj005x5MV
 pr8pTIzZbGEPL8m/Y1Cbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rp4YGC2HfCI=:WHEdgZLYv9/EZJKjErR/+S
 tlwyMUjZJ70o9wYaow14RRyx6XMMleZMsaKmdQTJrUt+nnaTZRKxvIkM6AHmHPEFRZ69ZOCmv
 nqheMezaj8bRegH8pagROx0D0qJ/kBbXVQWfpyab9WTEQcCaja3CqBL8D0u4bB/u7OXxWy0Oo
 tOxjczsZ9n0OfYKo8AUufynA6/fcWMhFEzi19YtGOHhfHagEtYtfXVpoYzf9S+Gt0TpJPPOug
 E12I2p1Tmd0MFzQF0Clvm4V4KoLyHo4WjC5c3hUQfInsssHqHiMncYmBOeeg5GGxgxAk+dqv6
 bmwCJdSQHzr6hUqz0V98bEpCqwe4r50GMYEQ6CFIinhZi6bAXL8HBlaHoBPSJ0fNxl67yWrSr
 NQJXHh2gkPTC0pRZbXqcFa69QNlApTCdt318/GJrzn9X7KtAKyicYS+QkV60seZyxRmH4GNBX
 IUWtaYUnMmqaEOTvUiWewIM+IyqE4pJg2XoETt5eE4ImfL865Gp4RL6cexVoOxZ+BcEPdqIIN
 7uvdFH4HXM61nLD13XaUVm/heCpC5Tf7XBVlxyakJlcQYYaijzP5Ekii66Grojkib4sHcJzS9
 tXfmDyBL9TxVtuZDjgP26ooGg1tlx9g2PDoxxh90G6D9FxX1oq8khIiu5lr5aHyYsijqf/YO9
 ESDlw3db1osB0XM/gTSBlIRGIB/L5te2oe8rjjLOQVDZ/028AHDDrjAdcb7nPfqp1JvAjrSdm
 X0YiTm/uCTkO4SX77SQ0SvOnTOO2D56b1xLkTRSsLQPP6XdAg6dBs3Lk6kHiw8L9/6/exhwIC
 vinA59WCftx7bRGJ0LIJDbwF0/vh0tee0yoSuXRNJr651Mmyi1ZOQ/0fVt6wJm4H7XzFlmwOP
 5bymmYNS+11jH9WKEbl74xOKug1kEh7ZvECCHyKHY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 7, 2022 at 3:30 PM <Conor.Dooley@microchip.com> wrote:
>
> On 22/06/2022 23:58, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Hardware random, PCI and clock drivers for the PolarFire SoC have been
> > upstreamed but are not covered by the MAINTAINERS entry, so add them.
> > Daire is the author of the clock & PCI drivers, so add him as a
> > maintainer in place of Lewis.
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>
> Arnd, Palmer:
> Does the SoC tree make more sense for this patch?
> I am missing an ack from Herbert (but I don't think that's blocking
> for a MAINTAINERS update to my own entry?).
>
> If SoC is the better option, should I resend this to soc@kernel.org?
> Unfortunately, since I originally sent this patch there have been
> other changes to this entry that will conflict in -next (all are
> additions so easily resolved...).
>
> I was hoping to get this patch applied to v5.19-rc(foo) since we
> never added maintainers entries for these drivers rather than wait
> for v5.20.
>
> If you (plural) would rather wait for v5.20, I can resubmit this patch
> after v5.20-mw1 with an additional i2c entry (if the driver is applied)
> that already has an ack from Wolfram.

I tend to take MAINTAINERS updates as bugfixes in the soc tre
(for 5.19), and I can pick it up if you send it to soc@kernel.org.

There should never be a need to wait for the merge window
with these updates, it's either a bugfix (for 5.19) or for the current
-next cycle (5.20).

       Arnd
