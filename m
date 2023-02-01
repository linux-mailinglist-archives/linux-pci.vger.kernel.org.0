Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549AC685FBE
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 07:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBAGb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 01:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 01:31:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9FE521FA;
        Tue, 31 Jan 2023 22:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675233084; x=1706769084;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lYiilF9w4hh4QaB7nPR19tby+N0vKxSAPNw6Txy0jvM=;
  b=cBDzy8g3wnq+qekizwQRMfHkj1gtkXSoopXrekv8va0lp94zPWZl9tcL
   leKWqsmojKwJTgtt20k3JChhJkEPBzm+ahjgDBnyha9kXXPuBjJrXcVZB
   9nW0MFhzQte/iwgl1uBhMHGH60H6W7nOaE2wyHnwiBKBsZXROwIr22Rzf
   0p+Ue0O+HIOWxs5rAd/XHFFxYsPl3uFWbqUPjsUTTg585zcFdTkR683wY
   c8C7BB1g0o5a0W3NYnZY58GegC/cP3zYO+gtzEGL8Ll2XBW5tHV5szTQz
   XaRuuBGHU527CydrQBj/Mfz2cDLWN6InzeU4BJQvSy8toZF+3N2VIKW8a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329355152"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="329355152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:31:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773322656"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="773322656"
Received: from xduan-mobl1.ccr.corp.intel.com (HELO [10.254.215.167]) ([10.254.215.167])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:31:06 -0800
Message-ID: <9c34747e-453f-8344-e7f2-cc24669160ec@linux.intel.com>
Date:   Wed, 1 Feb 2023 14:31:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230201001419.GA1776086@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/2/1 8:14, Bjorn Helgaas wrote:
>>>> The AMD iommu driver allocates a new domain (called v2 domain) for the
>>> "v2 domain" needs to be something greppable -- an identifier,
>>> filename, etc.
>> The code reads,
>>
>> 2052         if (iommu_feature(iommu, FEATURE_GT) &&
>> 2053             iommu_feature(iommu, FEATURE_PPR)) {
>> 2054                 iommu->is_iommu_v2   = true;
>>
>> So, how about
>>
>> ..The AMD GPU has a private interface to its own AMD IOMMU, which could
>> be detected by the FEATURE_GT && FEATURE_PPR features. The AMD iommu
>> driver allocates a special domain for the GPU device ..
> Where is this special domain allocated?  I think the above tests for
> *IOMMU*  features (I assume "GTSup: Guest translations supported" and
> "PPRSup: Peripheral page request support" based on the AMD IOMMU
> spec).  It doesn't test that this is a GPU.

 From the discussion, my understanding is that the IOMMU is a GPU
dedicated IOMMU. The translated-request-only feature is enumerated
through the IOMMU feature bits. However, I am not familiar with AMD
architecture. AMD guys may have a better explanation.

> This change doesn't feel safe for all possible devices that have a
> PASID Capability because we don't know whether they*always*  use
> Translated addresses with PASID TLPs.

I tend to think you are right. :-)

Best regards,
baolu
