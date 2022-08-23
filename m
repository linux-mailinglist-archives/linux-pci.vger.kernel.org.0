Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC959D1A9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbiHWHAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiHWHAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 03:00:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1EE4F68F;
        Tue, 23 Aug 2022 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661238021; x=1692774021;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pRFh70csbv3DLerPP6J9R5ttFXh/875KrSZevCmVDcE=;
  b=Rlxe8yZt5cMXccUsJnVkBlBBGX/1oic6GAxVfyojb4B15nxOdRNapK0H
   YcV7u5mr9wTQbkyHav3RbUa5KGYgel0afGhh1NhuadOQJtRJrUVenEIOm
   VVggL7xfC9yC1q9aRIk2kMVr41iIabGWG3yI3lKtLUBTRj4eotwDPyqbA
   /buJDUHCSUBaiRWKTVe56F66JYv+G1NSVBBlwQmFIKOSbQThTATRqAZpd
   aZW3TQrV//fUivwO4ZWWJ98S1o8Pw08tkS+cglXa6egiDFnyyDEpATU4u
   ucwXEPYk3tv10N+GGrElsbKmKIeL5vqoiQ0A89gd8QeE37ULDRu1W698I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379899105"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="379899105"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:00:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642334890"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:00:16 -0700
Message-ID: <81f0e556-d002-dfc1-cc7d-e8b3e51c6884@linux.intel.com>
Date:   Tue, 23 Aug 2022 15:00:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/13] iommu: SVA and IOPF refactoring
Content-Language: en-US
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <890a99fe-1e9b-85bd-e4bc-b746ae17b827@linaro.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <890a99fe-1e9b-85bd-e4bc-b746ae17b827@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/22 12:49, Zhangfei Gao wrote:
> On 2022/8/17 上午9:20, Lu Baolu wrote:
>> Hi folks,
>>
>> The former part of this series introduces the IOMMU interfaces to attach
>> or detach an iommu domain to/from a pasid of a device, and refactors the
>> exsiting IOMMU SVA implementation by assigning an SVA type of iommu
>> domain to a shared virtual address and replacing sva_bind/unbind iommu
>> ops with a set_dev_pasid domain ops.
>>
>> The latter part changes the existing I/O page fault handling framework
>> from only serving SVA to a generic one. Any driver or component could
>> handle the I/O page faults for its domain in its own way by installing
>> an I/O page fault handler.
>>
>> This series has been functionally tested on an x86 machine and compile
>> tested for all architectures.
>>
>> This series is also available on github:
>> [2] 
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v11
>>
>> Please review and suggest.
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> On arm64 (Kunpeng920) with uacce.

Thank you very much!

Best regards,
baolu
