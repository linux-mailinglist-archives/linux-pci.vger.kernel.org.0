Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279C727C008
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgI2IvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:51:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:44567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgI2IvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:51:14 -0400
IronPort-SDR: 3YeyJpOvCvfZxTsPJsIBFU7RGbxNlVsKMS+jTd0d3Iu/ZUXvkECNeXSEZ0cWOpjL8Zu8j/YKNP
 ZfIjKgqzqx3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226292884"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="226292884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 01:51:13 -0700
IronPort-SDR: A9zOVNdreFCO6YB4HTLdxJvLJ9+LRqzWT8AkpMgnN0QKy4Zojqa8YYgh21NVNydBFRVAGhHDaZ
 IWgcbqyC2IfQ==
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="514600857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 01:51:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kNBLl-002kT8-1s; Tue, 29 Sep 2020 11:51:05 +0300
Date:   Tue, 29 Sep 2020 11:51:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: Re: [PATCH 3/5] PCI/ERR: get device before call device driver to
 avoid null pointer reference
Message-ID: <20200929085105.GA3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com>
 <20200925123515.GF3956970@smile.fi.intel.com>
 <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 10:35:14AM +0800, Ethan Zhao wrote:
> Preferred style, there will be cleared comment in v6.

Avoid top postings.

> On Sat, Sep 26, 2020 at 12:42 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:
> > > During DPC error injection test we found there is race condition between
> > > pciehp and DPC driver, null pointer reference caused panic as following
> >
> > null -> NULL
> >
> > >
> > >  # setpci -s 64:02.0 0x196.w=000a
> > >   // 64:02.0 is rootport has DPC capability
> > >  # setpci -s 65:00.0 0x04.w=0544
> > >   // 65:00.0 is NVMe SSD populated in above port
> > >  # mount /dev/nvme0n1p1 nvme
> > >
> > >  (tested on stable 5.8 & ICX platform)
> > >
> > >  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
> > >  async page read
> > >  BUG: kernel NULL pointer dereference, address: 0000000000000050
> > >  #PF: supervisor read access in kernel mode
> > >  #PF: error_code(0x0000) - not-present page
> >
> > Same comment about Oops.

In another thread it was a good advice to move the full Oops (if you think it's
very useful to have) after the cutter '---' line, so it will be in email
archives but Git history.

-- 
With Best Regards,
Andy Shevchenko


