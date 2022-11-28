Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33E63B145
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiK1S12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 13:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiK1S1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 13:27:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DBA32066;
        Mon, 28 Nov 2022 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669659572; x=1701195572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KOVqni/ZwutMEZlCR+c8xAkaOfSr6ifVETx41oX673w=;
  b=lT55kz4uukImTTryCZI8RqkOgNxKuctdC71U+Z1NdApGRW17zSC/6iPE
   t3+pzV4i2J5Bq6D2H4fLDJaFI3skWVOxKAJ0JldOnfejBq7fZxya8VR8v
   4UnoO4Us85uL0A37J+cEfIPjxWnwuxNUSydVlfTTWhB3uflwqCzlE50UM
   nKowaHnV/pMH8fGzdm1JfQCi9qHp404yYqR3Li/uU/1llvGXMB+oJIgXC
   ENZwvXbrMsJTP2sHqRAch0Sd8TEU/g9Y+desFYVQl+vSEjbymBjRQ9cn3
   cDNLjZOqNpzfZt9bEgK8r0Qw4OFhep5yZnfFhA45694Ri6hnbjjEWIF1L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312540880"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="312540880"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 10:19:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="706893081"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="706893081"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.161.118]) ([10.209.161.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 10:19:31 -0800
Message-ID: <a1942dac-12be-c2d0-e1dd-51d4fbbebac6@intel.com>
Date:   Mon, 28 Nov 2022 11:19:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 10/11] PCI/AER: Add optional logging callback for
 correctable error
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
 <166879134199.674819.15564186577122699358.stgit@djiang5-desk3.ch.intel.com>
 <0eeb70d7-8f97-bd72-6db2-266fc2b0ba1b@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0eeb70d7-8f97-bd72-6db2-266fc2b0ba1b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/18/2022 6:08 PM, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 11/18/22 9:09 AM, Dave Jiang wrote:
>> Some new devices such as CXL devices may want to record additional error
>> information on a corrected error. Add a callback to allow the PCI device
>> driver to do additional logging and/or error handling.
> 
> Change looks good. But I am not sure whether this needs to be documented
> in Documentation/PCI/pci-error-recovery.rst with usage example. I will let
> Bjorn make a call on it.

Ok I'll add documentation. Thanks for the review!

> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/pci/pcie/aer.c |    8 +++++++-
>>   include/linux/pci.h    |    3 +++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
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
> 
