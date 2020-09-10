Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A5264DC7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIJSvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgIJSuq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 14:50:46 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F369720855;
        Thu, 10 Sep 2020 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599763846;
        bh=8/FN2pGrV2e6oHJ4XPt99FQ76GAY46jbQGsYN15injo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c9rA0ACnX9KBuHVDn0E0CuwtvCHjuD9ZzW5VyN6mV1QkoX34R0JctiRzqAAVZ+Gmc
         PvNdTEoxeGC5w/b5qmGhDSqKkj/hyJfmjOVuj9vjhq34djOA7cjH7W7fMtkwNPV7u7
         Tg0wt9KtvgYZ7ZN2QKZJ8pniNAg+rRoEVTuOUXvI=
Received: by mail-ot1-f47.google.com with SMTP id g10so6234718otq.9;
        Thu, 10 Sep 2020 11:50:45 -0700 (PDT)
X-Gm-Message-State: AOAM533UAVMdWhEgkaezVmC2zdlvVkVEi8b0SZvQrd74hXURTg+EWtEE
        UIr0tYxOwmnd4gQeaM+esJLZqMbctQdarqHa0g==
X-Google-Smtp-Source: ABdhPJxId/3nNZbBGqZxSbJuxtyRdyh2ZW5+MJHU0lYZCDw8GvbX0pkcX7nJAy2HYsIcmimVL93DTH8UyT5yVJErc2E=
X-Received: by 2002:a9d:411:: with SMTP id 17mr4977165otc.192.1599763845337;
 Thu, 10 Sep 2020 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-5-james.quinlan@broadcom.com> <20200910155637.GA423872@bogus>
 <CA+-6iNy9g8fhJvd7SOKtc-SZcL8_gLLN1HEs-W8fe-=q6n430A@mail.gmail.com>
In-Reply-To: <CA+-6iNy9g8fhJvd7SOKtc-SZcL8_gLLN1HEs-W8fe-=q6n430A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Sep 2020 12:50:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJR4wALnsFKKPQ8h2y-o-933rzxHbV29zGXiptgYuuHTg@mail.gmail.com>
Message-ID: <CAL_JsqJR4wALnsFKKPQ8h2y-o-933rzxHbV29zGXiptgYuuHTg@mail.gmail.com>
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 10:42 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Thu, Sep 10, 2020 at 11:56 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
> > > From: Jim Quinlan <jquinlan@broadcom.com>
> > >
> > > Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> > > and resume.  Now the PCIe driver may do so as well.
> > >
> > > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index c2b3d2946a36..3d588ab7a6dd 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> > >       brcm_pcie_bridge_sw_init_set(pcie, 1);
> > >  }
> > >
> > > +static int brcm_pcie_suspend(struct device *dev)
> > > +{
> > > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > > +
> > > +     brcm_pcie_turn_off(pcie);
> > > +     clk_disable_unprepare(pcie->clk);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int brcm_pcie_resume(struct device *dev)
> > > +{
> > > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > > +     void __iomem *base;
> > > +     u32 tmp;
> > > +     int ret;
> > > +
> > > +     base = pcie->base;
> > > +     clk_prepare_enable(pcie->clk);
> > > +
> > > +     /* Take bridge out of reset so we can access the SERDES reg */
> > > +     brcm_pcie_bridge_sw_init_set(pcie, 0);
> > > +
> > > +     /* SERDES_IDDQ = 0 */
> > > +     tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > > +     u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> > > +     writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > > +
> > > +     /* wait for serdes to be stable */
> > > +     udelay(100);
> >
> > Really needs to be a spinloop?
> >
> > > +
> > > +     ret = brcm_pcie_setup(pcie);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (pcie->msi)
> > > +             brcm_msi_set_regs(pcie->msi);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> > >  {
> > >       brcm_msi_remove(pcie);
> > > @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > >
> > >  MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> > >
> > > +static const struct dev_pm_ops brcm_pcie_pm_ops = {
> > > +     .suspend_noirq = brcm_pcie_suspend,
> > > +     .resume_noirq = brcm_pcie_resume,
> >
> > Why do you need interrupts disabled? There's 39 cases of .suspend_noirq
> > and 1352 of .suspend in the tree.
>
> I will test switching this to  suspend_late/resume_early.

Why not just the 'regular' flavor suspend/resume?

Rob
