Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070D68DF78
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjBGRzH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjBGRzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 12:55:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F110D;
        Tue,  7 Feb 2023 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675792506; x=1707328506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P30+lYIVc4wiz0EdRCOy8pNv7bvkxNZJAWCj9CeN+zY=;
  b=DBwyV7CZrXzQT8cgbLqlDcwODQ2RSPnkLGDEzIfTOpn8G1avGbtLA/y2
   YBFCoj+S/WvyrVuCuM98kDc+i8ERP8U4E3YcF/kdgs6KrJHZVE3PurIcU
   3oY3QL4cFgCBTFUoujf1JS6FV2OEOZDuZkCzyq7tElnGUqR3OWFmpQFTZ
   PxbI21lcTc5fPTw9kSajIbSQpqcUTzXcEosxCUIMcJqnbiy+BP0QJ5t0j
   bANbHCrNj3W7AnS0pypGHqDH7bSLoy4CygBUHR2hcDqzMBpV0FNHskzKT
   VVcLESm+UVYY/PvR8nwGYMLC8kUNC28bPWbxfa5yOyS2w8J95hpjNx+SM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317555509"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317555509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 07:48:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809562801"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="809562801"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 07:47:59 -0800
Message-ID: <bd978172-a774-b914-04a1-8e878dddfb92@intel.com>
Date:   Tue, 7 Feb 2023 08:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 02/18] ACPICA: Export acpi_ut_verify_cdat_checksum()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571657859.587790.12435839081602248140.stgit@djiang5-mobl3.local>
 <CAJZ5v0hO-FthRSRD5LPL1Onz7DaRG8zBo=GBDBR+k1_upYHVBQ@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0hO-FthRSRD5LPL1Onz7DaRG8zBo=GBDBR+k1_upYHVBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/7/23 7:19 AM, Rafael J. Wysocki wrote:
> On Mon, Feb 6, 2023 at 9:49 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> Export the CDAT checksum verify function so CXL driver can use it to verify
>> CDAT coming from the CXL devices.
>>
>> Given that this function isn't actually being used by ACPI internals,
>> removing the define check of APCI_CHECKSUM_ABORT so the function would
>> return failure on checksum fail since the driver will need to know.
> 
> If you want to make ACPICA changes, please first submit a pull request
> to the upstream ACPICA project on GitHub.
> 
> Having done that, please resubmit the corresponding Linux patch with a
> Link tag pointing to the upstream PR.

Ok will do. Thanks!
> 
> Thanks!
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/acpi/acpica/utcksum.c |    4 +---
>>   include/linux/acpi.h          |    7 +++++++
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
>> index c166e4c05ab6..c0f98c8f9a0b 100644
>> --- a/drivers/acpi/acpica/utcksum.c
>> +++ b/drivers/acpi/acpica/utcksum.c
>> @@ -102,15 +102,13 @@ acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
>>                                     "should be 0x%2.2X",
>>                                     acpi_gbl_CDAT, cdat_table->checksum,
>>                                     checksum));
>> -
>> -#if (ACPI_CHECKSUM_ABORT)
>>                  return (AE_BAD_CHECKSUM);
>> -#endif
>>          }
>>
>>          cdat_table->checksum = checksum;
>>          return (AE_OK);
>>   }
>> +EXPORT_SYMBOL_GPL(acpi_ut_verify_cdat_checksum);
>>
>>   /*******************************************************************************
>>    *
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 5e6a876e17ba..09b44afef7df 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1504,9 +1504,16 @@ static inline void acpi_init_ffh(void) { }
>>   #ifdef CONFIG_ACPI
>>   extern void acpi_device_notify(struct device *dev);
>>   extern void acpi_device_notify_remove(struct device *dev);
>> +extern acpi_status
>> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length);
>>   #else
>>   static inline void acpi_device_notify(struct device *dev) { }
>>   static inline void acpi_device_notify_remove(struct device *dev) { }
>> +static inline acpi_status
>> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
>> +{
>> +       return (AE_NOT_CONFIGURED);
>> +}
>>   #endif
>>
>>   #endif /*_LINUX_ACPI_H*/
>>
>>
