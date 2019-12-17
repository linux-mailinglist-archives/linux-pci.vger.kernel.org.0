Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4E12299A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLQLM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 06:12:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfLQLM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 06:12:26 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 748F543BB9F878B274C6;
        Tue, 17 Dec 2019 19:12:23 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 19:12:22 +0800
Subject: Re: [Patch]PCI:AER:Notify which device has no error_detected callback
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <31b3a6aa-e4c1-ee09-6302-9c4f25471a1c@hisilicon.com>
 <20191216175832.GA206621@google.com> <20191216112800.44d76017@x1.home>
CC:     <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <bb339868-252b-a759-cc8c-712352a55bd9@hisilicon.com>
Date:   Tue, 17 Dec 2019 19:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191216112800.44d76017@x1.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/12/17 2:28, Alex Williamson wrote:
> On Mon, 16 Dec 2019 11:58:32 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> [+cc Alex]
>>
>> On Mon, Dec 16, 2019 at 06:30:11PM +0800, Yicong Yang wrote:
>>> On 2019/12/14 6:57, Bjorn Helgaas wrote:  
>>>> On Fri, Dec 13, 2019 at 07:44:34PM +0800, Yicong Yang wrote:  
>>>>> The PCI error recovery will fail if any device under
>>>>> root port doesn't have an error_detected callback.
>>>>> Currently only failure result is printed, which is
>>>>> not enough to determine which device leads to the
>>>>> failure and the detailed failure reason.
>>>>>
>>>>> Add print information if certain device under root
>>>>> port has no error_detected callback.
>>>>>
>>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
>>>> Applied to pci/aer for v5.6, thanks!
>>>>
>>>> I also added a trivial follow-on patch to factor out the "AER: "
>>>> prefix (attached below).  This code is now used by DPC as well as AER,
>>>> so "AER: " might not be exactly the correct prefix, but I didn't try
>>>> to untangle that.
>>>>  
>>>>> ---
>>>>>  drivers/pci/pcie/err.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>>> index b0e6048..ec37c33 100644
>>>>> --- a/drivers/pci/pcie/err.c
>>>>> +++ b/drivers/pci/pcie/err.c
>>>>> @@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
>>>>>  		 * error callbacks of "any" device in the subtree, and will
>>>>>  		 * exit in the disconnected error state.
>>>>>  		 */
>>>>> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>>>>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>>>>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>>>>> +			pci_info(dev, "AER: Device has no error_detected callback\n");
>>>>> +		}
>>>>>  		else
>>>>>  			vote = PCI_ERS_RESULT_NONE;
>>>>>  	} else {
>>>>> --
>>>>> 2.8.1
>>>>>  
>>>> commit 9694ef043ea4 ("PCI/AER: Factor message prefixes with dev_fmt()")
>>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>>> Date:   Fri Dec 13 16:46:05 2019 -0600
>>>>
>>>>     PCI/AER: Factor message prefixes with dev_fmt()
>>>>     
>>>>     Define dev_fmt() with the common prefix of log messages so we don't have to
>>>>     repeat it in every printk.  No functional change intended.
>>>>     
>>>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index abde5e000f5d..747ef8b41d1f 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -10,6 +10,8 @@
>>>>   *	Zhang Yanmin (yanmin.zhang@intel.com)
>>>>   */
>>>>  
>>>> +#define dev_fmt(fmt) "AER: " fmt
>>>> +
>>>>  #include <linux/pci.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/kernel.h>
>>>> @@ -64,7 +66,7 @@ static int report_error_detected(struct pci_dev *dev,
>>>>  		 */
>>>>  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>>>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>>>> -			pci_info(dev, "AER: Driver has no error_detected callback\n");
>>>> +			pci_info(dev, "driver has no error_detected callback\n");  
>>> I think use "device" here is more proper. Sometimes the device is
>>> even not bind to the driver, which will also lead to the recovery
>>> failure.  
>> Hmmm, maybe so, although the error_detected callback is definitely a
>> property of the *driver*, not the device.  What would you think of
>> something like this?
>>
>>   pci_info(dev, dev->driver ? "driver not capable of error recovery\n" :
>>                               "no driver\n");

well, it seems like a better way. maybe :-)
    pci_info(dev, dev->driver ? "driver has no error_detected callback\n" :
                                                   "device has no driver\n")

>>
>> I am curious about the larger question of why we fail if the device
>> has no driver.  I understand why we fail the recovery for a device
>> with a driver that has no err_handlers: we can't just reset the device
>> out from under the driver.
>>
>> But why do we fail if a device has no driver at all?  Shouldn't it be
>> safe to reset such a device?  The commit log of 918b4053184c
>> ("PCI/AER: Report success only when every device has AER-aware
>> driver") suggests that it has something to do with KVM and the
>> pci-stub driver, but I don't understand it.
> That commit is from 2012, when legacy KVM device assignment existed in
> the kernel and was able to drive a device without really binding to it
> as a driver.  Sane users of this mechanism would at least bind the
> device to pci-stub to prevent it from being used by both a host driver
> and KVM simultaneously.  In any case, legacy KVM device assignment no
> longer exists in the kernel, so if that was the justification to not
> reset driver-less devices, we can probably fill that gap now.  Thanks,
>
> Alex
>

I think the reason why we fail if a device has no driver is the same as the driver has no
error_detected callback. Under both conditions, the next step process is uncertain.

If the error is from other devices, probably we can just ignore the unbind devices. But
I'm not certain whether errors will occur at devices with no drivers and results to ignore
them. If it's okay, maybe just ignore the unbind devices and return PCI_ERS_RESULT_NONE.
however, I tried to inject errors on an unbind device using aer_inject and the recovery
routine is invoked. is there real condition like this?
> .
>


