Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22964D06C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfFTOc4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 10:32:56 -0400
Received: from foss.arm.com ([217.140.110.172]:41472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfFTOc4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 10:32:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7445A344;
        Thu, 20 Jun 2019 07:32:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1223F718;
        Thu, 20 Jun 2019 07:32:54 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:32:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 06/27] PCI: tegra: Add PCIe Gen2 link speed support
Message-ID: <20190620143251.GB31996@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-7-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-7-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 11:31:45PM +0530, Manikanta Maddireddy wrote:
> Tegra124, Tegra132, Tegra210 and Tegra186 support Gen2 link speed. After
> PCIe link is up in Gen1, set target link speed as Gen2 and retrain link.
> Link switches to Gen2 speed if Gen2 capable end point is connected, else
> link stays in Gen1.
> 
> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
> PCIe LTSSM to come back from recovery before retraining the link.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V6: No change
> 
> V5: No change
> 
> V4: No change
> 
> V3: Added blank line after each while loop.
> 
> V2: Changed "for loop" to "while", to make it compact and handled coding
> style comments.
> 
>  drivers/pci/controller/pci-tegra.c | 64 ++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 5e9fcef5f8eb..5d19067f7193 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -191,6 +191,8 @@
>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
>  
> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
> +
>  #define PADS_CTL_SEL		0x0000009c
>  
>  #define PADS_CTL		0x000000a0
> @@ -226,6 +228,7 @@
>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
>  
>  #define PME_ACK_TIMEOUT 10000
> +#define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
>  
>  struct tegra_msi {
>  	struct msi_controller chip;
> @@ -2089,6 +2092,64 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>  	return false;
>  }
>  
> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct tegra_pcie_port *port, *tmp;
> +	ktime_t deadline;
> +	u32 value;
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {

And the reason to use the _safe version is ?

Lorenzo

> +		/*
> +		 * "Supported Link Speeds Vector" in "Link Capabilities 2"
> +		 * is not supported by Tegra. tegra_pcie_change_link_speed()
> +		 * is called only for Tegra chips which support Gen2.
> +		 * So there no harm if supported link speed is not verified.
> +		 */
> +		value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
> +		value &= ~PCI_EXP_LNKSTA_CLS;
> +		value |= PCI_EXP_LNKSTA_CLS_5_0GB;
> +		writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
> +
> +		/*
> +		 * Poll until link comes back from recovery to avoid race
> +		 * condition.
> +		 */
> +		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> +
> +		while (ktime_before(ktime_get(), deadline)) {
> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
> +				break;
> +
> +			usleep_range(2000, 3000);
> +		}
> +
> +		if (value & PCI_EXP_LNKSTA_LT)
> +			dev_warn(dev, "PCIe port %u link is in recovery\n",
> +				 port->index);
> +
> +		/* Retrain the link */
> +		value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +		value |= PCI_EXP_LNKCTL_RL;
> +		writel(value, port->base + RP_LINK_CONTROL_STATUS);
> +
> +		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> +
> +		while (ktime_before(ktime_get(), deadline)) {
> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
> +				break;
> +
> +			usleep_range(2000, 3000);
> +		}
> +
> +		if (value & PCI_EXP_LNKSTA_LT)
> +			dev_err(dev, "failed to retrain link of port %u\n",
> +				port->index);
> +	}
> +}
> +
>  static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> @@ -2113,6 +2174,9 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  		tegra_pcie_port_disable(port);
>  		tegra_pcie_port_free(port);
>  	}
> +
> +	if (pcie->soc->has_gen2)
> +		tegra_pcie_change_link_speed(pcie);
>  }
>  
>  static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
> -- 
> 2.17.1
> 
