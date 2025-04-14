Return-Path: <linux-pci+bounces-25770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F0A875E2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BBD188CF40
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B82BCF5;
	Mon, 14 Apr 2025 02:41:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40338C13D;
	Mon, 14 Apr 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744598486; cv=none; b=XeltIfzNuYjh2JjqVKGNoPktaurgPTBnmrevaVQnSPkcEFtuld0xKXj8eMxz7YS08bt1KVlr/djNpn6qtv1es3jOoE6zGro42MAfTZRS3M3zR9TOCNSziICQXDGVZEr7NUQ6IhObQ3dhPwF0hiuhBjZ+GNcI5jUkq7U+tsjtSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744598486; c=relaxed/simple;
	bh=uBuzwGH65HxhcXcGAQogXc6HaV/5M0QPvZyOUqtn10Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=IDCvUWXLx6PW09W6f6C/+1W0gHwRu+Ll4gg8WK46gc97bJk7uNnYK72S3sxmUgiI67ca8HJLLJC8cMQBJaACYYaEruqq1agNacn6QCSxmFKXJzyJ27urflsRPphJKq+ww7X5kQe9YzHXGSdJHSKQ5Xty6MtZAAdyii99j/5MKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZbWhQ1XWbz1R7bM;
	Mon, 14 Apr 2025 10:39:18 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id C822E18005F;
	Mon, 14 Apr 2025 10:41:13 +0800 (CST)
Received: from [10.174.179.176] (10.174.179.176) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 10:41:13 +0800
Message-ID: <7d2fe444-7e6a-4633-a489-55bba916a7cc@huawei.com>
Date: Mon, 14 Apr 2025 10:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "PCI: Fix reference leak in
 pci_register_host_bridge()"
From: "liwei (JK)" <liwei728@huawei.com>
To: Su Hui <suhui@nfschina.com>
CC: <linux-kernel@vger.kernel.org>, <make24@iscas.ac.cn>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<bobo.shaobowang@huawei.com>, <wangxiongfeng2@huawei.com>
References: <4a967093-97e2-401f-a0ea-9d7447d518c4@nfschina.com>
 <c81b43b7-e993-4e9f-ad27-acacd0b85847@huawei.com>
In-Reply-To: <c81b43b7-e993-4e9f-ad27-acacd0b85847@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2025/4/12 11:18, liwei (JK) 写道:
> 
> 
> 在 2025/4/10 19:19, Su Hui 写道:
>> On 2025/4/10 11:28, Xiangwei Li wrote:
>>> This reverts commit 804443c1f27883926de94c849d91f5b7d7d696e9.
>>>
>>> The newly added logic incorrectly sets bus_registered to true even when
>>> device_register returns an error, this is incorrect.
>>>
>>> When device_register fails, there is no need to release the reference 
>>> count,
>> I think you missed some thing about device_register(). This patch is 
>> wrong.
>>
>> device_register()
>>      -> device_initialize()
>>                -> kobject_init()
>>                      -> kobject_init_internal()
>>                          -> kref_init(&kobj->kref);  //set 
>> kref->refcount to 1
>>                             ^^^^^^^^^^^^^^^^^^^^^
>>
> Sorry, I missed the initialization of refcount in device_initialize,
> but I’m confused about the branch logic for bus_registered. Why isn’t
> free(bus) executed when bus_registered == true? My understanding is
> that the kobject_cleanup operation triggered when refcount reaches zero
> does not clean up the allocated bus. Could you clarify this further?
> 
> Thanks,
> Xiangwei Li
Hi Su,

Thank you very much for your explanation. Based on your response and an
analysis of the corresponding release paths, this confirms that the
issue I previously raised does not exist in your patch.

Release path:
  kobject_cleanup
	->device_release  // device_ktype.device_release
		->release_pcibus_dev  // pcibus_class.release_pcibus_dev
			->kfree(pci_bus)   // free(bus)

Thanks,
Xiangwei Li

>> device_register() only  fails when device_add() fails, and 
>> kerf->refcount can be 1
>> at this time ,  so we need to call put_deivce() to release  memory.
>>> and there are no direct error-handling operations following its 
>>> execution.
>>>
>>> Therefore, this patch is meaningless and should be reverted.
>>>
>>> Fixes: 804443c1f278 ("PCI: Fix reference leak in 
>>> pci_register_host_bridge()")
>>> Signed-off-by: Xiangwei Li <liwei728@huawei.com>
>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>
> 

