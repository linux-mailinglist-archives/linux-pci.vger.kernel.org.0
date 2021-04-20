Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D26365700
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhDTLCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:02:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:36275 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230290AbhDTLCm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:02:42 -0400
IronPort-SDR: 2EVMTZrDV0uNWNJxSa6hAgYuqHyo7uuazqskb234BCzm2xjRU2FGRE3UsTNtjsXDes1TXLKjk4
 5Hm4lLjgKteQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="175593013"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="175593013"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:02:10 -0700
IronPort-SDR: N9iqe5rW/vWlxZk0379oiq5CffC1Hbl+wY8nYTO3bqO3IjZx+G2xwnfFGXI0c4Jmv7UrdqGyQo
 SpkKMgYJjIOw==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="390958865"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:02:06 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B2A7922C62;
        Tue, 20 Apr 2021 13:56:40 +0300 (EEST)
Date:   Tue, 20 Apr 2021 13:56:40 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        bhelgaas@google.com, rajatja@google.com, grundler@chromium.org,
        tfiga@chromium.org, senozhatsky@chromium.org
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <20210420105640.GI3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bingbu,

On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> Andy,
> 
> On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> >> Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
> >> The IPU driver allocates its own page table that is not mapped
> >> via the DMA, and thus the Intel IOMMU driver blocks access giving
> >> this error:
> >>
> >> DMAR: DRHD: handling fault status reg 3
> >> DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
> >>       fault addr 76406000 [fault reason 06] PTE Read access is not set
> >>
> >> As IPU is not an external facing device which is not risky, so use
> >> IOMMU passthrough mode for Intel IPUs.
> >>
> >> Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
> >> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> >> ---
> >>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
> > 
> > This misses the changelog from v1 followed by the explanation why resent.
> > 
> I noticed there was a typo in the recipient list:
> stable.vger.kernel.org -> stable@vger.kernel.org
> 
> no code change for resent.

When you're submitting a patch and want it reach the stable kernels, you'll
need to add a Cc tag:

	Cc: stable@vger.kernel.org

But not actually add the address to cc. I dropped stable@vger address from
distribution.

Please change this for v3.

-- 
Kind regards,

Sakari Ailus
