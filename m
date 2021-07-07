Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96A3BE787
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGGMDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 08:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGMDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 08:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22BB161C78;
        Wed,  7 Jul 2021 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659267;
        bh=x3B4x8BU2OkCmrAavlTqYXzWR4EYU/t1YZNFwkkeelk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dv7cAsiHvsbf6rsHT5HoZGhUKAwVKSZrNZu3MJ+IAd8WSSbTTUz0aHgIrk7WyCRkv
         /RxlmQNWkovTNL93o8QSCXvJzA//EU4Dx7IfrXLdYjx1ckI1v7HZwqWXpTkKuu/4jf
         y1//8ZQ2Nj2Gprbm8c3qvH45a1gUTHcTAg6ZfZ/ilYyiJw4viYQLtKO2ICtUorE7aY
         g52rhmunhzNNtN0Om3toPXbqwJHZ/NfUNwcvjpgAoURtDUTpA4/vXkmpNqcbeeyisl
         2ulujxgkChNpY8GqwKzbyqHJo4A1zS1VKOrAeiWxHVb3h28l8UXCsQHoUhrO/8MPVE
         fGCDtlaVsVt2w==
Date:   Wed, 7 Jul 2021 07:01:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nadeem Athani <nadeem@cadence.com>
Subject: Re: [PATCH 2/5] PCI: j721e: Add PCIe support for J7200
Message-ID: <20210707120105.GA886562@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706105035.9915-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 04:20:32PM +0530, Kishon Vijay Abraham I wrote:
> J7200 has the same PCIe IP as in J721E with minor changes in the
> wrapper. J7200 allows byte access of bridge configuration space
> registers and the register field for LINK_DOWN interrupt is different.
> J7200 also requires "quirk_detect_quiet_flag" to be set. Configure these
> changes as part of driver data applicable only to J7200.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 44 ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 35e61048e133..803da33b86d8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -27,6 +27,7 @@
>  #define STATUS_REG_SYS_2	0x508
>  #define STATUS_CLR_REG_SYS_2	0x708
>  #define LINK_DOWN		BIT(1)
> +#define J7200_LINK_DOWN		BIT(10)
>  
>  #define J721E_PCIE_USER_CMD_STATUS	0x4
>  #define LINK_TRAINING_ENABLE		BIT(0)
> @@ -57,6 +58,7 @@ struct j721e_pcie {
>  	struct cdns_pcie	*cdns_pcie;
>  	void __iomem		*user_cfg_base;
>  	void __iomem		*intd_cfg_base;
> +	u32			link_irq_reg_field;

This seems to be a device-specific "link down" bit, so maybe a more
descriptive name that suggests "link down"?

>  };
>  
>  enum j721e_pcie_mode {
> @@ -67,6 +69,9 @@ enum j721e_pcie_mode {
>  struct j721e_pcie_data {
>  	enum j721e_pcie_mode	mode;
>  	bool quirk_retrain_flag;
> +	bool			quirk_detect_quiet_flag;
> +	u32			link_irq_reg_field;
> +	bool			byte_access_allowed;

Maybe re-indent quirk_retrain_flag so the struct is consistent?

I know there's a pattern of using "bool" in these structs, but I don't
think it's really any better than "unsigned int :1" and it takes more
space.

https://lore.kernel.org/r/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com/
https://lore.kernel.org/r/CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com/

>  };
>  
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -98,12 +103,12 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
>  	u32 reg;
>  
>  	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
> -	if (!(reg & LINK_DOWN))
> +	if (!(reg & pcie->link_irq_reg_field))
>  		return IRQ_NONE;
>  
>  	dev_err(dev, "LINK DOWN!\n");
>  
> -	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
> +	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, pcie->link_irq_reg_field);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -112,7 +117,7 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
>  	u32 reg;
>  
>  	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
> -	reg |= LINK_DOWN;
> +	reg |= pcie->link_irq_reg_field;
>  	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
>  }
>  
> @@ -284,10 +289,25 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
>  	.mode = PCI_MODE_RC,
>  	.quirk_retrain_flag = true,
> +	.byte_access_allowed = false,
> +	.link_irq_reg_field = LINK_DOWN,
>  };
>  
>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
> +	.link_irq_reg_field = LINK_DOWN,
> +};
> +
> +static const struct j721e_pcie_data j7200_pcie_rc_data = {
> +	.mode = PCI_MODE_RC,
> +	.quirk_detect_quiet_flag = true,
> +	.link_irq_reg_field = J7200_LINK_DOWN,
> +	.byte_access_allowed = true,
> +};
> +
> +static const struct j721e_pcie_data j7200_pcie_ep_data = {
> +	.mode = PCI_MODE_EP,
> +	.quirk_detect_quiet_flag = true,
>  };
>  
>  static const struct of_device_id of_j721e_pcie_match[] = {
> @@ -299,6 +319,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
>  		.compatible = "ti,j721e-pcie-ep",
>  		.data = &j721e_pcie_ep_data,
>  	},
> +	{
> +		.compatible = "ti,j7200-pcie-host",
> +		.data = &j7200_pcie_rc_data,
> +	},
> +	{
> +		.compatible = "ti,j7200-pcie-ep",
> +		.data = &j7200_pcie_ep_data,
> +	},
>  	{},
>  };
>  
> @@ -309,10 +337,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge;
>  	struct j721e_pcie_data *data;
>  	struct cdns_pcie *cdns_pcie;
> +	bool byte_access_allowed;
>  	struct j721e_pcie *pcie;
>  	struct cdns_pcie_rc *rc;
>  	struct cdns_pcie_ep *ep;
>  	struct gpio_desc *gpiod;
> +	u32 link_irq_reg_field;
>  	void __iomem *base;
>  	struct clk *clk;
>  	u32 num_lanes;
> @@ -325,6 +355,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	mode = (u32)data->mode;
> +	byte_access_allowed = data->byte_access_allowed;
> +	link_irq_reg_field = data->link_irq_reg_field;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -332,6 +364,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->dev = dev;
>  	pcie->mode = mode;
> +	pcie->link_irq_reg_field = link_irq_reg_field;
>  
>  	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
>  	if (IS_ERR(base))
> @@ -391,9 +424,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  
> -		bridge->ops = &cdns_ti_pcie_host_ops;
> +		if (!byte_access_allowed)

Why bother with the "byte_access_allowed" local variable?  Could just
use "data->byte_access_allowed" here, as the code below uses
"data->quirk_retrain_flag", etc.

Same with "link_irq_reg_field" above, I guess.

> +			bridge->ops = &cdns_ti_pcie_host_ops;
>  		rc = pci_host_bridge_priv(bridge);
>  		rc->quirk_retrain_flag = data->quirk_retrain_flag;
> +		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
>  
>  		cdns_pcie = &rc->pcie;
>  		cdns_pcie->dev = dev;
> @@ -459,6 +494,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			ret = -ENOMEM;
>  			goto err_get_sync;
>  		}
> +		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
>  
>  		cdns_pcie = &ep->pcie;
>  		cdns_pcie->dev = dev;
> -- 
> 2.17.1
> 
