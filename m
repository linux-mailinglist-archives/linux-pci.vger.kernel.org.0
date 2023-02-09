Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF63690F49
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBIRb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIRb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 12:31:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8814234;
        Thu,  9 Feb 2023 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675963887; x=1707499887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1g98/ZVZoLey73JyVaUiYu87hhxg9tWu13f6LSdBkA=;
  b=S9zNTOmcvyE05GszDVoX/wpE2hTacjwQkqvYC9sRIhadfXBEx5yvIid6
   wbKY1NJUwQNWUSrH3e4nVRr/x02+91mndS9EGuzOVBugfEQmxs8WvgZlB
   jyjm5jwSwRoz0cmMZslY7dkoqD7miZHfYb6y5Q4nQCCPN8zFKgI3w7mzY
   holzdvY/YWng0VVuhX17ezyz7yI1JO1bhAgrepHnBBDlIWhXxwc+ipH16
   IYG+mCtDQAouC34dztOEePsz9DIa/Agtc11St15fk4mgTTH20HTNh5+ww
   I+o9ysRkTixACGlIWDGJ9SXcTozUSbuh30nz5GbwzGIznUQfGPhJmBnxX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416404328"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="416404328"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:31:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="645333104"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="645333104"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.163.223]) ([10.213.163.223])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:31:25 -0800
Message-ID: <e5b3f9ca-3a1e-bc6f-1847-489de3bf00f0@intel.com>
Date:   Thu, 9 Feb 2023 10:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 03/18] cxl: Add checksum verification to CDAT from CXL
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571658747.587790.17252249256706733075.stgit@djiang5-mobl3.local>
 <20230209113422.00007017@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209113422.00007017@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/23 4:34 AM, Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:49:48 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> A CDAT table is available from a CXL device. The table is read by the
>> driver and cached in software. With the CXL subsystem needing to parse the
>> CDAT table, the checksum should be verified. Add checksum verification
>> after the CDAT table is read from device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave,
> 
> Some comments on this follow on from previous patch so may not
> be relevant once you've updated how that is done.

Dan advised to just drop the ACPICA changes and just do it locally since 
the verification code is tiny and simple.

> 
> Jonathan
> 
>> ---
>>   drivers/cxl/core/pci.c |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 57764e9cd19d..a24dac36bedd 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <linux/acpi.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <cxlpci.h>
>> @@ -592,6 +593,7 @@ void read_cdat_data(struct cxl_port *port)
>>   	struct device *dev = &port->dev;
>>   	struct device *uport = port->uport;
>>   	size_t cdat_length;
>> +	acpi_status status;
>>   	int rc;
>>   
>>   	cdat_doe = find_cdat_doe(uport);
>> @@ -620,5 +622,14 @@ void read_cdat_data(struct cxl_port *port)
>>   		port->cdat.length = 0;
>>   		dev_err(dev, "CDAT data read error\n");
>>   	}
>> +
>> +	status = acpi_ut_verify_cdat_checksum(port->cdat.table, port->cdat.length);
>> +	if (status != AE_OK) {
> 
> if (ACPI_FAILURE(acpi_ut...))  or better still put that in the wrapper I suggeste
> in previous patch so that we have normal kernel return code handling out here.
> 
> 
>> +		/* Don't leave table data allocated on error */
>> +		devm_kfree(dev, port->cdat.table);
>> +		port->cdat.table = NULL;
>> +		port->cdat.length = 0;
> 
> I'd rather see us manipulate a local copy of cdat_length, and cdat_table
> then only assign them to the port->cdat fields the success path rather
> than setting them then unsetting the on error.
> 
> Diff will be bigger, but nicer resulting code (and hopefully diff
> won't be too big!)

Ok, I'll create a prep patch to change this as you suggested.

> 
> 
>> +		dev_err(dev, "CDAT data checksum error\n");
>> +	}
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>
>>
> 
