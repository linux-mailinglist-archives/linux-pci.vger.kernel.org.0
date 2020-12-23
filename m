Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BA2E1B66
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 12:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgLWLHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 06:07:16 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2921 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgLWLHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2020 06:07:13 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D19Np5Fdnz57Zh;
        Wed, 23 Dec 2020 19:05:46 +0800 (CST)
Received: from [10.174.60.228] (10.174.60.228) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 23 Dec 2020 19:06:29 +0800
Subject: Re: [v2] PCI: Add pci reset quirk for Huawei Intelligent NIC virtual
 function
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yinshi (Stone)" <yin.yinshi@huawei.com>,
        "Wangxiaoyun (Cloud)" <cloud.wangxiaoyun@huawei.com>,
        zengweiliang zengweiliang <zengweiliang.zengweiliang@huawei.com>,
        "Chenlizhong (IT Chip)" <chenlizhong@huawei.com>
References: <20201202113450.2283-1-chiqijun@huawei.com>
 <20201210143130.6c62df86@omen.home>
From:   Chiqijun <chiqijun@huawei.com>
Message-ID: <dd9af6b6-6242-df9e-958a-7b6139d3087d@huawei.com>
Date:   Wed, 23 Dec 2020 19:06:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201210143130.6c62df86@omen.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.60.228]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/12/11 5:31, Alex Williamson wrote:
> On Wed, 2 Dec 2020 19:34:50 +0800
> Chiqijun <chiqijun@huawei.com> wrote:
> 
>> When multiple VFs do FLR at the same time, the firmware is
>> processed serially, resulting in some VF FLRs being delayed more
>> than 100ms, when the virtual machine restarts and the device
>> driver is loaded, the firmware is doing the corresponding VF
>> FLR, causing the driver to fail to load.
>>
>> To solve this problem, add host and firmware status synchronization
>> during FLR.
>>
>> Signed-off-by: Chiqijun <chiqijun@huawei.com>
>> ---
>> v2:
>>   - Update comments
>>   - Use the HINIC_VF_FLR_CAP_BIT_SHIFT and HINIC_VF_FLR_PROC_BIT_SHIFT
>>     macro instead of the magic number
>> ---
>>   drivers/pci/quirks.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index f70692ac79c5..c9ad55709d03 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3912,6 +3912,79 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>>   	return 0;
>>   }
>>   
>> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
>> +#define HINIC_VF_FLR_TYPE           0x1000
>> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  6
>> +#define HINIC_VF_OP                 0xE80
>> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 10
>> +#define HINIC_OPERATION_TIMEOUT     15000
>> +
>> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
>> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
>> +{
>> +	unsigned long timeout;
>> +	void __iomem *bar;
>> +	u16 old_command;
>> +	u32 val;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	bar = pci_iomap(pdev, 0, 0);
>> +	if (!bar)
>> +		return -ENOTTY;
>> +
>> +	pci_read_config_word(pdev, PCI_COMMAND, &old_command);
>> +
>> +	/*
>> +	 * FLR cap bit bit30, FLR processing bit: bit18, to avoid big-endian
>> +	 * conversion the big-endian bit6, bit10 is directly operated here.
>> +	 *
>> +	 * Get and check firmware capabilities.
>> +	 */
>> +	val = readl(bar + HINIC_VF_FLR_TYPE);
>> +	if (!(val & (1UL << HINIC_VF_FLR_CAP_BIT_SHIFT))) {
>> +		pci_iounmap(pdev, bar);
>> +		return -ENOTTY;
>> +	}
>> +
>> +	/*
>> +	 * Set the processing bit for the start of FLR, which will be cleared
>> +	 * by the firmware after FLR is completed.
>> +	 */
>> +	val = readl(bar + HINIC_VF_OP);
>> +	val = val | (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT);
>> +	writel(val, bar + HINIC_VF_OP);
>> +
>> +	/* Perform the actual device function reset */
>> +	pcie_flr(pdev);
>> +
>> +	pci_write_config_word(pdev, PCI_COMMAND,
>> +			      old_command | PCI_COMMAND_MEMORY);
> 
> 
> This quirk is specific to VFs, so isn't this command register handling
> here, further above, and restore below unnecessary?  VF memory space is
> controlled by the VF MSE bit on the PF.  On the VF this bit is
> hardwired to zero.  If that weren't the case then both the above
> read/write to the BAR without testing the memory bit, and the below
> polling of the BAR to watch for the reset to complete would be pretty
> troubling.  Thanks,
> 
> Alex
> 

Apologies for the delayed response.
You are right, the MSE bit in the VF configuration space is hardwired to 
zero, the MSE bit set here is useless.
But Huawei Intelligent NIC device must capture BDF after FLR to respond 
to BAR read requests, we still need to issue a configure write request 
here to let the device capture BDF.
I will add a comment in the next patch and remove the setthing of 
PCI_COMMAND_MEMORY bit to avoid misunderstanding, and just read the 
PCI_COMMAND and write it back.

Thanks.

> 
>> +
>> +	/* Waiting for device reset complete */
>> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
>> +	do {
>> +		val = readl(bar + HINIC_VF_OP);
>> +		if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
>> +			goto reset_complete;
>> +		msleep(20);
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	val = readl(bar + HINIC_VF_OP);
>> +	if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
>> +		goto reset_complete;
>> +
>> +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %x\n",
>> +		 be32_to_cpu(val));
>> +
>> +reset_complete:
>> +	pci_write_config_word(pdev, PCI_COMMAND, old_command);
>> +	pci_iounmap(pdev, bar);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>   		 reset_intel_82599_sfp_virtfn },
>> @@ -3923,6 +3996,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>>   	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>>   		reset_chelsio_generic_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>> +		reset_hinic_vf_dev },
>>   	{ 0 }
>>   };
>>   
> 
> .
> 
