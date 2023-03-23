Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544D6C730D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 23:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCWW0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWW0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 18:26:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8B17CF7;
        Thu, 23 Mar 2023 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679610371; x=1711146371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JvqqlZLI5QBdLv7UHeMkvXGX53SPPfX+WJ20n97dxJY=;
  b=KQVV3w+htmOnDsGjb11tPDheLUzVMuWdgU/I3T8r1XWJy1FWFUrr1veP
   sYmNBZ0Ml4lJfyWRET8I4i0vO+ldMWb8qR2Jm3MNoPziOQh43fb6KtpvI
   9yo+UJf6uY+z9yaF7GVEQaKLdlFOJiQz18Fyx7yJU8swncmchie1lc9zI
   Lncbrk7/zkjqHAeJdIQQZ6yV1uHK7zIfqknUcupOj0MaqkskVfwYy/Nv9
   kQqOIiyiD3HH9yHKA0sbfl3Sp+bBchUw2liX7FPOR2/6qGgExwDYO+4ZN
   aGjS1DyjKDQMtyMd8KYTlH/A1CwXxN1RnMxZd+RKeMatP4VzSLZkKVIo+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323504242"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="323504242"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751662842"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="751662842"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.121.177]) ([10.209.121.177])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:26:08 -0700
Message-ID: <ef57e100-e656-d692-b776-3f6e3f242c15@linux.intel.com>
Date:   Thu, 23 Mar 2023 15:26:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver
 logging
Content-Language: en-US
To:     Terry Bowman <Terry.Bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com, mahesh@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-4-terry.bowman@amd.com>
 <f31edb04-04c7-2d98-e3ef-a591993e7ceb@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f31edb04-04c7-2d98-e3ef-a591993e7ceb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/23/23 3:20 PM, Terry Bowman wrote:
> Adding PCI reviewers.
> 
> https://lore.kernel.org/all/20230323213808.398039-1-terry.bowman@amd.com/

> 
> On 3/23/23 16:38, Terry Bowman wrote:
>> The CXL driver plans to use cper_print_aer() for restricted CXL host
>> (RCH) logging. cper_print_aer() is not exported and as a result is not
>> available to the CXL driver or other loadable modules. Export
>> cper_print_aer() making it available to CXL and other loadable modules.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>>  drivers/pci/pcie/aer.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 625f7b2cafe4..7f0f52d094a4 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -809,6 +809,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>  }
>> +EXPORT_SYMBOL_GPL(cper_print_aer);
>>  #endif
>>  
>>  /**

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
