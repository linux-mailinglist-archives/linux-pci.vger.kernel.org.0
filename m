Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F164365C2D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhDTP2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 11:28:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:30872 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhDTP2U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 11:28:20 -0400
IronPort-SDR: MwUZeYHe1wa7nl2Ov9OeYwHARsGqyQTKtgoyfa+gZhzsQ6QYqNEZRw9XHWme6yZeS/YYPkSvR6
 GEwUlyWmj34A==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="216119977"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="216119977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:27:48 -0700
IronPort-SDR: VE0ZHW+dE8/dljSH/NnQfcj4YuIYvbQFSObNTUMZ6j7UyMlkLb1E559cOwR/VObfTIZVdIZ5L8
 af44Y8czr+aA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="523848457"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:27:45 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5BA292051E;
        Tue, 20 Apr 2021 18:27:43 +0300 (EEST)
Date:   Tue, 20 Apr 2021 18:27:43 +0300
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
Message-ID: <20210420152743.GQ3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
 <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
 <20210420143727.GP3@paasikivi.fi.intel.com>
 <YH7rQbDzQAlY5Z7R@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7rQbDzQAlY5Z7R@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 05:54:57PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 05:37:27PM +0300, Sakari Ailus wrote:
> > On Tue, Apr 20, 2021 at 02:55:33PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> > > > On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > > > > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > > > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> > > 
> > > ...
> > > 
> > > > > > This misses the changelog from v1 followed by the explanation why resent.
> > > > > > 
> > > > > I noticed there was a typo in the recipient list:
> > > > > stable.vger.kernel.org -> stable@vger.kernel.org
> > > > > 
> > > > > no code change for resent.
> > > > 
> > > > When you're submitting a patch and want it reach the stable kernels, you'll
> > > > need to add a Cc tag:
> > > > 
> > > > 	Cc: stable@vger.kernel.org
> > > > 
> > > > But not actually add the address to cc. I dropped stable@vger address from
> > > > distribution.
> > > 
> > > Does it really matter?
> > 
> > Usually aligning what you're doing with
> > Documentation/process/submitting-patches.rst is not a bad idea.
> 
> True, my point is that technically both ways will give the same result, no?

If you get your patch merged this way, then yes. :-)

-- 
Sakari Ailus
