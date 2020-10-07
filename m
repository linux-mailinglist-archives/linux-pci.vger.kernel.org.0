Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291D0285BC7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJGJTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgJGJTn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 05:19:43 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86246C0613D2
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 02:19:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so1443952lfr.10
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HearCtm5CzMBeIR1tHWuaWK0TC9md3N7NC53VUCWgV0=;
        b=tvUxN56NHfUl5/2EqKur2+5/omgmNucchkaRxEodbK6bpaQJjNKooi1cKy6/DPqoti
         xQS1dAoFvYB8aBcz/kzDREA4vnTD2B01zVEpGBDcgI7/SDexYB04zwEAE44CFU3WS/UZ
         wsS7dGd3b1XMPekBf3XdUa5uLsR2Z/oUydBoVU7VC1rz4bSrNdJw7fIBAUC4lTEbJoGF
         6hAXcK4Lexczm/fx6zvkHbZ3l8JNoh15PmmSDQ4PQ/PP+Xq47/BeSDLSDjGfSVnfr3SM
         hoqML1sRnpG9hSYIGye/ASCyZzynNZZwxVq6swk549j+//v5kRBeuC1SPPNeVv0v7HyG
         HstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HearCtm5CzMBeIR1tHWuaWK0TC9md3N7NC53VUCWgV0=;
        b=SNcl6j9+8bVJfET5TF+4g0b9kpfjYZ48DhJqd6W8w33yrSRZz1cG5ci9qP6fCgN6Wx
         KF7msHXSfSlfu/y0rj5JCpDeI3ZjKcneaTepX9kZtUDs6erlFBhulUtC7NdI3NPZ1XbR
         9FW3OhrfxaPVQEODzdhtcfam7HRmE/Yz7kG5ss2SrpGzVgoCDSyhwRv+ND2lqlPY7+Qq
         /e67G692dDd641e7UZqldE65oLomEbKopw+rs/O4DoCMWJCT7kjxIPvFvs+ZtDqppUe7
         LvZV/bKobQcg/V8iExG5AlCyjTzO/1DkBM1oEvSqVSA2ZufCUrJbejxtE7d5qmIYMNmt
         +Hxg==
X-Gm-Message-State: AOAM5328ztult/3hCW5ysMQrNm5zA7E+cUftyP1WJBgqBj+drCTn+KXL
        GQ60TSpzpsWCdN+8p07JEeZ1qP4pGFqNrCGSw1PuSbakAJGPh43A
X-Google-Smtp-Source: ABdhPJzztxuaghX7mt6AZbNjuI6U2enA74cptLuZ2N1KOPduaNmzcuFfhw0yARzqithV/Y+z1T9IEU7p48uS5wXZCmM=
X-Received: by 2002:ac2:42d8:: with SMTP id n24mr594980lfl.502.1602062380977;
 Wed, 07 Oct 2020 02:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com> <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 11:19:30 +0200
Message-ID: <CACRpkdbTw4UBw02RXX2prju45AsDZqPchhz=gdzsuT-QjhYHVw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> +properties:
> +  compatible:
> +    enum:
> +      - pci1b6f,7023
> +      - pci1b6f,7052

I think it is better to let the PCI driver for the whole hardware in
drivers/usb/host/xhci-pci.c probe from the PCI configuration space
numbers, and then add a gpio_chip to xhci-pci.c.

Thanks!
Linus Walleij
