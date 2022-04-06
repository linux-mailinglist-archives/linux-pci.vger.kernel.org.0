Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC234F57A9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiDFHbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585902AbiDFGtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 02:49:52 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0049377C
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 22:16:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4KYCRc6BdRz9sQV;
        Wed,  6 Apr 2022 07:16:44 +0200 (CEST)
Message-ID: <7f17661f-7c7a-3012-a230-8e081e475bcf@denx.de>
Date:   Wed, 6 Apr 2022 07:16:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] PCI/AER: Enable AER on all PCIe devices supporting
 it
Content-Language: en-US
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220125071820.2247260-1-sr@denx.de>
 <20220125071820.2247260-4-sr@denx.de>
 <c1ac5a6e-24c0-822a-fc1c-660bc56c0ecf@linux.dev>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <c1ac5a6e-24c0-822a-fc1c-660bc56c0ecf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/22 22:22, Jonathan Derrick wrote:
> 
> 
> On 1/25/2022 12:18 AM, Stefan Roese wrote:
>> With this change, AER is now enabled on all PCIe devices, also when the
>> PCIe device is hot-plugged.
>>
>> Please note that this change is quite invasive, as with this patch
>> applied, AER now will be enabled in the Device Control registers of all
>> available PCIe Endpoints, which currently is not the case.
>>
>> When "pci=noaer" is selected, AER stays disabled of course.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> Cc: Naveen Naidu <naveennaidu479@gmail.com>
>> ---
>> v4:
>> - No change
>>
>> v3:
>> - New patch, replacing the "old" 2/2 patch
>>    Now enabling of AER for each PCIe device is done in pci_aer_init(),
>>    which also makes sure that AER is enabled in each PCIe device even 
>> when
>>    it's hot-plugged.
>>
>>   drivers/pci/pcie/aer.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 5585fefc4d0e..10b2f7db8adb 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -388,6 +388,10 @@ void pci_aer_init(struct pci_dev *dev)
>>       pci_aer_clear_status(dev);
>> +    /* Enable AER if requested */
>> +    if (pci_aer_available())
>> +        pci_enable_pcie_error_reporting(dev);
> There are a lot of devices that do this explicitly [1]
> May suggest a cleanup patch to follow-up?

Yes, good idea. I can try to work on this once this patchset is merged.

> [1] 
> https://elixir.bootlin.com/linux/v5.18-rc1/A/ident/pci_enable_pcie_error_reporting 
> 
> 
> ... Also a quirk list in the future for broken devices

IMHO this should only be done, when such devices are detected.

Thanks,
Stefan
