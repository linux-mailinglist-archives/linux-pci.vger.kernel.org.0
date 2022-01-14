Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445748E9BE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 13:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiANMNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiANMNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 07:13:24 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD2C061574
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 04:13:24 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Jb0Z86D52zQl4Z;
        Fri, 14 Jan 2022 13:13:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <22b93b6c-5942-6d60-dc41-0efba27910f6@denx.de>
Date:   Fri, 14 Jan 2022 13:13:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] PCI: xilinx-nwl: Add method to
 init_platform_service_irqs hook
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220114075834.1938409-1-sr@denx.de>
 <20220114075834.1938409-3-sr@denx.de> <20220114114836.o5pjxsp6rjdemavr@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220114114836.o5pjxsp6rjdemavr@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/22 12:48, Pali Rohár wrote:
> On Friday 14 January 2022 08:58:34 Stefan Roese wrote:
>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>
>> Add nwl_init_platform_service_irqs() hook to init_platform_service_irqs
>> to register the platform-specific Service Errors IRQs for this PCIe
>> controller to fully support e.g. AER on this platform.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
>> ---
>>   drivers/pci/controller/pcie-xilinx-nwl.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
>> index 414b679175b3..540536bbe3f8 100644
>> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/irqchip/chained_irq.h>
>>   
>>   #include "../pci.h"
>> +#include "../pcie/portdrv.h"
>>   
>>   /* Bridge core config registers */
>>   #define BRCFG_PCIE_RX0			0x00000000
>> @@ -806,6 +807,22 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>>   	return 0;
>>   }
>>   
>> +static int nwl_init_platform_service_irqs(struct pci_dev *dev, int *irqs,
>> +					  int plat_mask)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +	struct nwl_pcie *pcie;
>> +
>> +	bridge = pci_find_host_bridge(dev->bus);
>> +	pcie = pci_host_bridge_priv(bridge);
>> +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
>> +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
>> +		return 0; /* platform-specific service IRQ installed */
>> +	}
> 
> Just I want to be sure, with this change PME and HP interrupts are not
> provided even when plat_mask argument contains them.

This function is only used for Root Ports. E.g. HP at the downstream
ports of the PCIe switch still works in our case, as here
pcie_init_service_irqs() still gets called:

# cat /proc/interrupts | grep pci
  44:          0          0          0          0     GICv2 150 Level 
   nwl_pcie:misc, aerdrv
  61:          2          0          0          0  nwl_pcie:msi 1064960 
Edge      pciehp
  63:          0          0          0          0  nwl_pcie:msi 1081344 
Edge      pciehp
  65:          4          0          0          0  nwl_pcie:msi 1097728 
Edge      pciehp

Thanks,
Stefan

>> +
>> +	return -ENODEV; /* platform-specific service IRQ not installed */
>> +}
>> +
>>   static const struct of_device_id nwl_pcie_of_match[] = {
>>   	{ .compatible = "xlnx,nwl-pcie-2.11", },
>>   	{}
>> @@ -857,6 +874,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>>   
>>   	bridge->sysdata = pcie;
>>   	bridge->ops = &nwl_pcie_ops;
>> +	bridge->init_platform_service_irqs = nwl_init_platform_service_irqs;
>>   
>>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>   		err = nwl_pcie_enable_msi(pcie);
>> -- 
>> 2.34.1
>>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
