Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D025E7B71
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIWNIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiIWNI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:08:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA413B017;
        Fri, 23 Sep 2022 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663938492; x=1695474492;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=+jRBBhYHBopY23l9bBAFyyx9K8uw3Z3+aT+0POwRhTE=;
  b=bUbkzXxolELageeye4r60lTpETyBcmLOlrEFN3gyhShsLBnW/Nohn/ub
   cO39Jxbh5DO605QAnUz32f0A0877B57oXr4shIrTUbnIgxAWUNc+9i9u9
   YWgjo57TdmJRe8h3l70AqXmwgFyNLgtApbqJM/sBjPeANFBsHwKrHYaAM
   jUc98eOma9Ik0qxXVeG2x445f2QKQbY6fkcc1Db1gqmZIEAoW1af0PqVo
   RB5ULoxKGfu9b39lYiCB+9ShNjb+fyrcmMh0ySMEaw/S67QrXlAN67bIV
   4GRdujJpWcpopFV32dMy3EYd++15CGd+jwsU1ta/1mNgsQx6LGoq+BRGe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="287703155"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="287703155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724121402"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:08:06 -0700
Message-ID: <9fc74da5-7bee-affe-c603-860d23b5f02f@linux.intel.com>
Date:   Fri, 23 Sep 2022 21:08:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
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
 <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 00/13] iommu: SVA and IOPF refactoring
In-Reply-To: <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/12 11:05, Baolu Lu wrote:
> On 2022/9/6 20:44, Lu Baolu wrote:
>> Hi folks,
>>
>> The former part of this series introduces the IOMMU interfaces to attach
>> or detach an iommu domain to/from a pasid of a device, and refactors the
>> existing IOMMU SVA implementation by assigning an SVA type of iommu
>> domain to a shared virtual address and replacing sva_bind/unbind iommu
>> ops with set/remove_dev_pasid ops.
>>
>> The latter part changes the existing I/O page fault handling framework
>> from only serving SVA to a generic one. Any driver or component could
>> handle the I/O page faults for its domain in its own way by installing
>> an I/O page fault handler.
>>
>> This series has been functionally tested by Tony Zhu on Intel hardware
>> and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
>> efforts.
>>
>> This series is also available on github:
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v13
>>
>> Please review and suggest.
> 
> Hi Joerg,
> 
> Can you please help to look at this series. Is there anything to be
> improved? Whose else "reviewed-by" would you like to see?

It seems that Jean/Kevin/Jason/Yi are satisfied with this series now. I
will post a new version and check whether we are lucky to have it in
v6.1.

Best regards,
baolu
