Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5853A35C2C3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 12:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhDLJtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 05:49:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17312 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbhDLJqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 05:46:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FJkMd21glz9yhl;
        Mon, 12 Apr 2021 17:43:57 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 17:46:04 +0800
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20210410152103.GA2043340@bjorn-Precision-5520>
 <dcd63859-2c66-2f0b-b6ca-877e50fbcee3@linux.intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <6b75b9e7-0019-7b29-bf87-7c8c63000663@hisilicon.com>
Date:   Mon, 12 Apr 2021 17:46:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <dcd63859-2c66-2f0b-b6ca-877e50fbcee3@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/12 11:32, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 4/10/21 8:21 AM, Bjorn Helgaas wrote:
>> On Wed, Feb 03, 2021 at 08:53:15PM +0800, Yicong Yang wrote:
>>> Per Downstream Port Containment Related Enhancements ECN[1],
>>> Table 4-6 Interpretation of _OSC Control Field Returned Value,
>>> for bit 7 of _OSC control return value:
>>>
>>>    "If firmware allows the OS control of this feature, then,
>>>    in the context of the _OSC method the OS must ensure that
>>>    Downstream Port Containment ERR_COR signaling is disabled
>>>    as described in the PCI Express Base Specification."
>>>
>>> and PCI Express Base Specification Revision 4.0 Version 1.0
>>> section 6.2.10.2, Use of DPC ERR_COR Signaling:
>>>
>>>    "...DPC ERR_COR signaling is primarily intended for use by
>>>    platform firmware..."
>>>
>>> Currently we don't set DPC ERR_COR enable bit, but explicitly
>>> clear the bit to ensure it's disabled.
> Instead of spec reference, can you explain what error you are
> fixing? without this fix what will be the impact and explain
> how you mitigating it with your fix.

I found this when I read the code and spec. No actual problem.
I have thought it might be sanity to ensure the ERR_COR are not set
if the firmware doesn't ensure this.

In the  PCI Firmware Specification, Rev. 3.3, it mentioned that
firmware must ensure this bit to be cleared if DPC goes native,
so not sure this patch is necessary now.

Thanks,
Yicong

>>>
>>> [1] Downstream Port Containment Related Enhancements ECN,
>>>      Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>>>      https://members.pcisig.com/wg/PCI-SIG/document/12888
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Anybody want to chime in and review this?  Sometimes I feel like a
>> one-man band :)
>>
>>> ---
>>>   drivers/pci/pcie/dpc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>> index e05aba8..5cc8ef3 100644
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>>>       pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>>>       pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>>>   -    ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>>> +    ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>>>       pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>>>       pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>>>   -- 
>>> 2.8.1
>>>
> 

