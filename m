Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E1607C0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbfGEOWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 10:22:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:41431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEOWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 10:22:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="191643567"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2019 07:21:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hjP5v-0000p3-5V; Fri, 05 Jul 2019 17:21:47 +0300
Date:   Fri, 5 Jul 2019 17:21:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v1 1/2] tools: PCI: Fix compilation error
Message-ID: <20190705142147.GE9224@smile.fi.intel.com>
References: <20190628131218.10244-1-andriy.shevchenko@linux.intel.com>
 <20190705133441.GA31464@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705133441.GA31464@e121166-lin.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 02:34:41PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 28, 2019 at 04:12:17PM +0300, Andy Shevchenko wrote:
> > The commit
> > 
> >   b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")
> > 
> > forgot to update function prototype and thus brought a regression:
> > 
> > pcitest.c:221:9: error: void value not ignored as it ought to be
> >  return run_test(test);
> >         ^~~~~~~~~~~~~~
> > 
> > Fix it by changing prototype from void to int.
> > 
> > While here, initialize ret with 0 to avoid compiler warning:
> > 
> > pcitest.c:132:25: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > Fixes: b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")
> > Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  tools/pci/pcitest.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Patch 1 and 2 already applied from another thread:
> 
> https://lore.kernel.org/linux-pci/1558646281-12676-1-git-send-email-alan.mikhak@sifive.com/
> 
> Thanks anyway !

I don't see neither in v5.2-rc7, nor in Linux Next.
In which repository is it?

-- 
With Best Regards,
Andy Shevchenko


