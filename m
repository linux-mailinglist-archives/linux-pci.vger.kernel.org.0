Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED348D4C0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiAMJIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 04:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiAMJIh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 04:08:37 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72245C06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 01:08:36 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZJWQ2X69zQkFr;
        Thu, 13 Jan 2022 10:08:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <6dfb6225-aca3-dcbb-9e62-4d8b1933995f@denx.de>
Date:   Thu, 13 Jan 2022 10:08:31 +0100
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2 2/4] PCI: Add pci_check_platform_service_irqs
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220112164226.GA263789@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220112164226.GA263789@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 17:42, Bjorn Helgaas wrote:
> On Wed, Jan 12, 2022 at 10:42:49AM +0100, Stefan Roese wrote:
>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>
>> Adding method pci_check_platform_service_irqs to check if platform
>> has registered method to proivde dedicated IRQ lines for PCIe services
>> like AER.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Tested-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> ---
>>   include/linux/pci.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 291eadade811..d6812d596ecc 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2420,6 +2420,24 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
>>   	return bus->self && bus->self->ari_enabled;
>>   }
>>   
>> +/**
>> + * pci_check_platform_service_irqs - check platform service irq's
>> + * @pdev: PCI Express device to check
>> + * @irqs: Array of irqs to populate
>> + * @mask: Bitmask of capabilities
>> + */
>> +static inline void pci_check_platform_service_irqs(struct pci_dev *dev,
>> +						   int *irqs, int mask)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
>> +		bridge = pci_find_host_bridge(dev->bus);
>> +		if (bridge && bridge->setup_platform_service_irq)
>> +			bridge->setup_platform_service_irq(bridge, irqs, mask);
>> +	}
>> +}
> 
> I don't think this needs to be in include/linux/pci.h; I think it
> should be in drivers/pci/pcie/portdrv_core.c where it is called.

Agreed.

> The name and signature should be parallel to pcie_init_service_irqs()
> since it is basically doing the same thing for platform-specific
> interrupts.

I've changed it now to pcie_init_platform_service_irqs(). Just let me
know if you had some other naming in mind.

> These patches are split up a little bit *too* much.  Each one should
> add some piece of functionality.  Currently they add declarations that
> are not used, functions that are not called, etc.  That makes it hard
> to read one patch and get any idea of what it's for.

Agreed. Let me see, how this is best done. Most likely 2 patches, one
adding the new infrastructure to the PCIe subsystem and one adding the
"user" to the Xilinx PCIe controller driver.

Thanks,
Stefan
