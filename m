Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B62F6F80
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKKIKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 03:10:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:58873 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKIKG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 03:10:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 00:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="197593916"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2019 00:10:05 -0800
Received: from [10.226.39.46] (ekotax-mobl.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 75A50580261;
        Mon, 11 Nov 2019 00:10:02 -0800 (PST)
Subject: Re: [PATCH v5 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        helgaas@kernel.org, jingoohan1@gmail.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <ac63d9856323555736c5b361612df3ee49b0f998.1572950559.git.eswara.kota@linux.intel.com>
 <20191108104254.GF43905@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <aedb7a6a-7fbe-a7d3-b629-775debbc8a1f@linux.intel.com>
Date:   Mon, 11 Nov 2019 16:09:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108104254.GF43905@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/8/2019 6:42 PM, Andrew Murray wrote:
> On Wed, Nov 06, 2019 at 11:44:02AM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>
>> Intel PCIe driver requires Upconfigure support, fast training
>> sequence and link speed configuration. So adding the respective
>> helper functions in the PCIe DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v5:
>> 	Use new, old variables in pcie_update_bits()
>> 	Correct naming:
>> 	  s/Designware/DesignWare
>> 	  s/pcie/PCIe
>> 	  s/pci/PCI
>> 	  s/Hw/HW
>> 	  Upconfig to Upconfigure
>> 	Remove extra lines after the intel_pcie_max_speed_setup() def.
>> 	Use pcie_link_speed[] and remove enum for pcie gen.
>> 	Remove dw_pcie_link_speed_change() def.
>> 	Remove "linux,pci-domain" parsing.
>> 	Remove 'id' variable in intel_pcie_port structure.
>> 	Remove extra spaces for lpp->link_gen =
>> 	Correct the offset of PCI_EXP_LNKCTL2_HASD to 0x0020.
>> 	Remove programming of RCB and CCC bits in PCI_EXP_LCTL reg.
>> 	Remove programming Slot clock cfg in PCI_EXP_LSTS reg.
>> 	Update the comments at num_viewport setting.
>> 	Update the description in Kconfig.
>> 	Get PCIe cap offset from the registers using dw_pcie_find_capability()
>> 	Define pcie_cap_ofst var in intel_pcie_port struct to store the same.
>> 	Remove the PCIE_CAP_OFST macro.
>> 	Move intel_pcie_max_speed_setup() function to DesignWare framework,
>> 	 defined as dw_pcie_link_set_max_speed()
>> 	Set EXPORT_SYMBOL_GPL for the newer functions defined in
>> 	  pcie-designware.c
>>
>> Changes on v4:
>> 	Rename the driver naming and description to
>> 	 "PCIe RC controller on Intel Gateway SoCs".
>> 	Use PCIe core register macros defined in pci_regs.h
>> 	 and remove respective local definitions.
>> 	Remove PCIe core interrupt handling.
>> 	Move PCIe link control speed change, upconfig and FTS.
>> 	configuration functions to DesignWare framework.
>> 	Use of_pci_get_max_link_speed().
>> 	Mark dependency on X86 and COMPILE_TEST in Kconfig.
>> 	Remove lanes and add n_fts variables in intel_pcie_port structure.
>> 	Rename rst_interval variable to rst_intrvl in intel_pcie_port structure.
>> 	Remove intel_pcie_mem_iatu() as it is already perfomed in dw_setup_rc()
>> 	Move sysfs attributes specific code to separate patch.
>> 	Remove redundant error handling.
>> 	Reduce LoCs by doing variable initializations while declaration itself.
>> 	Add extra line after closing parenthesis.
>> 	Move intel_pcie_ep_rst_init() out of get_resources()
>>
>> changes on v3:
>> 	Rename PCIe app logic registers with PCIE_APP prefix.
>> 	PCIE_IOP_CTRL configuration is not required. Remove respective code.
>> 	Remove wrapper functions for clk enable/disable APIs.
>> 	Use platform_get_resource_byname() instead of
>> 	  devm_platform_ioremap_resource() to be similar with DWC framework.
>> 	Rename phy name to "pciephy".
>> 	Modify debug message in msi_init() callback to be more specific.
>> 	Remove map_irq() callback.
>> 	Enable the INTx interrupts at the time of PCIe initialization.
>> 	Reduce memory fragmentation by using variable "struct dw_pcie pci"
>> 	  instead of allocating memory.
>> 	Reduce the delay to 100us during enpoint initialization
>> 	  intel_pcie_ep_rst_init().
>> 	Call  dw_pcie_host_deinit() during remove() instead of directly
>> 	  calling PCIe core APIs.
>> 	Rename "intel,rst-interval" to "reset-assert-ms".
>> 	Remove unused APP logic Interrupt bit macro definitions.
>>   	Use dwc framework's dw_pcie_setup_rc() for PCIe host specific
>> 	 configuration instead of redefining the same functionality in
>> 	 the driver.
>> 	Move the whole DT parsing specific code to intel_pcie_get_resources()
>>
>>   drivers/pci/controller/dwc/Kconfig           |  10 +
>>   drivers/pci/controller/dwc/Makefile          |   1 +
>>   drivers/pci/controller/dwc/pcie-designware.c |  57 +++
>>   drivers/pci/controller/dwc/pcie-designware.h |  12 +
>>   drivers/pci/controller/dwc/pcie-intel-gw.c   | 538 +++++++++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h                |   1 +
>>   6 files changed, 619 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0ba988b5b5bc..39c17b16b403 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>>   	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>   	  selected.
>>   
>> +config PCIE_INTEL_GW
>> +        bool "Intel Gateway PCIe host controller support"
>> +	depends on OF && (X86 || COMPILE_TEST)
>> +	select PCIE_DW_HOST
>> +	help
>> +          Say 'Y' here to enable PCIe Host controller support on Intel
>> +	  Gateway SoCs.
>> +	  The PCIe controller uses the DesignWare core plus Intel-specific
>> +	  hardware wrappers.
>> +
>>   config PCI_EXYNOS
>>   	bool "Samsung Exynos PCIe controller"
>>   	depends on SOC_EXYNOS5440 || COMPILE_TEST
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index b30336181d46..99db83cd2f35 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>   obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>>   obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>   obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>> +obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>   obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>   obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 820488dfeaed..20e5c3aec394 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -14,6 +14,8 @@
>>   
>>   #include "pcie-designware.h"
>>   
>> +extern const unsigned char pcie_link_speed[];
>> +
>>   /*
>>    * These interfaces resemble the pci_find_*capability() interfaces, but these
>>    * are for configuring host controllers, which are bridges *to* PCI devices but
>> @@ -474,6 +476,61 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>>   		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>>   }
>>   
>> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
>> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL,
>> +			   val | PORT_MLTI_UPCFG_SUPPORT);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>> +
>> +void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>> +{
>> +	u32 reg, val;
>> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +
>> +	reg = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>> +	reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +
>> +	switch (pcie_link_speed[link_gen]) {
>> +	case PCIE_SPEED_2_5GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;
>> +	break;
>> +	case PCIE_SPEED_5_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
>> +	break;
>> +	case PCIE_SPEED_8_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;
>> +	break;
>> +	case PCIE_SPEED_16_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_16_0GT;
>> +	break;
>> +	default:
>> +	/* Use hardware capability */
> I think the style here isn't quite inline with other controller drivers.
> Please indent the break statement.
While writing this switch case, i observed couple of drivers doing like 
this(I dont remember the driver names).
I checked now other PCIe controller drivers, break is inline to 'reg |=' 
line.
I will update it.
>
> Also the comment above should probably have the same indentation level
> as the code block.
Sure, i will correct it.
>
> But with those changes you can add:
>
> Reviewed-by: Andrew Murray <andrew.murray@arm.con>
Thanks a lot for reviewing patch and giving the inputs.


Regards,
Dilip


