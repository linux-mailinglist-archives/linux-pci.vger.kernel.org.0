Return-Path: <linux-pci+bounces-38394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23177BE5545
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 22:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D438C4E73C1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571ED2DC793;
	Thu, 16 Oct 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kg5T7JMw"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE962D46B2;
	Thu, 16 Oct 2025 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645489; cv=none; b=tDc7p+z0wZECHVJqocy/titrsjsVca3HknIWGDszuvILnmRiItpaoPhV67unfVZNyAXheYi0u2qMq7IF9xBhfzd0guydPhygdL5bZcZYWiI8SVvR0X7HQVnsjyV7XWdWDb/ImHnC8PQSTpsTNLbB7pKFR2qCzww+B9977tHf130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645489; c=relaxed/simple;
	bh=08kr2l/UWyG32Kp/2Umrbh3yZs0+clQ80REy2fHQfC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2E7aO3Et8x2r7kg7X6Av2JBBXyE1n1J1f3xksV8n77XJpmvD1vCLS2G3IcRmJ8vsHvYqBACX9K/Fw/dkUck1XIWyvL/x6HbBwp2LM+2SXWfcFt8Bzc5Bon+HtHu+tdgK69M2uGAT9Jv17Su/1qmYzn6Ag6P/osYqPBD6E+qya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kg5T7JMw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fH3uOL5pAcLj4w5mtMBuA/UvzktBnN4zub1YlfQY7TY=; b=Kg5T7JMwo1EPZEU182K+GycJh0
	VA6ynNMfzDNQL0AS5Sz2UpaWtCZl6K6mYSteM9uPB+2qbzu3BLVF1sIIsOt31EXEYRZqKCMFbILEV
	tZ6X3Lp6uMi4YP4abHshLoAi7WOOnW3df4uoJkQzk5mZoXV3nE1O671BY9wEr1UjTSIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9UJS-00BCbc-Pl; Thu, 16 Oct 2025 22:11:02 +0200
Date: Thu, 16 Oct 2025 22:11:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: stmmac: Add glue driver for Motorcomm
 YT6801 ethernet controller
Message-ID: <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014164746.50696-5-ziyao@disroot.org>

> +static int motorcomm_efuse_read_byte(struct dwmac_motorcomm_priv *priv,
> +				     u8 offset, u8 *byte)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	writel(FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_ROW_READ)	|
> +	       FIELD_PREP(EFUSE_OP_ADDR, offset)		|
> +	       EFUSE_OP_START, priv->base + EFUSE_OP_CTRL_0);
> +
> +	ret = readl_poll_timeout(priv->base + EFUSE_OP_CTRL_1,
> +				 reg, reg & EFUSE_OP_DONE, 2000,
> +				 EFUSE_READ_TIMEOUT_US);
> +
> +	reg = readl(priv->base + EFUSE_OP_CTRL_1);

Do you actually need this read? The documentation says:

 * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
 * case, the last read value at @addr is stored in @val.

> +	*byte = FIELD_GET(EFUSE_OP_RD_DATA, reg);
> +
> +	return ret;
> +}

> +static void motorcomm_reset_phy(struct dwmac_motorcomm_priv *priv)
> +{
> +	u32 reg = readl(priv->base + EPHY_CTRL);
> +
> +	reg &= ~EPHY_RESET;
> +	writel(reg, priv->base + EPHY_CTRL);
> +
> +	reg |= EPHY_RESET;
> +	writel(reg, priv->base + EPHY_CTRL);
> +}

How does this differ to the PHY doing its own reset via BMCR?

We need to be careful of lifetimes here. It would be better if the PHY
controlled its own reset. We don't want phylib to configure the PHY
and then the MAC driver reset it etc.

> +static int motorcomm_resume(struct device *dev, void *bsp_priv)
> +{
> +	struct dwmac_motorcomm_priv *priv = bsp_priv;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	pci_restore_state(pdev);
> +	pci_set_power_state(pdev, PCI_D0);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +
> +	motorcomm_reset_phy(priv);

Does the PHY support WoL? You probably should not be touching it if it
can wake the system.

> +		return NULL;
> +
> +	plat->mdio_bus_data = devm_kzalloc(dev, sizeof(*plat->mdio_bus_data),
> +					   GFP_KERNEL);
> +	if (!plat->mdio_bus_data)
> +		return NULL;

Is this required? If you look at other glue drivers which allocate
such a structure, they set members in it:

dwmac-intel.c:	plat->mdio_bus_data->needs_reset = true;
dwmac-loongson.c:		plat->mdio_bus_data->needs_reset = true;
dwmac-tegra.c:	plat->mdio_bus_data->needs_reset = true;
stmmac_pci.c:	plat->mdio_bus_data->needs_reset = true;
stmmac_platform.c:		plat->mdio_bus_data->needs_reset = true;

You don't set anything.

	Andrew

