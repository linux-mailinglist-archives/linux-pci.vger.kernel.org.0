Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D8666D5C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjALJE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 04:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjALJDm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 04:03:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F511C930
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513982; x=1705049982;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=em3zjcoJ2yMKD9zMycIPjA5fXYvghS+gN1F8Nxr1ROg=;
  b=fvfwY/1ChFMwagYwnlIZmdlrnSd6FQpHLD0LoWg1M2Z72IFeEe74iC4D
   OLylqeU8YXQV5yS9h7eEBaS7KbpoW5Z6pCfRNfw0NJkTCgHOIFxwtqYtb
   vDnHK5mmVECj8DcP8wSN7x24beDOiHb+OnUItL49nq19StG9T3f7l31B3
   7hVgmfEkbdXmPqe23lzdcFlzx7oXDcCEgWPJxCF0yFgQgyOmke9RewoyQ
   WBvCZ+HHxfjgFQIj7k2xaHf1sXOqKh0NdJfCEqk4bwP380uIslNyoYx5p
   vm9oJXBcUxuI/18LaiirjRbDNv6ZIy7/FaS+md6SJugloKT2etlpUHxQa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303351192"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303351192"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:59:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659706242"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659706242"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.188.101]) ([10.252.188.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:59:39 -0800
Message-ID: <0bd23c6b-c182-89ef-497b-40a7bd665812@linux.intel.com>
Date:   Thu, 12 Jan 2023 16:59:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com> <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
 <Y77ETB282pVL9/x6@nvidia.com> <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/11 22:17, Christian König wrote:
> Am 11.01.23 um 15:14 schrieb Jason Gunthorpe:
>> On Wed, Jan 11, 2023 at 09:54:03PM +0800, Baolu Lu wrote:
>>> On 2023/1/11 21:44, Jason Gunthorpe wrote:
>>>>> iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
>>>>> handling for ATS, so here we could check the info->ats_supported 
>>>>> flag if ACS
>>>>> needs to be checked or not.
>>>> *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
>>>> drivers instead of in the device drivers to declare they want to use
>>>> PASID?
>>> Currently it's common to enable pasid in the IOMMU drivers, but device
>>> driver has more knowledge of the device, hence it makes more sense to
>>> move pci_enable_pasid() to the device driver.
>> So, lets fix it that way.
>>
>> Add the flag to the pci_enable_pasid(), set the flag in the AMD
>> IOMMU's special AMD GPU only path assuming the device will always use
>> ATS
> 
> That will fix at least this the AMD use case.

I've post a patch for discussion.

https://lore.kernel.org/linux-iommu/20230112084629.737653-1-baolu.lu@linux.intel.com/

--
Best regards,
baolu
