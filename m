Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2538863B3D3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiK1VBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 16:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiK1VBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 16:01:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790662EF50;
        Mon, 28 Nov 2022 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669669296; x=1701205296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hIQ49By2HhsonQCK2A56x2bA3imymIkTPuRSOj8yaQA=;
  b=G+zFvKw4yxdU3vnK6rEJRGOT/XTW5xfRAda2JmpXT1fATKw8TxhI8P6O
   zYt6Xc/YNr/ZUUbIaMZ0cuxyNJ/AVAhUN3SpFEnooUs9ewxlZhsXTMO6K
   40eCgIxns0BZO6fMC/ba2tMtJ+tO7f0N96Ks/oJZLXbbADnx+m054JSaj
   Z1Gt2XAail7L5BoBEY7xekWQr8N+MO34lF7hsjdrw8u2JMIIDSMoi7hPE
   nFJMkqB/65N+V6bNaqR/fUPTplOhfKE/p3ilRnd7wSil2eMSv8UVfBHSF
   cV/YaJXqggSfN/vA6QA0641JfdAor+xAPDvRRiLOqDgLo3JEcoJO8wWZM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313653971"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="313653971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 13:01:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643538671"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="643538671"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.161.118]) ([10.209.161.118])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 13:01:23 -0800
Message-ID: <b360aba7-d1e4-7d9b-685f-5c910e13fed2@intel.com>
Date:   Mon, 28 Nov 2022 14:01:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 10/11] PCI/AER: Add optional logging callback for
 correctable error
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org, terry.bowman@amd.com, bhelgaas@google.com
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
 <166879134199.674819.15564186577122699358.stgit@djiang5-desk3.ch.intel.com>
 <20221121120527.0000608e@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221121120527.0000608e@Huawei.com>
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



On 11/21/2022 5:05 AM, Jonathan Cameron wrote:
> On Fri, 18 Nov 2022 10:09:02 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Some new devices such as CXL devices may want to record additional error
>> information on a corrected error. Add a callback to allow the PCI device
>> driver to do additional logging and/or error handling.
> 
> Probably want to be a little careful about talking about error handling for
> corrected errors.  It does make sense if you are doing stats based offlining
> of flaky parts of devices (we do this on some of our crypto and similar
> accelerators), but that isn't really 'error handling'.

I'll remove the text of error handling and make it to be for optional 
additional logging only.

> 
> Agreed with other review that it might warrant some documentation but as
> said their, Bjorn's call to make!
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
