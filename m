Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935A62D592
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKQIzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKQIzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:55:22 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2E725FD;
        Thu, 17 Nov 2022 00:55:21 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id x13so767630qvn.6;
        Thu, 17 Nov 2022 00:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYBhPvdCeDd/iVExb9nTFoQYzuFI59drf2/iH8jDOIg=;
        b=TRy1/s3He8DZiaWBJHAUsaweka0IAAxp3711mfiHkEanMsadB7pIBIL7bJHIO9VBHN
         sd+EM7RskcZrFWxWjlLJcreOMI3am8rXq5OFhy1yvW7BWr+q4trS/7NB/ipbsjVcHVa2
         oqaAWn5KBlxsfuyZDmZmsyo+sHsm5Nnxulv5N98tUPnqjak8Sp1QMQrMypzKxBtTTfyo
         PGQ/vlrWI5nZ/QRofgS+75Wi/UXqPzOIBdcUWncZBXFULDQQRUlBa0N+adBTn38CXppw
         WUZfkoc/UpadClPocFVLuO3lokQ5qwyTPoeS0BGaDU+xVNeD/3mqfBw01PyhPad1WZZK
         ifLA==
X-Gm-Message-State: ANoB5pliaWGIgnQ/uMzZBbWVgm6qgCIq8QaNGZC0D6g6uHySe+edl2ZR
        LiAIAG6lTkGDb2910ozI9MBowSpsGShLag==
X-Google-Smtp-Source: AA0mqf7ul8b+Jmt12TkV046AJHNgGiXc11ttMZqFb0vKulY66RAm8WDazkJM7s1DSuzZ3Fm5zPMvJA==
X-Received: by 2002:ad4:5042:0:b0:4bb:63be:9994 with SMTP id m2-20020ad45042000000b004bb63be9994mr1492616qvq.111.1668675320402;
        Thu, 17 Nov 2022 00:55:20 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006cfc9846594sm81035qkp.93.2022.11.17.00.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:55:19 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id g127so1088263ybg.8;
        Thu, 17 Nov 2022 00:55:19 -0800 (PST)
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr1150622yba.543.1668675319692; Thu, 17
 Nov 2022 00:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20221116205100.1136224-1-helgaas@kernel.org> <20221116205100.1136224-3-helgaas@kernel.org>
In-Reply-To: <20221116205100.1136224-3-helgaas@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 09:55:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtSHdFhd-V=7EzSZz6K7+fW9rLxUCN_=yZTGfKoAhS6A@mail.gmail.com>
Message-ID: <CAMuHMdVtSHdFhd-V=7EzSZz6K7+fW9rLxUCN_=yZTGfKoAhS6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Allow building CONFIG_OF drivers with COMPILE_TEST
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Wed, Nov 16, 2022 at 9:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Many drivers depend on OF interfaces, so they won't be functional if
> CONFIG_OF is not set.  But OF provides stub functions in that case, so make
> them buildable if CONFIG_COMPILE_TEST is set.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for the update!

> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig

> @@ -158,8 +162,9 @@ config PCI_LAYERSCAPE_EP
>           controller works in RC mode.
>
>  config PCI_HISI
> -       depends on OF && (ARM64 || COMPILE_TEST)
>         bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> +       depends on ARM64 || COMPILE_TEST
> +       depends on OF || COMPILE_TEST

Note that ARM64 selects OF, so this (and a few others) could be
simplified by dropping the "depends on OF || COMPILE_TEST".
But that might be the scope of a different patch?

>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCIE_DW_HOST
>         select PCI_HOST_COMMON

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
