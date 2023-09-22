Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D717AAFD5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjIVKnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 06:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjIVKmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 06:42:55 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC3E48;
        Fri, 22 Sep 2023 03:42:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 86A4624E26F;
        Fri, 22 Sep 2023 18:42:28 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Sep
 2023 18:42:28 +0800
Received: from [192.168.125.57] (113.72.146.252) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Sep
 2023 18:42:27 +0800
Message-ID: <57267a7d-c03a-6abe-c64a-08766a0ce01b@starfivetech.com>
Date:   Fri, 22 Sep 2023 18:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 07/19] PCI: plda: Move the setup functions to
 pcie-plda-host.c
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
 <20230915102243.59775-8-minda.chen@starfivetech.com>
 <CAJM55Z-wD4+TUJCsXsbgR49Zux5fuMZQmJ5bXEVW96QVNJbBFQ@mail.gmail.com>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <CAJM55Z-wD4+TUJCsXsbgR49Zux5fuMZQmJ5bXEVW96QVNJbBFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.252]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/18 6:45, Emil Renner Berthing wrote:
> Minda Chen wrote:
>> Move setup functions to common pcie-plda-host.c.
>>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  drivers/pci/controller/plda/Kconfig           |  4 +
>>  drivers/pci/controller/plda/Makefile          |  1 +
>>  .../pci/controller/plda/pcie-microchip-host.c | 59 -------------
>>  drivers/pci/controller/plda/pcie-plda-host.c  | 82 +++++++++++++++++++
>>  drivers/pci/controller/plda/pcie-plda.h       |  6 ++
>>  5 files changed, 93 insertions(+), 59 deletions(-)
>>  create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
>>
>> diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
>> index 5cb3be4fc98c..e54a82ee94f5 100644
>> --- a/drivers/pci/controller/plda/Kconfig
>> +++ b/drivers/pci/controller/plda/Kconfig
>> @@ -3,10 +3,14 @@
>>  menu "PLDA-based PCIe controllers"
>>  	depends on PCI
>>
>> +config PCIE_PLDA_HOST
>> +	bool
>> +
>>  config PCIE_MICROCHIP_HOST
>>  	tristate "Microchip AXI PCIe controller"
>>  	depends on PCI_MSI && OF
>>  	select PCI_HOST_COMMON
>> +	select PCIE_PLDA_HOST
>>  	help
>>  	  Say Y here if you want kernel to support the Microchip AXI PCIe
>>  	  Host Bridge driver.
>> diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
>> index e1a265cbf91c..4340ab007f44 100644
>> --- a/drivers/pci/controller/plda/Makefile
>> +++ b/drivers/pci/controller/plda/Makefile
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
>>  obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index 1d253acd6bc2..ac7126b0bacf 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -837,65 +837,6 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>>  	return mc_allocate_msi_domains(port);
>>  }
>>
>> -static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>> -				   phys_addr_t axi_addr, phys_addr_t pci_addr,
>> -				   size_t size)
>> -{
>> -	u32 atr_sz = ilog2(size) - 1;
>> -	u32 val;
>> -
>> -	if (index == 0)
>> -		val = PCIE_CONFIG_INTERFACE;
>> -	else
>> -		val = PCIE_TX_RX_INTERFACE;
>> -
>> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> -	       ATR0_AXI4_SLV0_TRSL_PARAM);
>> -
>> -	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
>> -			    ATR_IMPL_ENABLE;
>> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> -	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>> -
>> -	val = upper_32_bits(axi_addr);
>> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> -	       ATR0_AXI4_SLV0_SRC_ADDR);
>> -
>> -	val = lower_32_bits(pci_addr);
>> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> -	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
>> -
>> -	val = upper_32_bits(pci_addr);
>> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> -	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
>> -
>> -	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> -	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
>> -	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> -	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>> -}
>> -
>> -static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>> -				  struct plda_pcie_rp *port)
>> -{
>> -	void __iomem *bridge_base_addr = port->bridge_addr;
>> -	struct resource_entry *entry;
>> -	u64 pci_addr;
>> -	u32 index = 1;
>> -
>> -	resource_list_for_each_entry(entry, &bridge->windows) {
>> -		if (resource_type(entry->res) == IORESOURCE_MEM) {
>> -			pci_addr = entry->res->start - entry->offset;
>> -			plda_pcie_setup_window(bridge_base_addr, index,
>> -					       entry->res->start, pci_addr,
>> -					       resource_size(entry->res));
>> -			index++;
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static inline void mc_clear_secs(struct mc_pcie *port)
>>  {
>>  	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
>> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
>> new file mode 100644
>> index 000000000000..f0c7636f1f64
>> --- /dev/null
>> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PLDA PCIe XpressRich host controller driver
>> + *
>> + * Copyright (C) 2023 Microchip Co. Ltd
>> + *		      StarFive Co. Ltd.
>> + *
>> + * Author: Daire McNamara <daire.mcnamara@microchip.com>
>> + * Author: Minda Chen <minda.chen@starfivetech.com>
>> + */
>> +
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/msi.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/pci-ecam.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "pcie-plda.h"
>> +
>> +void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>> +			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>> +			    size_t size)
>> +{
>> +	u32 atr_sz = ilog2(size) - 1;
>> +	u32 val;
>> +
>> +	if (index == 0)
>> +		val = PCIE_CONFIG_INTERFACE;
>> +	else
>> +		val = PCIE_TX_RX_INTERFACE;
>> +
>> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> +	       ATR0_AXI4_SLV0_TRSL_PARAM);
>> +
>> +	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
>> +			    ATR_IMPL_ENABLE;
>> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> +	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>> +
>> +	val = upper_32_bits(axi_addr);
>> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> +	       ATR0_AXI4_SLV0_SRC_ADDR);
>> +
>> +	val = lower_32_bits(pci_addr);
>> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> +	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
>> +
>> +	val = upper_32_bits(pci_addr);
>> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>> +	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
>> +
>> +	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> +	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> 
> I know this code is just a straight copy, but for future cleanups are we
> guaranteed that this field is always zero?
> 
> Otherwise it looks a little suspicious to do read-modify-write, but just
> set the (0x25 << 1) bits without clearing the field first.
> 
The reset value is zero. And this is called once.
Maybe I can add a patch to fix this.
>> +	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> +	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>> +}
>> +EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
>> +
>> +int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>> +			   struct plda_pcie_rp *port)
>> +{
>> +	void __iomem *bridge_base_addr = port->bridge_addr;
>> +	struct resource_entry *entry;
>> +	u64 pci_addr;
>> +	u32 index = 1;
>> +
>> +	resource_list_for_each_entry(entry, &bridge->windows) {
>> +		if (resource_type(entry->res) == IORESOURCE_MEM) {
>> +			pci_addr = entry->res->start - entry->offset;
>> +			plda_pcie_setup_window(bridge_base_addr, index,
>> +					       entry->res->start, pci_addr,
>> +					       resource_size(entry->res));
>> +			index++;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index d04a571404b9..3deefd35fa5a 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -119,4 +119,10 @@ struct plda_pcie_rp {
>>  	struct plda_msi msi;
>>  	void __iomem *bridge_addr;
>>  };
>> +
>> +void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>> +			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>> +			    size_t size);
>> +int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>> +			   struct plda_pcie_rp *port);
>>  #endif
>> --
>> 2.17.1
