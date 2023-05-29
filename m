Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAC71451E
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 08:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjE2Gwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 02:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjE2Gwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 02:52:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AFA3;
        Sun, 28 May 2023 23:52:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso4035881a12.3;
        Sun, 28 May 2023 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685343162; x=1687935162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xLU0TDl8S2h/LajmRlkUSNAeMKsxbvqXKst8upBRuE=;
        b=LnzifqjYS+B2tULydawHuxxg+0jiTM3TjUV3DioFI26sY+LZ+SSFwChZsZaWitKw2n
         nFxVa2wSbWlFKw+3KOPipVLhGjWlL+gBGfCqrT6Mr1nqLI93jl2gMq/oKePEhfhpPJGH
         cu2o0bcAM/JUEetuNOS4Ezzn2+gthSxNwXvlC8iVqZGe5eJ5p7DPyOJ0Rky1T1UUi//X
         gvONRZaYwG4P0kmiyU/Nkz1CHCrmtibyi+CNcrVGCBZgZ3vQipuK/KwZ7heoEbz6MmZX
         f5waS5EHckuomnV0fzg9qsAGawIchNaorV6IpTYkPn7elH6Mbj3VxwxX2t14pFic2OxA
         M7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685343162; x=1687935162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xLU0TDl8S2h/LajmRlkUSNAeMKsxbvqXKst8upBRuE=;
        b=hQeYQ7LBa1AsSZJiaTxqauvmOEQBZ3faP1o606rzie8oUh7oOLT8Xgntxt5y3qBcS8
         mYz0afaL/lMxFookQ9u3zvQ0CGTraV6/1/vRJUFNKz1l+f/6HL5fU2r7OHh6SCkE9Asl
         VylZNoLt6IP2qKQCNxS24CMMPfKepc/2McnVGHeq9gzod1B99mbwRDRuI3+2haW7893Z
         SYBKVLsM5qz2F5nNZvdRuXZ9U1GY/jLd+StQ02EnpJ+1qc8vEhmu/DWbrP1cSjy3VSLF
         MwRxadXMXAYdmSsyKIDVdEVP9FVBlilrSbngHOT2IThD08UK9ndmsqbaE7CnYcRSBC72
         joZw==
X-Gm-Message-State: AC+VfDy1VdiohNreb4s8bYNWW6yU+Wq35elan2RNfsWxvjotPDAZmNh+
        E6No7IdrTKM8l+rXp8jllNpf9wEcdy1vMVZomv4=
X-Google-Smtp-Source: ACHHUZ4jYsiG4h1SNeAONK8ZW0V2k2rMFPZdC6crFet24ZOpKZSwB2Cj/fm2N2wxMjBZDTtJUb9Fsyl9ji9DMdcoQ0M=
X-Received: by 2002:a17:906:d555:b0:960:c5fe:a36a with SMTP id
 cr21-20020a170906d55500b00960c5fea36amr9914575ejc.61.1685343162370; Sun, 28
 May 2023 23:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas> <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad> <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
 <20230529053919.GB2856@thinkpad>
In-Reply-To: <20230529053919.GB2856@thinkpad>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 29 May 2023 14:52:29 +0800
Message-ID: <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
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

On Mon, May 29, 2023 at 1:39=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 29, 2023 at 10:02:20AM +0800, Huacai Chen wrote:
> > Hi, Manivannan,
> >
> > On Mon, May 29, 2023 at 12:57=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> > > > Hi, Bjorn,
> > > >
> > > > On Wed, May 24, 2023 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@ker=
nel.org> wrote:
> > > > >
> > > > > [+cc Marc, LKML]
> > > > >
> > > > > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > > > > Some platforms (such as LoongArch) cannot provide enough irq nu=
mbers as
> > > > > > many as logical cpu numbers. So we should limit pci irq numbers=
 when
> > > > > > allocate msi/msix vectors, otherwise some device drivers may fa=
il at
> > > > > > initialization. This patch add a cmdline parameter "pci_irq_lim=
it=3Dxxxx"
> > > > > > to control the limit.
> > > > > >
> > > > > > The default pci msi/msix number limit is defined 32 for LoongAr=
ch and
> > > > > > NR_IRQS for other platforms.
> > > > >
> > > > > The IRQ experts can chime in on this, but this doesn't feel right=
 to
> > > > > me.  I assume arch code should set things up so only valid IRQ nu=
mbers
> > > > > can be allocated.  This doesn't seem necessarily PCI-specific, I'=
d
> > > > > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid=
 a
> > > > > command-line parameter that users have to discover and supply.
> > > > The problem we meet: LoongArch machines can have as many as 256
> > > > logical cpus, and the maximum of msi vectors is 192. Even on a 64-c=
ore
> > > > machine, 192 irqs can be easily exhausted if there are several NICs
> > > > (NIC usually allocates msi irqs depending on the number of online
> > > > cpus). So we want to limit the msi allocation.
> > > >
> > >
> > > If the MSI allocation fails with multiple vectors, then the NIC drive=
r should
> > > revert to a single MSI vector. Is that happening in your case?
> > Thank you for pointing this out. Yes, I know  most existing drivers
> > will fallback to use single msi or legacy irqs when failed. However,
> > as I
> > replied in another thread (the new solution of this problem [1]), we
> > want to do some proactive throttling rather than consume msi vectors
> > aggressively. For example, if we have two NICs, we want both of them
> > to get 32 msi vectors; not one exhaust all available vectors, and the
> > other fallback to use single msi or legacy irq.
> >
> > I hope I have explained clearly, thanks.
> >
>
> The problem you are facing is not specific to Loongsoon but rather generi=
c. And
> the solution we have currently is what you were also aware of it seems. S=
o if
> you want to propose an alternative solution, it should be generic and als=
o a
> good justification needs to be provided to the maintainers i.e., comparin=
g two
> solutions and why yours is better.
Yes, I think we are facing a generic problem, but it is more obvious
on platforms which provide less MSI vectors. And my solution seems
generic enough. :)

At least in my example, "proactive throttling" is better than
"aggressive consuming", because two (or more) NICs have more balanced
throughput.

>
> But IMO what you are proposing seems like usecase driven and may not work=
 all
> the time due to architecture limitation. This again proves that the exist=
ing
> solution is sufficient enough.
Yes, it's a usecase driven solution, so I provide a cmdline parameter
to let the user decide.

Huacai
>
> - Mani
>
> > [1] https://lore.kernel.org/lkml/20230527054633.704916-1-chenhuacai@loo=
ngson.cn/T/#t
> >
> > Huacai
> > >
> > > - Mani
> > >
> > > > This is not a LoongArch-specific problem, because I think other
> > > > platforms can also meet if they have many NICs. But of course,
> > > > LoongArch can meet it more easily because the available msi vectors
> > > > are very few. So, adding a cmdline parameter is somewhat reasonable=
.
> > > >
> > > > After some investigation, I think it may be possible to modify
> > > > drivers/irqchip/irq-loongson-pch-msi.c and override
> > > > msi_domain_info::domain_alloc_irqs() to limit msi allocation. Howev=
er,
> > > > doing that need to remove the "static" before
> > > > __msi_domain_alloc_irqs(), which means revert
> > > > 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> > > > __msi_domain_alloc_irqs() static"), I don't know whether that is
> > > > acceptable.
> > > >
> > > > If such a revert is not acceptable, it seems that we can only use t=
he
> > > > method in this patch. Maybe rename pci_irq_limits to pci_msi_limits=
 is
> > > > a little better.
> > > >
> > > > Huacai
> > > >
> > > > >
> > > > > > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
> > > > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > > > index ef1d8857a51b..6617381e50e7 100644
> > > > > > --- a/drivers/pci/msi/msi.c
> > > > > > +++ b/drivers/pci/msi/msi.c
> > > > > > @@ -402,12 +402,34 @@ static int msi_capability_init(struct pci=
_dev *dev, int nvec,
> > > > > >       return ret;
> > > > > >  }
> > > > > >
> > > > > > +#ifdef CONFIG_LOONGARCH
> > > > > > +#define DEFAULT_PCI_IRQ_LIMITS 32
> > > > > > +#else
> > > > > > +#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
> > > > > > +#endif
> > > > > > +
> > > > > > +static int pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > > > > > +
> > > > > > +static int __init pci_irq_limit(char *str)
> > > > > > +{
> > > > > > +     get_option(&str, &pci_irq_limits);
> > > > > > +
> > > > > > +     if (pci_irq_limits =3D=3D 0)
> > > > > > +             pci_irq_limits =3D DEFAULT_PCI_IRQ_LIMITS;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +early_param("pci_irq_limit", pci_irq_limit);
> > > > > > +
> > > > > >  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, in=
t maxvec,
> > > > > >                          struct irq_affinity *affd)
> > > > > >  {
> > > > > >       int nvec;
> > > > > >       int rc;
> > > > > >
> > > > > > +     maxvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> > > > > > +
> > > > > >       if (!pci_msi_supported(dev, minvec) || dev->current_state=
 !=3D PCI_D0)
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > @@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struc=
t pci_dev *dev, struct msix_entry *en
> > > > > >  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_e=
ntry *entries, int minvec,
> > > > > >                           int maxvec, struct irq_affinity *affd=
, int flags)
> > > > > >  {
> > > > > > -     int hwsize, rc, nvec =3D maxvec;
> > > > > > +     int hwsize, rc, nvec;
> > > > > > +
> > > > > > +     nvec =3D clamp_val(maxvec, 0, pci_irq_limits);
> > > > > >
> > > > > >       if (maxvec < minvec)
> > > > > >               return -ERANGE;
> > > > > > --
> > > > > > 2.39.1
> > > > > >
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
