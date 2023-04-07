Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB56DB666
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 00:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDGWVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjDGWVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 18:21:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080ECA1C;
        Fri,  7 Apr 2023 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680906102; x=1712442102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5duwrcqSC7rCUO0BOmDoKW2vwKV3sKWMn9Hvx1yaVkM=;
  b=Jv2+iGIHuFmslrtMdB/AmKqETXio7rfRJNDfLy4X1CKDAQmOVgiCX6H9
   GBxBBuIM/UpKqIesPaYYD8o7bWuAycqndzGfw5asliHmuN0Jv3+asWk6O
   c73TwLb+3NF2QArX+E6wJsYeSu0v0FtaibkT6HwXdcShx7g59LIHhDYJb
   kxbkLD8hwMMC+MWCfSYdmqv6HQ6OgE6rR/1h1GoLdESzSIARSjx/4+2Hx
   q7Up0GsY5RiAyJRZMOf4hZvZFdK51HgBwfVM7tR8rrGm4goKUL9cN1lpE
   ND/zcTfZLsGder91n5Bz32tO+zp4bLGkFKfvDmTEbW1RCH7wa3LZJOX+R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="322715135"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="322715135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="933721155"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="933721155"
Received: from ssingh6-mobl2.amr.corp.intel.com (HELO [10.212.218.166]) ([10.212.218.166])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:21:41 -0700
Message-ID: <6010286e-c7b4-34d1-94d1-46b7f152c942@linux.intel.com>
Date:   Fri, 7 Apr 2023 15:21:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
References: <20230407215142.GA3825302@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230407215142.GA3825302@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/7/23 2:51 PM, Bjorn Helgaas wrote:
> [+cc Jonathan, Mahesh]
> 
> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>> OS owns AER") adds support to clear error status in the Device Status
>> Register(DEVSTA) only if OS owns the AER support. But this change
>> breaks the requirement of the EDR feature which requires OS to cleanup
>> the error registers even if firmware owns the control of AER support.
>>
>> More details about this requirement can be found in PCIe Firmware
>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
>> If the OS supports the Error Disconnect Recover (EDR) feature and
>> firmware sends the EDR event, then during the EDR recovery window, OS
>> is responsible for the device error recovery and holds the ownership of
>> the following error registers.
>>
>> • Device Status Register
>> • Uncorrectable Error Status Register
>> • Correctable Error Status Register
>> • Root Error Status Register
>> • RP PIO Status Register
>>
>> So call pcie_clear_device_status() in edr_handle_event() if the error
>> recovery is successful.
>>
>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Sorry I spent so much time on this, but I finally applied it to
> pci/aer for v6.4.
> 
> I added the "Fixes: 068c29a248b6" line.  It's not that 068c29a248b6 is
> a bug, just that EDR relied on behavior that 068c29a248b6 legitimately
> removed, so this patch should go where 068c29a248b6 goes.
> 

Agree

> I wordsmithed the commit log to add hints about things I stumbled
> over.  I'll post a follow-up patch to add a couple comments there,
> too.
> 
> Thanks for your patience in educating me through all this.

Thanks for working on it. I really appreciate your help.

> 
>> ---
>>
>> Changes since v1:
>>  * Rebased on top of v6.3-rc1.
>>  * Fixed a typo in pcie_clear_device_status().
>>
>>  drivers/pci/pcie/edr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index a6b9b479b97a..87734e4c3c20 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>  	 */
>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>>  		pci_dbg(edev, "DPC port successfully recovered\n");
>> +		pcie_clear_device_status(edev);
>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>>  	} else {
>>  		pci_dbg(edev, "DPC port recovery failed\n");
>> -- 
>> 2.34.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
