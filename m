Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A064C710876
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjEYJOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjEYJOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 05:14:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AFA7;
        Thu, 25 May 2023 02:14:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so4003448a12.3;
        Thu, 25 May 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685006080; x=1687598080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76DwNbDGQP83GHoYB0zX5gS/ikCHV5gsiqGNLpVFqG8=;
        b=boIE2/DjBSzAR6jnreSa/tnfPh3NCpOeJliJnP/XB09U40pEdzi3vKzsQZT6i06JeG
         sT+3n0kGa5LXepWTrSIcvuc8Te9puNUGfIveI5ZpGQrn0UTzkfSHNYb823DuojXpJXqn
         0FoaQT8xOsNz1Z2zCRMTQofhxWwBEBUw36nuTN1T1TCOQkfpcsn/B/5cdO5AlnSHl9eq
         L4N8phg1kxTKXnxidSbr3w5wzJPpv6WC90NsdhNw64tYe2sdtJ7Fcm7bp1qs1cE8IPr0
         USWEhmil2Il3JBhBKtc+H/cxAGGaSwdEtwBJ0Z5L1fC8JFvTZxkuqJb+eZathGdIbGnz
         H2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006080; x=1687598080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76DwNbDGQP83GHoYB0zX5gS/ikCHV5gsiqGNLpVFqG8=;
        b=IroaceaBLkM2c7MEkRSGotCAvdaosK6iy1G+bK3t41+PdF4gXvlhE4/h3NJA6ArBG+
         Jb9GPG1hDVBb8mdd7+SMVXAXZN0E+47mdnOWBrEN9UxCbyjapZcNSS3bg+KoV41oXFoZ
         2ezs0BLgULkam6WHS/LbDaC87XZBFS9Pd4wvbEvp5eqzo8IBAxjUiGT/HAW7iqd2STnv
         /hY4i3zdME/waiBOqy4Zr6lyXaOY+y/BTYtNVOEyrgBeu5s/YJKZAMEtw4sh09I4bWqT
         scKg2iQ0iJ6VeafbQak6+lUTVSHn6iH+G37VOlEmyCwcGwMIJ6G5LGm+5cZvwfrei7Yw
         AQOg==
X-Gm-Message-State: AC+VfDzQukXLSz5H130Pfczxnag1TEXhOur566OwtQfW4kw9m5ILc2l3
        7B+ExLiGz3UM1D0QZndSPZdwTZMusR/PNy1p5R0=
X-Google-Smtp-Source: ACHHUZ7qksFuVsSCC5e4gkXBm7DhNf6+QyeUwJCZOQbWdl2/LWLcjBKNw8OpJCnaFNMia0GgI3lmJsOwrZhrCmISxoI=
X-Received: by 2002:a17:906:dac4:b0:96f:da2c:ddc1 with SMTP id
 xi4-20020a170906dac400b0096fda2cddc1mr1039915ejb.75.1685006079534; Thu, 25
 May 2023 02:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093623.3698134-1-chenhuacai@loongson.cn> <ZG4rZYBKaWrsctuH@bhelgaas>
In-Reply-To: <ZG4rZYBKaWrsctuH@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 25 May 2023 17:14:28 +0800
Message-ID: <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Wed, May 24, 2023 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Marc, LKML]
>
> On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > Some platforms (such as LoongArch) cannot provide enough irq numbers as
> > many as logical cpu numbers. So we should limit pci irq numbers when
> > allocate msi/msix vectors, otherwise some device drivers may fail at
> > initialization. This patch add a cmdline parameter "pci_irq_limit=3Dxxx=
x"
> > to control the limit.
> >
> > The default pci msi/msix number limit is defined 32 for LoongArch and
> > NR_IRQS for other platforms.
>
> The IRQ experts can chime in on this, but this doesn't feel right to
> me.  I assume arch code should set things up so only valid IRQ numbers
> can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> command-line parameter that users have to discover and supply.
The problem we meet: LoongArch machines can have as many as 256
logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
machine, 192 irqs can be easily exhausted if there are several NICs
(NIC usually allocates msi irqs depending on the number of online
cpus). So we want to limit the msi allocation.

This is not a LoongArch-specific problem, because I think other
platforms can also meet if they have many NICs. But of course,
LoongArch can meet it more easily because the available msi vectors
are very few. So, adding a cmdline parameter is somewhat reasonable.

After some investigation, I think it may be possible to modify
drivers/irqchip/irq-loongson-pch-msi.c and override
msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
doing that need to remove the "static" before
__msi_domain_alloc_irqs(), which means revert
762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
__msi_domain_alloc_irqs() static"), I don't know whether that is
acceptable.

If such a revert is not acceptable, it seems that we can only use the
method in this patch. Maybe rename pci_irq_limits to pci_msi_limits is
a little better.

Huacai

>
> > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index ef1d8857a51b..6617381e50e7 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -402,12 +402,34 @@ static int msi_capability_init(struct pci_dev *de=
v, int nvec,
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_LOONGARCH
> > +#define DEFAULT_PCI_IRQ_LIMITS 32
> > +#else
> > +#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
> > +#endif
> > +
> > +static int pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > +
> > +static int __init pci_irq_limit(char *str)
> > +{
> > +     get_option(&str, &pci_irq_limits);
> > +
> > +     if (pci_irq_limits =3D=3D 0)
> > +             pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > +
> > +     return 0;
> > +}
> > +
> > +early_param("pci_irq_limit", pci_irq_limit);
> > +
> >  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec=
,
> >                          struct irq_affinity *affd)
> >  {
> >       int nvec;
> >       int rc;
> >
> > +     maxvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> > +
> >       if (!pci_msi_supported(dev, minvec) || dev->current_state !=3D PC=
I_D0)
> >               return -EINVAL;
> >
> > @@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struct pci_de=
v *dev, struct msix_entry *en
> >  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *en=
tries, int minvec,
> >                           int maxvec, struct irq_affinity *affd, int fl=
ags)
> >  {
> > -     int hwsize, rc, nvec =3D maxvec;
> > +     int hwsize, rc, nvec;
> > +
> > +     nvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> >
> >       if (maxvec < minvec)
> >               return -ERANGE;
> > --
> > 2.39.1
> >
