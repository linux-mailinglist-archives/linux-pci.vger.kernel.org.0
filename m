Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9964835F42F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351067AbhDNMog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 08:44:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2856 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350776AbhDNMob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 08:44:31 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FL28W3vwzz689s1;
        Wed, 14 Apr 2021 20:38:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 14:44:08 +0200
Received: from localhost (10.52.122.47) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 13:44:07 +0100
Date:   Wed, 14 Apr 2021 13:42:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <bpeled@marvell.com>
CC:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>
Subject: Re: =?UTF-8?Q?[=E2=80=9DPATCH=E2=80=9D?= 2/5] PCI: armada8k: Add
 link-down handle
Message-ID: <20210414134240.000057b4@Huawei.com>
In-Reply-To: <1618241456-27200-3-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
        <1618241456-27200-3-git-send-email-bpeled@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.47]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Apr 2021 18:30:53 +0300
<bpeled@marvell.com> wrote:

> From: Ben Peled <bpeled@marvell.com>
> 
> In PCIE ISR routine caused by RST_LINK_DOWN
> we schedule work to handle the link-down procedure.
> Link-down procedure will:
> 1. Remove PCIe bus
> 2. Reset the MAC
> 3. Reconfigure link back up
> 4. Rescan PCIe bus
> 
> Signed-off-by: Ben Peled <bpeled@marvell.com>

Trivial comment inline.

Also, something odd with quotes around PATCH in the title you probably
want to clean up.

> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 68 ++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b2278b1..4eb8607 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,6 +22,8 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -33,6 +35,9 @@ struct armada8k_pcie {
>  	struct clk *clk_reg;
>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>  	unsigned int phy_count;
> +	struct regmap *sysctrl_base;
> +	u32 mac_rest_bitmask;
> +	struct work_struct recover_link_work;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -73,6 +78,8 @@ struct armada8k_pcie {
>  #define AX_USER_DOMAIN_MASK		0x3
>  #define AX_USER_DOMAIN_SHIFT		4
>  
> +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
> +
>  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
> @@ -224,6 +231,49 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  
>  	return 0;
>  }
> +static void armada8k_pcie_recover_link(struct work_struct *ws)
> +{
> +	struct armada8k_pcie *pcie = container_of(ws, struct armada8k_pcie, recover_link_work);
> +	struct pcie_port *pp = &pcie->pci->pp;
> +	struct pci_bus *bus = pp->bridge->bus;
> +	struct pci_dev *root_port;
> +	int ret;
> +
> +	root_port = pci_get_slot(bus, 0);
> +	if (!root_port) {
> +		dev_err(pcie->pci->dev, "failed to get root port\n");
> +		return;
> +	}
> +	pci_lock_rescan_remove();
> +	pci_stop_and_remove_bus_device(root_port);
> +	/*
> +	 * Sleep needed to make sure all pcie transactions and access
> +	 * are flushed before resetting the mac
> +	 */
> +	msleep(100);
> +
> +	/* Reset mac */
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, 0, NULL, false, true);
> +	udelay(1);
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
> +				NULL, false, true);
> +	udelay(1);
> +	ret = armada8k_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
> +		pci_unlock_rescan_remove();
> +		pci_dev_put(root_port);
> +		return;
> +	}
> +
> +	bus = NULL;
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		pci_rescan_bus(bus);
> +	pci_unlock_rescan_remove();
> +	pci_dev_put(root_port);
> +}
>  
>  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  {
> @@ -262,6 +312,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  		 * initiate a link retrain. If link retrains were
>  		 * possible, that is.
>  		 */
> +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> +			schedule_work(&pcie->recover_link_work);
> +
>  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
>  	}
>  
> @@ -330,6 +383,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> +	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
> +
>  	pcie->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
> @@ -357,6 +412,19 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						       "marvell,system-controller");
> +	if (IS_ERR(pcie->sysctrl_base)) {
> +		dev_warn(dev, "failed to find marvell,system-controller\n");
> +		pcie->sysctrl_base = 0x0;

= NULL; ?

> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
> +				   &pcie->mac_rest_bitmask);
> +	if (ret < 0) {
> +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> +		pcie->mac_rest_bitmask = 0x0;
> +	}
>  	ret = armada8k_pcie_setup_phys(pcie);
>  	if (ret)
>  		goto fail_clkreg;

