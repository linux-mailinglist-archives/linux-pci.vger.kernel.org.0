Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168C5A5D3B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiH3Hpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiH3Hpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:45:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630362610E;
        Tue, 30 Aug 2022 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661845544; x=1693381544;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yi/c9wKZe1Xzm2RAJvy3wwK0+vYsU+x02Pu4wd0CR5k=;
  b=ldspFfeW5rQI0JdaopsTs9UeIzWp1butD1dgBdsYM1pqWNAv3KCAULqy
   SPM8OKiS8xd7fw98gRyp/dTaj3kaj0gNFaEDWmhKKRgS66xLfM8QzrfPG
   EClDw6tqNtOr2bWeC4J0r7zGWCOQTqlUq3ASY8afteSwhbEKszuBsOiKD
   P2Y3Qf3FjURMr3hVwRa8IMkqPD1GEMCjiZQxnjpcFzHpi1O0gaa7Wa9Ux
   +V4oJfkjxxnS34PYDxQgydASkThNdeL89lEo0nKYRLAvBSr6GcSP3ncH5
   W1DJbj2uMTFfvwgrRQoee+VMLy4Nze+rm3r9EXn9yQQxrgkQOTmlpX2A/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282080082"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282080082"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:45:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672737036"
Received: from hhuan14-mobl1.ccr.corp.intel.com (HELO [10.254.215.208]) ([10.254.215.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:45:37 -0700
Message-ID: <96ac1693-d87f-250d-c897-c79f13ed4c0a@linux.intel.com>
Date:   Tue, 30 Aug 2022 15:45:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 13/17] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Yuan Can <yuancan@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-14-baolu.lu@linux.intel.com>
 <47879368-fb4e-79aa-35f9-018d871f013c@huawei.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <47879368-fb4e-79aa-35f9-018d871f013c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/30 15:30, Yuan Can wrote:
> 
> 在 2022/8/26 20:11, Lu Baolu 写道:
>> The existing iommu SVA interfaces are implemented by calling the SVA
>> specific iommu ops provided by the IOMMU drivers. There's no need for
>> any SVA specific ops in iommu_ops vector anymore as we can achieve
>> this through the generic attach/detach_dev_pasid domain ops.
>>
>> This refactors the IOMMU SVA interfaces implementation by using the
>> iommu_detach/detach_device_pasid interfaces and align them with the
> 
> Did you mean using the iommu_attach/detach_device_pasid interfaces here?

The device driver oriented SVA interfaces keep consistent as before.
Here we only refactor the IOMMU internal implementation.

Best regards,
baolu
