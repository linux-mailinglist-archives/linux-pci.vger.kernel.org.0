Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612D7141D3
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE2CCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 May 2023 22:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2CCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 May 2023 22:02:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536AB8;
        Sun, 28 May 2023 19:02:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so4607807a12.1;
        Sun, 28 May 2023 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685325753; x=1687917753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wg139ZawHzc+EqrNyAUd4G4t6i7iB3NYXCpzkJY0bk=;
        b=Phtq21cb2/AQSZKaHipKQ83ww49PPXAmWpbP9Ynm+U4pEr3LCmBdcgDbGRMNqluXhd
         BJfVtAEq3/jo9lFqooWHoqIYPlAT+pMNm0zWUE6DBCOWBEAFeZsDWv/nQ0EJzCxtmXtp
         YiZHjU9usWKV2vWDhw0W8H2pmnnLjuG4dSoglkGTbnIHdhpylYXvHEJX682EhDDv7WoJ
         qxgG5QKdtxPOLZFV1t8HO2pOPDdB8S2r2ieqSI1+Z4g3JrjKq9fMw/fcoogR6K/FaC7l
         BWM+aaVjYwvflg6JyQtOnFKErhC5ItaVUMP5xhL3nSM0jy8tAYDhVBIX6Ec8BDMnuZoS
         KbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685325753; x=1687917753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wg139ZawHzc+EqrNyAUd4G4t6i7iB3NYXCpzkJY0bk=;
        b=MThS7wQZj6W+DJHv9tLZM+xWFaWXEbW1Lh3zU7tmkFXQqIJfv+viSt778PkEXDr+ei
         +JGM2FtpgRmdWIu3kzT3hHJoloXQC9et6/N9TXKJY0qAGpJqlLX3PT+e49J0KFsDFlU7
         Vye65G3F8IVAnyAaU8/Ef8DzcIdlCkx1vXBC9HEYJg7bGs8QoMur2GG2xuiY8vtXn0KL
         Ahou9u37P2iMxSmfJGczjwx5xVbrCFjHQLd5v034GenNAMg6zXDfqOXaGF/CauDlDGNc
         TviexidX5sLhenkpjRnsEFmyAQKR73xaJ3rPg2lpPKyeAdeJm0u0I7irZkFxkvpvWKaI
         3N1w==
X-Gm-Message-State: AC+VfDz3qySzRXbsT5zFct4+QjagF9DnT0FjrntOFfDs3W0NrlHlpvnC
        mgJmBJ29ySgd469tZQWPaY9RgkJjciKYX8FCspo=
X-Google-Smtp-Source: ACHHUZ71CUcbb0DiVR0aw6CpTjhsRK2rb6rDnCNIIPrgEp2YNinAPxlVWE3wcodb24NGskeKUrV7VPV5+duLKIPvaWU=
X-Received: by 2002:a17:907:26ce:b0:96a:1ee9:4a5 with SMTP id
 bp14-20020a17090726ce00b0096a1ee904a5mr9786555ejc.8.1685325752964; Sun, 28
 May 2023 19:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas> <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad>
In-Reply-To: <20230528165738.GF2814@thinkpad>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 29 May 2023 10:02:20 +0800
Message-ID: <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
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

Hi, Manivannan,

On Mon, May 29, 2023 at 12:57=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> > Hi, Bjorn,
> >
> > On Wed, May 24, 2023 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > >
> > > [+cc Marc, LKML]
> > >
> > > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > > Some platforms (such as LoongArch) cannot provide enough irq number=
s as
> > > > many as logical cpu numbers. So we should limit pci irq numbers whe=
n
> > > > allocate msi/msix vectors, otherwise some device drivers may fail a=
t
> > > > initialization. This patch add a cmdline parameter "pci_irq_limit=
=3Dxxxx"
> > > > to control the limit.
> > > >
> > > > The default pci msi/msix number limit is defined 32 for LoongArch a=
nd
> > > > NR_IRQS for other platforms.
> > >
> > > The IRQ experts can chime in on this, but this doesn't feel right to
> > > me.  I assume arch code should set things up so only valid IRQ number=
s
> > > can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> > > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> > > command-line parameter that users have to discover and supply.
> > The problem we meet: LoongArch machines can have as many as 256
> > logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
> > machine, 192 irqs can be easily exhausted if there are several NICs
> > (NIC usually allocates msi irqs depending on the number of online
> > cpus). So we want to limit the msi allocation.
> >
>
> If the MSI allocation fails with multiple vectors, then the NIC driver sh=
ould
> revert to a single MSI vector. Is that happening in your case?
Thank you for pointing this out. Yes, I know  most existing drivers
will fallback to use single msi or legacy irqs when failed. However,
as I
replied in another thread (the new solution of this problem [1]), we
want to do some proactive throttling rather than consume msi vectors
aggressively. For example, if we have two NICs, we want both of them
to get 32 msi vectors; not one exhaust all available vectors, and the
other fallback to use single msi or legacy irq.

I hope I have explained clearly, thanks.

[1] https://lore.kernel.org/lkml/20230527054633.704916-1-chenhuacai@loongso=
n.cn/T/#t

Huacai
>
> - Mani
>
> > This is not a LoongArch-specific problem, because I think other
> > platforms can also meet if they have many NICs. But of course,
> > LoongArch can meet it more easily because the available msi vectors
> > are very few. So, adding a cmdline parameter is somewhat reasonable.
> >
> > After some investigation, I think it may be possible to modify
> > drivers/irqchip/irq-loongson-pch-msi.c and override
> > msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
> > doing that need to remove the "static" before
> > __msi_domain_alloc_irqs(), which means revert
> > 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> > __msi_domain_alloc_irqs() static"), I don't know whether that is
> > acceptable.
> >
> > If such a revert is not acceptable, it seems that we can only use the
> > method in this patch. Maybe rename pci_irq_limits to pci_msi_limits is
> > a little better.
> >
> > Huacai
> >
> > >
> > > > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
> > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > index ef1d8857a51b..6617381e50e7 100644
> > > > --- a/drivers/pci/msi/msi.c
> > > > +++ b/drivers/pci/msi/msi.c
> > > > @@ -402,12 +402,34 @@ static int msi_capability_init(struct pci_dev=
 *dev, int nvec,
> > > >       return ret;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_LOONGARCH
> > > > +#define DEFAULT_PCI_IRQ_LIMITS 32
> > > > +#else
> > > > +#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
> > > > +#endif
> > > > +
> > > > +static int pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > > > +
> > > > +static int __init pci_irq_limit(char *str)
> > > > +{
> > > > +     get_option(&str, &pci_irq_limits);
> > > > +
> > > > +     if (pci_irq_limits =3D=3D 0)
> > > > +             pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +early_param("pci_irq_limit", pci_irq_limit);
> > > > +
> > > >  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int ma=
xvec,
> > > >                          struct irq_affinity *affd)
> > > >  {
> > > >       int nvec;
> > > >       int rc;
> > > >
> > > > +     maxvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> > > > +
> > > >       if (!pci_msi_supported(dev, minvec) || dev->current_state !=
=3D PCI_D0)
> > > >               return -EINVAL;
> > > >
> > > > @@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struct pc=
i_dev *dev, struct msix_entry *en
> > > >  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry=
 *entries, int minvec,
> > > >                           int maxvec, struct irq_affinity *affd, in=
t flags)
> > > >  {
> > > > -     int hwsize, rc, nvec =3D maxvec;
> > > > +     int hwsize, rc, nvec;
> > > > +
> > > > +     nvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> > > >
> > > >       if (maxvec < minvec)
> > > >               return -ERANGE;
> > > > --
> > > > 2.39.1
> > > >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
