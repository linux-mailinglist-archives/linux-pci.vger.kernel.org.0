Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF64310249
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhBEBdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 20:33:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12128 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhBEBdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 20:33:31 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWyYp4S5Cz162FZ;
        Fri,  5 Feb 2021 09:31:26 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 09:32:36 +0800
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@openeuler.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "Michal Marek" <michal.lkml@markovi.net>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210204161048.GA68790@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <8b4e51a2-ce4c-50e1-4e06-7752bf892f05@hisilicon.com>
Date:   Fri, 5 Feb 2021 09:32:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210204161048.GA68790@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/5 0:10, Bjorn Helgaas wrote:
> [+cc Masahiro, Michal, linux-kbuild, linux-kernel]
> 
> On Thu, Feb 04, 2021 at 07:30:15PM +0800, Yicong Yang wrote:
>> From: Junhao He <hejunhao2@hisilicon.com>
>>
>> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
>> settings from Kconfig when traversing subdirectories.
> 
> So I guess the current behavior is:
> 
>   If CONFIG_PCI_DEBUG=y, add -DDEBUG to CFLAGS in the current
>   directory, but not in any subdirectories
> 
> and the behavior after this patch is:
> 
>   If CONFIG_PCI_DEBUG=y, add -DDEBUG to CFLAGS in the current
>   directory and any subdirectories
> 
> Is that right?  That makes sense to me.  I wonder if any other places
> have this issue?

that's right. we didn't check other places, but some have individual config
in their sub-directory as you mentioned below.

> 
> 'git grep "^ccflags.*-DDEBUG"' finds a few cases where subdirectories
> use their own debug config options, e.g.,
> 
>   drivers/i2c/Makefile:ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
>   drivers/i2c/algos/Makefile:ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
>   drivers/i2c/busses/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
>   drivers/i2c/muxes/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> 
> But some have subdirectories that look like they probably should be
> included by using subdir-ccflags, e.g.,
> 
>   drivers/base/Makefile:ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>   drivers/base/power/Makefile:ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>     # drivers/base/{firmware_loader,regmap,test}/ not included
> 
>   drivers/hwmon/Makefile:ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>     # drivers/hwmon/{occ,pmbus}/ not included
> 
>   drivers/pps/Makefile:ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
>   drivers/pps/clients/Makefile:ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
>     # drivers/pps/generators/ not included
> 
> There are many more places that add -DDEBUG to ccflags-y that *don't*
> have subdirectories.
> 
> I wonder the default should be that we use subdir-ccflags all the
> time, and use ccflags only when we actually want different
> CONFIG_*_DEBUG options for subdirectories.

agree. if there is no debug config in the sub-directory, the
config should be inherited from its parent directory using subdir-ccflags.

we can post a separate serial to issue other places.

Thanks,
Yicong

> 
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
>>
> 
> .
> 

