Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3ED51BF8A
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiEEMkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244338AbiEEMkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:40:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE0154FA0;
        Thu,  5 May 2022 05:36:44 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvCqJ4wbJzQj6q;
        Thu,  5 May 2022 20:36:12 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 20:36:42 +0800
CC:     <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <lenb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI/ACPI: Always advertise ASPM support if
 CONFIG_PCIEASPM=y
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220503223857.GA414278@bhelgaas>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <38e81af3-e7fa-df0c-c3f7-14244dde5a21@huawei.com>
Date:   Thu, 5 May 2022 20:36:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220503223857.GA414278@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/5/4 6:38, Bjorn Helgaas wrote:
> On Mon, Apr 25, 2022 at 03:06:34PM +0800, Yicong Yang wrote:
>> When we have CONFIG_PCIEASPM enabled it means OS can always support ASPM no
>> matter user have disabled it through pcie_aspm=off or not. But currently we
>> won't advertise ASPM support in _OSC negotiation if user disables it, which
>> doesn't match the fact. This will also have side effects that other PCIe
>> services like AER and hotplug will be disabled as ASPM support is required
>> and we won't negotiate other services if ASPM support is absent.
>>
>> So this patch makes OS always advertising ASPM support if CONFIG_PCIEASPM=y.
>> It intends no functional change to pcie_aspm=off as it will still mark
>> aspm_disabled=1 and aspm_support_enabled=false, driver will check these
>> status before configuring ASPM.
>>
>> Tested this patch with pcie_aspm=off:
>> estuary:/$ dmesg | egrep -i "aspm|osc"
>> [    0.000000] PCIe ASPM is disabled
>> [    8.706961] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
>> ClockPM Segments MSI EDR HPX-Type3]
>> [    8.726032] acpi PNP0A08:00: _OSC: platform does not support [LTR]
>> [    8.742818] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
>> AER PCIeCapability DPC]
>> estuary:/sys/module/pcie_aspm/parameters$ cat policy
>> [default] performance powersave powersupersave
>> estuary:/sys/module/pcie_aspm/parameters$ echo powersave > policy
>> bash: echo: write error: Operation not permitted
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> [https://lore.kernel.org/linux-pci/20220407154257.GA235990@bhelgaas/]
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/acpi/pci_root.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 6f9e75d14808..17e78582e633 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -393,7 +393,7 @@ static u32 calculate_support(void)
>>  	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
>>  	if (pci_ext_cfg_avail())
>>  		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
>> -	if (pcie_aspm_support_enabled())
>> +	if (IS_ENABLED(CONFIG_PCIEASPM))
> 
> Is there any way firmware could tell the difference between
> "CONFIG_PCIEASPM not set" and "CONFIG_PCIEASPM=y and booted with
> 'pcie_aspm=off'"?
> 
> If not, why would we even check whether CONFIG_PCIEASPM is set?
> 

If we announce ASPM support when CONFIG_PCIEASPM=n it'll work as well
but negotiation and the log don't match the fact. We'll get misleading
messages that ASPM is supported by OS by it cannot be enable as there's
no driver.

As mentioned by the PCIe Firmware Spec r3.3,
"ASPM Optionality supported
 The operating system sets this bit to 1 if it properly recognizes
 and manages ASPM support on PCI Express components which report
 support for ASPM L1 only in the ASPM Support field within the Link
 Capabilities Register. Otherwise, the operating system sets this
 bit to 0"

When CONFIG_PCIEASPM=n we have no aspm driver and apparently cannot
support any ASPM features so we should set the bit to 0 to match the spec.

>>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>>  	if (pci_msi_enabled())
>>  		support |= OSC_PCI_MSI_SUPPORT;
>> -- 
>> 2.24.0
>>
> .
> 
