Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1576728C447
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgJLVrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 17:47:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:50849 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgJLVrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 17:47:08 -0400
IronPort-SDR: SBcJ0iUAvZ80zTueggJMoz8SeKJXoa0pABu9b9k/VQDwCEgNEIlAkLJgLmk6AQAMp3tRv/FvSa
 f+IM66gNAS7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165022939"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="165022939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 14:47:06 -0700
IronPort-SDR: IyiTXSkDr02AxtMYOLxxjIFBHGMwRarKUuo+sI0w/4DmzYEfZlXR0uboX7tL+eLoSwjhc3062C
 rKyO2J6Z7TOA==
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="345038868"
Received: from smaleki-mobl.amr.corp.intel.com (HELO [10.252.132.156]) ([10.252.132.156])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 14:47:05 -0700
Subject: Re: [PATCH v4 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.nkuppuswamy@gmail.com
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201012210522.GA86612@otc-nc-03>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9b7db59d-832c-1c21-90b6-1676ea9058ce@linux.intel.com>
Date:   Mon, 12 Oct 2020 14:47:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012210522.GA86612@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/12/20 2:05 PM, Raj, Ashok wrote:
> On Sun, Oct 11, 2020 at 10:03:40PM -0700, sathyanarayanan.nkuppuswamy@gmail.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently if report_error_detected() or report_mmio_enabled()
>> functions requests PCI_ERS_RESULT_NEED_RESET, current
>> pcie_do_recovery() implementation does not do the requested
>> explicit device reset, but instead just calls the
>> report_slot_reset() on all affected devices. Notifying about the
>> reset via report_slot_reset() without doing the actual device
>> reset is incorrect. So call pci_bus_reset() before triggering
>> ->slot_reset() callback.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/err.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index c543f419d8f9..067c58728b88 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -181,11 +181,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	}
>>   
>>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> -		/*
>> -		 * TODO: Should call platform-specific
>> -		 * functions to reset slot before calling
>> -		 * drivers' slot_reset callbacks?
>> -		 */
>> +		pci_reset_bus(dev);
> 
> pci_reset_bus() returns an error, do you need to consult that before
> unconditionally setting PCI_ERS_RESULT_RECOVERED?
Good point. I will fix this in next version.
> 
>>   		status = PCI_ERS_RESULT_RECOVERED;
>>   		pci_dbg(dev, "broadcast slot_reset message\n");
>>   		pci_walk_bus(bus, report_slot_reset, &status);
>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
