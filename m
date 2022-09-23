Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2109D5E7B92
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiIWNOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiIWNNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:13:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D513EAD0;
        Fri, 23 Sep 2022 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663938827; x=1695474827;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X+p5MF00JMc7VDvFne6EpeMaGyGhX0RXnAUIQvwk4cs=;
  b=fUcSIEx+zfqMEhTkgd+Pkn3R03/lf8pQyW7OXrtJPCzgOusAZ9p+wbj8
   b4PyjPiQneDlJpU6O0vEsKZpxOrhqZftslu4Yxhl9aQ1vZai8V2AWs6YT
   CprG8hkHNxfkbUJhlc4M2QpYciQ9vhX9OJkeSXZf7jR4gc7i4pG4fdatM
   +RwO2bzmWrwtashcTXPGB72i8w9VjlNjIwI9/TE76EnSGjli/Pu1ZX2JA
   hXRiGE4lf9MtHthSpFnRp/RWacxsAB0au24WpRhzAk6fXc554qhKU5pIv
   Rex7B7uYSLlsqxDhm7PnNKRf47CkOAIZg09EWyXgBVq1F91pOzgKx1Bbi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="298186802"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298186802"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:12:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724122153"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:12:33 -0700
Message-ID: <ef381875-80eb-6b85-2d4b-f5d8b8036618@linux.intel.com>
Date:   Fri, 23 Sep 2022 21:12:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
 <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
 <Yy2jbsaXuoxgR+fj@nvidia.com>
 <a0b43338-183b-3ece-c85a-e904bee27eef@linux.intel.com>
 <Yy2viUjvZsW6gx9/@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yy2viUjvZsW6gx9/@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/23 21:07, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 08:41:56PM +0800, Baolu Lu wrote:
>> On 2022/9/23 20:15, Jason Gunthorpe wrote:
>>> On Fri, Sep 23, 2022 at 10:21:51AM +0800, Baolu Lu wrote:
>>>
>>>> At the beginning of this project, I wanted to consolidate the mm
>>>> notifications into the core. However, ARM SMMUv3 and Intel handle the mm
>>>> notifications a little differently. Then I decided to do this work
>>>> separately from the current series.
>>> It doesn't look really different..
>> They are essentially the same, but slightly different. For example, arm
>> smmuv3 provides .free_notifier, and I don't think it could be merged to
>> the release callback.
> free_notifier allows to use mmu_notifier_put() instead of
> mmu_notifier_unregister() which avoids a synchronize_rcu() penalty on
> teardown. Intel should copy the same design.

Ah! Thanks for the guide. I will head in this direction.

Best regards,
baolu
