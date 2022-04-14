Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4098C500877
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiDNIhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 14 Apr 2022 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiDNIho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 04:37:44 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4ED1D0D8;
        Thu, 14 Apr 2022 01:35:20 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id b17so3513160qvp.6;
        Thu, 14 Apr 2022 01:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p4JDMOvhMVC+O6GBKDBlCsUXasEj3WV+5nDchlig3M8=;
        b=2kfGsVicDD05YiP7NBTKcddSbwF0SgSV6JukDMd+jDQlhaQ8KQ0vr3c1kefvzoo6v8
         sFhn64MfXMr1HMIi5HlaqpM2njwf1dBuuGp0EKlNxRt9Jql2fp7A3e6T2tlZDena02hJ
         5tnhra3Gl9PA2RhaWNPQidA60V2cAQxG3intWqLTcXRBzGhLcsttNaIE29fcRv2lCYh1
         K245zzRZovfnbC/SijjszuslUOam6hIHg/ZFouyFRoMqAQejQk4DzxHW6ag49u1tewG5
         SPbj+CzxBljIbHaOD5PeLvqsjTi7DcJB1tpJHYnqpLliiVPVNc9uBzGnCON28OWC4Zls
         SnLg==
X-Gm-Message-State: AOAM5301qWL2iD+da5J5CMnf2EsNHjqsmL9QUb+tzh8SfLHvy5Sd2X0N
        SkCaLnSfCQmgodl4aIBkByEGf9JpMUJY4Q==
X-Google-Smtp-Source: ABdhPJy93A1TQ9FosSD9C4AO5zGxiH0i+N3o/Xp7FuNsUoaEwchGwx7Cf1kwdQ9nDRf6rHDpykMuQA==
X-Received: by 2002:a0c:9064:0:b0:444:45a3:4b1d with SMTP id o91-20020a0c9064000000b0044445a34b1dmr2263970qvo.88.1649925319649;
        Thu, 14 Apr 2022 01:35:19 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm832484qtw.26.2022.04.14.01.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 01:35:19 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id i20so8138816ybj.7;
        Thu, 14 Apr 2022 01:35:18 -0700 (PDT)
X-Received: by 2002:a05:6902:72b:b0:641:c2d1:d01a with SMTP id
 l11-20020a056902072b00b00641c2d1d01amr1080702ybt.6.1649925318481; Thu, 14 Apr
 2022 01:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220414074011.500533-1-herve.codina@bootlin.com> <20220414074011.500533-4-herve.codina@bootlin.com>
In-Reply-To: <20220414074011.500533-4-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 10:35:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
Message-ID: <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> wrote:
> Define that multiple clocks can be present at clocks property.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> @@ -54,7 +54,8 @@ properties:
>        Standard property that helps to define the interrupt mapping.
>
>    clocks:
> -    description: The reference to the device clock.
> +    description:
> +      The references to the device clocks (several clocks can be referenced).

Please describe the clocks, and add the missing "clock-names" property.

>
>    bus-range:
>      description: |

I think it would be better to combine this with [PATCH v2 4/8], as the
additional clocks are only present on RZ/N1.

Then you can easily add json-schema logic to enforce the correct
number of clocks, depending on the compatible value.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
