Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364EA7392C9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjFUXCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUXCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 19:02:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CE1981
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687388538; x=1718924538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C/tAdtPH8/FfpGCzsRCGmO+KPnY+oJzm0w5UzTCHRPU=;
  b=fEZQ6hsg6/UA+wlsnySKzs6z1mM/UxhINYZ0KnKNWyNelZ8wRE6b2N6h
   1SHIY4q6/B1fjMX59/QkmoRS4kH18getNcgUVJcZRN3rmWhfyXth7rvID
   Kd6KmTOR5dgecjKndQuATERTxQfpjeb5piuqfMvEHa9bXJhlV/y8pI8Ou
   ACrr6ySKq9tgf1TgDp901zlYym/RW6fzzyMLYDqlcpJtekKzF2o4SxKl7
   2nh+/mRxbYEUJF4OmO468hMAqspsiHiWtz7EOoBCUr7FtFV1MDWEwBi5i
   GStBj9MA31CWquni8Ow0xQJyImH0vnVE1zO6Nopd7ZmxSBgdHYXvrZA7b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426288959"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="426288959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 16:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="708879767"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="708879767"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.163]) ([10.78.16.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 16:02:17 -0700
Message-ID: <acd6c41c-62dd-84e4-6ac5-3537b7d323da@linux.intel.com>
Date:   Wed, 21 Jun 2023 16:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI: vmd: Fix domain reset operation
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230620180745.GA52323@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230620180745.GA52323@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/20/2023 11:07 AM, Bjorn Helgaas wrote:
> On Tue, May 30, 2023 at 02:47:06PM -0700, Nirmal Patel wrote:
>> During domain reset process we are accidentally enabling
>> the prefetchable memory by writing 0x0 to Prefetchable Memory
>> Base and Prefetchable Memory Limit registers. As a result certain
>> platforms failed to boot up.
>>
>> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>>
>>   The Prefetchable Memory Limit register must be programmed to a smaller
>>   value than the Prefetchable Memory Base register if there is no
>>   prefetchable memory on the secondary side of the bridge.
>>
>> When clearing Prefetchable Memory Base, Prefetchable Memory
>> Limit and Prefetchable Base Upper 32 bits, the prefetchable
>> memory range becomes 0x0-0x575000fffff. As a result the
>> prefetchable memory is enabled accidentally.
>>
>> Implementing correct operation by writing a value to Prefetchable
>> Base Memory larger than the value of Prefetchable Memory Limit.
> Oh, I forgot: better to use imperative mood here instead of present
> participle ("-ing" form), e.g., "Write ... so that ..."
>
> This should probably use the same form as pci_disable_bridge_window(),
> since I think it's doing the same thing.

I will make the adjustment.

>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 769eedeb8802..f3eb740e3028 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -526,8 +526,18 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>>  				     PCI_CLASS_BRIDGE_PCI))
>>  					continue;
>>  
>> -				memset_io(base + PCI_IO_BASE, 0,
>> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>> +				writel(0, base + PCI_IO_BASE);
>> +				writew(0xFFF0, base + PCI_MEMORY_BASE);
>> +				writew(0, base + PCI_MEMORY_LIMIT);
>> +
>> +				writew(0xFFF1, base + PCI_PREF_MEMORY_BASE);
>> +				writew(0, base + PCI_PREF_MEMORY_LIMIT);
>> +
>> +				writel(0xFFFFFFFF, base + PCI_PREF_BASE_UPPER32);
>> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
>> +
>> +				writel(0, base + PCI_IO_BASE_UPPER16);
>> +				writeb(0, base + PCI_CAPABILITY_LIST);
>>  			}
>>  		}
>>  	}
>> -- 
>> 2.27.0
>>

