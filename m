Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0A2DFF9D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLUSWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 13:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLUSWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 13:22:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9833C0613D6;
        Mon, 21 Dec 2020 10:21:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so25880887lfc.8;
        Mon, 21 Dec 2020 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWyYMYoogTI0qEcPT7ewbmd4Di2kxWT27aivbJmhx28=;
        b=c8IRniwyiglKPVZFlpYSUzsKnpyYHZUumx0BgM9yzOuWuh/xrwae2gFez/R6GkI4T2
         Gk2dN+mCH5LKqsnlmg53XF6BKZTCYvssMmXchhIb2I1pWNWhuMMU32wxNZkI56NRLR8n
         rN185Qyp+QL7SFnNV1zfBvGedZq5jjF0pbxRYx+TCd5bGdr3H9guwM1EdVS7GeiZhDwL
         vUj2GwTwqAj242pHOCeS3LoVckq0l8MnXm73bPMIWTWsAqlUQTyl9QuQnG0pDMBMX/Op
         I0m+SX7i/ABxCA1L2er3Kr1vKQvKnFqqiV0tt5ufh/7onCwGkoDn6IMt74Yoc0EFhH54
         UiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWyYMYoogTI0qEcPT7ewbmd4Di2kxWT27aivbJmhx28=;
        b=jQ5J9NzILOP2ruarW/u2dJ5duPvTvmKxugyuwH9Xz1I5BM+cKDX7hNTQDxHh38fSyB
         2la7paFUWki2/nDt8J1ln05Uv6lByeFfnyVORDukI3onWAUU0mGb6zAjKYGGpJK+M8IT
         A44+WkOMMWGcuPFNepuYjvU8HDp8gmg7SKVPiUucOJYq14AUCVE+zdOy8TtlnHfrMbb1
         J2nHkBigxJripd1lI2xo9cKpHe6WkHfOMJC8Vuva9iskBJFgRmKNUOV8n8GKPnRDnVG2
         S1V6rB2RRiA9NWWW22OHntCsu3KEMEmeINyExKQwQ3Fmd4V+wo4qwcZ2w4eNS4yMHfp1
         RoJw==
X-Gm-Message-State: AOAM533jgeMPe+brDq2E6YBcJKSOf60RpOJRzZsE5xSalTb1pZRptOC0
        DmrAXIpOt+CzirK1GS7IUvM6Oi7Ev3mQwbeimWkqJoqbEaI=
X-Google-Smtp-Source: ABdhPJxU8ZS9Uqf73qEiCIFLa3Wey/Dnx2XDW3bpW4IPhdA/deXrAGBCmmPpxsiN47g/sORvF4vuVoBnwSS1EL7P3wE=
X-Received: by 2002:a17:906:6c8b:: with SMTP id s11mr15761117ejr.187.1608564530691;
 Mon, 21 Dec 2020 07:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-4-martin.blumenstingl@googlemail.com>
 <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com> <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com>
In-Reply-To: <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 21 Dec 2020 16:28:39 +0100
Message-ID: <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
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

On Wed, Oct 7, 2020 at 9:44 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > As noted on the earlier patches I think this should be folded into the
> > existing XHCI USB driver in drivers/usb/host/xhci-pci.c or, if that
> > gets messy, as a separate bolt-on, something like
> > xhci-pci-gpio.[c|h] in the drivers/usb/host/* directory.
> > You can use a Kconfig symbol for the GPIO portions or not.
> OK, I will do that if there are no objections from other developers
> I am intending to place the relevant code in xhci-pci-etron.c, similar
> to what we already have with xhci-pci-renesas.c
I tried this and unfortunately there's a catch.
the nice thing about having a separate GPIO driver means that the
xhci-pci driver doesn't need to know about it.

I implemented xhci-pci-etron.c and gave it a Kconfig option.
xhci-pci is then calling into xhci-pci-etron (through some
etron_xhci_pci_probe function).
unfortunately this means that xhci-pci now depends on xhci-pci-etron.
for xhci-pci-renesas this is fine (I think) because that part of the
code is needed to get the xHCI controller going
but for xhci-pci-etron this is a different story: the GPIO controller
is entirely optional and only used on few devices

my goal is (at some point in the future) to have the GPIO driver in OpenWrt.
I am not sure if they would accept a patch where xhci-pci would then
pull in the dependencies for that Etron controller, even though most
boards don't need it.

Please let me know if you have any idea on how to solve this.


Best regards,
Martin
