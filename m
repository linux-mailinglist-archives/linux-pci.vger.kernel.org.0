Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF45A5D45
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiH3HrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiH3HrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:47:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB348A221B;
        Tue, 30 Aug 2022 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661845621; x=1693381621;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yBpwSdK8tn25JNz7gtB+fP1W3XIksw4isildm6byryI=;
  b=NCIg/jkQxO9UYBsmJB2Bpgtl9cmvfIMpIfbGQMukHRbLJqOm+OTkP6/M
   Mz0/xS0T+a9tXev2Xyb8mQRSjvhdo2uUjLJ92gqzKyTXGLeNYmDKuT356
   mRpad+LjSnmZW2uHRLrMHsIiAWgBRO8e9ZULpYMJfoNa6uJOUIzM36Nri
   4cBanOMZGYynpLxPASA9q38qeVrUFwFNMSNVEsRFOnUGE2VlY2RMZrm1H
   yiq1W5AJfJmApLPb3jDSkBK5IQ6AZVEHCXfWUTjolDIHBiPbJVWflM0eN
   VqCM4uJR51SOq+NGRn/ThMpNprO91ldw2WD/PS6AKrAGtHAiJNHd2w1ps
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="274857938"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="274857938"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672737784"
Received: from hhuan14-mobl1.ccr.corp.intel.com (HELO [10.254.215.208]) ([10.254.215.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:46:56 -0700
Message-ID: <d8741636-ea2e-4c5f-4dc1-9a5dec4dafa1@linux.intel.com>
Date:   Tue, 30 Aug 2022 15:46:55 +0800
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
 <96ac1693-d87f-250d-c897-c79f13ed4c0a@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <96ac1693-d87f-250d-c897-c79f13ed4c0a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/30 15:45, Baolu Lu wrote:
> On 2022/8/30 15:30, Yuan Can wrote:
>>
>> 在 2022/8/26 20:11, Lu Baolu 写道:
>>> The existing iommu SVA interfaces are implemented by calling the SVA
>>> specific iommu ops provided by the IOMMU drivers. There's no need for
>>> any SVA specific ops in iommu_ops vector anymore as we can achieve
>>> this through the generic attach/detach_dev_pasid domain ops.
>>>
>>> This refactors the IOMMU SVA interfaces implementation by using the
>>> iommu_detach/detach_device_pasid interfaces and align them with the
>>
>> Did you mean using the iommu_attach/detach_device_pasid interfaces here?
> 
> The device driver oriented SVA interfaces keep consistent as before.
> Here we only refactor the IOMMU internal implementation.

Oh! A typo in the commit message, right? Thanks and I will fix it.

Best regards,
baolu
