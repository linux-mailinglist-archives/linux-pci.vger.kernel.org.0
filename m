Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C521A316268
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 10:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBJJgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 04:36:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13340 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBJJeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 04:34:46 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DbF021LFbz7jXq;
        Wed, 10 Feb 2021 17:32:02 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 17:33:18 +0800
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@openeuler.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "Michal Marek" <michal.lkml@markovi.net>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210209212510.GA513360@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <f65c648d-fdce-b4e9-b4bf-17c7543d1c5b@hisilicon.com>
Date:   Wed, 10 Feb 2021 17:33:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210209212510.GA513360@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/10 5:25, Bjorn Helgaas wrote:
> [+cc Masahiro, Michal, linux-kbuild, linux-kernel]
> 
> On Thu, Feb 04, 2021 at 07:30:15PM +0800, Yicong Yang wrote:
>> From: Junhao He <hejunhao2@hisilicon.com>
>>
>> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
>> settings from Kconfig when traversing subdirectories.
>>
>> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> I applied this with Krzysztof's reviewed-by and the commit log below
> to pci/misc for v5.12, thanks!
> 
> Feel free to copy or improve the commit log for use elsewhere.
> 

thanks for improving the commit. i admit that i didn't make the it
clear enough. it's much better now.

Thanks,
Yicong

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
> 
> commit e8e9aababe60 ("PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy")
> Author: Junhao He <hejunhao2@hisilicon.com>
> Date:   Thu Feb 4 19:30:15 2021 +0800
> 
>     PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy
>     
>     CONFIG_PCI_DEBUG=y adds -DDEBUG to CFLAGS, which enables things like
>     pr_debug() and dev_dbg() (and hence pci_dbg()).  Previously we added
>     -DDEBUG for files in drivers/pci/, but not files in subdirectories of
>     drivers/pci/.
>     
>     Add -DDEBUG to CFLAGS for all files below drivers/pci/ so CONFIG_PCI_DEBUG
>     applies to the entire hierarchy.
>     
>     [bhelgaas: commit log]
>     Link: https://lore.kernel.org/r/1612438215-33105-1-git-send-email-yangyicong@hisilicon.com
>     Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>     Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 11cc79411e2d..d62c4ac4ae1b 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> 
> .
> 

