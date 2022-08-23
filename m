Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF659D1C6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiHWHKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbiHWHKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 03:10:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7961D44;
        Tue, 23 Aug 2022 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661238613; x=1692774613;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s3CaB7J/QzCxWJHKyGoSrb3mqar/OfGRLx0AuZA3drA=;
  b=eic8Vc52VkulvsAwGWVaZ28U+cMIc0BXnJBNpGVPkFoNVOZ1Yp6hoIcV
   DPiPn5e34QBQgSKxJQ/PmqtVFVhFqpZXg5jlHgrjCnOk4ERbkawzI+B7N
   KBWhO5Ymb4bgmPPQu/odnyAU/922S48LknBKbcZPOf9x61iQ3+g8sYT4/
   Dlbv822FELN1WaBkVIGTIXksJUuz61TsG8C7I5yD3EQLOegVU1KAeFJsE
   gkZYdi7ylWFnnzs3V6aj2MtTNrTrmRVUHW9urEJ4qSKNZVG23wbzn0L3p
   aNTbPtCI6UVawG/ghH68kPEv4cyoxkERTY2z24Iux4XYvEPkgYT2LxCwt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292352744"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="292352744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:10:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642337729"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:10:02 -0700
Message-ID: <2ac74c62-1e2a-3758-6da8-a59f452e7799@linux.intel.com>
Date:   Tue, 23 Aug 2022 15:10:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-5-baolu.lu@linux.intel.com>
 <Yv440MU1UeD9u67g@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv440MU1UeD9u67g@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/18 21:04, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
>> Some configurations of the PCI fabric will route device originated TLP
>> packets based on the memory addresses. These configurations are
>> incompatible with PASID as the PASID packets form a distinct address
>> space. For instance, any configuration where switches are present
>> without ACS enabled is incompatible.
>>
>> This enhances the pci_enable_pasid() interface by requiring the ACS to
>> support Source Validation, Request Redirection, Completer Redirection,
>> and Upstream Forwarding. This effectively means that devices cannot
>> spoof their requester ID, requests and completions cannot be redirected,
>> and all transactions are forwarded upstream, even as it passes through a
>> bridge where the target device is downstream.
>>
>> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
>> Suggested-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/pci/ats.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index c967ad6e2626..0715e48e7973 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -382,6 +382,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>>   	if (!pasid)
>>   		return -EINVAL;
>>   
>> +	if (!pci_acs_path_enabled(pdev, NULL,
>> +				  PCI_ACS_SV | PCI_ACS_RR |
>> +				  PCI_ACS_CR | PCI_ACS_UF))
> I think we only need RR and UF here?
> 
> Source Validation causes the switch to validate the requestor RID in
> each TLP which has nothing to do with address based routing
> 
> Completion Redirect changes how RID routing works, and has nothing to
> do with address based routing.
> 
> Yes, both of those are usually set for virtualization scenarios but we
> shouldn't check it here as a basic requirement to enable PASID.

Yes. Here only requires RR and UF.

Best regards,
baolu
