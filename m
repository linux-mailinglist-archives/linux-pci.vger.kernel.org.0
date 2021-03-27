Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477834B9E9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 23:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhC0WVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhC0WVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 18:21:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431FAC0613B1;
        Sat, 27 Mar 2021 15:21:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so8713047otn.1;
        Sat, 27 Mar 2021 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhiwA8QdVsrjiKvGTVpszFdDyZbGGYVF4skoC50bngI=;
        b=EWrtJibAIuUIG3qngvPwcQcAT0rpX8YpOLnJSeN5/mRAkjwEd0SgSshSCo8PC/mAwW
         PeA9ERRR+mm6DR6w/tFtO1nEXWOeXYaiat+CAXQZvgqbNfhJ256lLxy2pVJ6g2xyllGf
         CQCjhQ/SKZiOmKRkjvgxOJk3K8XxNKedlEFA2How0RhcQpNtbS8Cyuy8FNtt8eYUqB0L
         kXbEkMFQttm+aNIFgGcw9vD3tGPdjbicrvN1+5mq60H94Va9e0Glj1d0M/+YcpkpGe3B
         mxRR7rWXq2x6z7eGB1+72ZSzLlNg33WYNK9U+7Z0W8KR0AI7aAlcyVKViShi+WEdvbdA
         x4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhiwA8QdVsrjiKvGTVpszFdDyZbGGYVF4skoC50bngI=;
        b=i2qTxqOOsNiTsEAKUnMIRdBfOfmaaeFMNuJapFpre38rOg6zVXFdK2YPbEURG1LIfV
         xugvyR8HnmKmRdeQnkiwOH5ierbX/ga2bKu7t/wuSZyFcTxW4M/v+O9t29kE5vp2l1AF
         Ai6jYIZFyo6ID9j9TQ76sVVjPQWybA0NhQrqLcn83IJ/nPm6DgcNGc54c3AZmlg7JoNK
         D0dTeFOdh9YO4/9aryUc7wzQrV7S2p4jGOzJv6WkGsVgSNKpAINYRx9y54ADN9kutHFv
         r5KUlXavXdOaasyy0mPzrh/ImVMTuDAvlpdRmyhqffFInEEoCa2EVyDK0B07/6yfgGyM
         UNtQ==
X-Gm-Message-State: AOAM5330+SrC1vVksE8QNdpMBAXpWDqK+iVUrlHmg2DNlG1aLFgcOAuh
        kWhulyF1sE+pLiX+qy3y7UrKYZ+1GcSTemB7lk4=
X-Google-Smtp-Source: ABdhPJyyRG5e2UQHXCvsYYwSglnPMEeb+B5lNZQa9TkFmXIpICYUW6MJNtM72K1Bvgt7Sj/Wr1bJ1XYbQC14Y/SKtqk=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr17635477oth.233.1616883670614;
 Sat, 27 Mar 2021 15:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191906.43567-3-jim2101024@gmail.com> <20210326201143.GA903800@bjorn-Precision-5520>
In-Reply-To: <20210326201143.GA903800@bjorn-Precision-5520>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sat, 27 Mar 2021 18:20:59 -0400
Message-ID: <CANCKTBuHXPX5eKAy3rVomFvekd4BfKKWSDM=0bCzhm7pAd29BQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 4:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 03:19:00PM -0400, Jim Quinlan wrote:
> > Control of EP regulators by the RC is needed because of the chicken-and-egg
>
> Can you expand "EP"?  Not sure if this refers to "endpoint" or
> something else.
Yes I meant "endpoint" -- I will expand it.
>
> If this refers to a device in a slot, I guess it isn't necessarily aWe only support this feature for endpoint devices; it they hav
> PCIe *endpoint*; it could also be a switch upstream port.
True; to be precise I mean the device directly connected to the single RC port.
>
> > situation: although the regulator is "owned" by the EP and would be best
> > handled on its driver, the EP cannot be discovered and probed unless its
> > regulator is already turned on.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 90 ++++++++++++++++++++++++++-
> >  1 file changed, 87 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index e330e6811f0b..b76ec7d9af32 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/pci-ecam.h>
> >  #include <linux/printk.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/reset.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > @@ -169,6 +170,7 @@
> >  #define SSC_STATUS_SSC_MASK          0x400
> >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> >  #define PCIE_BRCM_MAX_MEMC           3
> > +#define PCIE_BRCM_MAX_EP_REGULATORS  4
> >
> >  #define IDX_ADDR(pcie)                       (pcie->reg_offsets[EXT_CFG_INDEX])
> >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> > @@ -295,8 +297,27 @@ struct brcm_pcie {
> >       u32                     hw_rev;
> >       void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > +     struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
> > +     unsigned int            num_supplies;
> >  };
> >
> > +static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     int ret;
> > +
> > +     if (!pcie->num_supplies)
> > +             return 0;
> > +     if (on)
> > +             ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
> > +     else
> > +             ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
> > +     if (ret)
> > +             dev_err(dev, "failed to %s EP regulators\n",
> > +                     on ? "enable" : "disable");
> > +     return ret;
> > +}
> > +
> >  /*
> >   * This is to convert the size of the inbound "BAR" region to the
> >   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> > @@ -1141,16 +1162,63 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >       pcie->bridge_sw_init_set(pcie, 1);
> >  }
> >
> > +static int brcm_pcie_get_regulators(struct brcm_pcie *pcie)
> > +{
> > +     struct device_node *child, *parent = pcie->np;
> > +     const unsigned int max_name_len = 64 + 4;
> > +     struct property *pp;
> > +
> > +     /* Look for regulator supply property in the EP device subnodes */
> > +     for_each_available_child_of_node(parent, child) {
> > +             /*
> > +              * Do a santiy test to ensure that this is an EP node
>
> s/santiy/sanity/
>
> > +              * (e.g. node name: "pci-ep@0,0").  The slot number
> > +              * should always be 0 as our controller only has a single
> > +              * port.
> > +              */
> > +             const char *p = strstr(child->full_name, "@0");
> > +
> > +             if (!p || (p[2] && p[2] != ','))
> > +                     continue;
> > +
> > +             /* Now look for regulator supply properties */
> > +             for_each_property_of_node(child, pp) {
> > +                     int i, n = strnlen(pp->name, max_name_len);
> > +
> > +                     if (n <= 7 || strncmp("-supply", &pp->name[n - 7], 7))
> > +                             continue;
> > +
> > +                     /* Make sure this is not a duplicate */
> > +                     for (i = 0; i < pcie->num_supplies; i++)
> > +                             if (strncmp(pcie->supplies[i].supply,
> > +                                         pp->name, max_name_len) == 0)
> > +                                     continue;
> > +
> > +                     if (pcie->num_supplies < PCIE_BRCM_MAX_EP_REGULATORS)
> > +                             pcie->supplies[pcie->num_supplies++].supply = pp->name;
> > +                     else
> > +                             dev_warn(pcie->dev, "No room for EP supply %s\n",
> > +                                      pp->name);
> > +             }
> > +     }
> > +     /*
> > +      * Get the regulators that the EP devices require.  We cannot use
> > +      * pcie->dev as the device argument in regulator_bulk_get() since
> > +      * it will not find the regulators.  Instead, use NULL and the
> > +      * regulators are looked up by their name.
>
> The comment doesn't explain the interesting part of why you need NULL
> instead of "pcie->dev".  I assume it has something to do with the
> platform topology and its DT description.
>
> This appears to be the only instance in the whole kernel of a use of
> regulator_bulk_get() or devm_regulator_bulk_get() with NULL.  That
> definitely warrants a comment, so I'm glad you've got something here.
>
> The regulator_bulk_get() function comment doesn't mention the
> possibility of "dev == NULL", although regulator_dev_lookup(),
> create_regulator(), device_link_add() do check for it being NULL, so I
> guess it's not a surprise.  We may call dev_err(NULL), which I thinkWe only support this feature for endpoint devices; it they hav
> will *work* without crashing even though it will look like a mistake
> on the output.
Folks wanted me to put the "supply" in the endpoint subnode.  After
looking at the regulator code I assumed that using the pcie->dev in
this call would not work as the supply property is not in its DT node.
Turns out it works fine; I will fix it.
>
> > +      */
> > +     return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);
>
> devm_regulator_bulk_get()?
Yep.
>
> > +}
> > +
> >  static int brcm_pcie_suspend(struct device *dev)
> >  {
> >       struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > -     int ret;
> >
> >       brcm_pcie_turn_off(pcie);
> > -     ret = brcm_phy_stop(pcie);
> > +     brcm_phy_stop(pcie);We only support this feature for endpoint devices; it they hav
>
> If we no longer care whether brcm_phy_stop() returns an error, nobody
> looks at the return value and it could be void.
Will fix.

Thanks,
Jim Quinlan
Broadcom STB
>
> >       clk_disable_unprepare(pcie->clk);
> >
> > -     return ret;
> > +     return brcm_set_regulators(pcie, false);
> >  }
> >
> >  static int brcm_pcie_resume(struct device *dev)
> > @@ -1163,6 +1231,10 @@ static int brcm_pcie_resume(struct device *dev)
> >       base = pcie->base;
> >       clk_prepare_enable(pcie->clk);
> >
> > +     ret = brcm_set_regulators(pcie, true);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret = brcm_phy_start(pcie);
> >       if (ret)
> >               goto err;
> > @@ -1199,6 +1271,8 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> >       brcm_phy_stop(pcie);
> >       reset_control_assert(pcie->rescal);
> >       clk_disable_unprepare(pcie->clk);
> > +     brcm_set_regulators(pcie, false);
> > +     regulator_bulk_free(pcie->num_supplies, pcie->supplies);
> >  }
> >
> >  static int brcm_pcie_remove(struct platform_device *pdev)
> > @@ -1289,6 +1363,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > +     ret = brcm_pcie_get_regulators(pcie);
> > +     if (ret) {
> > +             dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
> > +             goto fail;
> > +     }
> > +
> > +     ret = brcm_set_regulators(pcie, true);
> > +     if (ret)
> > +             goto fail;
> > +
> >       ret = brcm_pcie_setup(pcie);
> >       if (ret)
> >               goto fail;
> > --
> > 2.17.1
> >
