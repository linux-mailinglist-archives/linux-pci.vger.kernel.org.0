Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A711260AD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLSLTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 06:19:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45822 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSLTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 06:19:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJBJcLU097120;
        Thu, 19 Dec 2019 05:19:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576754378;
        bh=hxb6JIinS7gm+NvrnQvD8AZ5CIJM9lcL1/MyauteoLw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=irD+RZuv40udwpVRCV5MQmHhhiIxMHwM05lglG57GEY7JQf8jjuJDdxjt7tfugzC/
         uDcLI6vl/qQAl0fMC0wLeUJuoRyzTNgPsq43qIjGaAw21sZ0Vqz4d8ypbNu8PBXrtg
         zLnSGMDCrThz38hMQficzenWuIcmjJGwBPjYXGsU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJBJc2U126453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:19:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 05:19:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 05:19:38 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJBJZpV109234;
        Thu, 19 Dec 2019 05:19:36 -0600
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
To:     Yurii Monakov <monakov.y@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>
References: <20191217193131.2dc1c53c@monakov-y.xu>
 <20191217215436.GA230275@google.com> <20191218163101.4af92f48@monakov-y.xu>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f4724c41-5bf4-d155-7dbe-36d8fec315de@ti.com>
Date:   Thu, 19 Dec 2019 16:51:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218163101.4af92f48@monakov-y.xu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/12/19 7:01 pm, Yurii Monakov wrote:
> On Tue, 17 Dec 2019 15:54:36 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> On Tue, Dec 17, 2019 at 07:31:31PM +0300, Yurii Monakov wrote:
>>> On Tue, 17 Dec 2019 08:31:13 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>   
>>>> [+cc Kishon]
>>>>
>>>> On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:  
>>>>> PCIe window memory start address should be incremented by OB_WIN_SIZE
>>>>> megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
>>>>>
>>>>> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>    
>>>>
>>>> I added:
>>>>
>>>>   Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
>>>>   Acked-by: Andrew Murray <andrew.murray@arm.com>
>>>>   Cc: stable@vger.kernel.org      # v4.20+
>>>>
>>>> and cc'd Kishon (author of  e75043ad9792) and put this on my
>>>> pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
>>>> returns.
>>>>
>>>> I'd like the commit message to say what this fixes.  Currently it just
>>>> restates the code change, which I can see from the diff.  
>>> This was my first patch sent to LKML, I'm sorry for inconvenience.
>>> Should I take any actions to fix this?  
>>
>> Great, welcome!  No need for you to do anything; just let me know if I
>> captured this correctly:
> Yes, everything is correct. New commit message perfectly describes this patch.

Thanks for the patch.
FWIW:

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Best Regards,
> Yurii Monakov
> 
>>
>> commit 93c53da177c9 ("PCI: keystone: Fix outbound region mapping")
>> Author: Yurii Monakov <monakov.y@gmail.com>
>> Date:   Fri Oct 4 18:48:11 2019 +0300
>>
>>     PCI: keystone: Fix outbound region mapping
>>     
>>     The Keystone outbound Address Translation Unit (ATU) maps PCI MMIO space in
>>     8 MB windows.  When programming the ATU windows, we previously incremented
>>     the starting address by 8, not 8 MB, so all the windows were mapped to the
>>     first 8 MB.  Therefore, only 8 MB of MMIO space was accessible.
>>     
>>     Update the loop so it increments the starting address by 8 MB, not 8, so
>>     more MMIO space is accessible.
>>     
>>     Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
>>     Link: https://lore.kernel.org/r/20191004154811.GA31397@monakov-y.office.kontur-niirs.ru
>>     [bhelgaas: commit log]
>>     Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Acked-by: Andrew Murray <andrew.murray@arm.com>
>>     Cc: stable@vger.kernel.org	# v4.20+
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index af677254a072..f19de60ac991 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>>  				   lower_32_bits(start) | OB_ENABLEN);
>>  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
>>  				   upper_32_bits(start));
>> -		start += OB_WIN_SIZE;
>> +		start += OB_WIN_SIZE * SZ_1M;
>>  	}
>>  
>>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> 
