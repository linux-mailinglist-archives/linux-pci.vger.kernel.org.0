Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2108667AC1
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2019 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGMPD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Jul 2019 11:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Jul 2019 11:03:56 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C832F20830;
        Sat, 13 Jul 2019 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030235;
        bh=rhgzDBUt9BwMxq+kcRcec6QPbDI11qibjcUAURXIaPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPt6oRaJ5kTRyGlNDrlZ/GflHZ4spBWudBFrnHFoXTH3eRJpAHq9wU02ulORAnSPn
         r1bn+A0jfbR15ra+hVS2N2gQSBz7uM8iERiEtO3sXaYczPMU/yYdWF3gHn4p2QysR4
         U5ennukmaVUWYktXX6S31jWL3IH6lWCZYgVZ7zfQ=
Date:   Sat, 13 Jul 2019 11:03:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Message-ID: <20190713150353.GF10104@sasha-vm>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 04:04:17PM +0000, Haiyang Zhang wrote:
>
>
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Friday, July 12, 2019 11:53 AM
>> To: linux-pci <linux-pci@vger.kernel.org>; LKML <linux-
>> kernel@vger.kernel.org>
>> Cc: Matthew Wilcox <willy@infradead.org>; Jake Oshins
>> <jakeo@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
>> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; Stephen Hemminger
>> <stephen@networkplumber.org>; Sasha Levin <sashal@kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>; Dexuan Cui <decui@microsoft.com>
>> Subject: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
>>
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
>>
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
>>
>> --- lnx-52.orig/drivers/pci/Kconfig
>> +++ lnx-52/drivers/pci/Kconfig
>> @@ -181,7 +181,7 @@ config PCI_LABEL
>>
>>  config PCI_HYPERV
>>          tristate "Hyper-V PCI Frontend"
>> -        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
>> && X86_64
>> +        depends on X86_64 && HYPERV && PCI_MSI &&
>> PCI_MSI_IRQ_DOMAIN && SYSFS
>>          help
>>            The PCI device frontend driver allows the kernel to import arbitrary
>>            PCI devices from a PCI backend to support PCI driver domains.
>>
>
>Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Queued up for hyperv-fixes, thank you!

--
Thanks,
Sasha
