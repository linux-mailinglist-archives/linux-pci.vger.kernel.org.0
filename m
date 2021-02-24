Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9403B323919
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhBXI5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 03:57:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12994 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhBXI5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 03:57:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DlqVw0yJRzjRb0;
        Wed, 24 Feb 2021 16:55:04 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Feb 2021
 16:56:29 +0800
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <20210218172053.GA986776@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <f00ab835-345d-6700-158e-94121b6f042b@hisilicon.com>
Date:   Wed, 24 Feb 2021 16:56:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210218172053.GA986776@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/19 1:20, Bjorn Helgaas wrote:
> On Wed, Feb 03, 2021 at 08:53:15PM +0800, Yicong Yang wrote:
>> Per Downstream Port Containment Related Enhancements ECN[1],
>> Table 4-6 Interpretation of _OSC Control Field Returned Value,
>> for bit 7 of _OSC control return value:
>>
>>   "If firmware allows the OS control of this feature, then,
>>   in the context of the _OSC method the OS must ensure that
>>   Downstream Port Containment ERR_COR signaling is disabled
>>   as described in the PCI Express Base Specification."
> 
> I think "the OS must ensure" is a typo in the spec.  In the new r3.3
> of the spec, it has been corrected to:
> 
>   If firmware allows the operating system control of this feature,
>   then, in the context of the _OSC method firmware must clear the DPC
>   ERR_COR Enable bit in the DPC Control Register (refer to the PCI
>   Express Base Specification) to 0.
> 

yes, it's probably a typo according to the latest spec.

>> and PCI Express Base Specification Revision 4.0 Version 1.0
>> section 6.2.10.2, Use of DPC ERR_COR Signaling:
>>
>>   "...DPC ERR_COR signaling is primarily intended for use by
>>   platform firmware..."
>>
>> Currently we don't set DPC ERR_COR enable bit, but explicitly
>> clear the bit to ensure it's disabled.
> 
> Does this fix a problem you observed?  If you're seeing a problem, and
> this patch fixes it, we need to do something.  But if it's just to
> line up with the language in the spec, I think we can rely on the
> corrected spec language, which says the *firmware* is responsible for
> doing this, and leave dpc_probe() alone.
> 

this patch comes when i was debugging the EDR and navigating the code and spec
(i cannot get the latest spec at that time). no problem was observed but
i have thought it might be sanity to ensure the ERR_COR was not set.

it's ok leave the code as is, as the latest spec exlicitly requires the
firmware to ensure this.

>> [1] Downstream Port Containment Related Enhancements ECN,
>>     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>>     https://members.pcisig.com/wg/PCI-SIG/document/12888
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/pci/pcie/dpc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index e05aba8..5cc8ef3 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>>  
>> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>> +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> 
> If we need to clear things here, I'd prefer to have names instead of
> the 0xfff4 or 0xffe4 magic numbers.
> 

sure, that will be clearer. i just followed the previous implementation.

Thanks,
Yicong

>>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>>  	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>>  
>> -- 
>> 2.8.1
>>
> 
> .
> 

