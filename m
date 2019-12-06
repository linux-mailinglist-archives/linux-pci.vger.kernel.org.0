Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31757114E4B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 10:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLFJo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 04:44:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52497 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFJo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 04:44:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so7096951wmc.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2019 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tD5cN6JrZpuSFRCt7liglnMruHf8uGIUBSOId/ul41Y=;
        b=Oc8XoFX5YOak0ZJQTZ4mpoDZHSTysWBR5rH14aTYu31Ew4GiKUwD2MgJE6LyhjEhVL
         AAs41F2SglycrHK/NPesRG88wRsTopB5XI1ITwYJY9+PtSg8Ba3VnV5CsjloGCzSRN8P
         zt1GHgab+fdLiBLOr7CelRJypEMolmKwhMg/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tD5cN6JrZpuSFRCt7liglnMruHf8uGIUBSOId/ul41Y=;
        b=Bqq1R0FgxTUCeXtADC5xOqunXO7BwEg4cQIC5yOmevUIIGrZkVUpATh1sLVgQwb24E
         I9gnOwbCMll/0uAznPYb0PBH2uGkeks5m0dpG/Rw7B7tGVaIMtWKtjn96Jixne/dwJeG
         zkh6PqYuIeVvqYPTNaLLzPL+r3Z3Bpb664GIRnzDsyIlGuE9eNxPEzBoRhjm7nUHxvDC
         hSvXwEHjLQWEen21rELFMG2ufWNS9sn54IZxmwkz0wXmh6I0WJhVUxJy6Pel6gj/EBp5
         m7nqM2UPKyBAUorzLKncL93lOSaw+KXGSj8ZRCB/vjT+pEVPnvM+fEv0mxvdwrcVvE5C
         91iA==
X-Gm-Message-State: APjAAAUvhjfo7eKwEp4apWDGlBdQ76dmlfixl4Ru1kdZxd3qxGhb0kCZ
        xdwx03/Hff+BGFrCi0EldxX6Ks3MneOasZOdVPrq0w==
X-Google-Smtp-Source: APXvYqyqAr8t+VqBdWWoSFNj3FbSNTxUyRiKH8kmrnrqoFnvXce9BSxmOl9qwYeYzyc8yxiVo0+B6bl/R5EK0Ia5/1Q=
X-Received: by 2002:a1c:a141:: with SMTP id k62mr9029403wme.98.1575625463761;
 Fri, 06 Dec 2019 01:44:23 -0800 (PST)
MIME-Version: 1.0
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com> <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 6 Dec 2019 15:14:11 +0530
Message-ID: <CABe79T6vAQdk1BQ=yGScJ3F5Xd8qFEbaCiTw29kFoyhrZDLZkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 3, 2019 at 9:25 PM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:
> > From: Ray Jui <ray.jui@broadcom.com>
> >
> > Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
> > modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
> > INTD share the same interrupt line connected to the GIC in the system,
> > while the status of each INTx can be obtained through the INTX CSR
> > register
> >
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 100 +++++++++++++++++++++++++++++++++++-
> >  drivers/pci/controller/pcie-iproc.h |   6 +++
> >  2 files changed, 104 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 2d457bf..e90c22e 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip/arm-gic-v3.h>
> > +#include <linux/irqchip/chained_irq.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> > @@ -270,6 +271,7 @@ enum iproc_pcie_reg {
> >
> >       /* enable INTx */
> >       IPROC_PCIE_INTX_EN,
> > +     IPROC_PCIE_INTX_CSR,
> >
> >       /* outbound address mapping */
> >       IPROC_PCIE_OARR0,
> > @@ -314,6 +316,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
> >       [IPROC_PCIE_CFG_ADDR]           = 0x1f8,
> >       [IPROC_PCIE_CFG_DATA]           = 0x1fc,
> >       [IPROC_PCIE_INTX_EN]            = 0x330,
> > +     [IPROC_PCIE_INTX_CSR]           = 0x334,
> >       [IPROC_PCIE_LINK_STATUS]        = 0xf0c,
> >  };
> >
> > @@ -325,6 +328,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
> >       [IPROC_PCIE_CFG_ADDR]           = 0x1f8,
> >       [IPROC_PCIE_CFG_DATA]           = 0x1fc,
> >       [IPROC_PCIE_INTX_EN]            = 0x330,
> > +     [IPROC_PCIE_INTX_CSR]           = 0x334,
> >       [IPROC_PCIE_OARR0]              = 0xd20,
> >       [IPROC_PCIE_OMAP0]              = 0xd40,
> >       [IPROC_PCIE_OARR1]              = 0xd28,
> > @@ -341,6 +345,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
> >       [IPROC_PCIE_CFG_ADDR]           = 0x1f8,
> >       [IPROC_PCIE_CFG_DATA]           = 0x1fc,
> >       [IPROC_PCIE_INTX_EN]            = 0x330,
> > +     [IPROC_PCIE_INTX_CSR]           = 0x334,
> >       [IPROC_PCIE_OARR0]              = 0xd20,
> >       [IPROC_PCIE_OMAP0]              = 0xd40,
> >       [IPROC_PCIE_OARR1]              = 0xd28,
> > @@ -846,9 +851,95 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
> >       return link_is_active ? 0 : -ENODEV;
> >  }
> >
> > -static void iproc_pcie_enable(struct iproc_pcie *pcie)
> > +static int iproc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> > +                            irq_hw_number_t hwirq)
> >  {
> > +     irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > +     irq_set_chip_data(irq, domain->host_data);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops intx_domain_ops = {
> > +     .map = iproc_pcie_intx_map,
> > +};
> > +
> > +static void iproc_pcie_isr(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct iproc_pcie *pcie;
> > +     struct device *dev;
> > +     unsigned long status;
> > +     u32 bit, virq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +     pcie = irq_desc_get_handler_data(desc);
> > +     dev = pcie->dev;
> > +
> > +     /* go through INTx A, B, C, D until all interrupts are handled */
> > +     do {
> > +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
>
> By performing this read once and outside of the do/while loop you may improve
> performance. I wonder how probable it is to get another INTx whilst handling
> one?
>
>
> > +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> > +                     virq = irq_find_mapping(pcie->irq_domain, bit);
> > +                     if (virq)
> > +                             generic_handle_irq(virq);
> > +                     else
> > +                             dev_err(dev, "unexpected INTx%u\n", bit);
> > +             }
> > +     } while ((status & SYS_RC_INTX_MASK) != 0);
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int iproc_pcie_intx_enable(struct iproc_pcie *pcie)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     struct device_node *node;
> > +     int ret;
> > +
> >       iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
> > +     /*
> > +      * BCMA devices do not map INTx the same way as platform devices. All
> > +      * BCMA needs is the above code to enable INTx
> > +      */
>
> NIT: Move this comment above the line of code?
I will change in the next patch set.
>
>
> > +
> > +     node = of_get_compatible_child(dev->of_node, "brcm,iproc-intc");
>
> As the interrupt controller is built into the PCI controller, what is the
> rationale for representing this as a separate device tree device?
In patchset v1, PCIe controller was taken as interrupt controller
which is not correct.
So that, separate DT node was taken, based on comments below link.
https://lore.kernel.org/linux-pci/CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com/
>
> Thanks,
>
> Andrew Murray
>
> > +     if (node)
> > +             pcie->irq = of_irq_get(node, 0);
> > +
> > +     if (!node || pcie->irq <= 0)
> > +             return 0;
> > +
> > +     /* set IRQ handler */
> > +     irq_set_chained_handler_and_data(pcie->irq, iproc_pcie_isr, pcie);
> > +
> > +     /* add IRQ domain for INTx */
> > +     pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> > +                                              &intx_domain_ops, pcie);
> > +     if (!pcie->irq_domain) {
> > +             dev_err(dev, "failed to add INTx IRQ domain\n");
> > +             ret = -ENOMEM;
> > +             goto err_rm_handler_data;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_rm_handler_data:
> > +     of_node_put(node);
> > +     irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> > +
> > +     return ret;
> > +}
> > +
> > +static void iproc_pcie_intx_disable(struct iproc_pcie *pcie)
> > +{
> > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, 0x0);
> > +
> > +     if (pcie->irq <= 0)
> > +             return;
> > +
> > +     irq_domain_remove(pcie->irq_domain);
> > +     irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> >  }
> >
> >  static inline bool iproc_pcie_ob_is_valid(struct iproc_pcie *pcie,
> > @@ -1537,7 +1628,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >               goto err_power_off_phy;
> >       }
> >
> > -     iproc_pcie_enable(pcie);
> > +     ret = iproc_pcie_intx_enable(pcie);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable INTx\n");
> > +             goto err_power_off_phy;
> > +     }
> >
> >       if (IS_ENABLED(CONFIG_PCI_MSI))
> >               if (iproc_pcie_msi_enable(pcie))
> > @@ -1582,6 +1677,7 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
> >       pci_remove_root_bus(pcie->root_bus);
> >
> >       iproc_pcie_msi_disable(pcie);
> > +     iproc_pcie_intx_disable(pcie);
> >
> >       phy_power_off(pcie->phy);
> >       phy_exit(pcie->phy);
> > diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
> > index 4f03ea5..103e568 100644
> > --- a/drivers/pci/controller/pcie-iproc.h
> > +++ b/drivers/pci/controller/pcie-iproc.h
> > @@ -74,6 +74,9 @@ struct iproc_msi;
> >   * @ib: inbound mapping related parameters
> >   * @ib_map: outbound mapping region related parameters
> >   *
> > + * @irq: interrupt line wired to the generic GIC for INTx
> > + * @irq_domain: IRQ domain for INTx
> > + *
> >   * @need_msi_steer: indicates additional configuration of the iProc PCIe
> >   * controller is required to steer MSI writes to external interrupt controller
> >   * @msi: MSI data
> > @@ -102,6 +105,9 @@ struct iproc_pcie {
> >       struct iproc_pcie_ib ib;
> >       const struct iproc_pcie_ib_map *ib_map;
> >
> > +     int irq;
> > +     struct irq_domain *irq_domain;
> > +
> >       bool need_msi_steer;
> >       struct iproc_msi *msi;
> >  };
> > --
> > 2.7.4
> >
