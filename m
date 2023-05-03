Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2F6F5918
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjECNbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjECNbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 09:31:47 -0400
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A37102;
        Wed,  3 May 2023 06:31:43 -0700 (PDT)
Received: from [IPV6:240e:3b7:327f:5c30:3c7d:9d61:755a:9449] (unknown [IPV6:240e:3b7:327f:5c30:3c7d:9d61:755a:9449])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id 8D8403C039C;
        Wed,  3 May 2023 21:31:38 +0800 (CST)
Message-ID: <8f4d543a-0b6d-65ca-59ef-70370fbfcb12@sangfor.com.cn>
Date:   Wed, 3 May 2023 21:31:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Cc:     dinghui@sangfor.com.cn, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        david.e.box@linux.intel.com, kai.heng.feng@canonical.com,
        michael.a.bottini@linux.intel.com, rajatja@google.com,
        qinzongquan@sangfor.com.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: fix UAF by removing cached downstream
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230501165254.GA589004@bhelgaas>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20230501165254.GA589004@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxpMVhkeGkwaQ0xJS0keSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTB1BThhIS0FIGEwfQUIfTUpBTE5OGkFCT09CWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a87e1cfb64d2eb2kusn8d8403c039c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46LSo*HD0IIzkPP0oYFA0X
        HTAaCk5VSlVKTUNISklLTUJCSEJIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUwdQU4YSEtBSBhMH0FCH01KQUxOThpBQk9PQllXWQgBWUFOTEJNNwY+
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/5/2 12:52 上午, Bjorn Helgaas wrote:
> On Mon, May 01, 2023 at 11:50:50AM +0800, Ding Hui wrote:
>> On 2023/5/1 10:10, Bjorn Helgaas wrote:
>>> On Sat, Apr 29, 2023 at 09:26:04PM +0800, Ding Hui wrote:
>>>> If the function 0 of a multifunction device is removed, an freed
>>>> downstream pointer will be left in struct pcie_link_state, and then
>>>> when pcie_config_aspm_link() be invoked from any path, we will get a
>>>> KASAN use-after-free report.
>>>
>>> Thanks for finding this problem, debugging it, and the patch!
>>>
>>> In this case we're doing a "software remove" and the other functions
>>> are still present, right?  It's kind of annoying that there's only one
>>> link, but all the functions of a multifunction device have a Link
>>> Control register, and the spec "recommends" that software program the
>>> same ASPM control value for all the functions.
>>
>> Yes, that is the case.
>>
>>> The hardware of course doesn't know anything about this software
>>> remove; all the functions are still physically present and powered up.
>>>
>>> That makes me think that if software ignores the "removed" function
>>> and continues to operate ASPM on the N-1 remaining functions, we're
>>> outside the spec recommendations because the ASPM configuration is no
>>> longer the same across all the functions.
>>>
>>> So my inclination would be disable ASPM completely when any function
>>> of a multi-function device is removed.  What are your thoughts on
>>> this?
>>
>> Agree with you.
>>
>> Previously, I thought another fix that was if the function 0 is removed,
>> we can free the link state to disable ASPM for this link.
>>
>> Now following you suggestion, it can be expanded to any child function.
>>
>> How about fixing like this?
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 66d7514ca111..657e0647d19f 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1011,12 +1011,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>   	down_read(&pci_bus_sem);
>>   	mutex_lock(&aspm_lock);
>>   	/*
>> -	 * All PCIe functions are in one slot, remove one function will remove
>> -	 * the whole slot, so just wait until we are the last function left.
>> +	 * All PCIe functions are in one slot.
>> +	 * The spec "recommends" that software program set the same ASPM control
>> +	 * value for all the functions.
>> +	 * Disable ASPM when any child function is removed.
> 
> Since we're updating the comment anyway, let's clean up the "slot"
> language here.  The PCIe spec doesn't use "slot" in the context of the
> bus/device/function PCIe topology; it only uses it when referring to a
> physical connector where a card might be installed.  What we want here
> is "Device," and then we have to consider whether ARI makes any
> difference here.
> 
> The spec says (referring to ASPM Control):
> 
>    For Multi-Function Devices (including ARI Devices), it is
>    recommended that software program the same value for this field in
>    all Functions. For non-ARI Multi-Function Devices, only capabilities
>    enabled in all Functions are enabled for the component as a whole.
> 
>    For ARI Devices, ASPM Control is determined solely by the setting in
>    Function 0, regardless of Function 0’s D-state. The settings in the
>    other Functions always return whatever value software programmed for
>    each, but otherwise are ignored by the component.
> 
> A spec reference, e.g., "PCIe r6.0, sec 7.5.3.7", would be good here.
> 
> Anyway, I think the idea of "software removing" a single function is
> kind of a niche situation that we don't need to worry about
> optimizing, and I think turning off ASPM completely will avoid a lot
> of weird corner cases.
> 

Thanks for details.

I'll redo the patch with different title.

>>   	 */
>> -	if (!list_empty(&parent->subordinate->devices))
>> -		goto out;
>> -
>>   	link = parent->link_state;
>>   	root = link->root;
>>   	parent_link = link->parent;
>>
>>
>> -- 
>> Thanks,
>> -dinghui
>>
> 

-- 
Thanks,
-dinghui

