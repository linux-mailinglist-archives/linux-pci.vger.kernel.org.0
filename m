Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC485B52C4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiILDFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiILDFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 23:05:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BDE193CB;
        Sun, 11 Sep 2022 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662951930; x=1694487930;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Vv/NFABKrupmGlwLBHHPWg5ZixXuw6qSJDDpj/HkRNg=;
  b=d6H5krnU1mEB/c0jNdh4y7yn+DmEn8VknOre8KzrJazoXiEr8/5FNmqq
   6w7BCKU4MQ7NTn+poBh1/9ePdct6R6AAAEpN2e4BvrWDxTnDRmm0wIGkt
   1GaUZwrNOwSIgbw7+LZS+YefoTq1dF4f0f5IMWrxeWUeucSDTCyRsPnJm
   5rLM6V5UPyoUL4zR+l06Q+V4PdXlqJYrvkOZLHtNRtufAGDlfqUAQXaAt
   GFJN1VZtYSqRvNh8/5UEH+XgLj15Z57kFnHYbF58nZ0dIlnpPJpD/BHTG
   nUwQt9yGHfdCFjPewlGIWtigUyZ3jX8eaHkzuybtxdbtP2QexqNmVqzNm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359499817"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="359499817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 20:05:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646281428"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.195]) ([10.254.208.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 20:05:25 -0700
Message-ID: <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
Date:   Mon, 12 Sep 2022 11:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 00/13] iommu: SVA and IOPF refactoring
In-Reply-To: <20220906124458.46461-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/6 20:44, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> existing IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with set/remove_dev_pasid ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested by Tony Zhu on Intel hardware
> and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
> efforts.
> 
> This series is also available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v13
> 
> Please review and suggest.

Hi Joerg,

Can you please help to look at this series. Is there anything to be
improved? Whose else "reviewed-by" would you like to see?

Best regards,
baolu
