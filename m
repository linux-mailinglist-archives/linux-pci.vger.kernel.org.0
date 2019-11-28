Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42E10C359
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 06:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfK1FGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 00:06:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:20146 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfK1FGQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 00:06:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 21:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="292269571"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2019 21:06:15 -0800
Received: from [10.226.39.9] (unknown [10.226.39.9])
        by linux.intel.com (Postfix) with ESMTP id E11385802E4;
        Wed, 27 Nov 2019 21:06:12 -0800 (PST)
Subject: Re: linux-next: Tree for Nov 27
 (drivers/pci/controller/dwc/pcie-designware-host.c)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>, bhelgaas@google.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20191127155717.400a60de@canb.auug.org.au>
 <fc3586ef-a0a1-84b3-2e0e-b8ba5c41f229@infradead.org>
 <20191127162614.GA6423@e121166-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <5cebfc73-b753-0a75-922b-335bd829950b@linux.intel.com>
Date:   Thu, 28 Nov 2019 13:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127162614.GA6423@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/28/2019 12:26 AM, Lorenzo Pieralisi wrote:
> On Wed, Nov 27, 2019 at 07:55:57AM -0800, Randy Dunlap wrote:
>> On 11/26/19 8:57 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do not add any material for v5.6 to your linux-next included
>>> trees until after v5.5-rc1 has been released.
>>>
>>> Changes since 20191126:
>>>
>> on i386:
>> # CONFIG_PCI_MSI is not set
>>
>>
>> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>>    Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>>    Selected by [y]:
>>    - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
>>
>> and related build errors:
> Dilip,
>
> I will have to drop your series which unfortunately forces Bjorn to pull
> my pci/dwc branch again, I don't think there is time for fixing it,
> given release timing and Stephen's request above.
My bad. I should have taken care of this.
Sorry for breaking it. I will submit a patch by marking PCI_INTEL_GW 
'depends on PCI_MSI_IRQ_DOMAIN'

Regards,
Dilip
>
> Lorenzo
>
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:72:15: error: variable ‘dw_pcie_msi_domain_info’ has initializer but incomplete type
>>   static struct msi_domain_info dw_pcie_msi_domain_info = {
>>                 ^~~~~~~~~~~~~~~
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:3: error: ‘struct msi_domain_info’ has no member named ‘flags’
>>    .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>     ^~~~~
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:12: error: ‘MSI_FLAG_USE_DEF_DOM_OPS’ undeclared here (not in a function); did you mean ‘SIMPLE_DEV_PM_OPS’?
>>    .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>              ^~~~~~~~~~~~~~~~~~~~~~~~
>>              SIMPLE_DEV_PM_OPS
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:39: error: ‘MSI_FLAG_USE_DEF_CHIP_OPS’ undeclared here (not in a function); did you mean ‘MSI_FLAG_USE_DEF_DOM_OPS’?
>>    .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>                                         MSI_FLAG_USE_DEF_DOM_OPS
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:74:6: error: ‘MSI_FLAG_PCI_MSIX’ undeclared here (not in a function); did you mean ‘SS_FLAG_BITS’?
>>        MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>>        ^~~~~~~~~~~~~~~~~
>>        SS_FLAG_BITS
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:74:26: error: ‘MSI_FLAG_MULTI_PCI_MSI’ undeclared here (not in a function); did you mean ‘MSI_FLAG_PCI_MSIX’?
>>        MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>>                            ^~~~~~~~~~~~~~~~~~~~~~
>>                            MSI_FLAG_PCI_MSIX
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: warning: excess elements in struct initializer
>>    .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>             ^
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: note: (near initialization for ‘dw_pcie_msi_domain_info’)
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:3: error: ‘struct msi_domain_info’ has no member named ‘chip’
>>    .chip = &dw_pcie_msi_irq_chip,
>>     ^~~~
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: warning: excess elements in struct initializer
>>    .chip = &dw_pcie_msi_irq_chip,
>>            ^
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: note: (near initialization for ‘dw_pcie_msi_domain_info’)
>> ../drivers/pci/controller/dwc/pcie-designware-host.c: In function ‘dw_pcie_allocate_domains’:
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:267:19: error: implicit declaration of function ‘pci_msi_create_irq_domain’; did you mean ‘pci_msi_get_device_domain’? [-Werror=implicit-function-declaration]
>>    pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>>                     pci_msi_get_device_domain
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:267:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>>    pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>>                   ^
>> ../drivers/pci/controller/dwc/pcie-designware-host.c: At top level:
>> ../drivers/pci/controller/dwc/pcie-designware-host.c:72:31: error: storage size of ‘dw_pcie_msi_domain_info’ isn’t known
>>   static struct msi_domain_info dw_pcie_msi_domain_info = {
>>                                 ^~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>> -- 
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
