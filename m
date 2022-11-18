Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5262FF6F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKRVkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 16:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKRVkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 16:40:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189685E9FE;
        Fri, 18 Nov 2022 13:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DF5625DC;
        Fri, 18 Nov 2022 21:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EDCC43140;
        Fri, 18 Nov 2022 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668807603;
        bh=YKUHTSPq5IDGNDGLjf/sjbiqE0AZozBsTwTI13qMcZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KDveWRKNOZyZVU+/76UW6M5Q/08kv/yJiaBcxH6kTaAvK0EC/0oB/lPwlzQXRfmt6
         Zm/6M8sSh3ksyjPfsLmQgNXmslxy66uL5hS1qxIj6follviijaqOxF2Ylk8xrW33Tq
         tROHgNpz9156QXsea3C6WmNgnCpvTK33f5e0Kl8qKFQujqsYAELF2CIoRERiHLZSQS
         RWX1QktikpkEd0k51tItGSYnnudBdJPC0ZiXCrXF9/tj55S2jo8fCS6mpcV6k2X5mq
         2BxJRJFcUCadrZkCMXM/Y8JSeEMHRoKa07VJ9fAMRabmA+AXFrZYTMVzJX+sgyxq1O
         erfDoFG1bweNQ==
Received: by mail-lf1-f42.google.com with SMTP id a29so10243073lfj.9;
        Fri, 18 Nov 2022 13:40:02 -0800 (PST)
X-Gm-Message-State: ANoB5pm9vecbdu77tVVB6cesyfMA80EX0F1B3J1ariFKWxfLoDbWQB6m
        qmHvwP+KNdTOQAdgNCzWeeS7nL0el4YY0cx/zw==
X-Google-Smtp-Source: AA0mqf4W7viCQPe0UTFofFT1SvVUt8YX11fzG82T1MZfAN+7A17E35zovc3VtyGLwVD/L6iRCqAuOeEDvppeVb0p8zA=
X-Received: by 2002:a05:6512:b97:b0:4a4:6ee3:f57b with SMTP id
 b23-20020a0565120b9700b004a46ee3f57bmr2843395lfv.17.1668807600996; Fri, 18
 Nov 2022 13:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20221118190126.100895-1-linux@fw-web.de> <20221118190126.100895-12-linux@fw-web.de>
In-Reply-To: <20221118190126.100895-12-linux@fw-web.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Nov 2022 15:39:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com>
Message-ID: <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 1:01 PM Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add devicetree overlays for using nand and nor on BPI-R3.

Can you not tell at runtime which one you booted from? If not, how
does one choose which overlay to apply? If you can, why not populate
both nodes and enable the right one? IMO, if all h/w is present, it
should all be in the DT. Selecting what h/w to use is a separate
problem and overlays aren't a great solution for that.


> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> maybe rename to dtso?
>
> "kbuild: Allow DTB overlays to built from .dtso named source files"
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2
>
> more comments about the dt overlay-support:
>
> https://patchwork.kernel.org/comment/25092116/
> https://patchwork.kernel.org/comment/25085681/
> ---
> v4:
> - drop compile-comment from overlays
> - add author-information to dt-overlays
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>  .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 55 +++++++++++++++
>  .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 69 +++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e8902f2cc58f..d42208c4090d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo

These need rules to apply them to the base dtb(s). You just need:

full.dtb := base.dtb overlay.dtb
dtb-y += full.dtb

Rob
