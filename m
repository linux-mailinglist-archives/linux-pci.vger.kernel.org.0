Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E517E153CC8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 02:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgBFBwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 20:52:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgBFBwj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 20:52:39 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DDD6BFAD601912C1D7BC;
        Thu,  6 Feb 2020 09:52:36 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 09:52:26 +0800
Subject: Re: [PATCH 5/6] PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200205185446.GA231340@google.com>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <920ab810-51b5-8f69-a27b-5263caf7c4fa@hisilicon.com>
Date:   Thu, 6 Feb 2020 09:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200205185446.GA231340@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/2/6 2:54, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2020 at 05:04:22PM +0800, Yicong Yang wrote:
>> Add PCIE_LNKCAP2_SLS2SPEED macro for transforming raw link cap 2
>> value to link speed. Use it in pcie_get_speed_cap() to reduce
>> redundancy. We'll not touch the functions when new link
>> speed comes.
> The patch seems OK to me, but I don't see where it reduces redundancy.
> There was one copy of "lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB" before,
> and there's one copy after.  It's just moved from pci.c to pci.h.
> Or am I missing something?

Seems I used improper description here. I'll correct it in next version.

Thanks,
Yang


>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/pci/pci.c | 17 ++++-------------
>>  drivers/pci/pci.h |  9 +++++++++
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index dce32ce..2ef4030 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5780,19 +5780,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>>  	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
>>  	 */
>>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>> -	if (lnkcap2) { /* PCIe r3.0-compliant */
>> -		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
>> -			return PCIE_SPEED_32_0GT;
>> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
>> -			return PCIE_SPEED_16_0GT;
>> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
>> -			return PCIE_SPEED_8_0GT;
>> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
>> -			return PCIE_SPEED_5_0GT;
>> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
>> -			return PCIE_SPEED_2_5GT;
>> -		return PCI_SPEED_UNKNOWN;
>> -	}
>> +
>> +	/* PCIe r3.0-compliant */
>> +	if (lnkcap2)
>> +		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
>>  
>>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5e1f810..3d988e9 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -290,6 +290,15 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>>  void pci_bus_put(struct pci_bus *bus);
>>  
>> +/* PCIe link information from Link Capabilities 2 */
>> +#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
>> +	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
>> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
>> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
>> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
>> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
>> +	 PCI_SPEED_UNKNOWN)
>> +
>>  /* PCIe link information */
>>  #define PCI_SPEED2STR(speed) \
>>  	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
>> -- 
>> 2.8.1
>>
> .
>


