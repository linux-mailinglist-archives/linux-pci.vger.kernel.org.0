Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16634DF72
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 05:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhC3Dge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhC3Dg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 23:36:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F1C061764
        for <linux-pci@vger.kernel.org>; Mon, 29 Mar 2021 20:36:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t16so7503766qvr.12
        for <linux-pci@vger.kernel.org>; Mon, 29 Mar 2021 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5oFbwfLQwyYfYwndfNuhqzfmnicAmT4eTuezCa87hZ8=;
        b=Ig+y6Y+c1gyTxgnPBQWPhpOyXg4OoXKv2BE4qr6DHkGfLyEyHrKOUH7MGn1otpkWcN
         kyE/XgUxXw2odCG9cs8Z01SbUYyCaZ5Lu35u7upzKgWerIlCX9tcG+ej8dGbF4oft59o
         Jz45nZZMBILlzNrBpaIkRVJbA0/irRVXLZ8M5ZS6fbuk1zvqLF+xmgeATsd8G2M9wchi
         ZqQaXZAQqhmisluHGosx2pBeGVINB4/GAWUybfaWEiIDOJmmYrmqzWrCWg05rXXqsEwA
         DRvVz8/su4/18C7RTUF8HDL18/u0ZvAZd8OvyXlYSmkfecn/kES13pwqea31yuVPL438
         0pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5oFbwfLQwyYfYwndfNuhqzfmnicAmT4eTuezCa87hZ8=;
        b=NF91fAhJewuIG3k9FRnfGeIUYWVtP767owMXkFyD6VP4pFXdfvsjdbfLa67/WXDBiS
         DZ0luFmwTzcUOVRaPOhuSol5AzO5I8ns+2nAehqoRBLai/33+0QzESM2UM+xwFkRoxjv
         r41IzojCNNZuDvkBefJ8yX8fPtsm2siZ4Gw/x61/UoMK8ncsbsgubjfgiy89d0lpHOek
         48W4HlnAd9aEqt3J7OwHQ3gXYtqo7jDw1u0MrKW2KU+P2hFPsD6EG1DQNZhIIB1dnOoy
         ofPlZu8Xlz+BnNFizhglP9m72bbTS5SIfcajaSN3Hle6YqXA6DGrTa9lO4UwJCRtPAno
         UV4w==
X-Gm-Message-State: AOAM5300M49rH6bsakZBdHZRRzagVhP6UuJGYY1oixGoyVfisGdTRcvP
        h+TzNz9NrVQvTrpRYrQWOZjkHhfhfqQC6yiJpqFuqw==
X-Google-Smtp-Source: ABdhPJycQJX/y0PAtsFp+YXjKCTZ+dLVuREDX7kiJ+wyKRjUQUcZEbZpXPSdS3GtQqa6UBU6KpvoUU+fWG5o791GvQ0=
X-Received: by 2002:a0c:e9c7:: with SMTP id q7mr28188265qvo.7.1617075384531;
 Mon, 29 Mar 2021 20:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615954045.git.greentime.hu@sifive.com> <91d016e59bab9d9175168a63e7bcd81fdb69b549.1615954046.git.greentime.hu@sifive.com>
 <161704524201.3012082.13807741329367593907@swboyd.mtv.corp.google.com>
In-Reply-To: <161704524201.3012082.13807741329367593907@swboyd.mtv.corp.google.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 30 Mar 2021 11:36:12 +0800
Message-ID: <CAHCEehL63aJQPA3DdRCa3pZHWX3DH9ktgKbo1+nD=KWxADsogA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clk: sifive: Use reset-simple in prci driver for
 PCIe driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     alex.dewar90@gmail.com, Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Erik Danie <erik.danie@sifive.com>,
        hayashi.kunihiko@socionext.com, Bjorn Helgaas <helgaas@kernel.org>,
        hes@sifive.com, jh80.chung@samsung.com, khilman@baylibre.com,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lorenzo.pieralisi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        vidyas@nvidia.com, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Quoting Greentime Hu (2021-03-17 23:08:09)
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 71ab75a46491..f094df93d911 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -173,7 +173,7 @@ config RESET_SCMI
> >
> >  config RESET_SIMPLE
> >         bool "Simple Reset Controller Driver" if COMPILE_TEST
> > -       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REAL=
TEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
> > +       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REAL=
TEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC || RISC=
V
>
> This conflicts. Can this default be part of the riscv defconfig instead?
>

Maybe I should remove this since it has been selected by CLK_SIFIVE_PRCI?

 config CLK_SIFIVE_PRCI
        bool "PRCI driver for SiFive SoCs"
+       select RESET_CONTROLLER
+       select RESET_SIMPLE

> >         help
> >           This enables a simple reset controller driver for reset lines=
 that
> >           that can be asserted and deasserted by toggling bits in a con=
tiguous,
> > @@ -187,6 +187,7 @@ config RESET_SIMPLE
> >            - RCC reset controller in STM32 MCUs
> >            - Allwinner SoCs
> >            - ZTE's zx2967 family
> > +          - SiFive FU740 SoCs
> >
> >  config RESET_STM32MP157
> >         bool "STM32MP157 Reset Driver" if COMPILE_TEST
