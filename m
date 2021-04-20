Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494F365B47
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDTOiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 10:38:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:47834 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231682AbhDTOiF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 10:38:05 -0400
IronPort-SDR: 9yxNDq7F2fK5lksTUkzFnUuqHOmHzkABswUAzZTlwOXIvRneGjvo0Wd8DdyETQEqM0WwjJvr8v
 SGso1lcbtmPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195630767"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195630767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:37:33 -0700
IronPort-SDR: WOahohYnePFwn7YJfMFaThS/W2tYoLkboNGRjY409sn0xa4wjpCsL1rwuIB8kq6sErXpiCGwQP
 x719Z0MFkTKA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="454810435"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:37:29 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 8B6202051E;
        Tue, 20 Apr 2021 17:37:27 +0300 (EEST)
Date:   Tue, 20 Apr 2021 17:37:27 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        bhelgaas@google.com, rajatja@google.com, grundler@chromium.org,
        tfiga@chromium.org, senozhatsky@chromium.org
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <20210420143727.GP3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
 <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 02:55:33PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> > On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> 
> ...
> 
> > > > This misses the changelog from v1 followed by the explanation why resent.
> > > > 
> > > I noticed there was a typo in the recipient list:
> > > stable.vger.kernel.org -> stable@vger.kernel.org
> > > 
> > > no code change for resent.
> > 
> > When you're submitting a patch and want it reach the stable kernels, you'll
> > need to add a Cc tag:
> > 
> > 	Cc: stable@vger.kernel.org
> > 
> > But not actually add the address to cc. I dropped stable@vger address from
> > distribution.
> 
> Does it really matter?

Usually aligning what you're doing with
Documentation/process/submitting-patches.rst is not a bad idea.

-- 
Sakari Ailus
