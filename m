Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96713516D38
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbiEBJXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384150AbiEBJXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 05:23:04 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B83BBC1;
        Mon,  2 May 2022 02:19:32 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id y6so8805587qke.10;
        Mon, 02 May 2022 02:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCJ3sid/SWrVSgupTxU+z71M9FpZSZiTUy8F3hojyaY=;
        b=3Ck8rmY/Pb/AYcIvsnkhstcjePHBY7PII7AU4evK8N8YeJmTryy+LNLVBwUN4WIgJj
         CNEfJ0FCdNsLIdFE3BATtzZVcD2K/h+icW827rVR/vDfnc2YWnqY9SO76a59BHOHoxEh
         h65zzk/EPpLDl9vsU6/09hoy+/fabhCnBokCQB5YKIq/nSx+18LnhzzEXZz3RDfIXqve
         2lojXasRMkoZtfmHz99+7yo7E5vVLMALmX0dUsgcW1S6mQeGbWD0Kihb+LlVSBffrwSf
         z180zAj7MyJ2YqezGgmAtmI11XpMBTkyMAiucR/ZzxjcfqQzqKMYOQWWHMICXrGF/3tR
         PuAQ==
X-Gm-Message-State: AOAM5301zFCkPIxO5YuPxEIwXcd6ILH/84AE60LyT0TW5BJRor8OkRnm
        IJQsnn6k/0ZFAN4taQEu7Mxmf/CAmRE2+w==
X-Google-Smtp-Source: ABdhPJxSC5E+jgB5wmlDGA9l4zmSGZakUMqn/HwDG/Y8K4eYus5uhqzT58zORHu4Kg7nKmw50+iffg==
X-Received: by 2002:a05:620a:240c:b0:69f:c9aa:201b with SMTP id d12-20020a05620a240c00b0069fc9aa201bmr5831022qkn.196.1651483171833;
        Mon, 02 May 2022 02:19:31 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l26-20020ac848da000000b002f39b99f6b7sm3705079qtr.81.2022.05.02.02.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 02:19:31 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i38so24957121ybj.13;
        Mon, 02 May 2022 02:19:31 -0700 (PDT)
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr9190493ybs.365.1651483170866; Mon, 02
 May 2022 02:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com> <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
In-Reply-To: <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 11:19:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
Message-ID: <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Sun, May 1, 2022 at 10:51 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/04/2022 15:41, Herve Codina wrote:
> > Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> > RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> > present in the R-Car Gen2 family.
> > Compared to the R-Car Gen2 family, it needs three clocks instead of
> > one.
> >
> > The 'resets' property for the RZ/N1 family is not required since
> > there is no reset-controller support yet for the RZ/N1 family.
>
> This should not be a reason why a property is or is not required. Either
> this is required for device operation or not. If it is required, should
> be in the bindings. Otherwise what are you going to do in the future?
> Add a required property breaking the ABI?

The problem is that there are no bindings for the reset controller
(actually the reset controller feature of the system-controller) yet.
Yeah, we can just add #reset-cells = <1> to the system-controller
device node, but we cannot add the actual resets properties to the
consumers, until the actual cell values are defined.

> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
