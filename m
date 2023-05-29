Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00AE7143C4
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 07:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjE2Fjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjE2Fje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 01:39:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFE9B
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 22:39:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b041cceb16so5505275ad.2
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 22:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685338771; x=1687930771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZMHeq9p6cGeob4UHg8LtWQXjOznzUEzA319SJMMUZAg=;
        b=Y2zzcbBr76OAjvnt0aa+mkjg3FDzM7mpkzpFFHTUuFKa4GBcqGgscC+UJ/INqrjYCP
         MV5dC9xXWehgjYNeTGZP1Oc0OI2fdLvt3MT3b5w5KHFSxKZ4xuGH+hBFDBo2ia6f9HUv
         J/PABijbLioetfuQD2KHYToFTREUzxdXjwEaCz9QUy0BFU2BjDgMHb2/HkWK4TJoT81G
         Qh+E8UO5hHmIKrHKQ+Qp75Tx++1zJCAiNdV/W7tQ3ZYpY0G9h/X/nypEyYSA4ePl4CmD
         Ox2bmR75PcMQJf3urYKef2fgtaykEKm4KeXfYiNE/3w+hvQf/hEhqac15QYNoD1dD2eF
         rWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685338771; x=1687930771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMHeq9p6cGeob4UHg8LtWQXjOznzUEzA319SJMMUZAg=;
        b=Z/DUnGF7iUaMGpUymHLUL1CAmB/OlMin/j8XPEYDpCFMuIGA+8HA7ILynHpFHZErHg
         7poFPey2icUlM/aQ1nqIcT0IyIYGsMrrUEezvk79TJHAtN/fwzufE4x7xoG348wtXXSo
         AytSSPTBzqgNup77sGt7Ldmqfaj57fLRr2dXSe+8NmqROReJC7sRMjedIfidDOOfQwlI
         KzxI7sSpLD/XhCoc9wffXDmIkxjdPeed7QCwuBnpyECGQdlqx6NnfqT7s+wXJucZs9eY
         tuC0IpPte0aow5TaZ912otl3WLBa2ycLVPvp/IlVPO4HXHHaHYTpJim5eDn7i3I+uk5j
         4dtw==
X-Gm-Message-State: AC+VfDzCmveHKjG1T2ew6RfixBdMaylIv/em8VcJHL53toDIkkLbTB60
        cTrc/IikCPDIah1dipZq7edW
X-Google-Smtp-Source: ACHHUZ6Ypi1Of4qg+4vs4ApPfBp6jB82NcYkwzptZq6gsVbdEFNqmfi635wfx7UnXSaNKt3bHt2j7Q==
X-Received: by 2002:a17:902:e548:b0:1ac:815e:320b with SMTP id n8-20020a170902e54800b001ac815e320bmr10764133plf.17.1685338771283;
        Sun, 28 May 2023 22:39:31 -0700 (PDT)
Received: from thinkpad ([117.248.1.157])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001ae44cd96besm7191664plb.135.2023.05.28.22.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:39:30 -0700 (PDT)
Date:   Mon, 29 May 2023 11:09:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Huacai Chen <chenhuacai@gmail.com>
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
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
Message-ID: <20230529053919.GB2856@thinkpad>
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas>
 <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad>
 <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 10:02:20AM +0800, Huacai Chen wrote:
> Hi, Manivannan,
> 
> On Mon, May 29, 2023 at 12:57 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> > > Hi, Bjorn,
> > >
> > > On Wed, May 24, 2023 at 11:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Marc, LKML]
> > > >
> > > > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > > > Some platforms (such as LoongArch) cannot provide enough irq numbers as
> > > > > many as logical cpu numbers. So we should limit pci irq numbers when
> > > > > allocate msi/msix vectors, otherwise some device drivers may fail at
> > > > > initialization. This patch add a cmdline parameter "pci_irq_limit=xxxx"
> > > > > to control the limit.
> > > > >
> > > > > The default pci msi/msix number limit is defined 32 for LoongArch and
> > > > > NR_IRQS for other platforms.
> > > >
> > > > The IRQ experts can chime in on this, but this doesn't feel right to
> > > > me.  I assume arch code should set things up so only valid IRQ numbers
> > > > can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> > > > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> > > > command-line parameter that users have to discover and supply.
> > > The problem we meet: LoongArch machines can have as many as 256
> > > logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
> > > machine, 192 irqs can be easily exhausted if there are several NICs
> > > (NIC usually allocates msi irqs depending on the number of online
> > > cpus). So we want to limit the msi allocation.
> > >
> >
> > If the MSI allocation fails with multiple vectors, then the NIC driver should
> > revert to a single MSI vector. Is that happening in your case?
> Thank you for pointing this out. Yes, I know  most existing drivers
> will fallback to use single msi or legacy irqs when failed. However,
> as I
> replied in another thread (the new solution of this problem [1]), we
> want to do some proactive throttling rather than consume msi vectors
> aggressively. For example, if we have two NICs, we want both of them
> to get 32 msi vectors; not one exhaust all available vectors, and the
> other fallback to use single msi or legacy irq.
> 
> I hope I have explained clearly, thanks.
> 

The problem you are facing is not specific to Loongsoon but rather generic. And
the solution we have currently is what you were also aware of it seems. So if
you want to propose an alternative solution, it should be generic and also a
good justification needs to be provided to the maintainers i.e., comparing two
solutions and why yours is better.

But IMO what you are proposing seems like usecase driven and may not work all
the time due to architecture limitation. This again proves that the existing
solution is sufficient enough.

- Mani

> [1] https://lore.kernel.org/lkml/20230527054633.704916-1-chenhuacai@loongson.cn/T/#t
> 
> Huacai
> >
> > - Mani
> >
> > > This is not a LoongArch-specific problem, because I think other
> > > platforms can also meet if they have many NICs. But of course,
> > > LoongArch can meet it more easily because the available msi vectors
> > > are very few. So, adding a cmdline parameter is somewhat reasonable.
> > >
> > > After some investigation, I think it may be possible to modify
> > > drivers/irqchip/irq-loongson-pch-msi.c and override
> > > msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
> > > doing that need to remove the "static" before
> > > __msi_domain_alloc_irqs(), which means revert
> > > 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> > > __msi_domain_alloc_irqs() static"), I don't know whether that is
> > > acceptable.
> > >
> > > If such a revert is not acceptable, it seems that we can only use the
> > > method in this patch. Maybe rename pci_irq_limits to pci_msi_limits is
> > > a little better.
> > >
> > > Huacai
> > >
> > > >
> > > > > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
> > > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > > index ef1d8857a51b..6617381e50e7 100644
> > > > > --- a/drivers/pci/msi/msi.c
> > > > > +++ b/drivers/pci/msi/msi.c
> > > > > @@ -402,12 +402,34 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_LOONGARCH
> > > > > +#define DEFAULT_PCI_IRQ_LIMITS 32
> > > > > +#else
> > > > > +#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
> > > > > +#endif
> > > > > +
> > > > > +static int pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
> > > > > +
> > > > > +static int __init pci_irq_limit(char *str)
> > > > > +{
> > > > > +     get_option(&str, &pci_irq_limits);
> > > > > +
> > > > > +     if (pci_irq_limits == 0)
> > > > > +             pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +early_param("pci_irq_limit", pci_irq_limit);
> > > > > +
> > > > >  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> > > > >                          struct irq_affinity *affd)
> > > > >  {
> > > > >       int nvec;
> > > > >       int rc;
> > > > >
> > > > > +     maxvec = clamp_val(maxvec, 0, pci_irq_limits);
> > > > > +
> > > > >       if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
> > > > >               return -EINVAL;
> > > > >
> > > > > @@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *en
> > > > >  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
> > > > >                           int maxvec, struct irq_affinity *affd, int flags)
> > > > >  {
> > > > > -     int hwsize, rc, nvec = maxvec;
> > > > > +     int hwsize, rc, nvec;
> > > > > +
> > > > > +     nvec = clamp_val(maxvec, 0, pci_irq_limits);
> > > > >
> > > > >       if (maxvec < minvec)
> > > > >               return -ERANGE;
> > > > > --
> > > > > 2.39.1
> > > > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
