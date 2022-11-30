Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FA63E2D9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 22:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiK3VhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiK3VhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 16:37:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985991379;
        Wed, 30 Nov 2022 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669844237; x=1701380237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8wZqdIjr5FpmOoemumOiOZUT8ftw3oFGWnSoeT/3WI=;
  b=DNZeVofFgZOj7DXLmmlLQ8ZckzZJz3Rd9YfWUkuLSUtZLGfqWL+UDHMi
   MtVp/G7g7gH/W58j5Zd0g+omYYNiuTiA1TQWJ5LOA7cYDLcE/MwQ9xgce
   HKgBQJGqCWsfTVUlRKowJUj7cM6mkCSdPp+DhtRV4Rlb688Xuz77vZ9fv
   bq2f4tnjOTaK5xI0OTpVzE+B1gRi9EPG29j58gmz9FtBfezb4de2xmsIO
   AoypBqTRyQ6b+iWoDajwG2rXATOTdxhYhzRJvnWg8HW4Tj5QuyVam51co
   EdWmvWOsWRBZ6w4WlJ1EAjydTPTG5Bxx6r9aA+RrOO5EYIgHPeykyLP4S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379795103"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379795103"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 13:37:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="712971066"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="712971066"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.104.222]) ([10.212.104.222])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 13:37:15 -0800
Message-ID: <1669ae81-e3fa-0401-1a18-dd77961bb8a9@intel.com>
Date:   Wed, 30 Nov 2022 14:37:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 10/11] PCI/AER: Add optional logging callback for
 correctable error
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
References: <20221130194521.GA829038@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221130194521.GA829038@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2022 12:45 PM, Bjorn Helgaas wrote:
> On Tue, Nov 29, 2022 at 10:49:05AM -0700, Dave Jiang wrote:
>> Some new devices such as CXL devices may want to record additional error
>> information on a corrected error. Add a callback to allow the PCI device
>> driver to do additional logging such as providing additional stats for user
>> space RAS monitoring.
>>
>> For CXL device, this is actually a need due to CXL needing to write to the
>> device AER status register in order to clear the unmasked CEs.
> 
> s/CE/correctable error/ since it's the first use and not common in
> PCI-land.
> 

Ok

> "device AER status register" sounds like the PCIe AER Correctable
> Error Status Register (PCIe r6.0, sec 7.8.4.5), but I think you mean
> something else, maybe a CXL-specific register?

Yes. It's part of the CXL device RAS structure. I'll add more details.

> 
> The PCIe core needs to own the AER one (PCI_ERR_COR_STATUS) so it can
> coordinate ownership between firmware and Linux.
> 
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you!

> 
>> ---
>>   Documentation/PCI/pci-error-recovery.rst |    7 +++++++
>>   drivers/pci/pcie/aer.c                   |    8 +++++++-
>>   include/linux/pci.h                      |    3 +++
>>   3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
>> index 187f43a03200..690220255d5e 100644
>> --- a/Documentation/PCI/pci-error-recovery.rst
>> +++ b/Documentation/PCI/pci-error-recovery.rst
>> @@ -83,6 +83,7 @@ This structure has the form::
>>   		int (*mmio_enabled)(struct pci_dev *dev);
>>   		int (*slot_reset)(struct pci_dev *dev);
>>   		void (*resume)(struct pci_dev *dev);
>> +		void (*cor_error_log)(struct pci_dev *dev);
> 
> I think I would remove "log" from the name because it suggests this
> hook should *only* log, and you need to actually clear some status.
> Maybe "cor_error_detected()" to be analogous to error_detected()?

Ok I'll change.

> 
>>   	};
>>   
>>   The possible channel states are::
>> @@ -422,5 +423,11 @@ That is, the recovery API only requires that:
>>      - drivers/net/cxgb3
>>      - drivers/net/s2io.c
>>   
>> +   The cor_error_log() callback is invoked in handle_error_source() when
>> +   the error severity is "correctable". The callback is optional and allows
>> +   additional logging to be done if desired. See example:
>> +
>> +   - drivers/cxl/pci.c
>> +
>>   The End
>>   -------
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e2d8a74f83c3..af1b5eecbb11 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -961,8 +961,14 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>   		if (aer)
>>   			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>   					info->status);
>> -		if (pcie_aer_is_native(dev))
>> +		if (pcie_aer_is_native(dev)) {
>> +			struct pci_driver *pdrv = dev->driver;
>> +
>> +			if (pdrv && pdrv->err_handler &&
>> +			    pdrv->err_handler->cor_error_log)
>> +				pdrv->err_handler->cor_error_log(dev);
>>   			pcie_clear_device_status(dev);
>> +		}
>>   	} else if (info->severity == AER_NONFATAL)
>>   		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>>   	else if (info->severity == AER_FATAL)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 575849a100a3..54939b3426a9 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -844,6 +844,9 @@ struct pci_error_handlers {
>>   
>>   	/* Device driver may resume normal operations */
>>   	void (*resume)(struct pci_dev *dev);
>> +
>> +	/* Allow device driver to record more details of a correctable error */
>> +	void (*cor_error_log)(struct pci_dev *dev);
>>   };
>>   
>>   
>>
>>
