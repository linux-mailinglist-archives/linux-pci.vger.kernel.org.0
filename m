Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE881FD38C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQRdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 13:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgFQRdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 13:33:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBFC061755
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 10:33:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y78so343948wmc.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QNRuJcws82P7uD3W5Xs1rYxppxPq6ASHSPM69pBKQM=;
        b=Fe61Js+MQ1NB3hDW2FqZX6bK8y0TfX5sBHTNEU2Yk0JzXcTVSvMsGzfAwL++w0EQLB
         gvg4q3+aUrOL9iaNWSM/h2bqDpSD3Vin8EmXucGR/bq6V6PQc6smK+NR7dHcQXgMaWzD
         UgjU7cA2bLrL+Byh9BAxtmivf+9accbbBQyCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QNRuJcws82P7uD3W5Xs1rYxppxPq6ASHSPM69pBKQM=;
        b=gpRuc52XdvnQeKYhIMhDMrf5/0Vht2HP5tZE/YPIFQVJRKO8NCTKgX7HU2bkC0mu8h
         UhFx7gOIfjvTiarGVrmte909zx74PnENevKdFrL+GKk2pvUYU7qiZuJCtU3l+HrPpAU2
         R6FmdWzdWwbzG+jhiebS6BaChDOAFu7dI/iZk4xAjvn9F9XlQ0826OiM1AGDpZquvJCy
         aPtRUNH/z/1AuqL/XYDAw24sVGxaa0vW/H+snkJuO18EWTQ/vy6dTuH87eF8USpCm924
         f+Qs1teRXLYLPW8U7Qw0qrqjnPjjT75a0TrbDklMC1hKyXzZs9gnVq+NuZAqSM4+nMU/
         eKAw==
X-Gm-Message-State: AOAM533s7vOqhUerhRXfsVNlaFOf6SsIyNjhxLjg8gPVP3pIqtw+GgRe
        +DDE1gVu54K5hmVIq+n+al3+JEeQyuhh1pFKylQ98Q==
X-Google-Smtp-Source: ABdhPJxnOs2MLe3C0AP9rvozUlSx2/nymavZrjsSjsvAn9I5kRCXHvTT2TSpRqQfMipTr/dlVrVwhPVh03aW+M/MoWI=
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr9971856wmh.111.1592415179181;
 Wed, 17 Jun 2020 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205533.3513-8-james.quinlan@broadcom.com> <20200616220523.GA1984295@bjorn-Precision-5520>
In-Reply-To: <20200616220523.GA1984295@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 17 Jun 2020 13:32:46 -0400
Message-ID: <CA+-6iNzFVmFp9MkYkRU=nf-sXSFPZY0gqmA0ZT4rfR0q1sueiA@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] PCI: brcmstb: Add control of rescal reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

On Tue, Jun 16, 2020 at 6:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 16, 2020 at 04:55:14PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Some STB chips have a special purpose reset controller named RESCAL (reset
> > calibration).  The PCIe HW can now control RESCAL to start and stop its
> > operation.
>
> The HW *can* now control RESCAL, but what does this patch do?
>
> I guess maybe this patch uses RESCAL to turn on the PHY in probe and
> resume and turn it off in suspend and remove?
Yes, I will redo this text with a better description.

Thanks,
Jim

PS Will attend to your other responses as well in the V6.
>
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
> >  1 file changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index d0e256d8578a..9189406fd35c 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/pci.h>
> >  #include <linux/printk.h>
> > +#include <linux/reset.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -158,6 +159,16 @@
> >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> >  #define PCIE_RGR1_SW_INIT_1(pcie)    (pcie->reg_offsets[RGR1_SW_INIT_1])
> >
> > +/* Rescal registers */
> > +#define PCIE_DVT_PMU_PCIE_PHY_CTRL                           0xc700
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS                       0x3
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK              0x4
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT     0x2
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK          0x2
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT         0x1
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK          0x1
> > +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT         0x0
> > +
> >  enum {
> >       RGR1_SW_INIT_1,
> >       EXT_CFG_INDEX,
> > @@ -248,6 +259,7 @@ struct brcm_pcie {
> >       const int               *reg_offsets;
> >       const int               *reg_field_info;
> >       enum pcie_type          type;
> > +     struct reset_control    *rescal;
> >  };
> >
> >  /*
> > @@ -963,6 +975,47 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
> >               dev_err(pcie->dev, "failed to enter low-power link state\n");
> >  }
> >
> > +static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
> > +{
> > +     static const u32 shifts[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT,
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT,
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT,};
> > +     static const u32 masks[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK,
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK,
> > +             PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK,};
> > +     const int beg = start ? 0 : PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS - 1;
> > +     const int end = start ? PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS : -1;
> > +     u32 tmp, combined_mask = 0;
> > +     u32 val = !!start;
> > +     void __iomem *base = pcie->base;
> > +     int i;
> > +
> > +     for (i = beg; i != end; start ? i++ : i--) {
> > +             tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> > +             tmp = (tmp & ~masks[i]) | ((val << shifts[i]) & masks[i]);
> > +             writel(tmp, base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> > +             usleep_range(50, 200);
> > +             combined_mask |= masks[i];
> > +     }
> > +
> > +     tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> > +     val = start ? combined_mask : 0;
> > +
> > +     return (tmp & combined_mask) == val ? 0 : -EIO;
> > +}
> > +
> > +static inline int brcm_phy_start(struct brcm_pcie *pcie)
> > +{
> > +     return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> > +}
> > +
> > +static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> > +{
> > +     return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> > +}
> > +
> >  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >  {
> >       void __iomem *base = pcie->base;
> > @@ -990,11 +1043,15 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >  static int brcm_pcie_suspend(struct device *dev)
> >  {
> >       struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > +     int ret;
> >
> >       brcm_pcie_turn_off(pcie);
> > +     ret = brcm_phy_stop(pcie);
> > +     if (ret)
> > +             dev_err(pcie->dev, "failed to stop phy\n");
> >       clk_disable_unprepare(pcie->clk);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int brcm_pcie_resume(struct device *dev)
> > @@ -1007,6 +1064,12 @@ static int brcm_pcie_resume(struct device *dev)
> >       base = pcie->base;
> >       clk_prepare_enable(pcie->clk);
> >
> > +     ret = brcm_phy_start(pcie);
> > +     if (ret) {
> > +             dev_err(pcie->dev, "failed to start phy\n");
> > +             return ret;
> > +     }
> > +
> >       /* Take bridge out of reset so we can access the SERDES reg */
> >       brcm_pcie_bridge_sw_init_set(pcie, 0);
> >
> > @@ -1032,6 +1095,9 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> >  {
> >       brcm_msi_remove(pcie);
> >       brcm_pcie_turn_off(pcie);
> > +     if (brcm_phy_stop(pcie))
> > +             dev_err(pcie->dev, "failed to stop phy\n");
> > +     reset_control_assert(pcie->rescal);
> >       clk_disable_unprepare(pcie->clk);
> >  }
> >
> > @@ -1117,6 +1183,19 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >               dev_err(&pdev->dev, "could not enable clock\n");
> >               return ret;
> >       }
> > +     pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> > +     if (IS_ERR(pcie->rescal))
> > +             return PTR_ERR(pcie->rescal);
> > +
> > +     ret = reset_control_deassert(pcie->rescal);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > +
> > +     ret = brcm_phy_start(pcie);
> > +     if (ret) {
> > +             dev_err(pcie->dev, "failed to start phy\n");
> > +             return ret;
> > +     }
> >
> >       ret = brcm_pcie_setup(pcie);
> >       if (ret)
> > --
> > 2.17.1
> >
