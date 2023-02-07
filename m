Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A939168E1E1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBGU3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBGU3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:29:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725191F5D1;
        Tue,  7 Feb 2023 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675801771; x=1707337771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JR411MJOx3/Xz5OKI7Rqwr8jF+ejIGX+FaaLtRQ0+pE=;
  b=Er7u4RwlBJym/eWb1i8YjGhMWquks9x1NZFJH6GGF2xTi9Tlid30T8r9
   AWYf8qkBxAiId4c4Q9gdjVUWNE0J3lqghuQQwXjPLrJXSir6lkNZ35m63
   Ys/xDmwsmVp4UElpD9wiTFCnc8Ka2O5n1FhGF5S3CLIUorZVjhp9RcOvg
   kIEpKyBdtx3FcdwOAG762M7VfkxRByzY9QGQdCN26z1VB4xg9eFYrQ1Ak
   Z2p3GQ9Yg0j3FKH5gzP3HiNFTccJo49e4KlLp1uN2QkDQvsU2c53OQGb1
   XlglDi0g7lFrrLP5mEY2bFzRXXyAp8PxdSxmpv1BplGtBcmuG4VPezC4F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330909843"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="330909843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:29:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="668931122"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="668931122"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:29:23 -0800
Message-ID: <c0b5044b-3efc-932c-7b73-ab5c70d62d71@intel.com>
Date:   Tue, 7 Feb 2023 13:29:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 10/18] PCI: Export pcie_get_speed() using the code from
 sysfs PCI link speed show function
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571665075.587790.11513782507200128278.stgit@djiang5-mobl3.local>
 <20230206222722.GC21823@wunner.de>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230206222722.GC21823@wunner.de>
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



On 2/6/23 3:27 PM, Lukas Wunner wrote:
> On Mon, Feb 06, 2023 at 01:50:52PM -0700, Dave Jiang wrote:
>> Move the logic in current_link_speed_show() to a common function and export
>> that functiuon as pcie_get_speed() to allow other drivers to to retrieve
>> the current negotiated link speed.
> [...]
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6215,6 +6215,26 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL(pcie_get_width_cap);
>>   
>> +/**
>> + * pcie_get_speed - query for the PCI device's current link speed
>> + * @dev: PCI device to query
>> + *
>> + * Query the PCI device current link speed.
>> + */
>> +enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
>> +{
>> +	u16 linkstat, cls;
>> +	int err;
>> +
>> +	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
>> +	if (err)
>> +		return PCI_SPEED_UNKNOWN;
>> +
>> +	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, linkstat);
>> +	return pcie_link_speed[cls];
>> +}
>> +EXPORT_SYMBOL(pcie_get_speed);
> 
> It seems we're already caching the current speed in dev->bus->cur_bus_speed.
> Is that not sufficient?  If it isn't, that should be explained in the
> commit message.

I did not realize. That should work. Thanks. I'll drop patch.

> 
> Thanks,
> 
> Lukas
