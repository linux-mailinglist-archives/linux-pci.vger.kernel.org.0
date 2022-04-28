Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCD5130A0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiD1KGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 28 Apr 2022 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiD1KFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:05:51 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00632EE4;
        Thu, 28 Apr 2022 02:51:59 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id t16so3012391qtr.9;
        Thu, 28 Apr 2022 02:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9+oGTlNW4Rw+j1mI5ZQn++S2sjGJsMH7CZqZR09nnas=;
        b=272MmZ+IWIIMGwEaQugGpTQz9bx9Z2XNiwTEUH3PGt4IdAkx+AVcHd7a6piDDFuRPy
         g1NoTpXuN5clQcxqIbpUsP2Xpqb1/uVTcrWmHLjfyRZFatAuPuWr60xeNt1i/g0UcZpF
         A5fBizH9o5XWJLH8dQTqNojFG8u6u0LPSsvw0aZu1ENW92gsCaVy1fx1XlUBP5dGA06m
         SPoSJ6ydkq+tiCN3Z2HqXZwRU8BlgcO/syZXX9ZXTSN/f8oRrfpC41VNyXVougcTuNIT
         993am5ZXNoAHvJBazKfdHgp0NlSB5D4ekLFvuHztC4AbLyQiBz+EMAJZDdJpp+MWPsSF
         iMIQ==
X-Gm-Message-State: AOAM531/N9w2NJjrVHGUxSL7adR906Oj0v3zdnSGIRHjTKVtwmEX0YYc
        nVLuQQ+lFL4CEBBjVSa0fjxxpIB8D2IERA==
X-Google-Smtp-Source: ABdhPJxVXkMHhpF3fypTOy50zuuV7otuYHr90zFMTy1nhYNw1tFzhlVXH2Xn6u0nGB5wjbuGZZsZ3Q==
X-Received: by 2002:a05:622a:588:b0:2f3:64ef:5566 with SMTP id c8-20020a05622a058800b002f364ef5566mr14664016qtb.327.1651139518120;
        Thu, 28 Apr 2022 02:51:58 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm11236434qtx.60.2022.04.28.02.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:51:57 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f16645872fso46693137b3.4;
        Thu, 28 Apr 2022 02:51:56 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr29976415ywa.479.1651139516383; Thu, 28
 Apr 2022 02:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-8-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-8-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:51:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYpntR6QpJTRMPtE_RjNq+vwfCVRViXCc8DhNRMMjqJQ@mail.gmail.com>
Message-ID: <CAMuHMdXYpntR6QpJTRMPtE_RjNq+vwfCVRViXCc8DhNRMMjqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ARM: dts: r9a06g032: Add USB PHY DT support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Define the r9a06g032 generic part of the USB PHY device node.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -59,6 +59,12 @@ ext_rtc_clk: extrtcclk {
>                 clock-frequency = <0>;
>         };
>
> +       usbphy: usbphy {

Please preserve sort order (by node name).

> +               #phy-cells = <0>;
> +               compatible = "usb-nop-xceiv";
> +               status = "disabled";
> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
