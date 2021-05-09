Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD13778B3
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEIVdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIVdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 17:33:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82529C061573
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 14:31:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p12so18392029ljg.1
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoXosc9+XwGG0DnYOKcmTBKa/Wh4sBv4A+cqg6uStcg=;
        b=cHKmZp27GIV6lvtgp+mIkhssli14Aj1rYa8NofrGhkrgYd/9ZKIOGkB/nvAE8dzReb
         G4XN87hF/bwnqIBUkJnQwza4CADN9k4WSAMJvtPyTtjxXaLg+F4RiGq4EtlOZYwTSPZJ
         w1fnyEVYDzcl+1/E7v7/WIhSCcDtNO7KMd3B2RQ03B0da9SM1lLUxP67VWoj/WwxVsdp
         HfZz+9TXkRjKOTagR8u08sHpz1Is9hYgQGplaQHTMjjcDkAAlUuQGydStYU33p9u7/5A
         jZsUHtZANQx8BCGSiR9Jf1DIqix3SiltA4dBm3GgphlqqAoDe7vV2WiYxwVCUd9OY8qI
         Z0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoXosc9+XwGG0DnYOKcmTBKa/Wh4sBv4A+cqg6uStcg=;
        b=fmYFPYWbKXhYkLd89C6lVccsfQPjBvVsOu1E9SFglOllmZ+s5J7oPmv22WqM2N379K
         TN4+QJKE+gMLTjpcVVsmZzBnkSXd+RciPv2sMQE14i9vmq0KgNWYpoHokCfOtADcx8/g
         wiPKptIGtllk73LePP2Us6ZlcT8ERmn3+qAMiwNhA3rljnpbgJwwa1ZdV+mJm6gK4pNl
         /r8Khdxm01O7RjZyRnvA3bo0Q7HFR5Z7YEqAumo8k6AY0ipls0Nc1FUuodGOubSjjnOz
         YxQ0sJ6+3DW4UuQjVojeSsFFq7syHwHDxNGnWnTdYFLes8n8Wv0/eO0RwOBNd6PW0Wts
         r6Cg==
X-Gm-Message-State: AOAM532BhRVIm8q61FoQj3HGn+58HvoTEepyVMHBG9FUPybg8wtu4T4m
        bnYtq+B8n4SySOWLWGXOUJIquJSgA+W6+q2HFOo/4Q==
X-Google-Smtp-Source: ABdhPJxv2Khh03qPjoVKn6TmaQ38/XVuKElIbxEctXxRSU+AmHrnIyUaPHrlwc6nNd48Am4ufY98TTKQJnKfzVIwz6M=
X-Received: by 2002:a2e:814d:: with SMTP id t13mr16973194ljg.467.1620595909066;
 Sun, 09 May 2021 14:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210503211649.4109334-1-linus.walleij@linaro.org>
 <20210503211649.4109334-4-linus.walleij@linaro.org> <CAK8P3a1ab_hvW_9_vBawhgsV3-W1F-qWm5KJ_ycuHmpVGzzz+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1ab_hvW_9_vBawhgsV3-W1F-qWm5KJ_ycuHmpVGzzz+Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 23:31:37 +0200
Message-ID: <CACRpkdZstp7Yi6Lke16yFGSkFMfb12LC=cqY5T3=YGd_bO-mcQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: ixp4xx: Add device tree bindings for IXP4xx
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 4, 2021 at 2:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 3, 2021 at 11:16 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - intel,ixp42x-pci
> > +          - intel,ixp43x-pci
> > +    description: The two supported variants are ixp42x and ixp43x,
> > +      though more variants may exist.
>
> These are still wildcard names, better pick a real soc identifier
> such as "ixp425" instead of "ixp42x" in case there are differences
> after all.

In general I agree. But when not even the vendor think they should
be held apart that is another thing. Even the official Intel
documentation uses these names:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/ixp42x-product-line-network-processors-datasheet.pdf
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/ixp43x-product-line-network-processors-datasheet.pdf

The differences seem to be very small and related to the NPE
and page 23 in the 42x documentation makes no difference
between them.

I guess I will change it if you insist, but none of the other
drivers have this fine-grained compatible strings.

> > +        <0x0800 0 0 1 &gpio0 11 3>, /* INT A on slot 1 is irq 11 */
> > +        <0x0800 0 0 2 &gpio0 10 3>, /* INT B on slot 1 is irq 10 */
> > +        <0x0800 0 0 3 &gpio0 9  3>, /* INT C on slot 1 is irq 9 */
> > +        <0x0800 0 0 4 &gpio0 8  3>, /* INT D on slot 1 is irq 8 */
> > +        <0x1000 0 0 1 &gpio0 10 3>, /* INT A on slot 2 is irq 10 */
> > +        <0x1000 0 0 2 &gpio0 9  3>, /* INT B on slot 2 is irq 9 */
> > +        <0x1000 0 0 3 &gpio0 8  3>, /* INT C on slot 2 is irq 8 */
> > +        <0x1000 0 0 4 &gpio0 11 3>, /* INT D on slot 2 is irq 11 */
> > +        <0x1800 0 0 1 &gpio0 9  3>, /* INT A on slot 3 is irq 9 */
> > +        <0x1800 0 0 2 &gpio0 8  3>, /* INT B on slot 3 is irq 8 */
> > +        <0x1800 0 0 3 &gpio0 11 3>, /* INT C on slot 3 is irq 11 */
> > +        <0x1800 0 0 4 &gpio0 10 3>; /* INT D on slot 3 is irq 10 */
>
> Is this different from the default swizzling rules? You normally
> only have to provide the irqs for the bus once.

The different board files for ixp4xx does the swizzling in different
ways.

The NSLU2 rotates only the top 3 IRQs and looks like this:

+                       /*
+                        * Taken from NSLU2 PCI boardfile, INT A, B, C
swizzled D constant
+                        * We have slots (IDSEL) 1, 2 and 3.
+                        */
+                       interrupt-map =
+                       /* IDSEL 1 */
+                       <0x0800 0 0 1 &gpio0 11 3>, /* INT A on slot 1
is irq 11 */
+                       <0x0800 0 0 2 &gpio0 10 3>, /* INT B on slot 1
is irq 10 */
+                       <0x0800 0 0 3 &gpio0 9  3>, /* INT C on slot 1
is irq 9 */
+                       <0x0800 0 0 4 &gpio0 8  3>, /* INT D on slot 1
is irq 8 */
+                       /* IDSEL 2 */
+                       <0x1000 0 0 1 &gpio0 10 3>, /* INT A on slot 2
is irq 10 */
+                       <0x1000 0 0 2 &gpio0 9  3>, /* INT B on slot 2
is irq 9 */
+                       <0x1000 0 0 3 &gpio0 11 3>, /* INT C on slot 2
is irq 11 */
+                       <0x1000 0 0 4 &gpio0 8  3>, /* INT D on slot 2
is irq 8 */
+                       /* IDSEL 3 */
+                       <0x1800 0 0 1 &gpio0 9  3>, /* INT A on slot 3
is irq 9 */
+                       <0x1800 0 0 2 &gpio0 11 3>, /* INT B on slot 3
is irq 11 */
+                       <0x1800 0 0 3 &gpio0 10 3>, /* INT C on slot 3
is irq 10 */
+                       <0x1800 0 0 4 &gpio0 8  3>; /* INT D on slot 3
is irq 8 */

Yours,
Linus Walleij
