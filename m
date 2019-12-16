Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77B120287
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLPKaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 05:30:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbfLPKaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 05:30:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 630969C8452616C67DEF;
        Mon, 16 Dec 2019 18:30:02 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 18:30:00 +0800
Subject: Re: [Patch]PCI:AER:Notify which device has no error_detected callback
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20191213225709.GA213811@google.com>
CC:     <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <31b3a6aa-e4c1-ee09-6302-9c4f25471a1c@hisilicon.com>
Date:   Mon, 16 Dec 2019 18:30:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191213225709.GA213811@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/12/14 6:57, Bjorn Helgaas wrote:
> On Fri, Dec 13, 2019 at 07:44:34PM +0800, Yicong Yang wrote:
>> The PCI error recovery will fail if any device under
>> root port doesn't have an error_detected callback.
>> Currently only failure result is printed, which is
>> not enough to determine which device leads to the
>> failure and the detailed failure reason.
>>
>> Add print information if certain device under root
>> port has no error_detected callback.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Applied to pci/aer for v5.6, thanks!
>
> I also added a trivial follow-on patch to factor out the "AER: "
> prefix (attached below).  This code is now used by DPC as well as AER,
> so "AER: " might not be exactly the correct prefix, but I didn't try
> to untangle that.
>
>> ---
>>  drivers/pci/pcie/err.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index b0e6048..ec37c33 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
>>  		 * error callbacks of "any" device in the subtree, and will
>>  		 * exit in the disconnected error state.
>>  		 */
>> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>> +			pci_info(dev, "AER: Device has no error_detected callback\n");
>> +		}
>>  		else
>>  			vote = PCI_ERS_RESULT_NONE;
>>  	} else {
>> --
>> 2.8.1
>>
> commit 9694ef043ea4 ("PCI/AER: Factor message prefixes with dev_fmt()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Dec 13 16:46:05 2019 -0600
>
>     PCI/AER: Factor message prefixes with dev_fmt()
>     
>     Define dev_fmt() with the common prefix of log messages so we don't have to
>     repeat it in every printk.  No functional change intended.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index abde5e000f5d..747ef8b41d1f 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -10,6 +10,8 @@
>   *	Zhang Yanmin (yanmin.zhang@intel.com)
>   */
>  
> +#define dev_fmt(fmt) "AER: " fmt
> +
>  #include <linux/pci.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -64,7 +66,7 @@ static int report_error_detected(struct pci_dev *dev,
>  		 */
>  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> -			pci_info(dev, "AER: Driver has no error_detected callback\n");
> +			pci_info(dev, "driver has no error_detected callback\n");

I think use "device" here is more proper. Sometimes the device is even not bind to the driver, which
will also lead to the recovery failure.


>  		} else {
>  			vote = PCI_ERS_RESULT_NONE;
>  		}
> @@ -236,12 +238,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  
>  	pci_aer_clear_device_status(dev);
>  	pci_cleanup_aer_uncorrect_error_status(dev);
> -	pci_info(dev, "AER: Device recovery successful\n");
> +	pci_info(dev, "device recovery successful\n");
>  	return;
>  
>  failed:
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>  
>  	/* TODO: Should kernel panic here? */
> -	pci_info(dev, "AER: Device recovery failed\n");
> +	pci_info(dev, "device recovery failed\n");
>  }
>
> .
>


