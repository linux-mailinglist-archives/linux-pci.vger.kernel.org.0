Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2880B3B37
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfIPNXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 09:23:22 -0400
Received: from foss.arm.com ([217.140.110.172]:44774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfIPNXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 09:23:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B7E337;
        Mon, 16 Sep 2019 06:23:21 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9C53F67D;
        Mon, 16 Sep 2019 06:23:21 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:23:19 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 4/6] phy: meson-g12a-usb3-pcie: Add support for PCIe
 mode
Message-ID: <20190916132319.GQ9720@e119886-lin.cambridge.arm.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
 <20190916125022.10754-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916125022.10754-5-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 02:50:20PM +0200, Neil Armstrong wrote:
> This adds extended PCIe PHY functions for the Amlogic G12A
> USB3+PCIE Combo PHY to support reset, power_on and power_off for
> PCIe exclusively.
> 
> With these callbacks, we can handle all the needed operations of the
> Amlogic PCIe controller driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 70 ++++++++++++++++---
>  1 file changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> index ac322d643c7a..08e322789e59 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> @@ -50,6 +50,8 @@
>  	#define PHY_R5_PHY_CR_ACK				BIT(16)
>  	#define PHY_R5_PHY_BS_OUT				BIT(17)
>  
> +#define PCIE_RESET_DELAY					500
> +
>  struct phy_g12a_usb3_pcie_priv {
>  	struct regmap		*regmap;
>  	struct regmap		*regmap_cr;
> @@ -196,6 +198,10 @@ static int phy_g12a_usb3_init(struct phy *phy)
>  	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
>  	int data, ret;
>  
> +	ret = reset_control_reset(priv->reset);
> +	if (ret)
> +		return ret;

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> +
>  	/* Switch PHY to USB3 */
>  	/* TODO figure out how to handle when PCIe was set in the bootloader */
>  	regmap_update_bits(priv->regmap, PHY_R0,
> @@ -272,24 +278,64 @@ static int phy_g12a_usb3_init(struct phy *phy)
>  	return 0;
>  }
>  
> -static int phy_g12a_usb3_pcie_init(struct phy *phy)
> +static int phy_g12a_usb3_pcie_power_on(struct phy *phy)
> +{
> +	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->mode == PHY_TYPE_USB3)
> +		return 0;
> +
> +	regmap_update_bits(priv->regmap, PHY_R0,
> +			   PHY_R0_PCIE_POWER_STATE,
> +			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
> +
> +	return 0;
> +}
> +
> +static int phy_g12a_usb3_pcie_power_off(struct phy *phy)
> +{
> +	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->mode == PHY_TYPE_USB3)
> +		return 0;
> +
> +	regmap_update_bits(priv->regmap, PHY_R0,
> +			   PHY_R0_PCIE_POWER_STATE,
> +			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1d));
> +
> +	return 0;
> +}
> +
> +static int phy_g12a_usb3_pcie_reset(struct phy *phy)
>  {
>  	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
>  	int ret;
>  
> -	ret = reset_control_reset(priv->reset);
> +	if (priv->mode == PHY_TYPE_USB3)
> +		return 0;
> +
> +	ret = reset_control_assert(priv->reset);
>  	if (ret)
>  		return ret;
>  
> +	udelay(PCIE_RESET_DELAY);
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	udelay(PCIE_RESET_DELAY);
> +
> +	return 0;
> +}
> +
> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
> +{
> +	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +
>  	if (priv->mode == PHY_TYPE_USB3)
>  		return phy_g12a_usb3_init(phy);
>  
> -	/* Power UP PCIE */
> -	/* TODO figure out when the bootloader has set USB3 mode before */
> -	regmap_update_bits(priv->regmap, PHY_R0,
> -			   PHY_R0_PCIE_POWER_STATE,
> -			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
> -
>  	return 0;
>  }
>  
> @@ -297,7 +343,10 @@ static int phy_g12a_usb3_pcie_exit(struct phy *phy)
>  {
>  	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
>  
> -	return reset_control_reset(priv->reset);
> +	if (priv->mode == PHY_TYPE_USB3)
> +		return reset_control_reset(priv->reset);
> +
> +	return 0;
>  }
>  
>  static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
> @@ -326,6 +375,9 @@ static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
>  static const struct phy_ops phy_g12a_usb3_pcie_ops = {
>  	.init		= phy_g12a_usb3_pcie_init,
>  	.exit		= phy_g12a_usb3_pcie_exit,
> +	.power_on	= phy_g12a_usb3_pcie_power_on,
> +	.power_off	= phy_g12a_usb3_pcie_power_off,
> +	.reset		= phy_g12a_usb3_pcie_reset,
>  	.owner		= THIS_MODULE,
>  };
>  
> -- 
> 2.22.0
> 
