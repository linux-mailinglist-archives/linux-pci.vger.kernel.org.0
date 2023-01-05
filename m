Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727765E948
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjAEKt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 05:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjAEKtR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 05:49:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09152757;
        Thu,  5 Jan 2023 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672915755; x=1704451755;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hYw5mt3Ho/5cEDP9Y30N0YmdDHdyUr2/axWszivFQR4=;
  b=GbuLLxUYR7Qg1dYaKXdx2fWq97nqUG+M4wuYmKyRaV3yc1R/m7jzuIzD
   RH5kb2mwH9fH9W1dCT06s6oO5zXJN8iTMW2YB1RrnbFN3uIgGzP0SJVAM
   oNazwBveE5ccWRgZNDsIMkPXaiT5bO3XHe7DYUxelNrmoIIkgiOQDWbjR
   MHlh7BQKSeoIjrHGlFOWzHTmjx21oLvVUSjIeeIkhVEMScAdDQDQ4zhIr
   DFuqdj6W5AuMU9GAMo8GZncvkZV6mEQ22dBBn7c5p+0nvaiLVX58daJAF
   yOBuU9Bur6jnOyZtJsSuCMJLpV37YIq3gBv1ETyQ5mSbTUd5SRSgwMcbS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320882571"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="320882571"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:49:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655527744"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="655527744"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:49:12 -0800
Message-ID: <d9d8fba9-a53a-11ea-9b28-ee5695da48eb@linux.intel.com>
Date:   Thu, 5 Jan 2023 18:49:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, senozhatsky@chromium.org,
        bingbu.cao@linux.intel.com, sangram.k.y@intel.com
Content-Language: en-US
To:     bingbu.cao@intel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux.dev
References: <20230105082857.4180299-1-bingbu.cao@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RESEND PATCH v3] iommu/vt-d: Use passthrough mode for the Intel
 IPUs
In-Reply-To: <20230105082857.4180299-1-bingbu.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/5 16:28, bingbu.cao@intel.com wrote:
> Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
> The IPU driver allocates its own page table that is not mapped
> via the DMA, and thus the Intel IOMMU driver blocks access giving
> this error:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
>        fault addr 76406000 [fault reason 06] PTE Read access is not set

Do you mind telling why does such DMA fault occur? How does the IPU
driver map the fault address 76406000 ?

> As IPU is not an external facing device which is not risky, so use
> IOMMU passthrough mode for Intel IPUs.

You can also set the passthrough mode with kernel option iommu=pt
(globally) or by writing IDENTITY to

/sys/..path_to_device../iommu_group/type

(per-device).

> Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")

Please don't try to fix any problem in the device driver by adding any
hard-coded quirky code in the IOMMU code.

> Signed-off-by: Bingbu Cao<bingbu.cao@intel.com>

--
Best regards,
baolu
