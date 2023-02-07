Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0624968E1F0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBGUff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBGUff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:35:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BBD37B78;
        Tue,  7 Feb 2023 12:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675802134; x=1707338134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=COq+zJrBQ8UVb2EFH4kB5bj/6NQTPCXFj3H5Q0d+tFc=;
  b=VCqpHaWInq9xU6cebpa8tvkdXBrLbgjr5c6jMXqQbuPkVghIbPdfI+Ek
   ma3pdaRQx2TSpwTmrRHsIGYDG5IA9ACWhP+s5e5YtzWKRJx5lMkjjI02s
   r6DZsUvrSfWke5UgSucFwqZjndecjTUDrq3YBvx2TGQa8d+h6XEMJcSYc
   rWMUiRKqKEN9XKmQbvaVwpGAFoxc7ejvKx9rzU1vQ9cxKoHlAC8t60Ari
   Q/5Zsd0Hgrin17F52RHqYLW0CgcTUxlOHEoquSY8Ewr2hh2RLJwmhj5Ss
   0KzjR0csDW6mKrYumjrs1hAhVagRUh7buBpijga6x/+Qg/FHCXQzQpd6m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330911432"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="330911432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:35:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="666977840"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="666977840"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:35:32 -0800
Message-ID: <664b54a6-699d-9c48-5cd7-d8fd7d54d165@intel.com>
Date:   Tue, 7 Feb 2023 13:35:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 11/18] PCI: Export pcie_get_width() using the code from
 sysfs PCI link width show function
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <20230206224338.GA2256550@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230206224338.GA2256550@bhelgaas>
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



On 2/6/23 3:43 PM, Bjorn Helgaas wrote:
> On Mon, Feb 06, 2023 at 01:51:01PM -0700, Dave Jiang wrote:
>> Move the logic in current_link_width_show() to a common function and export
>> that functiuon as pcie_get_width() to allow other drivers to to retrieve
>> the current negotiated link width.
> 
> s/a common function and export that functiuon and export that functiuon as//
> 
> I don't see the module caller of this, so not clear on why it needs to
> be exported.

You are right. I think I was using it before I found 
pcie_bandwidth_available() call. I will drop.

> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/pci/pci-sysfs.c |    9 +--------
>>   drivers/pci/pci.c       |   20 ++++++++++++++++++++
>>   include/linux/pci.h     |    1 +
>>   3 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 0217bb5ca8fa..139096c39380 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -215,15 +215,8 @@ static ssize_t current_link_width_show(struct device *dev,
>>   				       struct device_attribute *attr, char *buf)
>>   {
>>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>> -	u16 linkstat;
>> -	int err;
>>   
>> -	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
>> -	if (err)
>> -		return -EINVAL;
>> -
>> -	return sysfs_emit(buf, "%u\n",
>> -		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
>> +	return sysfs_emit(buf, "%u\n", pcie_get_width(pci_dev));
>>   }
>>   static DEVICE_ATTR_RO(current_link_width);
>>   
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d0131b5623b1..0858fa2f1c2d 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6235,6 +6235,26 @@ enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL(pcie_get_speed);
>>   
>> +/**
>> + * pcie_get_width - query for the PCI device's current link width
>> + * @dev: PCI device to query
>> + *
>> + * Query the PCI device current negoiated width.
>> + */
>> +
>> +enum pcie_link_width pcie_get_width(struct pci_dev *dev)
>> +{
>> +	u16 linkstat;
>> +	int err;
>> +
>> +	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
>> +	if (err)
>> +		return PCIE_LNK_WIDTH_UNKNOWN;
>> +
>> +	return FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
>> +}
>> +EXPORT_SYMBOL(pcie_get_width);
>> +
>>   /**
>>    * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
>>    * @dev: PCI device
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 6a065986ff8f..21eca09a98e2 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>>   
>>   enum pci_bus_speed pcie_get_speed(struct pci_dev *dev);
>>   enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>> +enum pcie_link_width pcie_get_width(struct pci_dev *dev);
>>   enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>>   
>>   struct pci_vpd {
>>
>>
