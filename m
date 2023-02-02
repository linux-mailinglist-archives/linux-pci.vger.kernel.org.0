Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC554687D04
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBBMOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBBMOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:14:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17CBD8D40B;
        Thu,  2 Feb 2023 04:14:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8CBC14;
        Thu,  2 Feb 2023 04:14:43 -0800 (PST)
Received: from [10.57.88.229] (unknown [10.57.88.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720523F64C;
        Thu,  2 Feb 2023 04:13:59 -0800 (PST)
Message-ID: <8dfc14be-a978-d84b-52e4-d421599fc783@arm.com>
Date:   Thu, 2 Feb 2023 12:13:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 10/11] PCI: microchip: Partition inbound address
 translation
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kw@linux.com,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-11-daire.mcnamara@microchip.com>
 <Y9ufDnZDA2plc2x6@lpieralisi>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y9ufDnZDA2plc2x6@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-02-02 11:31, Lorenzo Pieralisi wrote:
> [+CC Robin]
> 
> On Wed, Jan 11, 2023 at 12:53:22PM +0000, daire.mcnamara@microchip.com wrote:
>> From: Daire McNamara <daire.mcnamara@microchip.com>
>>
>> On Microchip PolarFire SoC the PCIe Root Port is behind a set of Fabric
>> Interface Controller (FIC) buses that encapsulate buses like ABP/AHP,
>> AXI-S, and AXI-M. Depending on which FIC(s) the Root Port is wired
>> through to cpu space, the Root Port driver needs to take account of the
>> address translation done by a parent (e.g. fabric) node before setting
>> up its own inbound address translation tables from attached devices.
>>
>> Parse the dma-range properties to determine how much address translation
>> to perform in the Root Port and how much is being provided by the
>> fabric.
> 
> Same reasoning as per patch (9), it requires some review from DT/DMA
> maintainers.

 From a quick look I'd imagine it's notionally correct. The definitions 
smell very much of it being a PLDA IP similar to the one we used in the 
Arm Juno SoC. If the kernel driver is in control of the whole thing and 
can't rely on it having previously been configured by firmware, then 
indeed it likely should need to configure outbound translation entries 
based on "ranges" and inbound ones based on "dma-ranges", much like 
dw_pcie_iatu_setup() for DWC drivers.

However, all the explicit parsing here looks a bit suspect - much like 
the DWC example again, the relevant information should already be 
provided in the bridge->windows and bridge->dma_ranges lists. If that 
doesn't work then it implies that either the DT is wrong, or 
devm_of_pci_get_host_bridge_resources() needs some work to avoid 
conflating the host bridge's own translations with any additional 
translations upstream.

Thanks,
Robin.

> 
> Lorenzo
> 
>>
>> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   drivers/pci/controller/pcie-microchip-host.c | 178 ++++++++++++++++++-
>>   1 file changed, 172 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
>> index f3dfcdf39c8a..2eb70fd01879 100644
>> --- a/drivers/pci/controller/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/pcie-microchip-host.c
>> @@ -22,6 +22,9 @@
>>   /* Number of MSI IRQs */
>>   #define MC_MAX_NUM_MSI_IRQS			32
>>   
>> +#define MC_MAX_NUM_INBOUND_WINDOWS		8
>> +#define MC_ATT_MASK				GENMASK_ULL(63, 31)
>> +
>>   /* PCIe Bridge Phy and Controller Phy offsets */
>>   #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
>>   #define MC_PCIE1_CTRL_ADDR			0x0000a000u
>> @@ -86,10 +89,13 @@
>>   #define ISTATUS_MSI				0x194
>>   
>>   #define ATR_WINDOW_DESC_SIZE			32
>> -#define ATR_PCIE_ATR_SIZE			0x25
>>   #define ATR_SIZE_SHIFT				1
>>   #define ATR_IMPL_ENABLE				1
>>   
>> +#define ATR_PCIE_WIN0_SRCADDR			0x80000000
>> +#define ATR_PCIE_ATR_SIZE			(512 * 1024 * 1024ul)
>> +#define ATR_PCIE_NUM_WINDOWS			8
>> +
>>   /* PCIe Master table init defines */
>>   #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
>>   #define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
>> @@ -278,6 +284,12 @@ struct mc_msi {
>>   	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
>>   };
>>   
>> +struct inbound_windows {
>> +	u64 axi_addr;
>> +	u64 pci_addr;
>> +	u64 size;
>> +};
>> +
>>   struct mc_pcie {
>>   	void __iomem *axi_base_addr;
>>   	struct device *dev;
>> @@ -286,6 +298,8 @@ struct mc_pcie {
>>   	raw_spinlock_t lock;
>>   	struct mc_msi msi;
>>   	u64 outbound_range_offset;
>> +	u32 num_inbound_windows;
>> +	struct inbound_windows inbound_windows[MC_MAX_NUM_INBOUND_WINDOWS];
>>   };
>>   
>>   struct cause {
>> @@ -948,6 +962,43 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>>   	return mc_allocate_msi_domains(port);
>>   }
>>   
>> +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
>> +{
>> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>> +	phys_addr_t pcie_addr;
>> +	phys_addr_t axi_addr;
>> +	u32 atr_size;
>> +	u32 val;
>> +	int i;
>> +
>> +	for (i = 0; i < port->num_inbound_windows; i++) {
>> +		atr_size = ilog2(port->inbound_windows[i].size) - 1;
>> +		atr_size &= GENMASK(5, 0);
>> +
>> +		pcie_addr = port->inbound_windows[i].pci_addr;
>> +
>> +		val = lower_32_bits(pcie_addr) & GENMASK(31, 12);
>> +		val |= (atr_size << ATR_SIZE_SHIFT);
>> +		val |= ATR_IMPL_ENABLE;
>> +		writel(val, bridge_base_addr +
>> +		       ATR0_PCIE_WIN0_SRCADDR_PARAM + (i * ATR_WINDOW_DESC_SIZE));
>> +		writel(upper_32_bits(pcie_addr), bridge_base_addr +
>> +		       ATR0_PCIE_WIN0_SRC_ADDR + (i * ATR_WINDOW_DESC_SIZE));
>> +
>> +		axi_addr = port->inbound_windows[i].axi_addr;
>> +
>> +		writel(lower_32_bits(axi_addr), bridge_base_addr +
>> +		       ATR0_PCIE_WIN0_TRSL_ADDR_LSB + (i * ATR_WINDOW_DESC_SIZE));
>> +		writel(upper_32_bits(axi_addr), bridge_base_addr +
>> +		       ATR0_PCIE_WIN0_TRSL_ADDR_UDW + (i * ATR_WINDOW_DESC_SIZE));
>> +
>> +		writel(TRSL_ID_AXI4_MASTER_0, bridge_base_addr +
>> +		       ATR0_PCIE_WIN0_TRSL_PARAM + (i * ATR_WINDOW_DESC_SIZE));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>>   				 phys_addr_t axi_addr, phys_addr_t pci_addr,
>>   				 size_t size)
>> @@ -979,11 +1030,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>>   	val = upper_32_bits(pci_addr);
>>   	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>>   	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
>> -
>> -	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> -	val |= (ATR_PCIE_ATR_SIZE << ATR_SIZE_SHIFT);
>> -	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>> -	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>>   }
>>   
>>   static int mc_pcie_setup_windows(struct platform_device *pdev,
>> @@ -1163,6 +1209,116 @@ static int mc_check_for_parent_range_handling(struct platform_device *pdev, stru
>>   	return 0;
>>   }
>>   
>> +static int mc_check_for_parent_dma_range_handling(struct platform_device *pdev,
>> +						  struct mc_pcie *port)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *dn = dev->of_node;
>> +	struct of_range_parser parser;
>> +	struct of_range range;
>> +	int num_parent_ranges = 0;
>> +	int num_ranges = 0;
>> +	struct inbound_windows ranges[MC_MAX_NUM_INBOUND_WINDOWS] = { 0 };
>> +	u64 start_axi = GENMASK_ULL(63, 0);
>> +	u64 end_axi = 0;
>> +	u64 start_pci = GENMASK_ULL(63, 0);
>> +	s64 size;
>> +	u64 window_size;
>> +	int i;
>> +
>> +	/* Find all dma-ranges */
>> +	if (of_pci_dma_range_parser_init(&parser, dn)) {
>> +		dev_err(dev, "missing dma-ranges property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_of_range(&parser, &range) {
>> +		if (num_ranges > MC_MAX_NUM_INBOUND_WINDOWS) {
>> +			dev_err(dev, "too many inbound ranges; %d available tables\n",
>> +				MC_MAX_NUM_INBOUND_WINDOWS);
>> +			return -EINVAL;
>> +		}
>> +		ranges[num_ranges].axi_addr = range.cpu_addr;
>> +		ranges[num_ranges].pci_addr = range.pci_addr;
>> +		ranges[num_ranges].size = range.size;
>> +
>> +		num_ranges++;
>> +	}
>> +
>> +	/*
>> +	 * Check for one level up; will need to adjust address translation
>> +	 * tables for these
>> +	 */
>> +	dn = of_get_parent(dn);
>> +	if (dn) {
>> +		of_pci_dma_range_parser_init(&parser, dn);
>> +
>> +		for_each_of_range(&parser, &range) {
>> +			if (num_parent_ranges > MC_MAX_NUM_INBOUND_WINDOWS) {
>> +				dev_err(dev, "too many parent inbound ranges; %d available tables\n",
>> +					MC_MAX_NUM_INBOUND_WINDOWS);
>> +				return -EINVAL;
>> +			}
>> +			ranges[num_parent_ranges].axi_addr = range.pci_addr;
>> +			num_parent_ranges++;
>> +		}
>> +	}
>> +
>> +	if (num_parent_ranges) {
>> +		if (num_ranges != num_parent_ranges) {
>> +			dev_err(dev, "num parent inbound ranges must be 0 or match num inbound ranges\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	/* Merge ranges */
>> +	for (i = 0; i < num_ranges; i++) {
>> +		struct inbound_windows *range = &ranges[i];
>> +
>> +		if (range->axi_addr < start_axi) {
>> +			start_axi = range->axi_addr;
>> +			start_pci = range->pci_addr;
>> +		}
>> +
>> +		if (range->axi_addr + range->size > end_axi)
>> +			end_axi = range->axi_addr + range->size;
>> +	}
>> +
>> +	/* Move starts back as far as possible */
>> +	start_axi &= MC_ATT_MASK;
>> +	start_pci &= MC_ATT_MASK;
>> +
>> +	/* Adjust size to take account of that change */
>> +	size = end_axi - start_axi;
>> +
>> +	/* May need to adjust size up to the next largest power of 2 */
>> +	if (size < 1ull << ilog2(size))
>> +		size = 1ull << (ilog2(size) + 1);
>> +
>> +	window_size = 1ull << (ilog2(size) - 1);
>> +
>> +	/* Divide merged range into windows */
>> +	i = 0;
>> +	while (size > 0 && i < MC_MAX_NUM_INBOUND_WINDOWS) {
>> +		port->inbound_windows[i].axi_addr = start_axi;
>> +		port->inbound_windows[i].pci_addr = start_pci;
>> +		port->inbound_windows[i].size = window_size;
>> +
>> +		size -= window_size;
>> +		start_axi += window_size;
>> +		start_pci += window_size;
>> +		i++;
>> +		port->num_inbound_windows = i;
>> +	}
>> +
>> +	if (size < 0) {
>> +		dev_err(dev, "insufficient windows to map inbound ranges\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int mc_platform_init(struct pci_config_window *cfg)
>>   {
>>   	struct device *dev = cfg->parent;
>> @@ -1180,6 +1336,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/* And similarly, check for inbound address translation */
>> +	ret = mc_check_for_parent_dma_range_handling(pdev, port);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* Configure address translation table 0 for PCIe config space */
>>   	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start - port->outbound_range_offset,
>>   			     cfg->res.start - port->outbound_range_offset,
>> @@ -1193,6 +1354,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/* Configure inbound translation tables */
>> +	ret = mc_pcie_setup_inbound_ranges(pdev, port);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* Address translation is up; safe to enable interrupts */
>>   	ret = mc_init_interrupts(pdev, port);
>>   	if (ret)
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
