Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3245B21726
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfEQKog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 06:44:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35258 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfEQKog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 06:44:36 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so11236706ith.0
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2019 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ae6y0KuXzMG1pHLjgX5VAMMTwD/mpdbSQHyUYqpGa1Y=;
        b=R6RUDRe47ZibIlkhxQWfsIgH9dt5pFYOUAFW/3Asfdh4QE7ekEXvUMeji89niTUt1k
         ThSHvMS8k3bXzi1VUy39vktMv6CElxov+TYUYhnWCWo/JeHIl+5X5uTCE/JPXOr9SNxF
         itX9zP/rxln7zlf7HwFmVYDMS5/xp2TFIkV0GGNN+/7PfpTnpEPE+hJBb0z/BNOLkuD8
         fM8SBe/WyYf0Wg2moOirFS03wLy6/d548Y2nMjbiOokDeRXQUbUn7dr6gtDP/bnIa6mx
         aaatnT+JDGwhVfUdZh/oAQz/iZ67xf1VLuE9Sq/dNCVBEWfSOEzycF2eMKOKgKqVT9/q
         Fw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ae6y0KuXzMG1pHLjgX5VAMMTwD/mpdbSQHyUYqpGa1Y=;
        b=cPfNGdkdzeNTU/g1RmzHdujk7iitxwHBMxX20lroX9Kp7COxmphSg5CspFNf/4X1SQ
         yTncOvOhXN6RVqiks+TcCtYNiAMuy/kdTFo8gNA43wEiCQb9K6UczPpdfmDGO1w+eASw
         gwAe7p8CJsdCj2+btwY7bk1/Lf3jMQwwo9j39Q3P7NYmYVuOZB6i6TxJK4ODjrRxIOFV
         LKIMhABkrGp3FSXfPjUEBssdGWe1i6M9oI1AtQekAm5toU5Ug/DCWO0AIWp7HzJUJE+L
         Ulgc3VwLE1MR24E0AgqgKbQ3O1bOAtDbbzya0haxvbJnFmfhfoJmSwhj3H3yIfNHD3EA
         3u8A==
X-Gm-Message-State: APjAAAUugYlZoBuIsTL2qZbrXu6acldFoUkB2qB8GBXBWVHWKf+zmE+0
        rrwQwLuDFWcJsI3v8Lwa/FQZ5j3LA1XcPmGb8mE2Jg==
X-Google-Smtp-Source: APXvYqx3JP27Nk1tvOQBMDUThEQjHMC4TS5L3KtmWKuKzLoARJahORDrcr3fbLBY/dMbMzQj6L5PkULqhdgPoVo6Vr4=
X-Received: by 2002:a02:1dc7:: with SMTP id 190mr34241024jaj.62.1558089874890;
 Fri, 17 May 2019 03:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190515072747.39941-1-xiaowei.bao@nxp.com> <20190515072747.39941-2-xiaowei.bao@nxp.com>
 <CAK8P3a3AXRp_v_7hkoJA28tUCiSh1eYzbk4Q4h29OqL6y-KL8A@mail.gmail.com>
 <AM5PR04MB329934765FB8EB1828743D79F50B0@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <CAK8P3a0kKb7njiJvUkwJYwf-yc-hEyErSiWcvbdf0XnMoctzrg@mail.gmail.com>
In-Reply-To: <CAK8P3a0kKb7njiJvUkwJYwf-yc-hEyErSiWcvbdf0XnMoctzrg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 17 May 2019 12:44:22 +0200
Message-ID: <CAKv+Gu-WVcVvqPoH3gsz8G3Dwizne81MAQAUGNnGrpthvUiSnw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 May 2019 at 10:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 17, 2019 at 5:21 AM Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > On Wed, May 15, 2019 at 9:36 AM Xiaowei Bao <xiaowei.bao@nxp.com> wrote=
:
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   52 ++++++++++++++=
++++++++++
> > >  1 files changed, 52 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/ar=
m64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > index b045812..50b579b 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > @@ -398,6 +398,58 @@
> > >                         status =3D "disabled";
> > >                 };
> > >
> > > +               pcie@3400000 {
> > > +                       compatible =3D "fsl,ls1028a-pcie";
> > > +                       reg =3D <0x00 0x03400000 0x0 0x00100000   /* =
controller registers */
> > > +                              0x80 0x00000000 0x0 0x00002000>; /* co=
nfiguration space */
> > > +                       reg-names =3D "regs", "config";
> > > +                       interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HI=
GH>, /* PME interrupt */
> > > +                                    <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH=
>; /* aer interrupt */
> > > +                       interrupt-names =3D "pme", "aer";
> > > +                       #address-cells =3D <3>;
> > > +                       #size-cells =3D <2>;
> > > +                       device_type =3D "pci";
> > > +                       dma-coherent;
> > > +                       num-lanes =3D <4>;
> > > +                       bus-range =3D <0x0 0xff>;
> > > +                       ranges =3D <0x81000000 0x0 0x00000000 0x80 0x=
00010000 0x0 0x00010000   /* downstream I/O */
> > > +                                 0x82000000 0x0 0x40000000 0x80 0x40=
000000 0x0 0x40000000>; /* non-prefetchable memory */
> >
> > Are you sure there is no support for 64-bit BARs or prefetchable memory=
?
> > [Xiaowei Bao] sorry for late reply, Thought that our Layerscape platfor=
m has not added prefetchable memory support in DTS, so this platform has no=
t been added, I will submit a separate patch to add prefetchable memory sup=
port for all Layerscape platforms.
>
> Ok, thanks.
>
> > Of course, the prefetchable PCIE device can work in our boards, because=
 the RC will
> > assign non-prefetchable memory for this device. We reserve 1G no-prefet=
chable
> > memory for PCIE device, it is enough for general devices.
>
> Sure, many devices work just fine, this is mostly a question of supportin=
g those
> devices that do require multiple gigabytes, or that need prefetchable mem=
ory
> semantics to get the expected performance. GPUs are the obvious example,
> but I think there are others (infiniband?).
>

Some implementations of the Synopsys dw PCIe IP contain a 'root port'
(within quotes because it is not actually a root port but an arbitrary
set of MMIO registers that looks like a type 01 config region) that
does not permit the prefetchable bridge window BAR to be written (a
thing which is apparently permitted by the PCIe spec). So while the
host bridge is capable of supporting more than one MMIO BAR window,
the OS visible software interface does not expose this functionality

In practice, it probably doesn't matter, since the driver uses the
same iATU attributes for prefetchable and non-prefetchable windows,
but I guess 1 GB of MMIO BAR space is a bit restrictive for modern
systems.
