Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21A7730F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGZU52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 16:57:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:25820 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfGZU51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 16:57:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 13:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="189741824"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2019 13:57:27 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 4E79E580107;
        Fri, 26 Jul 2019 13:57:27 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 8/9] PCI/DPC: Add support for DPC recovery on NON_FATAL
 errors
To:     Keith Busch <kbusch@kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
References: <cover.1563912591.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <211d4bf8f856c6aa5454751e25ab5c90970960ff.1563912591.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190725165037.GA7055@localhost.localdomain>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <0a3ccc81-971b-65ff-f754-9fbb1cd4eb40@linux.intel.com>
Date:   Fri, 26 Jul 2019 13:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725165037.GA7055@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/25/19 9:50 AM, Keith Busch wrote:
> On Tue, Jul 23, 2019 at 01:21:50PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently, in native mode, DPC driver is configured to trigger DPC only
>> for FATAL errors and hence it only supports port recovery for FATAL
>> errors. But with Error Disconnect Recover (EDR) support, DPC
>> configuration is done by firmware, and hence we should expect DPC
>> triggered for both FATAL/NON-FATAL errors. So add support for DPC
>> recovery with NON-FATAL errors.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/dpc.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 6e350149d793..5d328812aea9 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -267,15 +267,20 @@ static void dpc_process_error(struct dpc_dev *dpc)
>>   	/* show RP PIO error detail information */
>>   	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>>   		dpc_process_rp_pio_error(dpc);
>> -	else if (reason == 0 &&
>> +	else if (reason <= 2 &&
>>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>>   		 aer_get_device_error_info(pdev, &info)) {
>>   		aer_print_error(pdev, &info);
>>   		pci_cleanup_aer_uncorrect_error_status(pdev);
>> -		pci_aer_clear_fatal_status(pdev);
>> +		if (reason != 1)
>> +			pci_aer_clear_fatal_status(pdev);
> I'm not quite sure I understand the above. If the reason is 1 or 2,
> then the DSP received an error message from something downstream. In
> otherwords, the port was notified an error occured somewhere, but it
> was not the device that detected that error, so we should not expect
> aer_print_error on that device to show anything useful. Right?

My intention here was to just clear the AER registers. EDR spec expects 
OS to clear AER registers during DPC event (irrespective of DPC trigger 
reason). Consider a case where DPC is triggered due to ERR_FATAL 
message, but at the same time the port has some correctable errors 
logged. So before handling DPC, we need to clear the AER registers. 
Since there is no AER driver to handle AER registers in EDR mode, we 
need to clear AER registers in the same code path. But I got your point 
about there is nothing to report/print if the reason != 0. I think the 
correct way to clear all AER registers is to use 
pci_cleanup_aer_error_status_regs(). I will fix this and send a new 
patch set.

>
>>   	}
>>   
>> -	/* We configure DPC so it only triggers on ERR_FATAL */
>> +	/*
>> +	 * Irrespective of whether the DPC event is triggered by
>> +	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
>> +	 * use the FATAL error recovery path for both cases.
>> +	 */
>>   	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
>>   }
>>   
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

