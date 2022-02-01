Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D844A6790
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiBAWLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:11:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:63651 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbiBAWLS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 17:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643753478; x=1675289478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVRnUwpIgVIQTqCrlKs7rvT1ofZk7pwAxC60P+MQiRc=;
  b=JwNbNJHLOI/4f/mVDtso/Gh5DpRKK0Em918dpV36b0BfKsPuSt8m/C6M
   qWDV0KnBbqT2DOwYGxyqqgNOIxlRDwIAFsnGpgb10NoQfrjjYViUi0V4y
   KEImHW4JvVKat6pSUowsTujUqKA0a81dBtaskx5lCZaCDQuij3FNFdsLz
   HTaeKyjKVA9WlNjmMqT8E+Bj+kUKi3TJARKKbq84D+30i0TUv4dJn1err
   cyl0Ns1hF/j47Ztt7XvoEzYeWvnwuXGfqCSfR/AKvUlnEiGq4WCQrh1WZ
   mGlr97/euNFXwZqeZzrU7FEUBbgQxAA0WdxCk7n2pQlXkwm/+xtayDdwq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246637826"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="246637826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:11:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698575757"
Received: from aphan2-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.131.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:11:16 -0800
Date:   Tue, 1 Feb 2022 14:11:14 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
Message-ID: <20220201221114.25ivh5ubptd7kauk@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131181924.00006c57@Huawei.com>
 <20220201152410.36jvdmmpcqi3lhdw@intel.com>
 <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-01 13:41:50, Dan Williams wrote:
> On Tue, Feb 1, 2022 at 7:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-01-31 18:19:24, Jonathan Cameron wrote:
> > > On Sun, 23 Jan 2022 16:31:02 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > >
> > > > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > > > be implemented by CXL 2.0 endpoint devices. Since the information
> > > > contained within this DVSEC will be critically important, it makes sense
> > > > to find the value early, and error out if it cannot be found.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Guess the logic makes sense about checking this early though my cynical
> > > mind says, that if someone is putting in devices that claim to be
> > > CXL ones and this isn't there it is there own problem if they
> > > kernel wastes effort bringing the driver up only to find later
> > > it can't finish doing so...
> >
> > I don't remember if Dan and I discussed actually failing to bind this early if
> > the DVSEC isn't there.
> 
> On second look, the error message does not make sense because there is
> "no functionality" not "limited functionality" as a result of this
> failure because the cxl_pci driver just gives up. This failure should
> be limited to cxl_mem, not cxl_pci as there might still be value in
> accessing the mailbox on this device.
> 
> > I think the concern is less about wasted effort and more
> > about the inability to determine if the device is actively decoding something
> > and then having the kernel driver tear that out when it takes over the decoder
> > resources. This was specifically targeted toward the DVSEC range registers
> > (obviously things would fail later if we couldn't find the MMIO).
> 
> If there is no CXL DVSEC then cxl_mem should fail, that's it.
> 

If there is no CXL DVSEC we have no way to find the device's MMIO. You need the
register locator dvsec. Not sure how you intend to do anything with the device
at that point, but if you see something I don't, then by all means, change it.

> > I agree with your cynical mind though that it might not be our job to prevent
> > devices which aren't spec compliant. I'd say if we start seeing bug reports
> > around this we can revisit.
> 
> What would the bug report be, "driver fails to attach to device that
> does not implement the spec"?
