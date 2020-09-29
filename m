Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5927C2B4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgI2Kse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:48:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:39338 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgI2Ks0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:48:26 -0400
IronPort-SDR: CjEWLNuqGMCXpELff/TJt7oJ4HiP7zWaymWCNdCTtTk+qsWOvjFnSmD/qiAqHXmW1Bcr3hKxTv
 oAEXP6HnF7dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162225767"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="162225767"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 03:48:23 -0700
IronPort-SDR: rQRU8B/HjgztESUQFAR500NvMy8eCzvTAgY8KeLvEc2x/v13YFYwK9imFoLUApFy7Gpt13ER1k
 a46cFZR4qJYQ==
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="350178352"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 03:48:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kNDB9-002lwq-Lq; Tue, 29 Sep 2020 13:48:15 +0300
Date:   Tue, 29 Sep 2020 13:48:15 +0300
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
Message-ID: <20200929104815.GD3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com>
 <20200925123515.GF3956970@smile.fi.intel.com>
 <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com>
 <20200929085105.GA3956970@smile.fi.intel.com>
 <CAKF3qh28CLbt7N2MJ8WE318wYU4kFe+F5Uew3znVJ17yyTR7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKF3qh28CLbt7N2MJ8WE318wYU4kFe+F5Uew3znVJ17yyTR7OA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 05:38:00PM +0800, Ethan Zhao wrote:
> On Tue, Sep 29, 2020 at 4:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 29, 2020 at 10:35:14AM +0800, Ethan Zhao wrote:
> > > Preferred style, there will be cleared comment in v6.
> >
> > Avoid top postings.
> >
> > > On Sat, Sep 26, 2020 at 12:42 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:

...

> > > > >  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
> > > > >  async page read
> > > > >  BUG: kernel NULL pointer dereference, address: 0000000000000050
> > > > >  #PF: supervisor read access in kernel mode
> > > > >  #PF: error_code(0x0000) - not-present page
> > > >
> > > > Same comment about Oops.
> >
> > In another thread it was a good advice to move the full Oops (if you think it's
> > very useful to have) after the cutter '---' line, so it will be in email
> > archives but Git history.
> 
> So git history wouldn't give any of the Oops context, and he/she has
> to access LKML,
> if offline, then ...lost.

Tell me, do you really think the line:
   #PF: error_code(0x0000) - not-present page
makes any sense in the commit message?

I do not think so. And so on, for almost 60% of the Oops.
Really, to help one person you will make millions suffering. It's not okay.

-- 
With Best Regards,
Andy Shevchenko


