Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E9514474
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355872AbiD2Io3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355874AbiD2Io2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 04:44:28 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC223879C;
        Fri, 29 Apr 2022 01:41:11 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id a22so2288688qkl.5;
        Fri, 29 Apr 2022 01:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmuhzPRLCLPo7cMm4XZT2P+NSOpxwQLkY7PJWwuzFQA=;
        b=Cdryz4q/z7cdN+JLgrGjFT+WDFdS1EYadbkxCo8eNDpE2dw5jk2abLjDiX04G/Ne72
         BbsJt6IH1Th63tz/lDEEoRbT86cvUx+I7Hy88l+m6BcoefjHUU7zjbseDYQMEThU9t7C
         XHVqYnsL/qgPCD4/a7LWpnTb4BGoHYw53NKRe7T9LJbFgz6Safe03h/4JT2eZpsGUEvW
         OEgmQSYuZjbv4xkGuuzOSQxPnimJ96VSF3lVBWDagJwUAu/asX0rNxbL7F/uutY5wIU4
         iHcxdrGSxfcUa2kPDeg72utSgRo8J/HcRwQ61Df7hMKivURZiaxSy1a4xW89ZeMWP97L
         Jqvw==
X-Gm-Message-State: AOAM530Jl620tn8/6TwRL4fSq92ShtSYfmv5W0V16HNvHWaDHouihGgB
        7axIYFHgNdaZWfniXghL8uaKTMFJuUXznq22
X-Google-Smtp-Source: ABdhPJxHs4ThqUa83URs1u+Zgdnk1PkyyA4mqx/C57NLSEdHqvWSEhnocOL3F+rPzrJAWpZKCcxFbA==
X-Received: by 2002:a05:620a:1722:b0:69e:e99a:db06 with SMTP id az34-20020a05620a172200b0069ee99adb06mr22058792qkb.534.1651221670018;
        Fri, 29 Apr 2022 01:41:10 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm1415074qtz.59.2022.04.29.01.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:41:09 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f83983782fso78098357b3.6;
        Fri, 29 Apr 2022 01:41:09 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr34745160ywa.479.1651221668914; Fri, 29
 Apr 2022 01:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151630.586009-1-herve.codina@bootlin.com> <20220428151630.586009-6-herve.codina@bootlin.com>
In-Reply-To: <20220428151630.586009-6-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:40:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJAjCrHN_O5-4nGLMsx_X6+FRt_6-wQW3FM2Mir3AjHQ@mail.gmail.com>
Message-ID: <CAMuHMdXJAjCrHN_O5-4nGLMsx_X6+FRt_6-wQW3FM2Mir3AjHQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] ARM: dts: r9a06g032: Add USB PHY DT support
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 5:16 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Define the r9a06g032 generic part of the USB PHY device node.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
