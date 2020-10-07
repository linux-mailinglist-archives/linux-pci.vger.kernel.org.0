Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91A2868B3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgJGT6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGT6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 15:58:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F98C061755;
        Wed,  7 Oct 2020 12:58:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so3483008eds.3;
        Wed, 07 Oct 2020 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skyCaFa+SYfj0KOVfhGivSwyY27NnZlYEef5BrBJ01I=;
        b=JzmqWCN3pi0BbAp3zspE8DWaL7NiSqzle2xPYtrIKZz3+CHHHGewnLHc8bU24hWjJR
         R3LOLQ6g9BKgpGElmDivt//DJtNT1371tcW43QzCR/2E3Frf1Ap/4VEme3B2xgJSfG7e
         YuNtDfjkcViORxXlj8pD5EzaqTJuIpBBk1G4cEUh1JAvxhL79DYuUvly5sCJs0lKzBdI
         Wj7Fa0HdF4yK/dH4DUIioXfeSoAbKM1GFzoBWV8FYZ7cgSHS9Ko6VDAprxflv5fjB1hk
         1ZgVO44RQcJfW68GsbQSNy2t5s+QXV1GILKcgM7Xv7zIl35vKrHUWAiAzFHPYR2/Y0il
         XeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skyCaFa+SYfj0KOVfhGivSwyY27NnZlYEef5BrBJ01I=;
        b=p1p3woukR/LEhyy7BOXNKZOUBLUvXu7NirBXq9SrjeVUIWoj/o6kHN3QiUDnxzrnX6
         ditMjyz9lnMj0IG4v8c+d6hLig3d3OMMFKr6iz0D3HP4txdyIBu98Xh+OW0Tk1N4TfAZ
         n4r6gfhTuu22cLBe/UFl0PGlj7ifhiCyQnrr6uHrjqSV4wzzzLovi2Ubqz3djGtd7l7d
         pzVV64s/E8B7z9n8D5BCI0C8ISW5MqDqpIK68VxkYKCs2FDUv7RE1uU1Eh4TWtCqklnE
         J1GgFjtBytun/ssdk8jmBKutq3wLhR6gK4lRZgkzH5Mvt94bBLs+r38Vk7M0xV/BQwBU
         xvpA==
X-Gm-Message-State: AOAM530VV1kbjr4oeoMsMujQOyOaoZEYvqdDtLwqHhctH/w43BSAywws
        /pzr+O7O80bKAaKq3lkaEE9Y6WB/qrOFyyNWvuzXj1vG0Vg=
X-Google-Smtp-Source: ABdhPJxHK+pBG7sUNG1398mdCXIoRR4RuCQfil+jnbhNkIi83xhPiU0qQmcBkYjQsz/yZVx0y4egeQdjWmydLbxMVlA=
X-Received: by 2002:a05:6402:1356:: with SMTP id y22mr5218660edw.110.1602100681377;
 Wed, 07 Oct 2020 12:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com> <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com>
In-Reply-To: <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 7 Oct 2020 21:57:50 +0200
Message-ID: <CAFBinCAFDhWp6mgUqyOjdMVBR5oZQVpmVPjhnZs1Xg16tFa0PQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Wed, Oct 7, 2020 at 11:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1b6f,7023
> > +      - pci1b6f,7052
>
> I think it is better to let the PCI driver for the whole hardware in
> drivers/usb/host/xhci-pci.c probe from the PCI configuration space
> numbers, and then add a gpio_chip to xhci-pci.c.
to have everything consistent I will move the binding to
Documentation/devicetree/bindings/usb


Best regards,
Martin
