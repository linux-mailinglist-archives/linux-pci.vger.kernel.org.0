Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9496A41CC4A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbhI2THi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbhI2THh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 15:07:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F005C061765
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 12:05:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e15so14948931lfr.10
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ny2+77Uus4H/nPXbEE4fOfi5YTib/j8MfG7t5iU/Qjk=;
        b=u6OGwlgD9IMdZ2HdoL8lkGBaqUb5DoK6/ym/uunK23jP7PeZNuys4OF0DfZjcc71mS
         wSaga3Tz+eoQfYV0I77DEE+PbtHypvTZ/hqRMk541PeMfXxMoxuGqlNVo6GKIhgqBbtm
         w4CE6GxIgsoXcTdf0P78xhEPcZsN2n4qskMRL9Pso9qTEa0nE66xFL/I5iPwRYB5XEyZ
         ZI8Rbt2eumS1xSR4toHy0Z7Aqwi84+S12v0eY3n9N7BiGO3yEUodzVmc6BbfSI3q3Syx
         EhFNtc07A3S93kgvOonDkfZaLwDimfeSFWceB/mxA5hxY8a6ldJ3f52N3kCwWFaHdbDI
         bpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ny2+77Uus4H/nPXbEE4fOfi5YTib/j8MfG7t5iU/Qjk=;
        b=PsuJRxdVDsniEbuVVxyDDL9qOe+J+ETKlxc2eSHdgdbcYQStjv0ZCXCvxDNyAny89g
         9G0ptVZsuHuKAOuPaCXj/S5OgRgHde/rwv11XCoDWwHERe0pEHiLvZ+5wmlh+b4VXFG5
         kh6OrbGhNGCousHT3fWTopdQiRjobBQp1Wfxi6P3Kj9oCr4oN+6V66ru/OxRbDyGkEC/
         cKVsoy+gc+AY1y2VRoVFl6JZQtJM0r/e6tHT1pVhLR/pM7IKXRbqSEziOcVg5y+y61mn
         6/nM2NaOS29YgmHfrPTgTy5eX7huo5byNU7z75iCuzHbhdQ5NqAlnIE3zfXQeB5c9bf+
         4wXw==
X-Gm-Message-State: AOAM531pGZxjVyQXohzJI5qIf7nKAJ07Yq3igX1MKRKdC6QaXu3qYzP/
        4nLrFKddtN3RATxnH1wXa7fVHBU3UiJiNnRL7lgitg==
X-Google-Smtp-Source: ABdhPJyqcID0Rhrbbe0OvfTzDp/RzSDgD4HnmlSaEBRo17fjtzsvHgiue0dF/BTOtdBw+Qj5ZU01/pfPX32AilRT4+s=
X-Received: by 2002:a2e:8011:: with SMTP id j17mr1513715ljg.145.1632942354388;
 Wed, 29 Sep 2021 12:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20210929163847.2807812-11-maz@kernel.org>
In-Reply-To: <20210929163847.2807812-11-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Sep 2021 21:05:42 +0200
Message-ID: <CACRpkdaXbrmvoQQNRdyv6rJ+dHYAKMN+J_sc-3_c1d6D2dsfbQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] arm64: apple: Add pinctrl nodes
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 6:56 PM Marc Zyngier <maz@kernel.org> wrote:

> From: Mark Kettenis <kettenis@openbsd.org>
>
> Add pinctrl nodes corresponding to the gpio,t8101 nodes in the
> Apple device tree for the Mac mini (M1, 2020).
>
> Clock references are left out at the moment and will be added once
> the appropriate bindings have been settled upon.
>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210520171310.772-3-mark.kettenis@xs4all.nl
(...)
> +               pinctrl_ap: pinctrl@23c100000 {
> +                       compatible = "apple,t8103-pinctrl", "apple,pinctrl";
> +                       reg = <0x2 0x3c100000 0x0 0x100000>;
> +
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&pinctrl_ap 0 0 212>;

In other discussions it turns out that the driver is abusing these gpio-ranges
to find out how many pins are in each pinctrl instance. This is not the
idea with gpio-ranges, these can be multiple and map different sets,
so we need something like

apple,npins = <212>;
(+ bindings)

or so...

Yours,
Linus Walleij
