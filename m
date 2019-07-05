Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5360AC0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfGERI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 13:08:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:6344 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfGERI5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 13:08:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 10:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="248228553"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2019 10:08:54 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hjRhd-0004W6-OP; Fri, 05 Jul 2019 20:08:53 +0300
Date:   Fri, 5 Jul 2019 20:08:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v1] tools: PCI: Fix installation when `make
 tools/pci_install`
Message-ID: <20190705170853.GG9224@smile.fi.intel.com>
References: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
 <20190705162358.GA3080@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705162358.GA3080@e121166-lin.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 05:23:58PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 28, 2019 at 04:33:26PM +0300, Andy Shevchenko wrote:
> > The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
> > fixed a `make tools clean` issue and simultaneously brought a regression
> > to the installation process:
> > 
> >   for script in .../tools/pci/pcitest.sh; do	\
> > 	install $script .../usr/usr/bin;	\
> >   done
> >   install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory
> > 
> > Here is the missed part of the fix.
> 
> Sigh, hopefully that's the last fix :), Kishon if that's OK mind
> ACKing it please ?

From my side, yes. Now it works as I expect.

Honestly, I'm puzzled how so many errors has been pushed upstream...

-- 
With Best Regards,
Andy Shevchenko


