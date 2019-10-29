Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96AE908C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJ2UGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 16:06:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:22731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2UGi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 16:06:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="202965182"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 13:06:37 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 3830858049B;
        Tue, 29 Oct 2019 13:06:37 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 7/8] PCI/DPC: Clear AER registers in EDR mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <20191028232732.GA206631@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <283cbbb4-78b7-7773-5613-d77341af166b@linux.intel.com>
Date:   Tue, 29 Oct 2019 13:04:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191028232732.GA206631@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/28/19 4:27 PM, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 04:39:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 Downstream Port Containment
>> Related Enhancements ECN,
> Specific reference, please, e.g., the section/table/figure of the PCI
> Firmware Spec being modified by the ECN.
Ok. I will include it.
>
>> OS is responsible for clearing the AER
>> registers in EDR mode. So clear AER registers in dpc_process_error()
>> function.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Acked-by: Keith Busch <keith.busch@intel.com>
>> ---
>>   drivers/pci/pcie/dpc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fafc55c00fe0..de2d892bc7c4 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -275,6 +275,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
>>   		pci_aer_clear_fatal_status(pdev);
>>   	}
>>   
>> +	/* In EDR mode, OS is responsible for clearing AER registers */
>> +	if (dpc->firmware_dpc)
> I guess "EDR mode" is effectively the same as "firmware-first mode"?
Yes, EDR mode is an upgrade to FF mode in which firmware allows
OS to share some of it job by sending ACPI notification. If you don't get
ACPI notification, EDR mode is effectively same as FF mode.
>
> At least, the only place we set "firmware_dpc = 1" is:
>
>    +       if (pcie_aer_get_firmware_first(pdev))
>    +               dpc->firmware_dpc = 1;
>
> If they're the same, why do we need two different names for it?
For better readability and performance, I tried to cache the value of
pcie_aer_get_firmware_first() result in DPC driver.
>
>> +		pci_cleanup_aer_error_status_regs(pdev);
>> +
>>   	/*
>>   	 * Irrespective of whether the DPC event is triggered by
>>   	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

