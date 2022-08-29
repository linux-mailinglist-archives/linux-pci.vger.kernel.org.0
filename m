Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB55A4188
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 05:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiH2Dkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 23:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Dke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 23:40:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DC525E83;
        Sun, 28 Aug 2022 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661744434; x=1693280434;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oya5Hnsy4mm0/87tApeZ1XDEJ4Ant4xomrwmja1Ayxw=;
  b=BaiPprdCwpJzSQwrPMkVoX57Ja0QkwdvBAksmUSaWqz6VdoiMImfWt3i
   7p90/j6Gf/qZRWqdjTuD0yRPuCCp2BBrMlSBAKRkWC5PgzY3PYmi8KWiK
   b8kDZWwJGqAlR8eZ2TgiFTU+5S4+4jowKFzCR7hF3WgAU2uKgSzwT0N2H
   MkrXYEPom2YQEj2/tdiBY5kL9bKlpOmVhMpariNdy7KszouK3ciy15Jdv
   AdNFJ4xLZIQg28ERtgbqa9PLCr9MO+sSQYVlXMHc7yK/QzL9RDy7aokJX
   6x+np27kQb7l6Dp/OZ9io2m+n8grCQn4TZgCv2EUSkIAUd96K2+uqbCXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="274549902"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="274549902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:40:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644276121"
Received: from lizhipe2-mobl.ccr.corp.intel.com (HELO [10.254.210.26]) ([10.254.210.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:40:26 -0700
Message-ID: <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
Date:   Mon, 29 Aug 2022 11:40:24 +0800
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
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjeL2SVmdRpoWb6@nvidia.com>
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

On 2022/8/26 22:52, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
>> Allocate the blocking domain when probing devices if the driver supports
>> blocking domain allocation. Otherwise, revert to the previous behavior,
>> that is, use UNMANAGED domain instead when the blocking domain is needed.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>> Tested-by: Tony Zhu<tony.zhu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
> This seems like a lot of overhead to allocate these things for every
> group?
> 
> Why not add a simple refcount on the blocking domain instead and
> allocate the domain on the pasid attach like we do for ownership?

I am working towards implementing static instance of blocking domain for
each IOMMU driver, and then, there's no much overhead to allocate it in
the probing device path.

Best regards,
baolu
