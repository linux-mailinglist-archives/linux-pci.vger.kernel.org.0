Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67E5696FC6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBNVdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 16:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBNVdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 16:33:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0817CDC;
        Tue, 14 Feb 2023 13:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676410388; x=1707946388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f6bQJkXwo2qf60kDl1XKsTDkgf/AS1YQ9vht0Emetmk=;
  b=FV922Zkq81RRxLshFqoMEsqjRSXkJWTFxQ+lY/w9l5tzFXEqa7AvxVoy
   AhaB2gNjoxxXYDemQ6Ey9OcFtKs0caCbTPWH2rKteuH206o8SBnoahrFa
   GdqvIMCgpzMKN1+Ozan8ptOymPTqKMFZPZ2PWexGahKFIBB07HLNgM0t7
   sFc0SH+BZRBTF0kG1ueGznhlOL6ambaepr0zLVZ91lwQ+wre+cD/YdBS1
   PPfyTvCnyNAcoj5OiAFGBDRNFI6DS2PPa49HLKlCgmGKVGlCJRJt4Cofx
   GBlyRWFdY7l6TpGGJxuCAwS1D1QQGSJMnk2nYnB3aCVr1hrF1dqueXapX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358691340"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="358691340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:29:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="738037850"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="738037850"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:29:15 -0800
Message-ID: <2ec4df81-541a-c4d8-3b63-1f11a9d09dcf@intel.com>
Date:   Tue, 14 Feb 2023 14:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 09/18] cxl: Add helper function to retrieve ACPI handle of
 CXL root device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571664152.587790.608196538260467034.stgit@djiang5-mobl3.local>
 <20230209141020.00004831@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209141020.00004831@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/23 7:10 AM, Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:50:42 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Provide a helper to find the ACPI0017 device in order to issue the _DSM.
>> The helper will take the 'struct device' from a cxl_port and iterate until
>> the root device is reached. The ACPI handle will be returned from the root
>> device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/acpi.c |   30 ++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h       |    1 +
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
>> index 86dc6c9c1f24..05fcd4751619 100644
>> --- a/drivers/cxl/core/acpi.c
>> +++ b/drivers/cxl/core/acpi.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/acpi.h>
>>   #include <linux/pci.h>
>> +#include <linux/platform_device.h>
>>   #include <asm/div64.h>
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -13,6 +14,35 @@ const guid_t acpi_cxl_qtg_id_guid =
>>   	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>>   		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>>   
>> +/**
>> + * cxl_acpi_get_root_acpi_handle - get the ACPI handle of the CXL root device
>> + * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
>> + * Looks for the ACPI0017 device and return the ACPI handle
>> + **/
> 
> Inconsistent comment style.

ok
> 
>> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
>> +{
>> +	struct device *itr = dev, *root_dev;
> 
> Not nice for readability to have an assignment in a list of definitions
> all on the same line.

ok
> 
>> +	acpi_handle handle;
>> +
>> +	if (!dev)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	while (itr->parent) {
>> +		root_dev = itr;
>> +		itr = itr->parent;
>> +	}
>> +
>> +	if (!dev_is_platform(root_dev))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	handle = ACPI_HANDLE(root_dev);
>> +	if (!handle)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return handle;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);
>> +
>>   /**
>>    * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
>>    * @handle: ACPI handle
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index e70df07f9b4b..ac6ea550ab0a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -733,6 +733,7 @@ struct qtg_dsm_output {
>>   
>>   struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
>>   						 struct qtg_dsm_input *input);
>> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
>>   
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>>
>>
> 
