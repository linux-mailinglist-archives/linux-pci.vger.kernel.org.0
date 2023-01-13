Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F759668A7B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAMD6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 22:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjAMD6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 22:58:18 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75F1A3A5;
        Thu, 12 Jan 2023 19:58:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VZTDa66_1673582286;
Received: from 30.97.48.93(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VZTDa66_1673582286)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 11:58:07 +0800
Message-ID: <87b08879-4f1a-e91d-861a-0a1af4ad46fc@linux.alibaba.com>
Date:   Fri, 13 Jan 2023 11:58:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] PCI: Tune secondary bus reset time for PCIe
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, matthew@wil.cx,
        jbarnes@virtuousgeek.org, greg@kroah.com, patchwork-bot@kernel.org,
        andrew.murray@arm.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230112224808.GA1799425@bhelgaas>
From:   Yang Su <yang.su@linux.alibaba.com>
In-Reply-To: <20230112224808.GA1799425@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry to interrupt, this email is reformat as plaint text, I want to 
test this email

whether can send linux-kernel@vger.kernel.org .


Hi Bjorn,

I think my patch is different from Lucas, because I use 
pcie_wait_for_link not

pci_bridge_wait_for_secondary_bus, my patch is similar to the process logic

in pci_bridge_wait_for_secondary_bus which also call pcie_wait_for_link.


pcie_wait_for_link wait fixed 100ms and then wait the data link is 
ready, but

pci_bridge_wait_for_secondary_bus call pcie_wait_for_link wait time depends

on the devices max waiting time in bus, the calculate max time having a bug

as below,


In pci_bridge_wait_for_secondary_bus, pci_bus_max_d3cold_delay will take 
count of wrong time delay,

such as NVIDIA GPU T4 is not pci bridge, so the subordinate is none, 
pci_bus_max_d3cold_delay

set the min_delay is 100, max_delay is 0, here is the bug, after 
list_for_each_entry() in pci_bus_max_d3cold_delay,

the min_delay will be 0, the max_delay also 0, the 
pci_bus_max_d3cold_delay return is surely 0.


Last, I request Ravi Kishore Koppuravuri to test my patch to see Intel 
Ponte Vecchio HPC GPU

whether can work, I think my patch will wait enough time to be ready 
after secondary bus reset.


I have tested NVIDIA GPU T4 and NVIDIA GPU A100 which my patch is ok, 
but I think there is need

more test to validate my patch. But the fact is I do not have enough 
device to validate. If Ravi Kishore Koppuravuri

can help me test, the patch test will be more enough, and I would be 
grateful for test. Thank you very much!


Yang


On 2023/1/13 06:48, Bjorn Helgaas wrote:
> [+cc Lukas, Mika]
>
> Hi Yang Su,
>
> Thank you for your patch!
>
> On Sun, Jan 01, 2023 at 05:22:33PM +0800, Yang Su wrote:
>> On PCI Express, there will be cases where the new code sleeps far less
>> than the 1s being replaced by this patch. This should be okay, because
>> PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019)
>> in Section 6.6.1 "Conventional Reset" only notes 100ms as the minimum
>> waiting time. After this time, the OS is permitted to issue
>> Configuration Requests, but it is possible that the device responds
>> with Configuration Request Retry Status (CRS) Completions, rather than
>> Successful Completion. Returning CRS can go on for up to 1 second after
>> a Conventional Reset (such as SBR) before the OS can consider the device
>> broken. This additional wait is handled by pci_dev_wait. Besides,
>> this patch also cover PCI and PCI-X after device reset waiting Tpvrh 1000ms.
>>
>> Currently, the only callchain that lands in the function modified by
>> this patch which invokes one out of two versions of pcibios_reset_secondary_bus
>> that both end with a call to pci_reset_secondary_bus.
>>
>> Afterwards, pci_reset_secondary_bus always invokes pci_dev_wait
>> which wait for the device to return a non-CRS completion.
>>
>> Signed-off-by: Yang Su <yang.su@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index fba95486caaf..8e4899755718 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5063,10 +5063,40 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>>   	 * Trhfa for conventional PCI is 2^25 clock cycles.
>>   	 * Assuming a minimum 33MHz clock this results in a 1s
>>   	 * delay before we can consider subordinate devices to
>> -	 * be re-initialized.  PCIe has some ways to shorten this,
>> -	 * but we don't make use of them yet.
>> +	 * be re-initialized.
>> +	 *
>> +	 * For conventional PCI needing 1s delay after bus reset.
>> +	 * Using pci_is_pcie to judge the bus is pci or pcie.
>> +	 * If the bus is pci, sleeping 1s to wait device is ready.
>> +	 *
>> +	 * And if the bus is pcie, PCI Express Base Specification Revision 2.0
>> +	 * (December 20, 2006) in Section 6.6.1 "Conventional Reset" only notes
>> +	 * 100ms as the minimum waiting time, the same as the newer PCIe spec
>> +	 * PCI Express Base Specification Revision 3.0 Version 1.a (December 7, 2015)
>> +	 * and PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019).
>> +	 * With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
>> +	 * software must wait a minimum of 100 ms after Link training completes before
>> +	 * sending a Configuration Request to the device immediately below that Port.
>> +	 * After this time, the OS is permitted to issue Configuration Requests,
>> +	 * but it is possible that the device responds with Configuration Request
>> +	 * Retry Status (CRS) Completions, rather than Successful Completion.
>> +	 * Returning CRS can go on for up to 1 second after a Conventional Reset
>> +	 * (such as SBR) before the OS can consider the device. This additional
>> +	 * wait is handled by pci_dev_wait.
>> +	 *
>> +	 * Currently, the only callchain that lands in the function modified by
>> +	 * this patch starts at pci_bridge_secondary_bus_reset which invokes
>> +	 * one out of two versions of pcibios_reset_secondary_bus that both end
>> +	 * with a call to pci_reset_secondary_bus.
>> +	 * Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait.
>>   	 */
>> -	ssleep(1);
>> +	if (pci_is_pcie(dev))
>> +		if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)
>> +			msleep(100);
>> +		else
>> +			pcie_wait_for_link(dev, true);
>> +	else
>> +		ssleep(1);
> This code is also updated by Lukas' patch at
> https://lore.kernel.org/r/bd6ac49d60c1ca6fe5c27c2fa54b78d70a8ba07b.1672511017.git.lukas@wunner.de,
> which is pretty much ready to go.
>
> Can you take a look at that series and see whether it solves the same
> problem you're solving here?  And if not, can you provide feedback on
> what would still be needed?
>
> If you do need something on top of Lukas' series, please CC him if you
> post a revised patch.
>
> Bjorn
