Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F7511DFC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiD0PIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0PIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:08:32 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93CE0F0;
        Wed, 27 Apr 2022 08:05:20 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id f14so1328515qtq.1;
        Wed, 27 Apr 2022 08:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agafgRIcyKU96KX9arNKc39rksJmBWgsdHHVPeJSabE=;
        b=uG55K86Ebxit2/XpbwBAahXZpgZX4byNpCDUtn6K1R6w/2u+Mt8neOoF+sS3+zEciS
         syGPDX2KrABwtmFUlSmBYT8cQ0WGkby6uQTedBW33y5cee6GSx4y2CY0CVnlszwbfagb
         jfWPGwz/fCb6otop9yBxXnmS8H071Vc0Zv9U0JXwv/SuVbvgciFcRHNJrMXWX24v4L6U
         pVAVm+b6Ic/VTh4bgRnPn7JVky8LzAL3ytbsWIWVzBO7Hf7xXm6cc6UwbfRNW9o5ncoG
         8HC6vbH7K5GnjnJHIvscKxdEbqR9rxSqzL34f0Z4glvfrblQ9d8U8HwxZLPmE3pPt8Mx
         jG7g==
X-Gm-Message-State: AOAM531yFzOhinldpEXF54TCxgOVe+LWG1zVyHQ3/huiDeqbUrb5wYNl
        FFE53VoVCL+Iq4Rg15y8PiNsjIy71E8f1w==
X-Google-Smtp-Source: ABdhPJywoYYJlCD0rNO39LCYyn49J4PvQ/tUMmDdSANKZwOSr0eX0hJwhsA9rtF9qxOVJrum/ZwF8Q==
X-Received: by 2002:a05:622a:608c:b0:2f1:e3fa:b603 with SMTP id hf12-20020a05622a608c00b002f1e3fab603mr19200084qtb.48.1651071919469;
        Wed, 27 Apr 2022 08:05:19 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id r83-20020a37a856000000b0069ed4436a49sm8194957qke.87.2022.04.27.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 08:05:19 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id d12so3917920ybc.4;
        Wed, 27 Apr 2022 08:05:18 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr26972135ybq.393.1651071918482; Wed, 27
 Apr 2022 08:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-2-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-2-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 17:05:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVk-UkFqqFEeUn+ZqrdSy7u+S6Mz2GeDmx=mr33khzO6A@mail.gmail.com>
Message-ID: <CAMuHMdVk-UkFqqFEeUn+ZqrdSy7u+S6Mz2GeDmx=mr33khzO6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: pci-rcar-gen2: Convert bindings
 to json-schema
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Convert Renesas PCI bridge bindings documentation to json-schema.
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
