Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F98713AEB
	for <lists+linux-pci@lfdr.de>; Sun, 28 May 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjE1Q5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 May 2023 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE1Q5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 May 2023 12:57:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563BCAD
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 09:57:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b039168ba0so5215475ad.3
        for <linux-pci@vger.kernel.org>; Sun, 28 May 2023 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685293066; x=1687885066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRkRsLTcaRXXNLPVC/pQddeZGsKSw4A/x3n+BNs4brA=;
        b=tX4OvwkJGQGBWSoTLx5fhl6M7+eMOrecPg8ap1uooezx+6pSxN+tA0IyZHb8yY7You
         l9SUV5WVWAnnaDZaIuEU0cW5bXEM/veQTjlD5YNxvAM23tyCoH5jnI034TRnt1c7MO7P
         rpKoq6H8oC+ALQwb30pK0rkCDLyMdrGKY/TQj7k7gQwRAGVvQ4qjNfr58vuSZWh6XmcH
         Bqml4mSiWqtS16VgYBBFyVkv/qgcUE7DHbqxbe03XYrvt4bWquvAjxSrZDlcU/Hcf3yb
         J5gvZvSZNjWbjgapqsR0nEekRHLE8UmA5FeQiB5LfG+6X5aH8LBOGd6qzF0soxwTcLUg
         BZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685293066; x=1687885066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRkRsLTcaRXXNLPVC/pQddeZGsKSw4A/x3n+BNs4brA=;
        b=AhrHA7xOekmKEt7oOEBqGXypsClqWLXaWyrKMrelFW7y8XeAMzDysQboeI/hS4EHOI
         RcUGk7KC1BMeyzFR7zWFbty/fx0UR0nBwZ1eXO4AF65HO5SqLuhozin90+o5mNbK0P0e
         srmsmkINQWVcMwOldU5XW4CfTRoaJ7a6XuKX2SSjQb56aR/nm+9y4II0qxqHoPbIVSGD
         8A2DCQomIak6oBGnforJ7islm7kxzJVdbbzUNRMl0no9TnLfYnq+kBo+w4JHFpWyDpfs
         wPACAeixczlLmqgMZy9BDbUk/+cXPQClRxUGP8hugXCTWoOoH2phTnrmbzV5xsbbrZcs
         X2DA==
X-Gm-Message-State: AC+VfDx/bKirHN2Zsx1iZicGyuSCLshA3RrW5dISYSVsG1Tsmgd2NKTp
        NhoppPzba/RoNIAHJjOi63cv
X-Google-Smtp-Source: ACHHUZ7/k62dk4ZuvrJqPQctzbXQu9rlc3BvvCDXGNP3Ur6Q1O0PUWpRejzitcjoKLcsB+3h5/DZWA==
X-Received: by 2002:a17:902:c949:b0:1aa:e425:2527 with SMTP id i9-20020a170902c94900b001aae4252527mr10118933pla.21.1685293065809;
        Sun, 28 May 2023 09:57:45 -0700 (PDT)
Received: from thinkpad ([117.248.1.157])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001960706141fsm6531863plb.149.2023.05.28.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 09:57:45 -0700 (PDT)
Date:   Sun, 28 May 2023 22:27:38 +0530
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
Message-ID: <20230528165738.GF2814@thinkpad>
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas>
 <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Wed, May 24, 2023 at 11:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Marc, LKML]
> >
> > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > Some platforms (such as LoongArch) cannot provide enough irq numbers as
> > > many as logical cpu numbers. So we should limit pci irq numbers when
> > > allocate msi/msix vectors, otherwise some device drivers may fail at
> > > initialization. This patch add a cmdline parameter "pci_irq_limit=xxxx"
> > > to control the limit.
> > >
> > > The default pci msi/msix number limit is defined 32 for LoongArch and
> > > NR_IRQS for other platforms.
> >
> > The IRQ experts can chime in on this, but this doesn't feel right to
> > me.  I assume arch code should set things up so only valid IRQ numbers
> > can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> > command-line parameter that users have to discover and supply.
> The problem we meet: LoongArch machines can have as many as 256
> logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
> machine, 192 irqs can be easily exhausted if there are several NICs
> (NIC usually allocates msi irqs depending on the number of online
> cpus). So we want to limit the msi allocation.
> 

If the MSI allocation fails with multiple vectors, then the NIC driver should
revert to a single MSI vector. Is that happening in your case?

- Mani

> This is not a LoongArch-specific problem, because I think other
> platforms can also meet if they have many NICs. But of course,
> LoongArch can meet it more easily because the available msi vectors
> are very few. So, adding a cmdline parameter is somewhat reasonable.
> 
> After some investigation, I think it may be possible to modify
> drivers/irqchip/irq-loongson-pch-msi.c and override
> msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
> doing that need to remove the "static" before
> __msi_domain_alloc_irqs(), which means revert
> 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> __msi_domain_alloc_irqs() static"), I don't know whether that is
> acceptable.
> 
> If such a revert is not acceptable, it seems that we can only use the
> method in this patch. Maybe rename pci_irq_limits to pci_msi_limits is
> a little better.
> 
> Huacai
> 
> >
> > > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > index ef1d8857a51b..6617381e50e7 100644
> > > --- a/drivers/pci/msi/msi.c
> > > +++ b/drivers/pci/msi/msi.c
> > > @@ -402,12 +402,34 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
> > >       return ret;
> > >  }
> > >
> > > +#ifdef CONFIG_LOONGARCH
> > > +#define DEFAULT_PCI_IRQ_LIMITS 32
> > > +#else
> > > +#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
> > > +#endif
> > > +
> > > +static int pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
> > > +
> > > +static int __init pci_irq_limit(char *str)
> > > +{
> > > +     get_option(&str, &pci_irq_limits);
> > > +
> > > +     if (pci_irq_limits == 0)
> > > +             pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +early_param("pci_irq_limit", pci_irq_limit);
> > > +
> > >  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> > >                          struct irq_affinity *affd)
> > >  {
> > >       int nvec;
> > >       int rc;
> > >
> > > +     maxvec = clamp_val(maxvec, 0, pci_irq_limits);
> > > +
> > >       if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
> > >               return -EINVAL;
> > >
> > > @@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *en
> > >  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
> > >                           int maxvec, struct irq_affinity *affd, int flags)
> > >  {
> > > -     int hwsize, rc, nvec = maxvec;
> > > +     int hwsize, rc, nvec;
> > > +
> > > +     nvec = clamp_val(maxvec, 0, pci_irq_limits);
> > >
> > >       if (maxvec < minvec)
> > >               return -ERANGE;
> > > --
> > > 2.39.1
> > >

-- 
மணிவண்ணன் சதாசிவம்
