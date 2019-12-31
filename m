Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC012D80A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLaKlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:41:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:33889 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfLaKlS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 05:41:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 02:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,379,1571727600"; 
   d="scan'208";a="220913973"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2019 02:41:13 -0800
Date:   Tue, 31 Dec 2019 18:40:36 +0800
From:   Philip Li <philip.li@intel.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH 2/7] misc: pci_endpoint_test: Do not
 request or allocate IRQs in probe
Message-ID: <20191231104036.GB26177@intel.com>
References: <20191230123315.31037-3-kishon@ti.com>
 <201912310039.Jef27rlg%lkp@intel.com>
 <b561503f-a753-7750-2a43-78509755eb83@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b561503f-a753-7750-2a43-78509755eb83@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 02:05:15PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 30/12/19 10:40 PM, kbuild test robot wrote:
> > Hi Kishon,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on char-misc/char-misc-testing]
> > [also build test WARNING on pci/next arm-soc/for-next linus/master v5.5-rc4 next-20191220]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Kishon-Vijay-Abraham-I/Improvements-to-pci_endpoint_test-driver/20191230-203402
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git d1eef1c619749b2a57e514a3fa67d9a516ffa919
> > config: arm-randconfig-a001-20191229 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.5.0 make.cross ARCH=arm 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from include/linux/kernel.h:11:0,
> >                     from include/linux/delay.h:22,
> >                     from drivers/[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.commisc/pci_endpoint_test.c:10:
> >    drivers/misc/pci_endpoint_test.c: In function 'pci_endpoint_test_probe':
> >    drivers/misc/pci_endpoint_test.c:73:22: error: 'PCI_DEVICE_ID_TI_J721E' undeclared (first use in this function); did you mean 'PCI_DEVICE_ID_TI_7510'?
> >       ((pdev)->device == PCI_DEVICE_ID_TI_J721E)
> 
> The patches in this series should be merged only after [1]. With that
> this error wouldn't be seen.
thanks Kishon for the info, sorry for the false positive.

> 
> [1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
> 
> Thanks
> Kishon
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
