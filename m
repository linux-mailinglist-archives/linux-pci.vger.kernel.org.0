Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A796089E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGEPEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 11:04:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfGEPEQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 11:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D38F28;
        Fri,  5 Jul 2019 08:04:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9293F718;
        Fri,  5 Jul 2019 08:04:14 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:04:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v1 1/2] tools: PCI: Fix compilation error
Message-ID: <20190705150412.GC31464@e121166-lin.cambridge.arm.com>
References: <20190628131218.10244-1-andriy.shevchenko@linux.intel.com>
 <20190705133441.GA31464@e121166-lin.cambridge.arm.com>
 <20190705142147.GE9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705142147.GE9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 05:21:47PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 05, 2019 at 02:34:41PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Jun 28, 2019 at 04:12:17PM +0300, Andy Shevchenko wrote:
> > > The commit
> > > 
> > >   b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")
> > > 
> > > forgot to update function prototype and thus brought a regression:
> > > 
> > > pcitest.c:221:9: error: void value not ignored as it ought to be
> > >  return run_test(test);
> > >         ^~~~~~~~~~~~~~
> > > 
> > > Fix it by changing prototype from void to int.
> > > 
> > > While here, initialize ret with 0 to avoid compiler warning:
> > > 
> > > pcitest.c:132:25: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > 
> > > Fixes: b71f0a0b1e3f ("tools: PCI: Exit with error code when test fails")
> > > Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  tools/pci/pcitest.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > Patch 1 and 2 already applied from another thread:
> > 
> > https://lore.kernel.org/linux-pci/1558646281-12676-1-git-send-email-alan.mikhak@sifive.com/
> > 
> > Thanks anyway !
> 
> I don't see neither in v5.2-rc7, nor in Linux Next.
> In which repository is it?

It is in -next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/tools/pci/pcitest.c?h=next-20190705
