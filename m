Return-Path: <linux-pci+bounces-25768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA9AA87593
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E763167FC5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552B1624DE;
	Mon, 14 Apr 2025 01:48:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 04F1A178372;
	Mon, 14 Apr 2025 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595319; cv=none; b=fKvKXICFT4Ymw2XI7Vk84EGs8ucLKBj9moVGgxvGrlJbBy6+9AHw+jQOyoRZfVtkTa+zg7HTs0EyJGLsIwT/GNqUSlctqskIWdarlis0ZLH77krjw6Yv9bINFa9c/6ZMNnnGCcDxUicw8Ty6RDM3VVP5hD4mVJqfCtf2F1ISTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595319; c=relaxed/simple;
	bh=k3+Pw6nnVOlaFTatgzu829SDj9sOEFPIIJet/21rX2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=ZwxX1RHCuvE1CYbDVsvqmoZLj1016hjkIml11Pe9zF/tXgLCGgl7hDIcRcTwg3v5QZgv3/PkI4VMXTNndNa7y6vcA1LzelfFWeItvoGIT1y/xu90K7qNXn99jE3OcRjPkvz9uqfdb3885NnPqH3AYsLbVH9SJdT+W6i78OKEI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id DA88F60187F4F;
	Mon, 14 Apr 2025 09:48:28 +0800 (CST)
Message-ID: <c6fb3f34-4296-4b86-a08c-92b16cd8e1d0@nfschina.com>
Date: Mon, 14 Apr 2025 09:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "PCI: Fix reference leak in
 pci_register_host_bridge()"
To: "liwei (JK)" <liwei728@huawei.com>
Cc: linux-kernel@vger.kernel.org, make24@iscas.ac.cn, bhelgaas@google.com,
 linux-pci@vger.kernel.org, bobo.shaobowang@huawei.com,
 wangxiongfeng2@huawei.com
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <c81b43b7-e993-4e9f-ad27-acacd0b85847@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/4/12 11:18, liwei (JK) wrote:
> 在 2025/4/10 19:19, Su Hui 写道:
>> On 2025/4/10 11:28, Xiangwei Li wrote:
>>> This reverts commit 804443c1f27883926de94c849d91f5b7d7d696e9.
>>>
>>> The newly added logic incorrectly sets bus_registered to true even when
>>> device_register returns an error, this is incorrect.
>>>
>>> When device_register fails, there is no need to release the 
>>> reference count,
>> I think you missed some thing about device_register(). This patch is 
>> wrong.
>>
>> device_register()
>>      -> device_initialize()
>>                -> kobject_init()
>>                      -> kobject_init_internal()
>>                          -> kref_init(&kobj->kref); //set 
>> kref->refcount to 1
>>                             ^^^^^^^^^^^^^^^^^^^^^
>>
> Sorry, I missed the initialization of refcount in device_initialize,
> but I’m confused about the branch logic for bus_registered. Why isn’t
> free(bus) executed when bus_registered == true? My understanding is
> that the kobject_cleanup operation triggered when refcount reaches zero
> does not clean up the allocated bus. Could you clarify this further?
>
1020         dev_set_name(&bus->dev, "%04x:%02x", pci_domain_nr(bus), 
bus->number);
                   ^^^^^^^^^^^^^^^^^^^^
                 //device name is allocated, and should be freed when 
device_register() is failed.

1021         name = dev_name(&bus->dev);
1022
1023         err = device_register(&bus->dev);
1024         bus_registered = true;
1025         if (err)
1026                 goto unregister;
                         [...]
1117         if (bus_registered)
1118                 put_device(&bus->dev);
                            ^^^^^^^^^^^^^^^^
                            // decrement reference count  to zero and 
call release_pcibus_dev() to free bus.
                            // And call kfree_const() to free device 
name in kobject_cleanup().

1119         else
1120                 kfree(bus);

Commit 804443c1f278 fixes the memory leak of 'name' and consistent with 
the annotation of device_degister():

  '* NOTE: _Never_ directly free @dev after calling this function, even
  * if it returned an error! Always use put_device() to give up the
  * reference initialized in this function instead.'

Su Hui







