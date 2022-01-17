Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602C490697
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 12:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiAQLGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 06:06:54 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47795 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238956AbiAQLGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 06:06:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V249G5w_1642417595;
Received: from 30.225.24.118(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V249G5w_1642417595)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 19:06:36 +0800
Message-ID: <41c0cadc-a623-b013-24f0-410af2a6dc64@linux.alibaba.com>
Date:   Mon, 17 Jan 2022 19:06:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] PCI: Add "pci=reassign_all_bus" boot parameter
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220112154310.GA259954@bhelgaas>
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
In-Reply-To: <20220112154310.GA259954@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/1/12 下午11:43, Bjorn Helgaas 写道:
> On Thu, Dec 30, 2021 at 05:30:13PM +0800, Yao Hongbo wrote:
>> PCI bridges may be misconfigured by te system BIOS, and then the OS
>> scan the bridges that need to be reconfigured.
>> However, the PCI bus topology configured by the bios may be wrong:
>>
>> [   19.376273] pci 0000:40:00.0: bridge configuration invalid ([bus
>> 00-00]), reconfiguring
>> [   19.384443] pci_bus 0000:47: busn_res: can not insert [bus 47-46]
>> under [bus 40-46] (conflicts with (null) [bus 40-46])
>>
>> The primary bus number and subordinate bus number written by the bios
>> were wrong, and the OS continues to add bridges on the wrong bus
>> topology.
>>
>> In order to avoid such problems, a kernel cmdline needs to be
>> added to support the os to fully configure the pci bus.
> 
> Why can't we make Linux smart enough to fix this by itself, without
> forcing the user to boot with "pci=reassign_all_bus"?
> 

   Hi, Bjorn.

   You're right, it's better for us to make pci enumeration more smart.

   But i think it's better to provide an additional option for users on ACPI systems,

which can quickly distingguish the issues between the BIOS and the OS.
>> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>>  drivers/acpi/pci_root.c                         | 3 +++
>>  drivers/pci/pci.c                               | 5 +++++
>>  include/linux/pci.h                             | 2 ++
>>  4 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 2fba824..c83a2e5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4084,6 +4084,7 @@
>>  		nomio		[S390] Do not use MIO instructions.
>>  		norid		[S390] ignore the RID field and force use of
>>  				one PCI domain per PCI function
>> +		reassign_all_bus	The OS fully configure the PCI bus.
>>  
>>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>>  			Management.
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ab2f7df..e21ac25 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -592,6 +592,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
>>  	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
>>  	negotiate_os_control(root, &no_aspm, is_pcie);
>>  
>> +	if (pci_reassign_all_bus)
>> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> +
>>  	/*
>>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
>>  	 */
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 3d2fb39..5746e88 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -142,6 +142,9 @@ bool pci_reset_supported(struct pci_dev *dev)
>>  /* If set, the PCI config space of each device is printed during boot. */
>>  bool pci_early_dump;
>>  
>> +/* If set, the pci will reassign resources*/
>> +bool pci_reassign_all_bus;
>> +
>>  bool pci_ats_disabled(void)
>>  {
>>  	return pcie_ats_disabled;
>> @@ -6846,6 +6849,8 @@ static int __init pci_setup(char *str)
>>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>>  				disable_acs_redir_param = str + 18;
>> +			} else if (!strncmp(str, "reassign_all_bus", 16)) {
>> +				pci_reassign_all_bus = true;
>>  			} else {
>>  				pr_err("PCI: Unknown option `%s'\n", str);
>>  			}
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 18a75c8e..ad0e3e9 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2119,6 +2119,8 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
>>  extern u8 pci_dfl_cache_line_size;
>>  extern u8 pci_cache_line_size;
>>  
>> +extern bool pci_reassign_all_bus;
>> +
>>  /* Architecture-specific versions may override these (weak) */
>>  void pcibios_disable_device(struct pci_dev *dev);
>>  void pcibios_set_master(struct pci_dev *dev);
>> -- 
>> 1.8.3.1
>>
