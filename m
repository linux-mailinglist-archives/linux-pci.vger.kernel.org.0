Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F974F665B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDFREC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiDFRDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 13:03:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F620A3B6
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 07:49:32 -0700 (PDT)
Message-ID: <51ee3a55-dd07-7d13-f4c0-a772706d9630@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649256570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+EvWnmgwCzgEhcIjth9C7JEw9KhwD2IzRt5LhF8e5Q=;
        b=IjpOHM61dAUWkXOGgZKf/BC4wsKBg6EKd6pTfrGurKuuzWaGnOIwaPiHfiQnfoMe00+bwF
        zwZTlE22bhH6sOSTG1tiwHYltoFlIB/fCNjGvXmU0WGe17QREMBbPHxSC+5J0JefkgDi3t
        KZNgb2XqV8N4ZEdnWATbCuCaNaCvFFQ=
Date:   Wed, 6 Apr 2022 08:49:27 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] PCI/AER: Enable AER on all PCIe devices supporting
 it
Content-Language: en-US
To:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220125071820.2247260-1-sr@denx.de>
 <20220125071820.2247260-4-sr@denx.de>
 <c1ac5a6e-24c0-822a-fc1c-660bc56c0ecf@linux.dev>
 <7f17661f-7c7a-3012-a230-8e081e475bcf@denx.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <7f17661f-7c7a-3012-a230-8e081e475bcf@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/5/2022 11:16 PM, Stefan Roese wrote:
> On 4/4/22 22:22, Jonathan Derrick wrote:
>>
>>
>> On 1/25/2022 12:18 AM, Stefan Roese wrote:
>>> With this change, AER is now enabled on all PCIe devices, also when the
>>> PCIe device is hot-plugged.
>>>
>>> Please note that this change is quite invasive, as with this patch
>>> applied, AER now will be enabled in the Device Control registers of all
>>> available PCIe Endpoints, which currently is not the case.
>>>
>>> When "pci=noaer" is selected, AER stays disabled of course.
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>>> Cc: Pali Rohár <pali@kernel.org>
>>> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
>>> Cc: Naveen Naidu <naveennaidu479@gmail.com>
>>> ---
>>> v4:
>>> - No change
>>>
>>> v3:
>>> - New patch, replacing the "old" 2/2 patch
>>>    Now enabling of AER for each PCIe device is done in pci_aer_init(),
>>>    which also makes sure that AER is enabled in each PCIe device even 
>>> when
>>>    it's hot-plugged.
>>>
>>>   drivers/pci/pcie/aer.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 5585fefc4d0e..10b2f7db8adb 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -388,6 +388,10 @@ void pci_aer_init(struct pci_dev *dev)
>>>       pci_aer_clear_status(dev);
>>> +    /* Enable AER if requested */
>>> +    if (pci_aer_available())
>>> +        pci_enable_pcie_error_reporting(dev);
>> There are a lot of devices that do this explicitly [1]
>> May suggest a cleanup patch to follow-up?
> 
> Yes, good idea. I can try to work on this once this patchset is merged.
> 
>> [1] 
>> https://elixir.bootlin.com/linux/v5.18-rc1/A/ident/pci_enable_pcie_error_reporting 
>>
>>
>> ... Also a quirk list in the future for broken devices
> 
> IMHO this should only be done, when such devices are detected.
Yep; I'm just anticipating

> 
> Thanks,
> Stefan
