Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01548D3C5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 09:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiAMImU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 03:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiAMImU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 03:42:20 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C9C06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 00:42:20 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZHx60t3SzQjDt;
        Thu, 13 Jan 2022 09:42:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <edd87a39-706c-ab53-66ee-fde4c4f34bac@denx.de>
Date:   Thu, 13 Jan 2022 09:42:13 +0100
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2 1/4] PCI: Add setup_platform_service_irq hook to
 struct pci_host_bridge
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220112094251.1271531-1-sr@denx.de>
 <20220112102350.hewhzawceohtmtx3@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220112102350.hewhzawceohtmtx3@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 11:23, Pali Rohár wrote:
> Hello!
> 
> On Wednesday 12 January 2022 10:42:48 Stefan Roese wrote:
>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>
>> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 error interrupts can
>> be delivered with platform specific interrupt lines.
> 
> My understanding of these sections is that they still have to be
> deliverable via standard interrupts (INTx / MSI) if root port supports
> standard interrupts:
> 
> "If a Root Port or Root Complex Event Collector is enabled for
> level-triggered interrupt signaling using the INTx messages, the virtual
> INTx wire must be asserted..."
> 
> "If a Root Port or Root Complex Event Collector is enabled for
> edge-triggered interrupt signaling using MSI or MSI-X, an interrupt
> message must be sent every time..."
> 
>> Add setup_platform_service_irq hook to struct pci_host_bridge.
>> Some platforms have dedicated interrupt line from root complex to
>> interrupt controller for PCIe services like AER.
>> This hook is to register platform IRQ's to PCIe port services.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Tested-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> ---
>>   include/linux/pci.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 18a75c8e615c..291eadade811 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -554,6 +554,8 @@ struct pci_host_bridge {
>>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>>   	void (*release_fn)(struct pci_host_bridge *);
>> +	void (*setup_platform_service_irq)(struct pci_host_bridge *, int *,
>> +					   int);
> 
> This callback is used only for root port. So I would suggest to put
> _root port_ into the name of the callback to indicate it. To distinguish
> for which devices is callback designed because other callbacks (e.g.
> map_irq) are used for any device.

I see your point, but I also don't want to make this function name too
long, making the code harder to read IMHO. In the next patchset version
I've changed this name to init_platform_service_irqs (added 's') to
better reflect the input parameters and its related function in
portdrv_core.c, which I now changed according to Bjorn's suggestion to
pcie_init_platform_service_irqs().

Please feel free to suggest a better matching name that is not too long
if one comes to your mind.

> This callback is root port specific and therefore struct pci_dev *
> pointer should be passed as callback argument. Host bridge may have
> multiple root ports, so passing only host bridge is not enough.
> 
> Maybe it would be better to pass struct pci_dev * instead of struct
> pci_host_bridge * As from pci_dev can be easily derived host bridge.

Good idea. I'll integrate this in the next version.

> Anyway, this callback looks to be very useful, I would like to use it in
> pci-aardvark.c and pci-mvebu.c drivers for better mapping of PME, AER
> and HP interrupts. And pci-mvebu.c is multi root port driver, so needs
> pci_dev*.

Sounds like a plan.

> And my guess is that this callback can be useful for adding AER support
> also for pcie-uniphier.c driver, as replacement for this (rather ugly)
> patches:
> https://lore.kernel.org/linux-pci/1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com/
> 
> So I would be happy to see it!

Stay tuned...

Thanks,
Stefan
