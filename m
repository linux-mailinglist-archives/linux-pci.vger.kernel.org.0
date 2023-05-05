Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90B6F7C02
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 06:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEEEk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEEEkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 00:40:53 -0400
Received: from mail-m127104.qiye.163.com (mail-m127104.qiye.163.com [115.236.127.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77961BC;
        Thu,  4 May 2023 21:40:43 -0700 (PDT)
Received: from [0.0.0.0] (unknown [172.96.223.238])
        by mail-m127104.qiye.163.com (Hmail) with ESMTPA id C4EA7A402F3;
        Fri,  5 May 2023 12:40:34 +0800 (CST)
Message-ID: <0d2f0f66-02a6-0cdd-4d96-f11f09ff71aa@sangfor.com.cn>
Date:   Fri, 5 May 2023 12:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI/ASPM: fix UAF by disable ASPM for link when child
 function is removed
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com
Cc:     vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230504123418.4438-1-dinghui@sangfor.com.cn>
 <2f32591a-77d8-f620-46bf-825074ba24c2@linux.intel.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <2f32591a-77d8-f620-46bf-825074ba24c2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ04dVklKSEgeSk8fHx0eGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpMSVVCTVVJSUhVSUhDWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a87ea364addb282kuuuc4ea7a402f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6GDo*Mz0PFT0qHE86FlEU
        GQwwFA9VSlVKTUNISU1KTU9LSUNIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKTElVQk1VSUlIVUlIQ1lXWQgBWUFOSUhNNwY+
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/5/5 10:51, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 5/4/23 5:34 AM, Ding Hui wrote:
> 
> Maybe you can use the following title?
> 
> "PCI/ASPM: Fix UAF by disabling ASPM for link when child function is removed
> 

Thanks, I'll fix it in next patch.

>> If the Function 0 of a Multi-Function device is software removed,
>> a freed downstream pointer will be left in struct pcie_link_state,
>> and then when pcie_config_aspm_link() be invoked from any path,
>> we will trigger use-after-free.
>>
>> Based on the PCIe spec about ASPM Control (PCIe r6.0, sec 7.5.3.7),
> 
> As per PCIe spec r6.0, sec 7.5.3.7, it is recommended
> 

Thanks, I'll fix it in next patch.

>> for Multi-Function Devices (including ARI Devices), it is recommended
>> that software program the same value in all Functions. For ARI
>> Devices, ASPM Control is determined solely by the setting in Function 0.
>>
>> So we can just disable ASPM of the whole component if any child
>> function is removed, the downstream pointer will be avoided from
>> use-after-free, that will also avoid other potential corner cases.
>>
>> Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
>> Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
> 
> Any bugzilla link with error log and reproduction steps?

Yes, I should link previous
https://lore.kernel.org/lkml/20230429132604.31853-1-dinghui@sangfor.com.cn/

Since Bjorn think the ALL details is not necessary, so I'll add the
reproducer and compact result in next patch.

> 
>> Suggestion-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Suggested-by?

Sorry, I'll fix it in next patch.

> 
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>>   drivers/pci/pcie/aspm.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 66d7514ca111..1bf8306141aa 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1010,18 +1010,17 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>   
>>   	down_read(&pci_bus_sem);
>>   	mutex_lock(&aspm_lock);
>> -	/*
>> -	 * All PCIe functions are in one slot, remove one function will remove
>> -	 * the whole slot, so just wait until we are the last function left.
>> -	 */
>> -	if (!list_empty(&parent->subordinate->devices))
>> -		goto out;
>>   
>>   	link = parent->link_state;
>>   	root = link->root;
>>   	parent_link = link->parent;
>>   
>> -	/* All functions are removed, so just disable ASPM for the link */
>> +	/*
>> +	 * Any function is removed (including software removing), just
>> +	 * disable ASPM for the link, in case we can not configure the same
>> +	 * setting for all functions.
> 
> How about following?
> 
> /*
>   * For any function removed, disable ASPM for the link. See PCIe r6.0,
>   * sec 7.7.3.7 for details.
>   */
> 

Thanks, it's better.

>> +	 * See PCIe r6.0, sec 7.5.3.7.
>> +	 */
>>   	pcie_config_aspm_link(link, 0);
>>   	list_del(&link->sibling);
>>   	/* Clock PM is for endpoint device */
>> @@ -1032,7 +1031,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>   		pcie_update_aspm_capable(root);
>>   		pcie_config_aspm_path(parent_link);
>>   	}
>> -out:
>> +
>>   	mutex_unlock(&aspm_lock);
>>   	up_read(&pci_bus_sem);
>>   }
> 

-- 
Thanks,
- Ding Hui

