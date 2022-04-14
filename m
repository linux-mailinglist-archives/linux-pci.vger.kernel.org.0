Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51555008B1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiDNIsc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 14 Apr 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiDNIsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 04:48:31 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3319034;
        Thu, 14 Apr 2022 01:46:07 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id c1so3529796qvl.3;
        Thu, 14 Apr 2022 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4RiddBxTlplmCUwfOPae3vR0/GMxp3cgfJfRb5yM9Y=;
        b=hd4ko3zV1OtIWp8ClIpk0841VLsn/hIXqV/hAnB5hcVabh8/MNGbwhW14OHBnW1RDV
         EUzZUeblSfiy8gPgLrFHTgUAoMCWdW5OGElnA34cvRsic/h3Do/NgIGJU4im1liTssjk
         T1iNi6Nt8HH0/5a7aT0i5Iojpi6yvGCmcCDjyFyU3PWS8NsH65FV1G482ttztpSQa8W7
         WZCn5DWL+czclPXscXiRF/xuW0qUcLbvKOJUCExEOBWmuw0U/v0Q583FXkKpTh5feXuh
         RCJOEUviQub3qxHPIZBw//8SrpyJ4B+Kr5r/Jc1dT+tOnwIvVceMb/9HJKGNBGq4xTCB
         dBWw==
X-Gm-Message-State: AOAM530Y2Q6nj43trRtKBpva+vCnS19bnZeMoUedZZrzwMzdhcb+qXFY
        TrtM+Pe0Uqkl2itiX6oiGP4JEIwijDPnJg==
X-Google-Smtp-Source: ABdhPJxPJtq8fTec3tKZMxBpOi1IkM5gTOZJ9/afJF+sIvIePVm+xkWWDlKTGsYX3qbIQtCqPV6FFw==
X-Received: by 2002:ad4:5347:0:b0:42c:4711:5eb5 with SMTP id v7-20020ad45347000000b0042c47115eb5mr2310705qvs.101.1649925966706;
        Thu, 14 Apr 2022 01:46:06 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a04c800b002e06d7c1eabsm905448qtx.16.2022.04.14.01.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 01:46:06 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id g34so8249353ybj.1;
        Thu, 14 Apr 2022 01:46:06 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr979130ybq.342.1649925965987; Thu, 14 Apr
 2022 01:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220414074011.500533-1-herve.codina@bootlin.com> <20220414074011.500533-2-herve.codina@bootlin.com>
In-Reply-To: <20220414074011.500533-2-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 10:45:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
Message-ID: <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] PCI: rcar-gen2: Add support for clocks
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

Thanks for your patch!

On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> wrote:
> The PCI rcar-gen2 does not call any clk_prepare_enable().

Correct, this driver manages the clocks indirectly through Runtime PM.

> This lead to an access failure when the driver tries to access
> the IP (at least on a RZ/N1D platform).

I expect adding

    power-domans = <&sysctrl>;

to the pci_usb node makes this patch redundant.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
