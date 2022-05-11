Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03230523AFB
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbiEKQ53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiEKQ50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 12:57:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58646677
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652288244; x=1683824244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+NWnGNJYf46SVOU0nzamlDIEmiOV9qFuWzzou7Mhbf0=;
  b=Mw8VK4oyQB9vou7eZWkj8hGbVkRU/+7WgEoZ0nZWFm4X97efYl1e9qxM
   Hxz/x7NCwWuRZRePsSvffCpToU5zeuUS2wzAKAcjrZBMLWLRjQ7eEwz5H
   DXoP/ZSQSEy+1Nf35EGnRA82mq0ja/ZLI9fGGfzCQiPmdIUrRrxk2YKm5
   1LDJnCQlJvcJbV8DJHeq79eF4f09gTv1cdXscNUGuv8AFBUXqHd7vVlz0
   4o49JkXPcNlYmsiH+oLOj8rHpNyCXB6Iot9itl8nAzjk+i2IM3qnaFHrd
   wQ1PWLGroqlEr6IgqZeTXcpB7P7XCGe8knGXhml/hCeNDXkiCXiBVt6TK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267341196"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="267341196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:57:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="624033752"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.49.34]) ([10.212.49.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:57:20 -0700
Message-ID: <fccd0dc4-fe00-6f34-0fd3-3cedcbcb8ca3@linux.intel.com>
Date:   Wed, 11 May 2022 09:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, maz@kernel.org
References: <20220502084900.7903-1-nirmal.patel@linux.intel.com>
 <20220502084900.7903-2-nirmal.patel@linux.intel.com>
 <Ynt9jJU78JnIiZ7z@lpieralisi>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <Ynt9jJU78JnIiZ7z@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/11/2022 2:10 AM, Lorenzo Pieralisi wrote:
> [Adding Marc, to keep an eye on IRQ domain usage]
>
> On Mon, May 02, 2022 at 01:48:59AM -0700, Nirmal Patel wrote:
>> VMD creates and assigns a separate IRQ domain when MSI-X remapping is
>> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
>> MSI-X remapping is disabled resulting child devices getting default
>> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
>> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
>> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
>> when VMD create a root bus and configures child devices.
> I would encourage you to rewrite this log, it is unclear - granted,
> I don't know intel-iommu internals - but IMHO if you explain the
> issue and the fix thoroughly this could avoid repeating what
> you have to do in patch(2).
>
> Please describe how VMD handles IRQ domains and how you are fixing
> that.
>
> Thanks,
> Lorenzo
I will add more information to the commit logs.

Thanks,
nirmal

>> As a result DMAR errors were observed when interrupt remapping was
>> enabled on Intel Icelake CPUs. For instance:
>>
>>   DMAR: DRHD: handling fault status reg 2
>>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index eb05cceab964..5015adc04d19 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -853,6 +853,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  	vmd_attach_resources(vmd);
>>  	if (vmd->irq_domain)
>>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>> +	else
>> +		dev_set_msi_domain(&vmd->bus->dev,
>> +				   dev_get_msi_domain(&vmd->dev->dev));
>>  
>>  	vmd_acpi_begin();
>>  
>> -- 
>> 2.26.2
>>

