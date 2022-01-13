Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475EC48D6DF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiAMLph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 06:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiAMLpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 06:45:36 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD6C06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 03:45:36 -0800 (PST)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZN0Z0FrFzQlJV;
        Thu, 13 Jan 2022 12:45:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <517324a1-c099-2c7b-73a0-c6cca027c796@denx.de>
Date:   Thu, 13 Jan 2022 12:45:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220113104939.1635398-1-sr@denx.de>
 <20220113104939.1635398-2-sr@denx.de> <20220113111450.pgacviso7sn627ln@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220113111450.pgacviso7sn627ln@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/13/22 12:14, Pali Rohár wrote:
> On Thursday 13 January 2022 11:49:38 Stefan Roese wrote:
>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>
>> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
>> platform-specific System Errors like AER can be delivered via platform-
>> specific interrupt lines.
>>
>> This patch adds the init_platform_service_irqs() hook to struct
>> pci_host_bridge, making it possible that platforms may implement this
>> function to hook IRQs for these platform-specific System Errors, like
>> AER.
>>
>> If these platform-specific service IRQs have been successfully
>> installed via pcie_init_platform_service_irqs(),
>> pcie_init_service_irqs() is skipped.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> ---
>>   drivers/pci/pcie/portdrv_core.c | 43 ++++++++++++++++++++++++++++++++-
>>   include/linux/pci.h             |  2 ++
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index bda630889f95..4dab74ff4368 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -190,6 +190,31 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * pcie_init_platform_service_irqs - initialize platform service irqs for
>> + * platform-specific System Errors
>> + * @dev: PCI Express port to handle
>> + * @irqs: Array of irqs to populate
>> + * @mask: Bitmask of capabilities
>> + *
>> + * Return value: true/false for platforms service irqs installed or not
>> + */
>> +static bool pcie_init_platform_service_irqs(struct pci_dev *dev,
>> +					    int *irqs, int mask)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> 
> I think that this check is not needed as it is done before calling
> pcie_init_platform_service_irqs() function.

Ah, you are correct. I'll remove this check in v4.

>> +		bridge = pci_find_host_bridge(dev->bus);
>> +		if (bridge && bridge->init_platform_service_irqs) {
>> +			bridge->init_platform_service_irqs(dev, irqs, mask);
>> +			return true;
> 
> Suggestion: What about "return bridge->init_platform_service_irqs(...);" ?
> This could allow callback function to fail...

Even better. I'll make this change as well and will wait a bit with
sending v4 to collect a few more review comments.

Thanks,
Stefan
