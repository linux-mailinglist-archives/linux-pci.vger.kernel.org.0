Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A26FC410
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjEIKgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 9 May 2023 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjEIKgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 06:36:02 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D7106E5;
        Tue,  9 May 2023 03:35:49 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-55a829411b5so51867797b3.1;
        Tue, 09 May 2023 03:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628539; x=1686220539;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STRG9z0qGkjgtmp/Ps+FRw09qM+RNYz5SrXCeHI+JvM=;
        b=LnHcvKDYr8O+nD84jiRRtE+nsuRO+Y79Pj9hGS952uKq/vzJW4s357JFbho8d/M5lO
         76X51V1AJwLvAs4/huy8Pg5M8j4JixEE6urk8ikVMbcBXZThu8u9E4RZ8K4V9uQaIz0r
         Mn3xM9XoCbYBnWVWaesGwNPbsCLqU/8se/KmcKnKYeai6Nw6tXRmGB0NTkOqQrIlxxW2
         r+vUBxXNTT7Icz00gucwnSenXBhZ7dcIXC8EoFxlSBgheJ/46Dt0no5jQsoZXt4fQZAo
         2uK6/syaXdXedAipo13eA3yFbN/bY5BQmZ4nuyCJO7ocqtrgYVyLaKAWl95TK+w6NR52
         LFkg==
X-Gm-Message-State: AC+VfDxMdiLc2KDXaNj8unEAVb36p7BNSWRlCBKQ1FC/WcsjFKQO9Ycc
        mzMR/+MCiuYfS5uhBwYKENysHU3h+tqtCA==
X-Google-Smtp-Source: ACHHUZ4pZlGzrTflynDcIgK6hxKFt8Aqe8g8SmveSIhcsigtQrFOUhoAlFdNVE8fnV+ai98Z70b3QQ==
X-Received: by 2002:a81:4602:0:b0:55a:c42:406d with SMTP id t2-20020a814602000000b0055a0c42406dmr15061368ywa.3.1683628539086;
        Tue, 09 May 2023 03:35:39 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id a145-20020a0dd897000000b0055a07c7be39sm3199458ywe.31.2023.05.09.03.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:35:38 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9e27684b53so4982207276.0;
        Tue, 09 May 2023 03:35:38 -0700 (PDT)
X-Received: by 2002:a25:258a:0:b0:b96:e7a6:dbe4 with SMTP id
 l132-20020a25258a000000b00b96e7a6dbe4mr12470821ybl.21.1683628537827; Tue, 09
 May 2023 03:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
 <20230508104557.47889-2-wsa+renesas@sang-engineering.com> <CAMuHMdWGaDT_XGpeVm-915hbxa8-w5303QWg0a0iCjqk998unQ@mail.gmail.com>
 <ZFlD7x99++k3yfE1@kunai>
In-Reply-To: <ZFlD7x99++k3yfE1@kunai>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 May 2023 12:35:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUS56xQbOcRx7kVhL_irQQR2cnDr0Y6p6q8tCjZ2U_dwg@mail.gmail.com>
Message-ID: <CAMuHMdUS56xQbOcRx7kVhL_irQQR2cnDr0Y6p6q8tCjZ2U_dwg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: PCI: rcar-pci-host: add optional regulators
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Wolfram,

On Mon, May 8, 2023 at 8:48 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +  vpcie1v5-supply:
> > > +    description: The 1.5v regulator to use for PCIe.
> >
> > +1.5V is only present on mini-PCIe slots...
>
> Since mini-PCIe is a subset of PCIe, I'd think we can leave the
> description as-is.

Sure, the description is fine.

> > > +
> > > +  vpcie3v3-supply:
> > > +    description: The 3.3v regulator to use for PCIe.
> >
> > ... while +3.3V is present on PCIe, mini-PCIe, and M2 PCIe slots.
> >
> > In addition, normal PCIe slots also have +12V.
> > So I think it would be prudent to add a vpcie12v0-supply property, too.
>
> I agree. I can't test it but it is trivial enough to add 12v support as
> well.
>
> > W.r.t. to the actual naming, I don't know if there's already a (de facto)
> > standard for that?
>
> I couldn't find one and took what I think is the most used pattern. But
> I wasn't entirely sure, this is why the series is still RFC.

Upon second thought, shouldn't these supplies be part of a PCIe
connector subnode, as they are not properties of the PCIe host
controller itself?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
