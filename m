Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216BB1B7E60
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXSz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 14:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDXSz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 14:55:26 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86452075A;
        Fri, 24 Apr 2020 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587754526;
        bh=/zsuBLZBWcyKhFy0XnQh9GmAuII7wM1H2MRZQWN7pb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4V0I0t08Tu4XOP7uq+nK7X2CqD6+siNyymB/9Zru8WCjhaDmYr/82Z28tC8OOzau
         Gpkoeqt+PlTp9RYlpU/NV3PvxZiz5bccFVD433/zDHP/ecmVVa3c8hVO7CfTYzh0km
         e/DpyW/Naddj1tB9x4NRoQq8DEgVFaM95ICuLZ5o=
Received: by pali.im (Postfix)
        id D5F17832; Fri, 24 Apr 2020 20:55:23 +0200 (CEST)
Date:   Fri, 24 Apr 2020 20:55:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 04/12] PCI: aardvark: Improve link training
Message-ID: <20200424185523.hevihypwklly6vrs@pali>
References: <20200424153858.29744-1-pali@kernel.org>
 <20200424153858.29744-5-pali@kernel.org>
 <CAL_JsqLTXGE4SAmbzkPJ-omusMiSoBwgF0j8HhAq7F+9w7g1wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLTXGE4SAmbzkPJ-omusMiSoBwgF0j8HhAq7F+9w7g1wg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 24 April 2020 12:00:54 Rob Herring wrote:
> On Fri, Apr 24, 2020 at 10:39 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > From: Marek Behún <marek.behun@nic.cz>
> >
> > Currently the aardvark driver trains link in PCIe gen2 mode. This may
> > cause some buggy gen1 cards (such as Compex WLE900VX) to be unstable or
> > even not detected. Moreover when ASPM code tries to retrain link second
> > time, these cards may stop responding and link goes down. If gen1 is
> > used this does not happen.
> >
> > Unconditionally forcing gen1 is not a good solution since it may have
> > performance impact on gen2 cards.
> >
> > To overcome this, read 'max-link-speed' property (as defined in PCI
> > device tree bindings) and use this as max gen mode. Then iteratively try
> > link training at this mode or lower until successful. After successful
> > link training choose final controller gen based on Negotiated Link Speed
> > from Link Status register, which should match card speed.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <marek.behun@nic.cz>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 113 ++++++++++++++++++++------
> >  1 file changed, 88 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 74b90940a9d4..a6c4d4d52631 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -40,6 +40,7 @@
> >  #define PCIE_CORE_LINK_CTRL_STAT_REG                           0xd0
> >  #define     PCIE_CORE_LINK_L0S_ENTRY                           BIT(0)
> >  #define     PCIE_CORE_LINK_TRAINING                            BIT(5)
> > +#define     PCIE_CORE_LINK_SPEED_SHIFT                         16
> >  #define     PCIE_CORE_LINK_WIDTH_SHIFT                         20
> >  #define PCIE_CORE_ERR_CAPCTL_REG                               0x118
> >  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX                   BIT(5)
> > @@ -201,6 +202,7 @@ struct advk_pcie {
> >         struct mutex msi_used_lock;
> >         u16 msi_msg;
> >         int root_bus_nr;
> > +       int link_gen;
> >         struct pci_bridge_emul bridge;
> >  };
> >
> > @@ -225,20 +227,16 @@ static int advk_pcie_link_up(struct advk_pcie *pcie)
> >
> >  static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
> >  {
> > -       struct device *dev = &pcie->pdev->dev;
> >         int retries;
> >
> >         /* check if the link is up or not */
> >         for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > -               if (advk_pcie_link_up(pcie)) {
> > -                       dev_info(dev, "link up\n");
> > +               if (advk_pcie_link_up(pcie))
> >                         return 0;
> > -               }
> >
> >                 usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> >         }
> >
> > -       dev_err(dev, "link never came up\n");
> >         return -ETIMEDOUT;
> >  }
> >
> > @@ -253,6 +251,85 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
> >         }
> >  }
> >
> > +static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
> > +{
> > +       int ret, neg_gen;
> > +       u32 reg;
> > +
> > +       /* Setup link speed */
> > +       reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > +       reg &= ~PCIE_GEN_SEL_MSK;
> > +       if (gen == 3)
> > +               reg |= SPEED_GEN_3;
> > +       else if (gen == 2)
> > +               reg |= SPEED_GEN_2;
> > +       else
> > +               reg |= SPEED_GEN_1;
> > +       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > +
> > +       /*
> > +        * Enable link training. This is not needed in every call to this
> > +        * function, just once suffices, but it does not break anything either.
> > +        */
> > +       reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > +       reg |= LINK_TRAINING_EN;
> > +       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > +
> > +       /*
> > +        * Start link training immediately after enabling it.
> > +        * This solves problems for some buggy cards.
> > +        */
> > +       reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> > +       reg |= PCIE_CORE_LINK_TRAINING;
> > +       advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> > +
> > +       ret = advk_pcie_wait_for_link(pcie);
> > +       if (ret)
> > +               return ret;
> > +
> > +       reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> > +       neg_gen = (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
> > +
> > +       return neg_gen;
> > +}
> > +
> > +static void advk_pcie_train_link(struct advk_pcie *pcie)
> > +{
> > +       struct device *dev = &pcie->pdev->dev;
> > +       int neg_gen = -1, gen;
> > +
> > +       /*
> > +        * Try link training at link gen specified by device tree property
> > +        * 'max-link-speed'. If this fails, iteratively train at lower gen.
> > +        */
> > +       for (gen = pcie->link_gen; gen > 0; --gen) {
> > +               neg_gen = advk_pcie_train_at_gen(pcie, gen);
> > +               if (neg_gen > 0)
> > +                       break;
> > +       }
> > +
> > +       if (neg_gen < 0)
> > +               goto err;
> > +
> > +       /*
> > +        * After successful training if negotiated gen is lower than requested,
> > +        * train again on negotiated gen. This solves some stability issues for
> > +        * some buggy gen1 cards.
> > +        */
> > +       if (neg_gen < gen) {
> > +               gen = neg_gen;
> > +               neg_gen = advk_pcie_train_at_gen(pcie, gen);
> > +       }
> > +
> > +       if (neg_gen == gen) {
> > +               dev_info(dev, "link up at gen %i\n", gen);
> > +               return;
> > +       }
> > +
> > +err:
> > +       dev_err(dev, "link never came up\n");
> > +}
> > +
> >  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  {
> >         u32 reg;
> > @@ -288,12 +365,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >                 PCIE_CORE_CTRL2_TD_ENABLE;
> >         advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> >
> > -       /* Set GEN2 */
> > -       reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > -       reg &= ~PCIE_GEN_SEL_MSK;
> > -       reg |= SPEED_GEN_2;
> > -       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > -
> >         /* Set lane X1 */
> >         reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> >         reg &= ~LANE_CNT_MSK;
> > @@ -341,20 +412,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >          */
> >         msleep(PCI_PM_D3COLD_WAIT);
> >
> > -       /* Enable link training */
> > -       reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > -       reg |= LINK_TRAINING_EN;
> > -       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > -
> > -       /*
> > -        * Start link training immediately after enabling it.
> > -        * This solves problems for some buggy cards.
> > -        */
> > -       reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> > -       reg |= PCIE_CORE_LINK_TRAINING;
> > -       advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> > -
> > -       advk_pcie_wait_for_link(pcie);
> > +       advk_pcie_train_link(pcie);
> >
> >         reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> >         reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
> > @@ -988,6 +1046,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >         }
> >         pcie->root_bus_nr = bus->start;
> >
> > +       ret = of_pci_get_max_link_speed(dev->of_node);
> > +       if (ret < 0)
> > +               return ret;
> 
> Why just give up simply on DT error? Just start at gen 3 since you now
> retry at lower speeds.

Ou, I forgot there a special check for ret == -ENOENT.

> > +       pcie->link_gen = (ret > 3) ? 3 : ret;
> > +
> >         advk_pcie_setup_hw(pcie);
> >
> >         advk_sw_pci_bridge_init(pcie);
> > --
> > 2.20.1
> >
