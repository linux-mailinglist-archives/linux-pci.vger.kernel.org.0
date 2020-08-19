Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A705824A51B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHSRmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 13:42:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:64742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgHSRl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 13:41:59 -0400
IronPort-SDR: 9GePG7TSx19MVHI3q5n9VMrar3WGx+855WPW8fTQBhKkVDMgJzZ5PDcaP3qBOQVPj1GVy8jkOk
 zDQrE7Mbhpvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152775787"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="152775787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:41:58 -0700
IronPort-SDR: /Gw14F3T8MavSsw3w+CZqaHM4PiaxwU3a5v7JUXi420k8E2r9jXx2lHUbjBfc2ZPH65C/BQLuH
 iWMvySpupPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="327159666"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 10:41:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k8S3s-009w8o-L8; Wed, 19 Aug 2020 20:39:44 +0300
Date:   Wed, 19 Aug 2020 20:39:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/3] swiotlb: Use %pa to print phys_addr_t variables
Message-ID: <20200819173944.GR1891694@smile.fi.intel.com>
References: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5B9FGqSsnQcw1hhyOQnvkgxXK_xAkvNbjdtNuH+5V8kBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5B9FGqSsnQcw1hhyOQnvkgxXK_xAkvNbjdtNuH+5V8kBA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 02:24:10PM -0300, Fabio Estevam wrote:
> On Wed, Aug 19, 2020 at 2:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > -       unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > +       unsigned long mb = (io_tlb_nslabs << IO_TLB_SHIFT) >> 20;
> 
> Looks like an unrelated change.

To put pr_info() onto one (not so long) line. But of course, can leave it.

-- 
With Best Regards,
Andy Shevchenko


