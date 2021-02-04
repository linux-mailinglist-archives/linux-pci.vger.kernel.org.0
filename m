Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664CD30F3C6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhBDNUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 08:20:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhBDNUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 08:20:08 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWfHg4mdLzjJM0;
        Thu,  4 Feb 2021 21:18:07 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 21:19:20 +0800
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
 <YBvoauS9WagVizdh@rocinante>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <3171ed82-c114-2298-1c03-f7c854fb15c0@hisilicon.com>
Date:   Thu, 4 Feb 2021 21:19:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YBvoauS9WagVizdh@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/4 20:28, Krzysztof Wilczyński wrote:
> Hi Yicong,
> 
> Thank you for taking care of this!
> 
> By the way, did you have some issues with things like pr_debug() and other
> things printing debug information not working correctly before?

i cannot remember that i have met any, so maybe they work properly. :)

> 
> On 21-02-04 19:30:15, Yicong Yang wrote:
>> From: Junhao He <hejunhao2@hisilicon.com>
>>
>> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
>> settings from Kconfig when traversing subdirectories.
>>
>> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/pci/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 11cc794..d62c4ac 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>>  obj-y				+= controller/
>>  obj-y				+= switch/
>>  
>> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>> -- 
>> 2.8.1
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> Krzysztof
> 
> .
> 

