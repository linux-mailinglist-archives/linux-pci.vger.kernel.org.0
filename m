Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8561E4471F3
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 07:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhKGGza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 01:55:30 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53144 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhKGGz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 01:55:29 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jc2mmiWjzUujjjc2nmXikG; Sun, 07 Nov 2021 07:52:46 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 07:52:46 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] PCI: endpoint: Use 'bitmap_zalloc()' when applicable
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <01eba3c86137eb348f8cce69f500222bd7c72c57.1635058203.git.christophe.jaillet@wanadoo.fr>
 <YYb7NwlYcmsdw8AR@rocinante>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <8123c76f-3887-09ad-17ec-a160f63b9f86@wanadoo.fr>
Date:   Sun, 7 Nov 2021 07:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYb7NwlYcmsdw8AR@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 06/11/2021 à 23:01, Krzysztof Wilczyński a écrit :
> Hi Christophe,
> 
>> 'mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
>> improve the semantic and avoid some open-coded arithmetic in allocator
>> arguments.
>>
>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>> consistency.
> 
> Thank you!
> 
>> Finally, while at it, axe the useless 'bitmap' variable and use
>> 'mem->bitmap' directly.
> 
> Personally, I would keep the bitmap variable - this might be what Bjorn
> would also prefer, as I believe he prefers not to store what is a "failed"
> state of sorts in a target variable directly, if memory serves me right.

Hi,

mostly a mater of taste.
On another similar patch I got the answer in [1] :).

'mem' is kzalloc'ed, so in case of failure, here we are just replacing 
NULL by NULL.

Let me know the preferred style here and if I should send a V2.

CJ

[1]; https://lore.kernel.org/kernel-janitors/20211028164437.GA4045120@p14s/

> 
> [...]
>> @@ -49,10 +49,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>   			   unsigned int num_windows)
>>   {
>>   	struct pci_epc_mem *mem = NULL;
>> -	unsigned long *bitmap = NULL;
>>   	unsigned int page_shift;
>>   	size_t page_size;
>> -	int bitmap_size;
>>   	int pages;
>>   	int ret;
>>   	int i;
>> @@ -72,7 +70,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>   			page_size = PAGE_SIZE;
>>   		page_shift = ilog2(page_size);
>>   		pages = windows[i].size >> page_shift;
>> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>>   
>>   		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>   		if (!mem) {
>> @@ -81,8 +78,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>   			goto err_mem;
>>   		}
>>   
>> -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
>> -		if (!bitmap) {
>> +		mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
>> +		if (!mem->bitmap) {
>>   			ret = -ENOMEM;
>>   			kfree(mem);
>>   			i--;
>> @@ -92,7 +89,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>   		mem->window.phys_base = windows[i].phys_base;
>>   		mem->window.size = windows[i].size;
>>   		mem->window.page_size = page_size;
>> -		mem->bitmap = bitmap;
>>   		mem->pages = pages;
>>   		mutex_init(&mem->lock);
>>   		epc->windows[i] = mem;
>> @@ -106,7 +102,7 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>>   err_mem:
>>   	for (; i >= 0; i--) {
>>   		mem = epc->windows[i];
>> -		kfree(mem->bitmap);
>> +		bitmap_free(mem->bitmap);
>>   		kfree(mem);
>>   	}
>>   	kfree(epc->windows);
>> @@ -145,7 +141,7 @@ void pci_epc_mem_exit(struct pci_epc *epc)
>>   
>>   	for (i = 0; i < epc->num_windows; i++) {
>>   		mem = epc->windows[i];
>> -		kfree(mem->bitmap);
>> +		bitmap_free(mem->bitmap);
>>   		kfree(mem);
>>   	}
>>   	kfree(epc->windows);
> 
> Thank you!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> 	Krzysztof
> 

