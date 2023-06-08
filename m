Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5072756C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjFHDFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 23:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjFHDFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 23:05:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74B2115;
        Wed,  7 Jun 2023 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686193508; x=1717729508;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qbYHxqwb+lRQXv1Qno1Zzxd311Ixqqs8VMrd2MxUXcY=;
  b=N+O0SdhvQawpz3gDU2kR/zIMIxc/kwnsJLKqhXuAbIDKiGJW5OQl/8Cs
   /hzh1OA7HU3uxrmsC2c8XeiyRQ/pyBHYikPlb3w3G1qhCu9a9KYn9lhg0
   ajeo+DTOnxy8ZSgCpzWA89e/5KpTlqYTCaLh0RsjtGdtiOtENFNm7OzCO
   8uK+0X2IPX651zdfi5KKgbtt9a1pOqX/MYzyTjPCwB5tjmtNgQWaCDMxM
   YG+WFFJ23CSlVMo61YamXVqcS/m95H1iVVQynxu0ADgMMoZqscbW3kHac
   vJwzsI4mwXseEHz1FVnAkR24+2sKkIWC697jgduUEtsol3YMPKhIrYu9i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="341840949"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="341840949"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703909451"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703909451"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2023 20:05:06 -0700
Message-ID: <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
Date:   Thu, 8 Jun 2023 11:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/8/23 7:03 AM, Alexander Duyck wrote:
> On Wed, Jun 7, 2023 at 3:40 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>>
>> I am running into a DMA issue that appears to be a conflict between
>> ACS and IOMMU. As per the documentation I can find, the IOMMU is
>> supposed to create reserved regions for MSI and the memory window
>> behind the root port. However looking at reserved_regions I am not
>> seeing that. I only see the reservation for the MSI.
>>
>> So for example with an enabled NIC and iommu enabled w/o passthru I am seeing:
>> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
>> 0x00000000fee00000 0x00000000feefffff msi
>>
>> Shouldn't there also be a memory window for the region behind the root
>> port to prevent any possible peer-to-peer access?
> 
> Since the iommu portion of the email bounced I figured I would fix
> that and provide some additional info.
> 
> I added some instrumentation to the kernel to dump the resources found
> in iova_reserve_pci_windows. From what I can tell it is finding the
> correct resources for the Memory and Prefetchable regions behind the
> root port. It seems to be calling reserve_iova which is successfully
> allocating an iova to reserve the region.
> 
> However still no luck on why it isn't showing up in reserved_regions.

Perhaps I can ask the opposite question, why it should show up in
reserve_regions? Why does the iommu subsystem block any possible peer-
to-peer DMA access? Isn't that a decision of the device driver.

The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
which is not related to peer-to-peer accesses.

Best regards,
baolu
