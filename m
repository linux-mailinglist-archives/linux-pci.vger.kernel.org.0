Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166BA50896A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiDTNf3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 20 Apr 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiDTNf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:35:26 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454B1D331;
        Wed, 20 Apr 2022 06:32:40 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id hh4so924266qtb.10;
        Wed, 20 Apr 2022 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O2zqYz6f2JW9p8GXuaBeDIZrjGwPRsDUFhT2oeYzVjQ=;
        b=ms1qTTMei8PAz3/Q/ZVW8+2780zDm6ABOXPxULthMRKMYxdG4K/xEBZH8EFNbo2pX9
         cvhF92PylJAa2ERXgutVWl0dprZdTpcVYrbY4tVK7eOKasmr5gGeMPH5/N+E/xzM17IS
         8W54a09PL+KF0Gh4pUCVtRZJvpOTQIFtXDCWPDDpItq+LxBru8BPd+y37qlqhdVwnJxU
         U3YfJxLQSn2RW6pP+wzP3i/17QRxkVzfptswrO6m7nvft35J3uNq/tqJk/1uUWW2Cjgd
         6GOaphyYNkVZviaGLnC1QVLJ7ymCFPfrS/eOlqm2+KPKdn9fX0hUufrM4zvAFa3eXfw4
         givQ==
X-Gm-Message-State: AOAM531Y/tYRT7QszW55Tx4Ip9fpGBv0YPdeajZ0JYMQfR3/n7LrmbA4
        G59W53FR9dfDcJQkahltVaZZe+iA+MGnMw==
X-Google-Smtp-Source: ABdhPJx696Sb89RhmnZFCCPKEIhmeynIZ7Scb+hIJmNcAnIH6HM2oyoxlQtvwymzaMIXipV+ny9V+Q==
X-Received: by 2002:ac8:1487:0:b0:2ef:ca47:89c1 with SMTP id l7-20020ac81487000000b002efca4789c1mr13915535qtj.646.1650461559411;
        Wed, 20 Apr 2022 06:32:39 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a079300b0069eb4c4e007sm1452690qka.29.2022.04.20.06.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:32:39 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ebf4b91212so18017907b3.8;
        Wed, 20 Apr 2022 06:32:38 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr20700663ywi.449.1650461558616; Wed, 20
 Apr 2022 06:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-4-herve.codina@bootlin.com> <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
 <20220420150759.713fcd02@bootlin.com>
In-Reply-To: <20220420150759.713fcd02@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 15:32:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqVDwdyNuB3tBrWNGt7tuNOXQwqB_Un9sZYCS-6P99bA@mail.gmail.com>
Message-ID: <CAMuHMdWqVDwdyNuB3tBrWNGt7tuNOXQwqB_Un9sZYCS-6P99bA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas-pci-usb: Allow multiple clocks
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Wed, Apr 20, 2022 at 3:08 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Is there a way to have the clocks description depending on the compatible value.

Rob already replied.
For an example, check out the various bindings for RZ/G2L devices,
e.g. Documentation/devicetree/bindings/net/renesas,etheravb.yaml

> I mean something like:
> --- 8< ---
> properties:
>   clocks:
>     maxItems: 1
>
> if:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - renesas,pci-r9a06g032
>           - renesas,pci-rzn1

Checking only for the second compatible value should be sufficient.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
