Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F69631BA4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 09:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKUIiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 03:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKUIiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 03:38:08 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23701D336;
        Mon, 21 Nov 2022 00:38:05 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id z17so7536025qki.11;
        Mon, 21 Nov 2022 00:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=majJ1avGrA5sKHgff1+tjzzyZx4Q8F2N6bTI30UoVN0=;
        b=XYtG3qcXZlf52gle7v15TTQkORhvT49sba3oM7PqdMTxAKDHBjfdF1pljGp/7X1gnS
         xjGAet8iSokRhVpc2ofwrYWcPTGQeGBid6PFyiAUTUoBtSjbnJuRKNsBj7Ss/iaSOQrf
         dfTwjabUpY/bcLe0pbr/J9LqtVmKHzW6RFzfgw29ZDmqfF+BZ5ev4EcLStk+zpot8jYU
         5V/MTRlqcwvLu7kduSo9EkSz+8OvDzBzk5MeMo3HWuxbi18FCa+MJ/PM58UrjBdmiyX2
         YUKMYA3qCaWEwdpa2NcmhDwJNfdyhyhlmIMsz7VC3zITWwx91En5TE/hT8iwkAUVq8qK
         hNKw==
X-Gm-Message-State: ANoB5pkkyMAWWQby9+ws2v6gKkhCq0xfy7ksRLDzTdlM/ksbkm1M1rzf
        we6Lr5O/g9g3WmExoZKeAxxgPW9ZX0Qa0A==
X-Google-Smtp-Source: AA0mqf42m6RtQH9n3FrT6ck1TJ8JYf+DL91aVh89zndnYg5xcI3fw3Cqh+f19rdsFfPeepAOEMNnfw==
X-Received: by 2002:a05:620a:150c:b0:6f8:aafe:27e7 with SMTP id i12-20020a05620a150c00b006f8aafe27e7mr15094781qkk.590.1669019884806;
        Mon, 21 Nov 2022 00:38:04 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a0f1200b006fa32a26433sm7838132qkl.38.2022.11.21.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:38:03 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id k84so12771887ybk.3;
        Mon, 21 Nov 2022 00:38:02 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr16184146ybp.202.1669019882500; Mon, 21
 Nov 2022 00:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20221118223728.1721589-1-robh@kernel.org>
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 09:37:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXevKD5uq9k+gWygy0rZ_AVjxBW1vrE_Gzzu8=mJu1vjQ@mail.gmail.com>
Message-ID: <CAMuHMdXevKD5uq9k+gWygy0rZ_AVjxBW1vrE_Gzzu8=mJu1vjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex anchors
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Mack <zonque@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml     | 2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
