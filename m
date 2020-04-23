Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325C61B63E2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgDWSjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbgDWSjQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 14:39:16 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0C820767;
        Thu, 23 Apr 2020 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667156;
        bh=cuYjB9ls/RJYVkMRBYEGViFdRykOE2Fb7FnWf8ljgoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XGurc8Wa+9MqLMySmpB6MUm/Jutc9I6mo78jHQWD4v32iQ1cpzWeHasxQ84P0vwcu
         AE7qsxKaD2ALGZvLa80zdMrcqqTXWLWTZPoqfiqFd+KQtOeIQJ+1OhuNLbWayNdMEz
         bd+oEsJwJUsp+f4EMTxWBQdYwisZDXGZZXwme1FM=
Date:   Thu, 23 Apr 2020 13:39:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/9] PCI: aardvark: improve link training
Message-ID: <20200423183914.GA201745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-4-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Tue, Apr 21, 2020 at 01:16:55PM +0200, Marek Behún wrote:
> Currently the aardvark driver trains link in PCIe gen2 mode. This may
> cause some buggy gen 1 cards (such as Compex WLE900VX) to be unstable or
> even not detected. Moreover when ASPM code tries to retrain link second
> time, these cards may stop responding and link goes down. If gen1 is
> used this does not happen.

Does this patch make the retrain done by ASPM reliable?  If aardvark
can't work reliably at gen2, you may need to just restrict it to gen1.

> Unconditionally forcing gen1 is not a good solution since it may have
> performance impact on gen2 cards.
> 
> To overcome this, read 'max-link-speed' property (as defined in PCI
> device tree bindings) and use this as max gen mode. Then iteratively try
> link training at this mode or lower until successful. After successful
> link training choose final controlled gen based on Negotiated Link Speed
> from Link Status register, which should match card speed.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> ---
>  drivers/pci/controller/pci-aardvark.c | 111 ++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 551d98174613..606bae1e7a88 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -40,6 +40,7 @@
>  #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
>  #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
>  #define     PCIE_CORE_LINK_TRAINING				BIT(5)
> +#define     PCIE_CORE_LINK_SPEED_SHIFT				16
>  #define     PCIE_CORE_LINK_WIDTH_SHIFT				20
>  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> @@ -201,6 +202,7 @@ struct advk_pcie {
>  	struct mutex msi_used_lock;
>  	u16 msi_msg;
>  	int root_bus_nr;
> +	int link_gen;
>  	struct pci_bridge_emul bridge;
>  };
>  
> @@ -225,20 +227,16 @@ static int advk_pcie_link_up(struct advk_pcie *pcie)
>  
>  static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
>  {
> -	struct device *dev = &pcie->pdev->dev;
>  	int retries;
>  
>  	/* check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (advk_pcie_link_up(pcie)) {
> -			dev_info(dev, "link up\n");
> +		if (advk_pcie_link_up(pcie))
>  			return 0;
> -		}
>  
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}
>  
> -	dev_err(dev, "link never came up\n");
>  	return -ETIMEDOUT;
>  }
>  
> @@ -253,6 +251,84 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
>  	}
>  }
>  
> +static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
> +{
> +	int ret, neg_gen;
> +	u32 reg;
> +
> +	/* Setup link speed */
> +	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +	reg &= ~PCIE_GEN_SEL_MSK;
> +	if (gen == 2)
> +		reg |= SPEED_GEN_2;
> +	else
> +		reg |= SPEED_GEN_1;
> +	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +	/*
> +	 * Enable link training. This is not needed in every call to this
> +	 * function, just once suffices, but it does not break anything either.
> +	 */
> +	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +	reg |= LINK_TRAINING_EN;
> +	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +	/*
> +	 * Start link training immediately after enabling it. This solves
> +	 * problems for some buggy cards.
> +	 */
> +	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +	reg |= PCIE_CORE_LINK_TRAINING;
> +	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> +
> +	ret = advk_pcie_wait_for_link(pcie);
> +	if (ret)
> +		return ret;
> +
> +	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +	neg_gen = (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
> +
> +	return neg_gen;
> +}
> +
> +static void advk_pcie_train_link(struct advk_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	int neg_gen = -1, gen;
> +
> +	/*
> +	 * Try link training at link gen specified by device tree property
> +	 * 'max-link-speed' (defaults to 2, since this controller does not
> +	 * support higher gen). If this fails, iteratively train at lower gen.
> +	 */
> +	for (gen = pcie->link_gen; gen > 0; --gen) {
> +		neg_gen = advk_pcie_train_at_gen(pcie, gen);
> +		if (neg_gen > 0)
> +			break;
> +	}
> +
> +	if (neg_gen < 0)
> +		goto err;
> +
> +	/*
> +	 * After successful training if negotiated gen is lower than requested,
> +	 * train again on negotiated gen. This solves some stability issues for
> +	 * some buggy gen1 cards.
> +	 */
> +	if (neg_gen < gen) {
> +		gen = neg_gen;
> +		neg_gen = advk_pcie_train_at_gen(pcie, gen);
> +	}
> +
> +	if (neg_gen == gen) {
> +		dev_info(dev, "link up at gen %i\n", gen);
> +		return;
> +	}
> +
> +err:
> +	dev_err(dev, "link never came up\n");
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>  	u32 reg;
> @@ -288,12 +364,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  		PCIE_CORE_CTRL2_TD_ENABLE;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
>  
> -	/* Set GEN2 */
> -	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> -	reg &= ~PCIE_GEN_SEL_MSK;
> -	reg |= SPEED_GEN_2;
> -	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -
>  	/* Set lane X1 */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg &= ~LANE_CNT_MSK;
> @@ -341,20 +411,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	 */
>  	msleep(PCI_PM_D3COLD_WAIT);
>  
> -	/* Enable link training */
> -	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> -	reg |= LINK_TRAINING_EN;
> -	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -
> -	/*
> -	 * Start link training immediately after enabling it. This solves
> -	 * problems for some buggy cards.
> -	 */
> -	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> -	reg |= PCIE_CORE_LINK_TRAINING;
> -	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> -
> -	advk_pcie_wait_for_link(pcie);
> +	advk_pcie_train_link(pcie);
>  
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
> @@ -988,6 +1045,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	}
>  	pcie->root_bus_nr = bus->start;
>  
> +	pcie->link_gen = of_pci_get_max_link_speed(dev->of_node);
> +	if (pcie->link_gen < 1 || pcie->link_gen > 2)

This is a DT error, isn't it?  Maybe should warn about it and mention
how you're dealing with it?

> +		pcie->link_gen = 2;
> +
>  	advk_pcie_setup_hw(pcie);
>  
>  	advk_sw_pci_bridge_init(pcie);
> -- 
> 2.24.1
> 
