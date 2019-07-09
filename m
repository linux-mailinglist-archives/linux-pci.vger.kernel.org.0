Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3313263507
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGILiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 07:38:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:32665 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGILiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 07:38:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 04:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="364113714"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2019 04:38:23 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkoRy-0002TV-NH; Tue, 09 Jul 2019 14:38:22 +0300
Date:   Tue, 9 Jul 2019 14:38:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v1] tools: PCI: Fix installation when `make
 tools/pci_install`
Message-ID: <20190709113822.GV9224@smile.fi.intel.com>
References: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
 <20190705162358.GA3080@e121166-lin.cambridge.arm.com>
 <20190705170853.GG9224@smile.fi.intel.com>
 <7c48dbae-847b-812d-88f3-7336686bd46e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c48dbae-847b-812d-88f3-7336686bd46e@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 09, 2019 at 04:48:57PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 05/07/19 10:38 PM, Andy Shevchenko wrote:
> > On Fri, Jul 05, 2019 at 05:23:58PM +0100, Lorenzo Pieralisi wrote:
> >> On Fri, Jun 28, 2019 at 04:33:26PM +0300, Andy Shevchenko wrote:
> >>> The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
> >>> fixed a `make tools clean` issue and simultaneously brought a regression
> >>> to the installation process:
> >>>
> >>>   for script in .../tools/pci/pcitest.sh; do	\
> >>> 	install $script .../usr/usr/bin;	\
> >>>   done
> >>>   install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory
> >>>
> >>> Here is the missed part of the fix.
> >>
> >> Sigh, hopefully that's the last fix :), Kishon if that's OK mind
> >> ACKing it please ?
> > 
> > From my side, yes. Now it works as I expect.
> > 
> > Honestly, I'm puzzled how so many errors has been pushed upstream...
> 
> I'm not sure why, but I don't see any issue without this patch as well. Am I
> missing something here?

Yes.
I'm not contaminate my Linux kernel tree with any build stuff, so, I'm using
the folder which is out to the build, i.e.

% make O=/xyz ...

> I'm copy pasting the steps below.
> 
> a0393678@a0393678ub:~/repos/linux/tools/pci$ make clean
> rm -f pcitest
> rm -rf include/
> find . -name '*.o' -delete -o -name '\.*.d' -delete
> a0393678@a0393678ub:~/repos/linux/tools/pci$ make
> mkdir -p include/linux/ 2>&1 || true
> ln -sf /home/a0393678/repos/linux/tools/pci/../../include/uapi/linux/pcitest.h
> include/linux/
> make -f /home/a0393678/repos/linux/tools/build/Makefile.build dir=. obj=pcitest
> make[1]: Entering directory '/home/a0393678/repos/linux/tools/pci'
>   CC       pcitest.o
>   LD       pcitest-in.o
> make[1]: Leaving directory '/home/a0393678/repos/linux/tools/pci'
>   LINK     pcitest
> a0393678@a0393678ub:~/repos/linux/tools/pci$ sudo make install
> make -f /home/a0393678/repos/linux/tools/build/Makefile.build dir=. obj=pcitest
> install -d -m 755 /usr/bin;		\
> for program in pcitest pcitest.sh; do	\
> 	install $program /usr/bin;	\
> done;						\
> for script in pcitest.sh; do		\
> 	install $script /usr/bin;	\
> done
> a0393678@a0393678ub:~/repos/linux/tools/pci$
> 
> Thanks
> Kishon

-- 
With Best Regards,
Andy Shevchenko


