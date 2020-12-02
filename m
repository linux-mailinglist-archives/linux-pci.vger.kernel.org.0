Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E532CB883
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 10:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgLBJS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 04:18:57 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2326 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgLBJS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2020 04:18:57 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CmCzX0D7fz13KpP;
        Wed,  2 Dec 2020 17:17:28 +0800 (CST)
Received: from [10.174.60.228] (10.174.60.228) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 17:18:12 +0800
Subject: Re: [PATCH] PCI: Add pci reset quirk for Huawei Intelligent NIC
 virtual function
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yinshi (Stone)" <yin.yinshi@huawei.com>,
        "Wangxiaoyun (Cloud)" <cloud.wangxiaoyun@huawei.com>,
        zengweiliang zengweiliang <zengweiliang.zengweiliang@huawei.com>,
        "Chenlizhong (IT Chip)" <chenlizhong@huawei.com>
References: <20201128061825.2629-1-chiqijun@huawei.com>
 <20201128232919.GA929748@bjorn-Precision-5520>
 <20201130084622.0b71d526@w520.home>
From:   Chiqijun <chiqijun@huawei.com>
Message-ID: <9232bf61-8906-0848-8078-a2c6b6a78864@huawei.com>
Date:   Wed, 2 Dec 2020 17:18:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201130084622.0b71d526@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.60.228]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/11/30 23:46, Alex Williamson wrote:
> On Sat, 28 Nov 2020 17:29:19 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> [+cc Alex]
>>
>> On Sat, Nov 28, 2020 at 02:18:25PM +0800, Chiqijun wrote:
>>> When multiple VFs do FLR at the same time, the firmware is
>>> processed serially, resulting in some VF FLRs being delayed more
>>> than 100ms, when the virtual machine restarts and the device
>>> driver is loaded, the firmware is doing the corresponding VF
>>> FLR, causing the driver to fail to load.
>>>
>>> To solve this problem, add host and firmware status synchronization
>>> during FLR.
>>
>> Is this because the Huawei Intelligent NIC isn't following the spec,
>> or is it because Linux isn't correctly waiting for the FLR to
>> complete?
> 
> Seems like a spec compliance issue, I don't recall anything in the spec
> about coordinating FLR between VFs.

The spec stipulates that the FLR time of a single VF does not exceed 
100ms, but when multiple VMs are reset concurrently in Linux, there will 
be multiple VF parallel FLRs, VF of Huawei Intelligent NIC
  FLR will exceed 100ms in this case.

>   
>> If this is a Huawei Intelligent NIC defect, is there documentation
>> somewhere (errata) that you can reference?  Will it be fixed in future
>> designs, so we don't have to add future Device IDs to the quirk?
>>
>>> Signed-off-by: Chiqijun <chiqijun@huawei.com>
>>> ---
>>>   drivers/pci/quirks.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index f70692ac79c5..bd6236ea9064 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -3912,6 +3912,71 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>>>   	return 0;
>>>   }
>>>   
>>> +#define PCI_DEVICE_ID_HINIC_VF  0x375E
>>> +#define HINIC_VF_FLR_TYPE       0x1000
>>> +#define HINIC_VF_OP             0xE80
>>> +#define HINIC_OPERATION_TIMEOUT 15000
>>> +
>>> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
>>> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
>>> +{
>>> +	unsigned long timeout;
>>> +	void __iomem *bar;
>>> +	u16 old_command;
>>> +	u32 val;
>>> +
>>> +	if (probe)
>>> +		return 0;
>>> +
>>> +	bar = pci_iomap(pdev, 0, 0);
>>> +	if (!bar)
>>> +		return -ENOTTY;
>>> +
>>> +	pci_read_config_word(pdev, PCI_COMMAND, &old_command);
>>> +
>>> +	/*
>>> +	 * FLR cap bit bit30, FLR ACK bit: bit18, to avoid big-endian conversion
>>> +	 * the big-endian bit6, bit10 is directly operated here
>>> +	 */
>>> +	val = readl(bar + HINIC_VF_FLR_TYPE);
>>> +	if (!(val & (1UL << 6))) {
>>> +		pci_iounmap(pdev, bar);
>>> +		return -ENOTTY;
>>> +	}
> 
> 
> I don't know exactly what this is testing, but it seems like a
> feature/capability test that can fail, why is it not done as part of
> the probe?  Can we define bit 6 with a macro?  Same for bit 10 in the
> VF op register below.

The firmware of Huawei Intelligent NIC does not support this feature in 
the old version. here is the reading ability to determine whether the 
firmware supports it.
In the next patch, I will add a comment here and replace bit 6 and bit 
10 with macro definitions.

> 
>>> +
>>> +	val = readl(bar + HINIC_VF_OP);
>>> +	val = val | (1UL << 10);
>>> +	writel(val, bar + HINIC_VF_OP);
>>> +
>>> +	/* Perform the actual device function reset */
>>> +	pcie_flr(pdev);
>>> +
>>> +	pci_write_config_word(pdev, PCI_COMMAND,
>>> +			      old_command | PCI_COMMAND_MEMORY);
>>> +
>>> +	/* Waiting for device reset complete */
>>> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
> 
> Yikes, 15s timeout!

Huawei Intelligent NIC supports a maximum of 496 VFs, so the total 
timeout period is set to 15s, which will not reach the timeout time 
under normal circumstances.

> 
>>> +	do {
>>> +		val = readl(bar + HINIC_VF_OP);
>>> +		if (!(val & (1UL << 10)))
>>> +			goto reset_complete;
>>> +		msleep(20);
>>> +	} while (time_before(jiffies, timeout));
>>> +
>>> +	val = readl(bar + HINIC_VF_OP);
>>> +	if (!(val & (1UL << 10)))
>>> +		goto reset_complete;
>>> +
>>> +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %x\n",
>>> +		 be32_to_cpu(val));
>>> +
>>> +reset_complete:
>>> +	pci_write_config_word(pdev, PCI_COMMAND, old_command);
>>> +	pci_iounmap(pdev, bar);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>>   		 reset_intel_82599_sfp_virtfn },
>>> @@ -3923,6 +3988,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>>   	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>>>   	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>>>   		reset_chelsio_generic_dev },
>>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>>> +		reset_hinic_vf_dev },
>>>   	{ 0 }
>>>   };
>>>   
>>> -- 
>>> 2.17.1
>>>    
>>
> 
> .
> 
