Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1048D4B4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 10:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiAMJFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 04:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiAMJEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 04:04:44 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF8C06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 01:04:44 -0800 (PST)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JZJQy5HM0zQk4J;
        Thu, 13 Jan 2022 10:04:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <23d61a81-dac8-f801-d1f1-17d67a774285@denx.de>
Date:   Thu, 13 Jan 2022 10:04:37 +0100
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2 3/4] PCI/portdrv: Check platform supported
 service IRQ's
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220112163646.GA263326@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220112163646.GA263326@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 17:36, Bjorn Helgaas wrote:
> On Wed, Jan 12, 2022 at 11:34:02AM +0100, Pali Rohár wrote:
>> On Wednesday 12 January 2022 10:42:50 Stefan Roese wrote:
>>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>>
>>> Platforms may have dedicated IRQ lines for PCIe services like
>>> AER/PME etc., check for such IRQ lines.
>>> Check if platform has any dedicated IRQ lines for PCIe
>>> services.
> 
> Use the terminology from the spec again ("platform-specific System
> Errors").

Ok.

>>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Tested-by: Stefan Roese <sr@denx.de>
>>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>>> Cc: Pali Rohár <pali@kernel.org>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>   drivers/pci/pcie/portdrv_core.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index bda630889f95..70dd45671ed8 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -358,6 +358,14 @@ int pcie_port_device_register(struct pci_dev *dev)
>>>   		}
>>>   	}
>>>   
>>> +	/*
>>> +	 * Some platforms have dedicated interrupt line from root complex to
>>> +	 * interrupt controller for PCIe services like AER/PME etc., check
>>> +	 * if platform registered with any such IRQ.
>>> +	 */
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>>> +		pci_check_platform_service_irqs(dev, irqs, capabilities);
>>> +
>>
>> In my opinion calling this hook at this stage is too late. Few lines
>> above is following code:
>>
>> 	if (irq_services) {
>> 		/*
>> 		 * Initialize service IRQs. Don't use service devices that
>> 		 * require interrupts if there is no way to generate them.
>> 		 * However, some drivers may have a polling mode (e.g.
>> 		 * pciehp_poll_mode) that can be used in the absence of IRQs.
>> 		 * Allow them to determine if that is to be used.
>> 		 */
>> 		status = pcie_init_service_irqs(dev, irqs, irq_services);
>> 		if (status) {
>> 			irq_services &= PCIE_PORT_SERVICE_HP;
>> 			if (!irq_services)
>> 				goto error_disable;
>> 		}
>> 	}
>>
>> Function pcie_init_service_irqs() fails if "dev" does not have any
>> suitable interrupt. Which happens for devices / root ports without
>> support for standard interrupts (INTx / MSI).
>>
>> I think that this new hook should have preference over
>> pcie_init_service_irqs() and after this new hook should be
>> pcie_init_service_irqs() called only for irq_services which new hook has
>> not filled. And if at least new hook or pcie_init_service_irqs() passes
>> then "error_disable" path should not be called.
> 
> I tend to agree.  I expect that a host bridge will only use this new
> mechanism if the standard INTx/MSI interrupts don't work.
> 
> I guess it's possible a device could use platform-specific errors for
> some services and standard INTx/MSI for others, but unless we have an
> example of that, I'm not sure it's worth trying to support that.
> 
> For now, I think it will be simpler to skip pcie_init_service_irqs()
> completely if the platform-specific hook is successful.

Understood. I'll make the necessary changes in v3.

Thanks,
Stefan
