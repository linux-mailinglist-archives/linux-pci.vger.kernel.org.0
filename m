Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB572101A8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 03:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgGABxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 21:53:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgGABxg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 21:53:36 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09CE3BAF1119D29E0A4F;
        Wed,  1 Jul 2020 09:53:34 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Jul 2020
 09:53:32 +0800
Subject: Re: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports
 as well
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200630220107.GA3489322@bjorn-Precision-5520>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>, <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <c4282c55-8312-53a0-d9e6-4818b9206c1f@hisilicon.com>
Date:   Wed, 1 Jul 2020 09:53:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200630220107.GA3489322@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,


On 2020/7/1 6:01, Bjorn Helgaas wrote:
> On Mon, Jun 22, 2020 at 07:12:48PM +0300, Mika Westerberg wrote:
>> Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
>> pci_find_pcie_root_port()") unified the root port finding functionality
>> into a single function but missed the fact that the passed in device may
>> already be a root port. This causes the kernel to block power management
>> of PCIe hierarchies in recent systems because ->bridge_d3 started to
>> return false for such ports after the commit in question.
>>
>> Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  include/linux/pci.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index c79d83304e52..c17c24f5eeed 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2169,8 +2169,13 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
>>   */
>>  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>>  {
>> -	struct pci_dev *bridge = pci_upstream_bridge(dev);
>> +	struct pci_dev *bridge;
>>  
>> +	/* If dev is already root port */
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		return dev;
>> +
>> +	bridge = pci_upstream_bridge(dev);
>>  	while (bridge) {
>>  		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
>>  			return bridge;
> I applied the patch below, which is slightly simplified but I think
> still equivalent, to for-linus for v5.8.  Let me know if it's not.
>
> I dropped the stable tag because 6ae72bfa656e was merged for v5.8-rc1,
> and I assume v5.7 works correctly so it doesn't need any change.
>
>
> commit 5396956cc7c6 ("PCI: Make pcie_find_root_port() work for Root Ports")
> Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> Date:   Mon Jun 22 19:12:48 2020 +0300
>
>     PCI: Make pcie_find_root_port() work for Root Ports
>     
>     Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
>     pci_find_pcie_root_port()") broke acpi_pci_bridge_d3() because calling
>     pcie_find_root_port() on a Root Port returned NULL when it should return
>     the Root Port, which in turn broke power management of PCIe hierarchies.
>     
>     Rework pcie_find_root_port() so it returns its argument when it is already
>     a Root Port.
>     
>     [bhelgaas: test device only once, test for PCIe]
>     Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
>     Link: https://lore.kernel.org/r/20200622161248.51099-1-mika.westerberg@linux.intel.com
>     Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c79d83304e52..34c1c4f45288 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2169,12 +2169,11 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
>   */
>  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  {
> -	struct pci_dev *bridge = pci_upstream_bridge(dev);
> -
> -	while (bridge) {
> -		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
> -			return bridge;
> -		bridge = pci_upstream_bridge(bridge);
> +	while (dev) {
> +		if (pci_is_pcie(dev) &&
> +		    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +			return dev;
> +		dev = pci_upstream_bridge(dev);
>  	}
>  

We may have some problems here, as after pcie_find_root_port() called, *dev will
be either root port or NULL but users may want it unchanged. One such usage is
in acpi_pci_bridge_d3(), drivers/pci/pci-acpi.c, *dev is used as origin
after called this.

So we should use a temporary point to *dev rather than directly modify it.

Thanks,
Yicong


>  	return NULL;
> .
>

