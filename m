Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C16F8D30
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 02:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEFAof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 20:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 20:44:34 -0400
Received: from mail-m127104.qiye.163.com (mail-m127104.qiye.163.com [115.236.127.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537D4ED0;
        Fri,  5 May 2023 17:44:32 -0700 (PDT)
Received: from [0.0.0.0] (unknown [172.96.223.238])
        by mail-m127104.qiye.163.com (Hmail) with ESMTPA id F1C18A401D7;
        Sat,  6 May 2023 08:44:22 +0800 (CST)
Message-ID: <306e8a8b-e411-102c-3ebb-a226dcb5adc8@sangfor.com.cn>
Date:   Sat, 6 May 2023 08:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI/ASPM: fix UAF by disable ASPM for link when child
 function is removed
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230505205845.GA978671@bhelgaas>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20230505205845.GA978671@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0JOVk0eQktKS0pNSBhNGVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpMSVVCTVVJSUhVSUhDWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a87ee8468cfb282kuuuf1c18a401d7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46Lyo5Dj0NLzxDTDFWPzYJ
        Sg8KCTJVSlVKTUNISEhIQ01DTkNJVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKTElVQk1VSUlIVUlIQ1lXWQgBWUFOTENKNwY+
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/5/6 4:58, Bjorn Helgaas wrote:
> On Thu, May 04, 2023 at 08:34:18PM +0800, Ding Hui wrote:
>> If the Function 0 of a Multi-Function device is software removed,
>> a freed downstream pointer will be left in struct pcie_link_state,
>> and then when pcie_config_aspm_link() be invoked from any path,
>> we will trigger use-after-free.
>>
>> Based on the PCIe spec about ASPM Control (PCIe r6.0, sec 7.5.3.7),
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
>> Suggestion-by: Bjorn Helgaas <bhelgaas@google.com>
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
> 
> Not directly related to your patch, but this looks racy to me:
> 
>    void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>    {
>      struct pci_dev *parent = pdev->bus->self;
> 
>      if (!parent || !parent->link_state)
>        return;
> 
>      down_read(&pci_bus_sem);
>      mutex_lock(&aspm_lock);
> 
>      link = parent->link_state;
>      root = link->root;
>      ...
>      free_link_state(link);
>        link->pdev->link_state = NULL;
>        kfree(link);
> 
> Since we check "parent->link_state" before acquiring the locks, I
> suspect that removing two functions at the same time could end up with
> a NULL pointer dereference:
> 
>    pcie_aspm_exit_link_state(fn 0)    pcie_aspm_exit_link_state(fn 1)
>    parent = X                         parent = X
>    parent->link_state != NULL         parent->link_state != NULL
> 
>    acquire locks
>    free_link_state(link)
>    link->pdev->link_state = NULL # aka parent->link_state
>    kfree(link)
>    release locks
> 
>                                       acquire locks
>                                       link = parent->link_state # now NULL
>                                       root = link->root         # NULL ptr
> 
> What do you think?  I guess if this *is* a race, it should be fixed by
> a separate patch.
> 

Maybe there's no need to worry about the race, when a pci device is removing,
the pci_rescan_remove_lock should be acquired.

Anyway, double check would be safer.

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
>> -- 
>> 2.17.1
>>
> 

-- 
Thanks,
- Ding Hui

