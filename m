Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B09363976
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDSCoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Apr 2021 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhDSCoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Apr 2021 22:44:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B4C061760
        for <linux-pci@vger.kernel.org>; Sun, 18 Apr 2021 19:43:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a18so1341469qtj.10
        for <linux-pci@vger.kernel.org>; Sun, 18 Apr 2021 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sx7h0f2GZxD3nAjPPDDUPLWWYJCyRbQKUNjPW59daPo=;
        b=KwlvFeQWVR/uxKtcJ2SY+8qVoqs3VJGOGaLKPkos/++5xUzVOq/KPh47X/sAZdvj/V
         qCDBiJXTvRK8f8nGQTtHqW8pYwwukQRknOp5cT93YwADCUUwAIephISjfWzAhpvwbSl5
         6hcWmhf0MkhR4HYPV2vAZIQ6MUOZ+UOpPvqCJoIc3v+5fOLmHzvZRmh3GV9TrKQ4SWLW
         j8dBgB4u63HgjaiJjP8X6ExOJRPEGZTQflnt3uKdk5Dwec9k3FrdBC3b9vfyXEjNN55Y
         +9GeDymJGoZS9Uanohn4SD7WUaR6sazddH9qZtPcwasUI0t40lW6UyAeGBtiduaEikWx
         ElSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sx7h0f2GZxD3nAjPPDDUPLWWYJCyRbQKUNjPW59daPo=;
        b=BxKUMRjWV203ozSF9A7CdnJw0DGkeZ8IuvIGrNA9psTDpB0BpIFHj3lHX8k8Abz58W
         bvVbcVFxJMmggngv3MgXYEv6rK5p3sICA/SVnpffFGmL4fBU+O3D/CVNyL1o7nnKOZxb
         DrCv3lzvummb2v+ubm6zPmOU5ehSd2Xpas4kEyRZ/jTgY09rNcrJakbgE49QP9HMHf5q
         Z40SVQIjjo+c2lkXa4vDtKKNO5JS8mgkZhg1gjCCid/6eYmvUTVBvfJGZ4bbps9BErvP
         4qZof7NGVT8AyRurSpuFpqKILsnuSTp3US4V/oYdf/znI2QxeEwDMxzeLNWukRNgFNR9
         nZzA==
X-Gm-Message-State: AOAM530tqi8I1IrOvgEoT+ejinGU6pHAe7mlQq9/mGzorjmobOPM8alK
        qojkyLK8yFsevB/38k6YMFApdJP5yEW22XtjH1ZPEA==
X-Google-Smtp-Source: ABdhPJzVmkhzl9leyhZ9ljuuMImwewyFcTNGBbjtAcCIixr8PrGFghNigQ+fWIFC9V5deD3rl4jtmuriLP4mGsSeH+Q=
X-Received: by 2002:ac8:502:: with SMTP id u2mr9576775qtg.218.1618800216887;
 Sun, 18 Apr 2021 19:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <17994571deaf703e65ece7e44c742f82c988cf39.1615954046.git.greentime.hu@sifive.com>
 <mhng-30f397a9-b7af-4247-baa0-d8e1d30c6b97@palmerdabbelt-glaptop>
In-Reply-To: <mhng-30f397a9-b7af-4247-baa0-d8e1d30c6b97@palmerdabbelt-glaptop>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 19 Apr 2021 10:43:28 +0800
Message-ID: <CAHCEehL+3ZxKv_nxSR6s0vWEFtNHSYOX_dHrpfGq1hM8xwhHRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] riscv: dts: Add PCIe support for the SiFive
 FU740-C000 SoC
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=888:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 17 Mar 2021 23:08:13 PDT (-0700), greentime.hu@sifive.com wrote:
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 34 ++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/bo=
ot/dts/sifive/fu740-c000.dtsi
> > index d1bb22b11920..d0839739b425 100644
> > --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > @@ -158,6 +158,7 @@ prci: clock-controller@10000000 {
> >                       reg =3D <0x0 0x10000000 0x0 0x1000>;
> >                       clocks =3D <&hfclk>, <&rtcclk>;
> >                       #clock-cells =3D <1>;
> > +                     #reset-cells =3D <1>;
> >               };
> >               uart0: serial@10010000 {
> >                       compatible =3D "sifive,fu740-c000-uart", "sifive,=
uart0";
> > @@ -288,5 +289,38 @@ gpio: gpio@10060000 {
> >                       clocks =3D <&prci PRCI_CLK_PCLK>;
> >                       status =3D "disabled";
> >               };
> > +             pcie@e00000000 {
> > +                     #address-cells =3D <3>;
> > +                     #interrupt-cells =3D <1>;
> > +                     #num-lanes =3D <8>;
> > +                     #size-cells =3D <2>;
> > +                     compatible =3D "sifive,fu740-pcie";
> > +                     reg =3D <0xe 0x00000000 0x1 0x0
> > +                            0xd 0xf0000000 0x0 0x10000000
> > +                            0x0 0x100d0000 0x0 0x1000>;
> > +                     reg-names =3D "dbi", "config", "mgmt";
> > +                     device_type =3D "pci";
> > +                     dma-coherent;
> > +                     bus-range =3D <0x0 0xff>;
> > +                     ranges =3D <0x81000000  0x0 0x60080000  0x0 0x600=
80000 0x0 0x10000        /* I/O */
> > +                               0x82000000  0x0 0x60090000  0x0 0x60090=
000 0x0 0xff70000      /* mem */
> > +                               0x82000000  0x0 0x70000000  0x0 0x70000=
000 0x0 0x1000000      /* mem */
> > +                               0xc3000000 0x20 0x00000000 0x20 0x00000=
000 0x20 0x00000000>;  /* mem prefetchable */
> > +                     num-lanes =3D <0x8>;
> > +                     interrupts =3D <56 57 58 59 60 61 62 63 64>;
> > +                     interrupt-names =3D "msi", "inta", "intb", "intc"=
, "intd";
> > +                     interrupt-parent =3D <&plic0>;
> > +                     interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > +                     interrupt-map =3D <0x0 0x0 0x0 0x1 &plic0 57>,
> > +                                     <0x0 0x0 0x0 0x2 &plic0 58>,
> > +                                     <0x0 0x0 0x0 0x3 &plic0 59>,
> > +                                     <0x0 0x0 0x0 0x4 &plic0 60>;
> > +                     clock-names =3D "pcie_aux";
> > +                     clocks =3D <&prci PRCI_CLK_PCIE_AUX>;
> > +                     pwren-gpios =3D <&gpio 5 0>;
> > +                     perstn-gpios =3D <&gpio 8 0>;
> > +                     resets =3D <&prci 4>;
> > +                     status =3D "okay";
> > +             };
> >       };
> >  };
>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> I'm happy to take these all through the RISC-V tree if that helps, but
> as usual I'd like reviews or acks from the subsystem maintainers.  It
> looks like there are some issues so I'm going to drop this from my
> inbox.

Hi Palmer,

Since the subsystem maintainer has pick the first 5 patches to his
branch, would you please help to pick the 6th patch of version 6?
Thank you. :)

https://www.spinics.net/lists/linux-clk/msg57213.html
https://patchwork.kernel.org/project/linux-riscv/patch/20210406092634.50465=
-7-greentime.hu@sifive.com/
