Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D819734E7DE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhC3MtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 08:49:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhC3Msy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 08:48:54 -0400
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F8q2m65f1zRQnW;
        Tue, 30 Mar 2021 20:46:56 +0800 (CST)
Received: from [10.174.61.99] (10.174.61.99) by dggeme706-chm.china.huawei.com
 (10.1.199.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 30
 Mar 2021 20:48:51 +0800
Subject: Re: [v5] PCI: Add reset quirk for Huawei Intelligent NIC virtual
 function
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.williamson@redhat.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <zengweiliang.zengweiliang@huawei.com>, <chenlizhong@huawei.com>
References: <20210318205455.GA160826@bjorn-Precision-5520>
From:   Chiqijun <chiqijun@huawei.com>
Message-ID: <8f77bedb-4905-f1e7-a05a-04bc6ffa60c0@huawei.com>
Date:   Tue, 30 Mar 2021 20:48:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210318205455.GA160826@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.61.99]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/3/19 4:54, Bjorn Helgaas wrote:
> On Tue, Mar 16, 2021 at 10:08:47PM +0800, Chiqijun wrote:
>> When multiple VFs do FLR at the same time, the firmware is
>> processed serially, resulting in some VF FLRs being delayed more
>> than 100ms, when the virtual machine restarts and the device
>> driver is loaded, the firmware is doing the corresponding VF
>> FLR, causing the driver to fail to load.
> 
> Nit: VFs do not do FLR; *software* does FLR on a VF.  And I think this
> is a spec compliance issue specific to the Huawei NIC.  I would say
> something like "When we do an FLR on several VFs at the same time, the
> Huawei Intelligent NIC processes them serially, ..."
> 

OK，will update it at next patch.

> "VF FLRs being delayed more than 100ms" does not by itself explain
> what the problem is.  I'm guessing the problem is that it exceeds the
> "msleep(100)" in pcie_flr(), which is based on PCIe r5.0, sec 6.6.2,
> which requires:
> 
>    After an FLR has been initiated by writing a 1b to the Initiate
>    Function Level Reset bit, the Function must complete the FLR within
>    100 ms.
> 
> So this device is apparently out of spec.  Is there an erratum for
> this?  Please cite it and quote the relevant part here.  I want to
> avoid having to update this quirk with future device IDs.
> 

We added a description of this problem to the document on the Huawei 
support website:
https://support.huawei.com/enterprise/en/doc/EDOC1100063073/87950645/vm-oss-occasionally-fail-to-load-the-in200-driver-when-the-vf-performs-flr

> IIUC, VFIO is initiating the FLR, probably as part of assigning the VF
> to a VM?

Yes, any process that can trigger multiple VF parallel FLRs has this 
problem.

> 
>> To solve this problem, add host and firmware status synchronization
>> during FLR.
>>
>> Signed-off-by: Chiqijun <chiqijun@huawei.com>
>> ---
>> v5:
>>   - Fix build warning reported by kernel test robot
>>
>> v4:
>>   - Addressed Bjorn's review comments
>>
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
>>   drivers/pci/quirks.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 653660e3ba9e..343890432ba8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3913,6 +3913,73 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>>   	return 0;
>>   }
>>   
>> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
>> +#define HINIC_VF_FLR_TYPE           0x1000
>> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  30
>> +#define HINIC_VF_OP                 0xE80
>> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 18
>> +#define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */
> 
> If you did this:
> 
>    #define HINIC_VF_FLR_CAP_BIT   (1UL << 30)
>    #define HINIC_VF_FLR_PROC_BIT  (1UL << 18)
> 
> the code below could be a little more readable, e.g,:
> 
>    if (!(val & HINIC_VF_FLR_CAP_BIT))
>      ...
>    val |= HINIC_VF_FLR_PROC_BIT;
> 

Will fix.

>> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
>> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
>> +{
>> +	unsigned long timeout;
>> +	void __iomem *bar;
>> +	u32 val;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	bar = pci_iomap(pdev, 0, 0);
>> +	if (!bar)
>> +		return -ENOTTY;
>> +
>> +	/* Get and check firmware capabilities. */
>> +	val = ioread32be(bar + HINIC_VF_FLR_TYPE);
>> +	if (!(val & (1UL << HINIC_VF_FLR_CAP_BIT_SHIFT))) {
>> +		pci_iounmap(pdev, bar);
>> +		return -ENOTTY;
>> +	}
>> +
>> +	/*
>> +	 * Set the processing bit for the start of FLR, which will be cleared
>> +	 * by the firmware after FLR is completed.
>> +	 */
>> +	val = ioread32be(bar + HINIC_VF_OP);
>> +	val = val | (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT);
> 
>> +	iowrite32be(val, bar + HINIC_VF_OP);
>> +
>> +	/* Perform the actual device function reset */
>> +	pcie_flr(pdev);
>> +
>> +	/*
>> +	 * The device must learn BDF after FLR in order to respond to BAR's
>> +	 * read request, therefore, we issue a configure write request to let
>> +	 * the device capture BDF.
> 
> Will this device capture the bus/device here even though it hasn't
> completed the reset?  Or does this write need to happen below, after
> the device has cleared HINIC_VF_FLR_PROC_BIT?
> 

The FLR processing of Huawei NIC is completed by the cooperation of 
hardware and firmware. The hardware can be executed in parallel and 
ensured within 100ms, but the firmware processing can only be executed 
serially; bus/device clearing and capturing are all completed by 
hardware, so it can be directly complete the config write operation here.

>> +	 */
>> +	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
>> +
>> +	/* Waiting for device reset complete */
>> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
>> +	do {
>> +		val = ioread32be(bar + HINIC_VF_OP);
>> +		if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
>> +			goto reset_complete;
>> +		msleep(20);
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	val = ioread32be(bar + HINIC_VF_OP);
>> +	if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
>> +		goto reset_complete;
>> +
>> +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %#010x\n", val);
> 
> s/flr/FLR/
> 

Will fix.

>> +reset_complete:
>> +	pci_iounmap(pdev, bar);
>> +
>> +	return 0;
> 
> You return 0 (success) even if the reset timed out.  Is that what you
> want?
> 
> I'd consider adding an "int err" local variable, then doing this so
> there's a single cleanup place that does the pci_iounmap() and the
> straight-line main path is the non-error one:
> 
>      int err = 0;
> 
>      if (!(val & HINIC_VF_FLR_CAP_BIT)) {
>        err = -ENOTTY;
>        goto reset_complete;
>      }
> 
>      do {
>        ...
>      } while (time_before(jiffies, timeout));
> 
>      val = ioread32be(bar + HINIC_VF_OP);
>      if (val & HINIC_VF_FLR_PROC_BIT) {
>        pci_warn(pdev, "Reset dev timeout, FLR ack reg: %#010x\n", val);
>        err = -EBUSY;            /* if you want error here; I dunno */
>        goto reset_complete;
>      }
> 
>      /* Let device capture bus/device, per PCIe r5.0, sec 2.2.9 */
>      pci_write_config_word(pdev, PCI_VENDOR_ID, 0);  /* if it goes here? */
> 
>    reset_complete:
>      pci_iounmap(pdev, bar);
>      return err;
> 

Waiting for FLR timeout here means that the firmware has not executed 
FLR for a period of time, but eventually FLR will be executed. We expect 
PCIE to be initialized after the timeout to ensure that PCIE is normal; 
even if VF initialization fails at the beginning, we do not restart the 
virtual machine, But after the remove/insmod driver, it can still be 
used normally.

Thanks.

>> +}
>> +
>>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>   		 reset_intel_82599_sfp_virtfn },
>> @@ -3924,6 +3991,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
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
