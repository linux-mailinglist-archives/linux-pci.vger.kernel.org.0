Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBD1888D4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgCQPPf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 11:15:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQPPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6Ine+oxODCtUbbLGDC7KuyhjrafGxZgBxDpnNryKXdM=; b=Cd6zB2rertxgUVBlgWIzX7rUmR
        wRFeBAcnGec5STrdxeu0KiY3qs3Qxek0Yk0VwQI5GxfLIO6AhnHzmbiD45EUmzDmsvOnM5MK4KKCo
        Xs2axkQL4IjPjYAC9dYlwUhBkYQUP+nKrQ0jxftgGDY1OoJwsFTQwn7fsOlYfY3lkwkIxYyEEg5Fn
        nowUsrLw7QdBXAvTg8493O3IYsfrooLIhAfiD1uW40xYZzrfpFPR8oSG9mhDfr+vV/HXYCSGkSa5U
        YCDTJLbRbTCETEmB4ZwWbhty2gIRa2xTzrf4P5V1DEEEv6hldanyJ0XszMcwnMo55e3jL9flE7tmm
        itOYZ3CQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDwL-0003Ob-JG; Tue, 17 Mar 2020 15:15:33 +0000
Subject: Re: linux-next: Tree for Mar 12 (pci/controller/mobiveil/)
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
References: <4c0db5d0-1a61-cb80-2bcb-034f5bcd1597@infradead.org>
 <20200312193917.GA160316@google.com>
 <DB8PR04MB6747C1032BF126CFFB5720E084F60@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <e53be1bc-e84d-433a-e9a7-ea442c93f2cf@infradead.org>
 <DB8PR04MB6747E855D3349173CE2AE9F684F60@DB8PR04MB6747.eurprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <23a2a891-4d69-34a3-4cf6-525e54738b77@infradead.org>
Date:   Tue, 17 Mar 2020 08:15:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6747E855D3349173CE2AE9F684F60@DB8PR04MB6747.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/20 3:05 AM, Z.q. Hou wrote:
> Hi Randy,
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: 2020年3月17日 12:59
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>; Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>; Linux Next Mailing List
>> <linux-next@vger.kernel.org>; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>; linux-pci <linux-pci@vger.kernel.org>;
>> Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
>> Subject: Re: linux-next: Tree for Mar 12 (pci/controller/mobiveil/)
>>
>> On 3/16/20 9:31 PM, Z.q. Hou wrote:
>>> Hi Randy and Bjorn,
>>>
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>> Sent: 2020年3月13日 3:39
>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>; Stephen Rothwell
>>>> <sfr@canb.auug.org.au>; Linux Next Mailing List
>>>> <linux-next@vger.kernel.org>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>; linux-pci
>>>> <linux-pci@vger.kernel.org>; Karthikeyan Mitran
>>>> <m.karthikeyan@mobiveil.co.in>
>>>> Subject: Re: linux-next: Tree for Mar 12 (pci/controller/mobiveil/)
>>>>
>>>> On Thu, Mar 12, 2020 at 08:13:50AM -0700, Randy Dunlap wrote:
>>>>> On 3/12/20 3:04 AM, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20200311:
>>>>>>
>>>>>
>>>>> on i386:
>>>>> # CONFIG_PCI_MSI is not set
>>>>>
>>>>> WARNING: unmet direct dependencies detected for
>> PCIE_MOBIVEIL_HOST
>>>>>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>>>>>   Selected by [y]:
>>>>>   - PCIE_MOBIVEIL_PLAT [=y] && PCI [=y] && (ARCH_ZYNQMP ||
>>>> COMPILE_TEST [=y]) && OF [=y]
>>>>
>>>> Thanks, Randy.
>>>>
>>>> I'm not sure if this is a new problem introduced by something in my
>>>> "next" branch, or if this is an existing problem we just happened to
>>>> hit with randconfig.
>>>>
>>>> Here are the commits on remotes/lorenzo/pci/mobiveil branch:
>>>>
>>>>   d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC driver for
>>>> Layerscape
>>>> SoCs")
>>>>   3edeb49525bb ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
>>>> controller")
>>>>   11d22cc395ca ("PCI: mobiveil: Add Header Type field check")
>>>>   029dea3cdc67 ("PCI: mobiveil: Add 8-bit and 16-bit CSR register
>>>> accessors")
>>>>   52cae4c7082f ("PCI: mobiveil: Allow mobiveil_host_init() to be used
>>>> to re-init host")
>>>>   fc99b3311af7 ("PCI: mobiveil: Add callback function for link up check")
>>>>   ed620e96541f ("PCI: mobiveil: Add callback function for interrupt
>>>> initialization")
>>>>   03bdc3884019 ("PCI: mobiveil: Modularize the Mobiveil PCIe Host
>>>> Bridge IP
>>>> driver")
>>>>   39e3a03eea5b ("PCI: mobiveil: Collect the interrupt related
>>>> operations into a function")
>>>>   2ba24842d6b4 ("PCI: mobiveil: Move the host initialization into a
>> function")
>>>>   1f442218d657 ("PCI: mobiveil: Introduce a new structure
>>>> mobiveil_root_port")
>>>>
>>>> I dropped that mobiveil branch for now, so Hou, can you please check
>>>> this out and resolve it one way or the other?
>>>
>>> I don't reproduce this issue with i386_defconfig, can you help me to
>> reproduce it?
>>
>> Sure, see below.
>>
>>
>>> Thanks,
>>> Zhiqiang
>>>
>>>>
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:375:15: error:
>>>> variable ‘mobiveil_msi_domain_info’ has initializer but incomplete
>>>> type
>>>>>  static struct msi_domain_info mobiveil_msi_domain_info = {
>>>>>                ^~~~~~~~~~~~~~~
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:376:3:
>>>>> error: ‘struct
>>>> msi_domain_info’ has no member named ‘flags’
>>>>>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>>>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>>>>    ^~~~~
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:376:12: error:
>>>> ‘MSI_FLAG_USE_DEF_DOM_OPS’ undeclared here (not in a function);
>> did
>>>> you mean ‘SIMPLE_DEV_PM_OPS’?
>>>>>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>>>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>>>>             ^~~~~~~~~~~~~~~~~~~~~~~~
>>>>>             SIMPLE_DEV_PM_OPS
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:376:39: error:
>>>> ‘MSI_FLAG_USE_DEF_CHIP_OPS’ undeclared here (not in a function); did
>>>> you mean ‘MSI_FLAG_USE_DEF_DOM_OPS’?
>>>>>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>>>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>>>>
>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>> MSI_FLAG_USE_DEF_DOM_OPS
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:377:6: error:
>>>> ‘MSI_FLAG_PCI_MSIX’ undeclared here (not in a function); did you mean
>>>> ‘SS_FLAG_BITS’?
>>>>>       MSI_FLAG_PCI_MSIX),
>>>>>       ^~~~~~~~~~~~~~~~~
>>>>>       SS_FLAG_BITS
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:376:11: warning:
>>>> excess elements in struct initializer
>>>>>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>>>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>>>>            ^
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:376:11:
>>>>> note: (near
>>>> initialization for ‘mobiveil_msi_domain_info’)
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:378:3:
>>>>> error: ‘struct
>>>> msi_domain_info’ has no member named ‘chip’
>>>>>   .chip = &mobiveil_msi_irq_chip,
>>>>>    ^~~~
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:378:10: warning:
>>>> excess elements in struct initializer
>>>>>   .chip = &mobiveil_msi_irq_chip,
>>>>>           ^
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:378:10:
>>>>> note: (near
>>>> initialization for ‘mobiveil_msi_domain_info’)
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c: In function
>>>> ‘mobiveil_allocate_msi_domains’:
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:469:20: error:
>>>> implicit declaration of function ‘pci_msi_create_irq_domain’; did you
>>>> mean ‘pci_msi_get_device_domain’?
>>>> [-Werror=implicit-function-declaration]
>>>>>   msi->msi_domain = pci_msi_create_irq_domain(fwnode,
>>>>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>                     pci_msi_get_device_domain
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:469:18: warning:
>>>> assignment makes pointer from integer without a cast
>>>> [-Wint-conversion]
>>>>>   msi->msi_domain = pci_msi_create_irq_domain(fwnode,
>>>>>                   ^
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c: At top level:
>>>>> ../drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:375:31: error:
>>>> storage size of ‘mobiveil_msi_domain_info’ isn’t known
>>>>>  static struct msi_domain_info mobiveil_msi_domain_info = {
>>>>>                                ^~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>>
>>>>>
>>>>> Full randconfig file is attached.
>>
>> Use the .config file that was attached in the report.
> 
> One query, which default config you used to generate this .config? I cannot select
> the PCIE_MOBIVEIL_PLAT in 'menuconfig' when use the i386_defconfig.

Hi,

I did not use any defconfig.
Just cp that config file into your build directory (as .config)

and do something like:
$ make ARCH=i386 oldconfig


-- 
~Randy

