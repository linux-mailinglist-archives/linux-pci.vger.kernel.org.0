Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBC4D41A2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 08:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiCJHOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 02:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiCJHOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 02:14:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF1C7EAD
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646896419; x=1678432419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JGBnD1Xd6+a9ea03SZmB7PQAE0BzWWh9QqWszyJutTI=;
  b=B+Miv799/YaOlGoqZ144fswZqdoWwBSCTkdu0qPg0Gk05ZnXGimNARBf
   j8sW7q+cUI1aPnDILZgSKfOTxGSAXAWGanoyWPEl4F/ZvywqVBvflzDan
   CwWJAqBqABBfcF3eJ9Slnd8i1/IzzAIV26Ok8XCB2OH+1fXXPQRnChd54
   rjsrb09noqzUb02HFg6dGN7PV/UWqw7OUuFUi4CPS73xitlC07mcD6TEP
   SyFdoWBqZ7gK2pSVs0H6sBlzNC2/Vx4sSHheZtmT7mSLqO19Tlu8d04eX
   PDTvcTyMjWQqC1b5nKg4zbMPezya9eUR/SXFw7MxpPqeea2u+bVGOqJcm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255365626"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255365626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 23:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="578696305"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 23:13:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSCzP-0004WO-M0; Thu, 10 Mar 2022 07:13:35 +0000
Date:   Thu, 10 Mar 2022 15:12:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [helgaas-pci:for-linus 3/3] arch/x86/kernel/resource.c:51:18: error:
 missing terminating " character
Message-ID: <202203101540.DAEpd9Mt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
head:   3018c5d59f923be2fa2d91c4ce02c8d97a37edce
commit: 3018c5d59f923be2fa2d91c4ce02c8d97a37edce [3/3] x86/PCI: Preserve host bridge windows completely covered by E820
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220310/202203101540.DAEpd9Mt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=3018c5d59f923be2fa2d91c4ce02c8d97a37edce
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci for-linus
        git checkout 3018c5d59f923be2fa2d91c4ce02c8d97a37edce
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/resource.c: In function 'remove_e820_regions':
   arch/x86/kernel/resource.c:51:18: warning: missing terminating " character
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |                  ^
   arch/x86/kernel/resource.c:52:24: warning: missing terminating " character
      52 | [mem %#010Lx-%#010Lx]\n",
         |                        ^
   In file included from arch/x86/kernel/resource.c:2:
>> arch/x86/kernel/resource.c:51:18: error: missing terminating " character
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
>> arch/x86/kernel/resource.c:52:1: error: expected expression before '[' token
      52 | [mem %#010Lx-%#010Lx]\n",
         | ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
>> arch/x86/kernel/resource.c:52:2: error: 'mem' undeclared (first use in this function); did you mean 'sem'?
      52 | [mem %#010Lx-%#010Lx]\n",
         |  ^~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
   arch/x86/kernel/resource.c:52:2: note: each undeclared identifier is reported only once for each function it appears in
      52 | [mem %#010Lx-%#010Lx]\n",
         |  ^~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
>> arch/x86/kernel/resource.c:52:7: error: stray '#' in program
      52 | [mem %#010Lx-%#010Lx]\n",
         |       ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
>> arch/x86/kernel/resource.c:52:8: error: invalid suffix "Lx" on integer constant
      52 | [mem %#010Lx-%#010Lx]\n",
         |        ^~~~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
   arch/x86/kernel/resource.c:52:15: error: stray '#' in program
      52 | [mem %#010Lx-%#010Lx]\n",
         |               ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
   arch/x86/kernel/resource.c:52:16: error: invalid suffix "Lx" on integer constant
      52 | [mem %#010Lx-%#010Lx]\n",
         |                ^~~~~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
   arch/x86/kernel/resource.c:52:22: error: stray '\' in program
      52 | [mem %#010Lx-%#010Lx]\n",
         |                      ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
>> arch/x86/kernel/resource.c:52:23: error: expected ')' before 'n'
      52 | [mem %#010Lx-%#010Lx]\n",
         |                       ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~
   arch/x86/kernel/resource.c:52:24: error: missing terminating " character
      52 | [mem %#010Lx-%#010Lx]\n",
         |                        ^~
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
     110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
         |                ^~~
   include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
     150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~~~~~
   arch/x86/kernel/resource.c:51:4: note: in expansion of macro 'dev_info'
      51 |    dev_info(dev, "resource %pR fully covered by e820 entry
         |    ^~~~~~~~


vim +51 arch/x86/kernel/resource.c

    26	
    27	void remove_e820_regions(struct device *dev, struct resource *avail)
    28	{
    29		struct resource orig = *avail;
    30		int i;
    31		struct e820_entry *entry;
    32		u64 e820_start, e820_end;
    33	
    34		if (!(avail->flags & IORESOURCE_MEM))
    35			return;
    36	
    37		for (i = 0; i < e820_table->nr_entries; i++) {
    38			entry = &e820_table->entries[i];
    39			e820_start = entry->addr;
    40			e820_end = entry->addr + entry->size - 1;
    41	
    42			/*
    43			 * If an E820 entry covers just part of the resource, we
    44			 * assume E820 is telling us about something like host
    45			 * bridge register space that is unavailable for PCI
    46			 * devices.  But if it covers the *entire* resource, it's
    47			 * more likely just telling us that this is MMIO space, and
    48			 * that doesn't need to be removed.
    49			 */
    50			if (e820_start <= avail->start && avail->end <= e820_end) {
  > 51				dev_info(dev, "resource %pR fully covered by e820 entry
  > 52	[mem %#010Lx-%#010Lx]\n",
    53					 avail, e820_start, e820_end);
    54	
    55				continue;
    56			}
    57	
    58			resource_clip(avail, e820_start, e820_end);
    59			if (orig.start != avail->start || orig.end != avail->end) {
    60				dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
    61					 &orig, avail, e820_start, e820_end);
    62				orig = *avail;
    63			}
    64		}
    65	}
    66	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
