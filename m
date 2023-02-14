Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AD696BEB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBNRmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjBNRmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:42:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E66227A4
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676396528; x=1707932528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bW8uR6wBCsYeJt8h1QLJxYsTlf2+8LSnUYNPBUIqPmw=;
  b=Kaiu9h68+koeZpg3tBHcGKCMxQIBltk6ski22ikRhaghufyqM6vzqQ7+
   xoBg6txpjzqQvsZSieppnK5v6SAREglfCDx5A8/ewAkbWzZZxw7YJjVoR
   0QLZz4RQN7vObp7LkK8+/J43f3CMlennDwsGEUtAcaxxmiMObF8Jy9ZRg
   qRNQL2tN3p0gty4o+hQSgtUPg1d3+sTi259UyYqtpRNoFYyJMIgK8xCXa
   aYiMRuvymyYwO9mVXiDBl8n92Z8u30ye5YeXAn94+ynnVjP3PY9rE7QFu
   beFJ39xCfB5yG7cx9zZGy21Du9+v/vizgShZsQbhRReFEgWRcqFvOECLw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310850961"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="310850961"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:42:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778438565"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778438565"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:42:07 -0800
Message-ID: <3d99758b-7462-7ed7-1e37-7e3f97e87c84@intel.com>
Date:   Tue, 14 Feb 2023 10:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
        lukas@wunner.de
References: <167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local>
 <9d131247-8196-7979-d267-51325dff9281@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <9d131247-8196-7979-d267-51325dff9281@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/23 10:37 AM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 2/14/23 8:48 AM, Dave Jiang wrote:
>> With commit [1] upstream that enables AER reporting by default for all PCIe
>> devices, the documentation for pcie_enable_pcie_error_reporting() is no
> 
> /s/pcie_enable_pcie_error_reporting/pci_enable_pcie_error_reporting
> 
>> longer necessary. Remove references to the helper function.
> 
> Before removing the documentation, are the references removed from the
> code? I think Bjorn only cleaned up the net drivers.

I have not touched any of the calling code. This popped up because of 
CXL RAS enabling. The removal of documentation is the hope to stop new 
implementations from calling the function.

> 
>>
>> [1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>>   1 file changed, 18 deletions(-)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..a82802795a06 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>>   errors because device specific errors will still get sent directly to
>>   the device driver.
>>   
>> -Configure the AER capability structure
>> ---------------------------------------
>> -
>> -AER aware drivers of PCI Express component need change the device
>> -control registers to enable AER. They also could change AER registers,
>> -including mask and severity registers. Helper function
>> -pci_enable_pcie_error_reporting could be used to enable AER. See
>> -section 3.3.
>> -
>>   Provide callbacks
>>   -----------------
>>   
>> @@ -214,15 +205,6 @@ to mmio_enabled.
>>   
>>   helper functions
>>   ----------------
>> -::
>> -
>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_enable_pcie_error_reporting enables the device to send error
>> -messages to root port when an error is detected. Note that devices
>> -don't enable the error reporting by default, so device drivers need
>> -call this function to enable it.
>> -
>>   ::
>>   
>>     int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>>
>>
> 
