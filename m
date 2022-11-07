Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223661EE4C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKGJKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 04:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiKGJKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 04:10:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F5167C8
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 01:10:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f5so28298817ejc.5
        for <linux-pci@vger.kernel.org>; Mon, 07 Nov 2022 01:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq7f5awERCBOzRjQecmifE8ARalisdBJSDWTzIB4PxQ=;
        b=ZUFFDsZKDnQfoyM9/MObxP3JEorLMtGF2pXlhdoE9hwl9N54nPUCE7s97sAz+L/81q
         dqtkmW5Ag6NAZOXcJrAREmLpl45C0hJTaXbScoVWHwA/UOaU9Ljcygb3jiGoI49/Fd77
         EnwWz/xPj/uXTlTH4u70IqttOvNaZM4wOzKUmn+A78fd3LokucErLFJj5CrY7E/wN/QI
         18HVOkrowHVA2wmI+Dv8+8mVZrC9l75Rf+//aRQEv9Kc2D4I92+nfdbCybYqvTXov8G5
         S4J9UHnxdoGdeXuMJBjNgIazvz94uulPoLoWYfetKrFDOUL6BviWgw2iZxTK7+0D2BdX
         4sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq7f5awERCBOzRjQecmifE8ARalisdBJSDWTzIB4PxQ=;
        b=CMwmZZJ7IO8PNYL04phY66qrnfPgwg4vs3IN06C7eoNQw+7yH2W30Ei7NtotAIC3Co
         DvlMUh7RnvLQnbvM+mTgH0vnD+Abuy/hBR7b+aNGYfdRJyIBU9RP5IO/ZiJvY+DbpUnV
         h5iiUNYNNcAw8fjr7sWK3GQ/NL7/+cObBrgcilJ8YatsGCcn8LBaJxzU77zvyoNFRjB9
         +1eBJtBlTNPDNeFmcB5h0XDuuwMXcELwHZAA1WmEzYgqUIC/x21AaHQ0L9EKVtatOTg/
         /iKoqeJ8zmY0MjsvYCn5u1oG6UT1Ft9OEeUWebxD5R7If54tSxJP2GWEcrPdKeyZNyys
         nJAQ==
X-Gm-Message-State: ACrzQf0zkdpDSe6yCG20AdXMXC/XhuEgkUIu8hyeZutREj3iYlL78CXc
        lkiYDz65EpJ03JnGtV6udPf6rKaT1/TmOFjMfVzRZEhbsXyb8g==
X-Google-Smtp-Source: AMsMyM4UGVtK5cQLWcYKRCKijpzjWIQcbQOb9hXBPbn5fTr0GKFl1wodrAcSHLpgVUU2i3d/nPixC59uVars83S8tVM=
X-Received: by 2002:a17:906:371a:b0:7ad:c01c:6fa0 with SMTP id
 d26-20020a170906371a00b007adc01c6fa0mr42731140ejc.267.1667812213764; Mon, 07
 Nov 2022 01:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20221107081327.336239-1-nathan@nathanrossi.com> <20221107084346.ksdhcxk7bppvpmqc@pali>
In-Reply-To: <20221107084346.ksdhcxk7bppvpmqc@pali>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 7 Nov 2022 19:10:02 +1000
Message-ID: <CA+aJhH0k1zaP0sVNk98qviTiyCEAmQKO4MOD8LSiHiwuzh6-aA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Set Target Link Speed for 2.5GT downstream devices
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Nov 2022 at 18:43, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 07 November 2022 08:13:27 Nathan Rossi wrote:
> > From: Nathan Rossi <nathan.rossi@digi.com>
> >
> > There is a known issue with the mvebu PCIe controller when triggering
> > retraining of the link (via Link Control) where the link is dropped
> > completely causing significant delay in the renegotiation of the link.
> > This occurs only when the downstream device is 2.5GT and the upstream
> > port is configured to support both 2.5GT and 5GT.
> >
> > It is possible to prevent this link dropping by setting the associated
> > link speed in Target Link Speed of the Link Control 2 register. This
> > only needs to be done when the downstream is specifically 2.5GT.
> >
> > This change applies the required Target Link Speed value during
> > mvebu_pcie_setup_hw conditionally depending on the current link speed
> > from the Link Status register, only applying the change when the link
> > is configured to 2.5GT already.
> >
> > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controlle=
r/pci-mvebu.c
> > index 1ced73726a..6a869a33ba 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -248,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie=
_port *port)
> >
> >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  {
> > -     u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
> > +     u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl, lnksta, lnkctl2;
> >
> >       /* Setup PCIe controller to Root Complex mode. */
> >       ctrl =3D mvebu_readl(port, PCIE_CTRL_OFF);
> > @@ -339,6 +339,22 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_=
port *port)
> >       unmask |=3D PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> >                 PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> >       mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > +
> > +     /*
> > +      * Set Target Link Speed within the Link Control 2 register when =
the
> > +      * linked downstream device is connected at 2.5GT. This is config=
ured
> > +      * in order to avoid issues with the controller when the upstream=
 port
> > +      * is configured to support 2.5GT and 5GT and the downstream devi=
ce is
> > +      * linked at 2.5GT, retraining the link in this case causes the l=
ink to
> > +      * drop taking significant time to retrain.
> > +      */
> > +     lnksta =3D mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) >>=
 16;
> > +     if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D PCI_EXP_LNKSTA_CLS_2_5GB=
) {
>
> This code does not work because at this stage endpoint device does not
> have to be ready and therefore link is not established yet.
>
> Also this code is not running when kernel issue PCIe Hot Reset via
> PCI Secondary Bus Reset bit.
>
> And it does not handle possible hot-plug situation.
>
> That check that code below has to be done _after_ kernel enumerate
> device. PCI core code has already logic to handle delays for "slow"
> devices.
>
> And reverse operation (setting lnkctl2 target speed to original value)
> has to be called after unplugging device - when link goes down.
>
> If you want to work on this stuff, I can try to find my notes which I
> done during investigation of this issue... where is probably the best
> place in kernel pci core code for handling this issue.

Some notes/direction for implementation would be very appreciated. I
am not particularly familiar with the pci core code, so I don't have a
good idea on how to best implement this workaround.

Thanks,
Nathan

>
> > +             lnkctl2 =3D mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_L=
NKCTL2);
> > +             lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> > +             lnkctl2 |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
> > +             mvebu_writel(port, lnkctl2, PCIE_CAP_PCIEXP + PCI_EXP_LNK=
CTL2);
> > +     }
> >  }
> >
> >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie =
*pcie,
> > ---
> > 2.37.2
