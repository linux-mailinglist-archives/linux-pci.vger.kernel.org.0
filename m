Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FE2587F3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAGRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 02:17:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgIAGRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Sep 2020 02:17:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9513316CCEF2AEE92511;
        Tue,  1 Sep 2020 14:17:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 14:17:28 +0800
Subject: Re: [PATCH] x86/platform/intel-mid: Fix build error without
 CONFIG_ACPI
To:     Randy Dunlap <rdunlap@infradead.org>, <bhelgaas@google.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <efremov@linux.com>,
        <andriy.shevchenko@linux.intel.com>
References: <20200901035825.25256-1-yuehaibing@huawei.com>
 <5427fca0-6674-42e9-a3b1-52b060ef0301@infradead.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <6d686f3f-b4ee-70e0-3050-1eb6d060ffc3@huawei.com>
Date:   Tue, 1 Sep 2020 14:17:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5427fca0-6674-42e9-a3b1-52b060ef0301@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/9/1 12:07, Randy Dunlap wrote:
> On 8/31/20 8:58 PM, YueHaibing wrote:
>> arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
>> arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
>>   acpi_noirq_set();
>>   ^~~~~~~~~~~~~~
>>   acpi_irq_get
>>
>> Fixes: a912a7584ec3 ("x86/platform/intel-mid: Move PCI initialization to arch_init()")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Bjorn has merged my patch (or so his email says), but apparently it's not
> in linux-next yet.

Thanks for info.

> 
> 
>> ---
>>  arch/x86/pci/intel_mid_pci.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
>> index 00c62115f39c..0aaf31917061 100644
>> --- a/arch/x86/pci/intel_mid_pci.c
>> +++ b/arch/x86/pci/intel_mid_pci.c
>> @@ -33,6 +33,7 @@
>>  #include <asm/hw_irq.h>
>>  #include <asm/io_apic.h>
>>  #include <asm/intel-mid.h>
>> +#include <asm/acpi.h>
>>  
>>  #define PCIE_CAP_OFFSET	0x100
>>  
>>
> 
> thanks.
> 

