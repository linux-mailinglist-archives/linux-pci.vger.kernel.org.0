Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017F5A1FB0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 06:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiHZESN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 00:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243720AbiHZESM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 00:18:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2EBFC61;
        Thu, 25 Aug 2022 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661487491; x=1693023491;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YsDHteRcq1xMbpE+Et5nCrI0+XEVYx8Ur9biKx/cQPU=;
  b=eGCetfeBSSnCGgngDaksi+RjHlSDpCrcbb/juav78rlQFRp04wDXvV0M
   bE7tKpTsUW7oF3RK3//O+HXqPCywRCmTRQkKMOuu6iNtNbI7pkF4k7+cW
   dqsL87wWXCPvnUUwP6fsSwzLd1Agahxx3bXAVDaoDFsTggT315aXfHiPn
   wRngBporDWxhLWEeOYxNJt1FK+/fcHCTrRXHUL01WH4bHt9LWpWFhTgmg
   L76BOZK3bCEZ17Q5oAD4FxbYl193nqBzsAuY3vF6CplMZHZWp2+g4jBBD
   ZFVR+rGZf7Dm4RNVIfRQushyMRvodqBG99dFThRMNaOgsRDfJRFm8MLUL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274171622"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="274171622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:17:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587156893"
Received: from xjing1-mobl1.ccr.corp.intel.com (HELO [10.254.211.48]) ([10.254.211.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:17:08 -0700
Message-ID: <c160bb06-5739-d1bb-f9a9-722a24e567c7@linux.intel.com>
Date:   Fri, 26 Aug 2022 12:17:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/13] iommu: SVA and IOPF refactoring
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/17 9:20, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> exsiting IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with a set_dev_pasid domain ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested on an x86 machine and compile
> tested for all architectures.
> 
> This series is also available on github:
> [2]https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v11
> 
> Please review and suggest.

Thank you all for review and test. I have updated this series and
uploaded a new version at

https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v12

Zhangfei and Tony have tested it on real Intel and arm64 hardware.

I will soon post it for further review.

Best regards,
baolu
