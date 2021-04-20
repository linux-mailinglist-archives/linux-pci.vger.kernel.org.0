Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B200365828
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDTL4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:56:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:13350 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDTL4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:56:12 -0400
IronPort-SDR: dRdlpRLYzIG0dl+HZObUHa4AGjD3m3I1G9McZc6MIWhVslg3lkTnnVpiGOXE6IjCXcHrrPr4KN
 M1d0e7h2zj/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="216080517"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="216080517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:55:40 -0700
IronPort-SDR: eqdJR0Z+KYTp2Lh8lgAxQf2fBxsMYAQFpBEefuDaRAiStsxvTQ/V2n2z2nowR9PKUs6BTiDxQL
 f9ebH8EDBH4w==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="534466127"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:55:37 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYoyb-005jR3-Rr; Tue, 20 Apr 2021 14:55:33 +0300
Date:   Tue, 20 Apr 2021 14:55:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        bhelgaas@google.com, rajatja@google.com, grundler@chromium.org,
        tfiga@chromium.org, senozhatsky@chromium.org
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420105640.GI3@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:

...

> > > This misses the changelog from v1 followed by the explanation why resent.
> > > 
> > I noticed there was a typo in the recipient list:
> > stable.vger.kernel.org -> stable@vger.kernel.org
> > 
> > no code change for resent.
> 
> When you're submitting a patch and want it reach the stable kernels, you'll
> need to add a Cc tag:
> 
> 	Cc: stable@vger.kernel.org
> 
> But not actually add the address to cc. I dropped stable@vger address from
> distribution.

Does it really matter?

-- 
With Best Regards,
Andy Shevchenko


