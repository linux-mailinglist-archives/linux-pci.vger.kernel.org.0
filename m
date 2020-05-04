Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFC1C3F02
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgEDPwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgEDPwu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 11:52:50 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343E320705;
        Mon,  4 May 2020 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588607569;
        bh=AGDxw0MW8aAebw6WlhG9CfOILh00EtjOKxqc25DpNow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R300NHO1dDSUAthZKMfjGmN7n4jKSBZCh/GQhoQYgQsQYkwEck8KsCP0v8JQ4mlJ8
         ixgHfgpSlETQ2IOHghiYKvfJ1VrKK1dG9uj0xsSzAVNKICd3k5hsBUrSdAkNZEeM8V
         YhkpKQdoHwIz8XGmeV0MchZPmGHsToBCmIjLm6zI=
Date:   Mon, 4 May 2020 10:52:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 08/12] PCI: aardvark: Replace custom macros by
 standard linux/pci_regs.h macros
Message-ID: <20200504155247.GA271721@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-9-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 10:06:21AM +0200, Pali Rohár wrote:
> PCI-E capability macros are already defined in linux/pci_regs.h.
> Remove their reimplementation in pcie-aardvark.

s/PCI-E/PCIe/

I mentioned this last time, but I guess you missed it.

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 41 ++++++++++++---------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 053ae6c19a3d..c53ae2511a9c 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -34,17 +34,6 @@
>  #define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
>  #define PCIE_CORE_DEV_REV_REG					0x8
>  #define PCIE_CORE_PCIEXP_CAP					0xc0
> -#define PCIE_CORE_DEV_CTRL_STATS_REG				0xc8
> -#define     PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE	(0 << 4)
> -#define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
> -#define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
> -#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
> -#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
> -#define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
> -#define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
> -#define     PCIE_CORE_LINK_TRAINING				BIT(5)
> -#define     PCIE_CORE_LINK_SPEED_SHIFT				16
> -#define     PCIE_CORE_LINK_WIDTH_SHIFT				20
>  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
> @@ -223,6 +212,11 @@ static inline u32 advk_readl(struct advk_pcie *pcie, u64 reg)
>  	return readl(pcie->base + reg);
>  }
>  
> +static inline u16 advk_read16(struct advk_pcie *pcie, u64 reg)
> +{
> +	return advk_readl(pcie, (reg & ~0x3)) >> ((reg & 0x3) * 8);
> +}
> +
>  static int advk_pcie_link_up(struct advk_pcie *pcie)
>  {
>  	u32 val, ltssm_state;
> @@ -286,16 +280,16 @@ static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
>  	 * Start link training immediately after enabling it.
>  	 * This solves problems for some buggy cards.
>  	 */
> -	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> -	reg |= PCIE_CORE_LINK_TRAINING;
> -	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> +	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
> +	reg |= PCI_EXP_LNKCTL_RL;
> +	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
>  
>  	ret = advk_pcie_wait_for_link(pcie);
>  	if (ret)
>  		return ret;
>  
> -	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> -	neg_gen = (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
> +	reg = advk_read16(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKSTA);
> +	neg_gen = reg & PCI_EXP_LNKSTA_CLS;
>  
>  	return neg_gen;
>  }
> @@ -385,13 +379,14 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
>  	advk_writel(pcie, reg, PCIE_CORE_ERR_CAPCTL_REG);
>  
> -	/* Set PCIe Device Control and Status 1 PF0 register */
> -	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
> -		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
> -		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
> -		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
> -		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
> -	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
> +	/* Set PCIe Device Control register */
> +	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> +	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
> +	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> +	reg &= ~PCI_EXP_DEVCTL_READRQ;
> +	reg |= PCI_EXP_DEVCTL_PAYLOAD; /* Set max payload size */
> +	reg |= PCI_EXP_DEVCTL_READRQ_512B;
> +	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>  
>  	/* Program PCIe Control 2 to disable strict ordering */
>  	reg = PCIE_CORE_CTRL2_RESERVED |
> -- 
> 2.20.1
> 
