Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE968EF1D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfHOPO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:14:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbfHOPO6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=10q5T0aOD1la3+BpiY+S9zqCgRrKNaeZtsX3VZw5VxY=; b=gg4D1gWf8X+2Arko+oEkMeegw
        UJw1OKqnBBmXrMYrmYbD3BjV+tZ1zPHj86w+/ofJDU7xwAmIUnXa8t9yQ+WdEeHJNEo+cHeBd5nX7
        deZDXop9Jdtjw1E04bFBXSbmkiG9YkWsY93f23ig1ZCcAutpYl3tlQYQHTIE/PPweHBmDIFCC+Eu/
        mkQ8ySnIoUMLOZHtt0XJHZC38IvH5L6nWcG3QYYgupmNWwN0MaalbowAh/0wsmBpRBILt8FgJBwNB
        XOzYaaXWTCJu02wPP57sVrb/RayVlnrUJZQROH4uyBCLm6KYKG9eBbPiRZaqCjYUwXStHmVhRXhAh
        eLtqoVR5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyHSn-0000cI-1u; Thu, 15 Aug 2019 15:14:53 +0000
Subject: Re: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <20190815104748.GB9511@e121166-lin.cambridge.arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e1b9297-c75d-3d64-1d40-c14e9033dc10@infradead.org>
Date:   Thu, 15 Aug 2019 08:14:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815104748.GB9511@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/15/19 3:47 AM, Lorenzo Pieralisi wrote:
> On Fri, Jul 12, 2019 at 08:53:19AM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors when building almost-allmodconfig but with SYSFS
>> not set (not enabled).  Fixes these build errors:
>>
>> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>
>> drivers/pci/slot.o is only built when SYSFS is enabled, so
>> pci-hyperv.o has an implicit dependency on SYSFS.
>> Make that explicit.
>>
>> Also, depending on X86 && X86_64 is not needed, so just change that
>> to depend on X86_64.
>>
>> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
>> information")
> 
> Fixed line break on Fixes tag, FYI.

Thanks.

> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Jake Oshins <jakeo@microsoft.com>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Stephen Hemminger <stephen@networkplumber.org>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-hyperv@vger.kernel.org
>> Cc: Dexuan Cui <decui@microsoft.com>
>> ---
>> v3: corrected Fixes: tag [Dexuan Cui <decui@microsoft.com>]
>>     This is the Microsoft-preferred version of the patch.
>>
>>  drivers/pci/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied to pci/hv for v5.4.
> 
> Thanks,
> Lorenzo
> 
>> --- lnx-52.orig/drivers/pci/Kconfig
>> +++ lnx-52/drivers/pci/Kconfig
>> @@ -181,7 +181,7 @@ config PCI_LABEL
>>  
>>  config PCI_HYPERV
>>          tristate "Hyper-V PCI Frontend"
>> -        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
>> +        depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
>>          help
>>            The PCI device frontend driver allows the kernel to import arbitrary
>>            PCI devices from a PCI backend to support PCI driver domains.
>>
>>


-- 
~Randy
