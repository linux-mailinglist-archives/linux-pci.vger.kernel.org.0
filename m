Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC5331FB7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 08:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCIHXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 02:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCIHX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 02:23:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B2C06175F
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 23:23:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t4so12134414qkp.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oqO7RxhDDe9vwKp/BB6AgPJShCvp9ZtWoA6Sh+EENcs=;
        b=Ud3PEmS7F/HL1ClBM5fvcc71dFxIGph/JiVvIxFtoAACgUhUdwd3d1JDpZAWyryI4/
         H00WQUh6kjUPafd2ThBYw9ZtS34nshFF5tWtZGNZ1EgBfQTdUN3XYkl7kzREpnyavn71
         TK+awh0xLrq0MfmLyTt1/Y13AGmNR3ZBJ15axGl3gd82rU/QKEwN/OMs+2mvmBscgDVy
         BZeZLu7f0meD98GsZFypmTNkG5/8iycndvsukzJpMwALx2+3+j4rat0gZlbufwYXVt82
         vFlOJutYcZmd4oW9S7VQwWQPDoXikWAturt0OVgGLzb5SQ+c5k0WpbbIHyWni6dbwUGq
         Kaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oqO7RxhDDe9vwKp/BB6AgPJShCvp9ZtWoA6Sh+EENcs=;
        b=VN2J7rJNWO8OwX5EN2Gsysh8KYBKMqgxKE5XCfRqa9KDVR1I153wjPB8Zf4nOC9VkU
         sd9G6B4aAQuBZ+cxxNjO4ipM1ViTcRxvkZv6pbT64ZBGrVVKtjVcoVwOJv5eLbycAl1S
         MY1n2gEkP6eHUPNPGB9P9kvUHManhcNc0N5FhykRRJQwYaH1kf4So+J+BtyjWRBoozIr
         td8nrFaiyF/EpC5XljfLorrAybZieZY+V8rEDEAd1q+JLkb1LZL4WVWRm9oVWO2b3U6U
         +NTBzoxjiSO+aJJs2536DRzGY8GWEtzOaW/5ZIlvTXouG498abFvYmkAgX5kRrwr18xv
         fazA==
X-Gm-Message-State: AOAM5317HLzk4vla7gK02ji4bQ4ZeF5cVlSW8CIXIheBiX3vn9fO6z2c
        2eE8ViCKy5wnLrYnXtn0M9xMqNIFJisnk1nTLb97TA==
X-Google-Smtp-Source: ABdhPJwtYPYtApR4EueplUtwNsjPnC8GSeKATOROKTHuWvVYiLX1g7t/b1oVki8yJ8MfrVSGPDDRQGIb0ZVn6cn5YHw=
X-Received: by 2002:a37:66cd:: with SMTP id a196mr16664749qkc.374.1615274606652;
 Mon, 08 Mar 2021 23:23:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614681831.git.greentime.hu@sifive.com> <e2bd7db9db3c196b9b0399f0655a56939a0f3d62.1614681831.git.greentime.hu@sifive.com>
 <81c45bf40b397b57343f159baae896528fa32d89.camel@pengutronix.de>
In-Reply-To: <81c45bf40b397b57343f159baae896528fa32d89.camel@pengutronix.de>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 9 Mar 2021 15:23:14 +0800
Message-ID: <CAHCEehK3P7jXq-v_xVm-0+BQsugG21VgjU0teyuUgANyR5ErKA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] clk: sifive: Use reset-simple in prci driver for
 PCIe driver
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Philipp Zabel <p.zabel@pengutronix.de> =E6=96=BC 2021=E5=B9=B43=E6=9C=884=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:58=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 2021-03-02 at 18:59 +0800, Greentime Hu wrote:
> > We use reset-simple in this patch so that pcie driver can use
> > devm_reset_control_get() to get this reset data structure and use
> > reset_control_deassert() to deassert pcie_power_up_rst_n.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  drivers/clk/sifive/Kconfig       |  2 ++
> >  drivers/clk/sifive/sifive-prci.c | 14 ++++++++++++++
> >  drivers/clk/sifive/sifive-prci.h |  4 ++++
> >  drivers/reset/Kconfig            |  3 ++-
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> > index 1c14eb20c066..9132c3c4aa86 100644
> > --- a/drivers/clk/sifive/Kconfig
> > +++ b/drivers/clk/sifive/Kconfig
> > @@ -10,6 +10,8 @@ if CLK_SIFIVE
> >
> >  config CLK_SIFIVE_PRCI
> >       bool "PRCI driver for SiFive SoCs"
> > +     select RESET_CONTROLLER
> > +     select RESET_SIMPLE
> >       select CLK_ANALOGBITS_WRPLL_CLN28HPC
> >       help
> >         Supports the Power Reset Clock interface (PRCI) IP block found =
in
> > diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifi=
ve-prci.c
> > index baf7313dac92..925affc6de55 100644
> > --- a/drivers/clk/sifive/sifive-prci.c
> > +++ b/drivers/clk/sifive/sifive-prci.c
> > @@ -583,7 +583,21 @@ static int sifive_prci_probe(struct platform_devic=
e *pdev)
> >       if (IS_ERR(pd->va))
> >               return PTR_ERR(pd->va);
> >
> > +     pd->reset.rcdev.owner =3D THIS_MODULE;
> > +     pd->reset.rcdev.nr_resets =3D PRCI_RST_NR;
> > +     pd->reset.rcdev.ops =3D &reset_simple_ops;
> > +     pd->reset.rcdev.of_node =3D pdev->dev.of_node;
> > +     pd->reset.active_low =3D true;
> > +     pd->reset.membase =3D pd->va + PRCI_DEVICESRESETREG_OFFSET;
> > +     spin_lock_init(&pd->reset.lock);
> > +
> > +     r =3D devm_reset_controller_register(&pdev->dev, &pd->reset.rcdev=
);
> > +     if (r) {
> > +             dev_err(dev, "could not register reset controller: %d\n",=
 r);
> > +             return r;
> > +     }
> >       r =3D __prci_register_clocks(dev, pd, desc);
> > +
>
> Accidental whitespace?
>
> Otherwise,
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thank you, Philipp.
Yes, it is an accidental whitespace. I'll remove it in my next version patc=
h.
