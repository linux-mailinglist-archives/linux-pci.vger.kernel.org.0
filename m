Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0972FEABC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbhAUMyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 07:54:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2956 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbhAUMyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 07:54:07 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DM2N55qzxz5KYw;
        Thu, 21 Jan 2021 20:52:05 +0800 (CST)
Received: from [10.174.60.228] (10.174.60.228) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 21 Jan 2021 20:53:13 +0800
Subject: Re: [v3] PCI: Add pci reset quirk for Huawei Intelligent NIC virtual
 function
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Yinshi (Stone)" <yin.yinshi@huawei.com>,
        "Wangxiaoyun (Cloud)" <cloud.wangxiaoyun@huawei.com>,
        zengweiliang zengweiliang <zengweiliang.zengweiliang@huawei.com>,
        "Chenlizhong (IT Chip)" <chenlizhong@huawei.com>
References: <20210108222519.GA1473637@bjorn-Precision-5520>
From:   Chiqijun <chiqijun@huawei.com>
Message-ID: <7e0a6c6c-a12c-ee54-0468-69079b8edde4@huawei.com>
Date:   Thu, 21 Jan 2021 20:53:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210108222519.GA1473637@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.60.228]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/1/9 6:25, Bjorn Helgaas wrote:
> s/pci reset/reset/ in subject (it's obvious this is for PCI).

Will fix.

> 
> On Fri, Dec 25, 2020 at 05:25:30PM +0800, Chiqijun wrote:
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
>> v3:
>>   - The MSE bit in the VF configuration space is hardwired to zero,
>>     remove the setting of PCI_COMMAND_MEMORY bit. Add comment for
>>     set PCI_COMMAND register.
>>
>> v2:
>>   - Update comments
>>   - Use the HINIC_VF_FLR_CAP_BIT_SHIFT and HINIC_VF_FLR_PROC_BIT_SHIFT
>>     macro instead of the magic number
>> ---
>>   drivers/pci/quirks.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index f70692ac79c5..9c310012ef19 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3912,6 +3912,81 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>>   	return 0;
>>   }
>>   
>> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
>> +#define HINIC_VF_FLR_TYPE           0x1000
>> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  6
>> +#define HINIC_VF_OP                 0xE80
>> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 10
>> +#define HINIC_OPERATION_TIMEOUT     15000
> 
> Add a comment so we know the scale here.  "15 sec" or "15000 msec"
> or similar.

Will fix.

> 
>> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
>> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
>> +{
>> +	unsigned long timeout;
>> +	void __iomem *bar;
>> +	u16 command;
>> +	u32 val;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	bar = pci_iomap(pdev, 0, 0);
>> +	if (!bar)
>> +		return -ENOTTY;
>> +
>> +	/*
>> +	 * FLR cap bit bit30, FLR processing bit: bit18, to avoid big-endian
>> +	 * conversion the big-endian bit6, bit10 is directly operated here.
> 
> I don't understand the big-endian comments here.  Unless the above
> adds useful information, I'd say just remove it.
> 
> Obviously, the code here has to work correctly on both big- and
> little-endian systems.
> 
> Below you use be32_to_cpu() before printing HINIC_VF_OP.  Why aren't
> you using it here for HINIC_VF_FLR_TYPE?  be32_to_cpu() is common in
> drivers/net/ethernet/huawei/hinic/, which I assume is for the same
> device.
I only considered using the device on the little endian system before, 
but we should also consider using it on the big endian system, Will fix 
it in the next patch. Thanks.

> 
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
>> +	/*
>> +	 * The device must learn BDF after FLR in order to respond to BAR's
>> +	 * read request, therefore, we issue a configure write request to let
>> +	 * the device capture BDF.
>> +	 */
>> +	pci_read_config_word(pdev, PCI_COMMAND, &command);
>> +	pci_write_config_word(pdev, PCI_COMMAND, command);
> 
> I assume this is because of this requirement from PCIe r5.0, sec
> 2.2.9:
> 
>    Functions must capture the Bus and Device Numbers supplied with all
>    Type 0 Configuration Write Requests completed by the Function, and
>    supply these numbers in the Bus and Device Number fields of the
>    Completer ID for all Completions generated by the Device/Function.
> 
> I'm a little concerned because it seems like this requirement should
> apply to *all* resets, and I don't see where we do a similar write
> following other resets.  Can you help me out?  Do we need this in
> other cases?  Do we do it?
> 

This depends on the hardware device. The HINIC device clears the BDF 
information of the VF during FLR, so it relies on Configuration Write 
Requests to capture BDF. If other devices do not clear the DBF 
information during FLR, this operation is not required.
In addition, I did not find other devices directly access the BAR 
register after FLR in resets.

> I'm also slightly nervous about writing the Command register, even
> though we just reset the device (so the register should be all zeroes)
> and we're writing the same value we just read from it.  Wouldn't
> writing 0 to the Vendor ID register, which is guaranteed to be HwInit,
> accomplish the same?
> 

OK, writing 0 to the Vendor ID register can also achieve the same 
effect. Will fix it in the next patch.

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
> 
> "%#010x" so it's obvious that this is hex, no matter what the value.
> 

Will fix.
Thanks.

>> +		 be32_to_cpu(val));
>> +
>> +reset_complete:
>> +	pci_iounmap(pdev, bar);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>   		 reset_intel_82599_sfp_virtfn },
>> @@ -3923,6 +3998,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>>   	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>>   		reset_chelsio_generic_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>> +		reset_hinic_vf_dev },
>>   	{ 0 }
>>   };
>>   
>> -- 
>> 2.17.1
>>
> .
> 
