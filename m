Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77724D4163
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 07:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiCJGxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 01:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiCJGxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 01:53:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F51117E
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 22:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646895159; x=1678431159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c5Cn77my4fxZsjlLZmTRZYb8Yewm32e4tPUpwayZdUs=;
  b=lQ+sjTZYh9EHiAsqDkzUUQ8MEwjvO5PIQRG4jztoVteyXkyeVh6ZtusB
   i22wpVWt0NTXOS4cADlnNErZsyvW7BvoQr33EMx9M4/t6xKeDCGO+AsZY
   kK73GjipjCHnvh9p45Gg5Vplm07lHjWU65lH8aFnotvtW5gqp3aog22eU
   yCw9SOj0Z6Aa8zBb9osq75gRxFdYZA/a74Fmot9xSgr3f0nqj0snB5T5L
   mvN7fpteZ7G3KES+YK/dxeEqn5rym+wfkZvTi6BI5c/lb1dtUE5pf13N2
   HitrmQ0F9+509bkQAkw8Mg3XM+vpvVhCCAIjGN9HKKxEaXZZ4wem8VvQg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252744065"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252744065"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 22:52:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513861327"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 22:52:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSCf4-0004Uo-8G; Thu, 10 Mar 2022 06:52:34 +0000
Date:   Thu, 10 Mar 2022 14:52:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [helgaas-pci:for-linus 3/3] arch/x86/kernel/resource.c:51:18:
 warning: missing terminating '"' character
Message-ID: <202203101402.DpRD30NZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
head:   3018c5d59f923be2fa2d91c4ce02c8d97a37edce
commit: 3018c5d59f923be2fa2d91c4ce02c8d97a37edce [3/3] x86/PCI: Preserve host bridge windows completely covered by E820
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220310/202203101402.DpRD30NZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=3018c5d59f923be2fa2d91c4ce02c8d97a37edce
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci for-linus
        git checkout 3018c5d59f923be2fa2d91c4ce02c8d97a37edce
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/resource.c:51:18: warning: missing terminating '"' character [-Winvalid-pp-token]
                           dev_info(dev, "resource %pR fully covered by e820 entry
                                         ^
   arch/x86/kernel/resource.c:52:24: warning: missing terminating '"' character [-Winvalid-pp-token]
   [mem %#010Lx-%#010Lx]\n",
                          ^
   arch/x86/kernel/resource.c:51:18: error: expected expression
                           dev_info(dev, "resource %pR fully covered by e820 entry
                                         ^
   2 warnings and 1 error generated.


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
    52	[mem %#010Lx-%#010Lx]\n",
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
