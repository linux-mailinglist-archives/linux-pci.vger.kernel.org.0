Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72E263144
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgIIQEM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 12:04:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:32501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730606AbgIIQDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 12:03:41 -0400
IronPort-SDR: CatHmGElU45wxnKiNJteAwAGeYyDzHkOWJhbWNq46XqWcK/D+4Yi++nVo7wmuEEjp/TRK5ckdJ
 dEkpHHNXyVrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155756922"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155756922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 09:03:40 -0700
IronPort-SDR: xy3KDPmftNRmodzebQIyAY/hR5HldsxXFlM4S6TuinX2uomzlHcFUwtVYKM+MpuyiEfASAs+iI
 qjnlBVUq1STw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333865397"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 09:03:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kG2V7-00FTRl-Ap; Wed, 09 Sep 2020 18:59:13 +0300
Date:   Wed, 9 Sep 2020 18:59:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
Message-ID: <20200909155913.GF1891694@smile.fi.intel.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 11:02:46PM -0300, Fabio Estevam wrote:
> On Wed, Sep 2, 2020 at 2:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There is an extension to a %p to print phys_addr_t type of variables.
> > Use it here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: dropped bytes replacement (Fabio)
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks!

Guys, can this series be applied?

-- 
With Best Regards,
Andy Shevchenko


