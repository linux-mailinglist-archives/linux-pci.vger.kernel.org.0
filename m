Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2848D3D0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiAMIq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 03:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiAMIq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 03:46:58 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2CC06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 00:46:57 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZJ2S3fxnzQjDt;
        Thu, 13 Jan 2022 09:46:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <5d22c26e-62ad-1186-8298-9b214a9f7201@denx.de>
Date:   Thu, 13 Jan 2022 09:46:52 +0100
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2 1/4] PCI: Add setup_platform_service_irq hook to
 struct pci_host_bridge
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220112162032.GA260336@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220112162032.GA260336@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 17:20, Bjorn Helgaas wrote:
> On Wed, Jan 12, 2022 at 10:42:48AM +0100, Stefan Roese wrote:
>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>
>> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 error interrupts can
>> be delivered with platform specific interrupt lines.
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
> 
> It would be nice if this included a cover letter like Bharat's
> original posting did [1].  That makes it easier to keep organized.

I wanted to do this, but somehow forgot it when sending the patches.
Will do in the next version for sure.

> The PCIe r6.0 spec just came out, so let's update the spec references
> to that.  Conveniently, the section numbers stayed the same as they
> were in r4.0.
> 
> Update the language here to use the spec terminology, i.e.,
> "platform-specific System Errors"  That helps find the related bits,
> e.g., "System Error on Correctable Error Enable" in the Root Control
> register.
> 
> Rewrap this into paragraphs separated by blank lines.
> 
> [1] https://lore.kernel.org/all/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/

Okay, I'll try to update these descriptions accordingly in v3.

Thanks,
Stefan

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
>>   	void		*release_data;
>>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>> -- 
>> 2.34.1
>>
