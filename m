Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2976C2E1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBC2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHBC2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 22:28:08 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7053213E;
        Tue,  1 Aug 2023 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690943286; x=1722479286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00ybSWj/CYZrSLL9FE5JS5iIpOHI720pdL7DCsfZB0A=;
  b=W5SGEK4Gh5hYRleZxM5khguzGhH+/ZKGAljWu3LxPsNjWkr1EHkTXsw2
   YmjuHgtrUwsDGk5y7MwMz4OuAlmdjuy4Se/Cd9egF8e18ESfzxJITLs2j
   NON1wcPht+x9N3c1lj4JKv48qTqdAkmIOUap6DSzQtxU1MLCm65tTqC5P
   AEpNnVy/naCy/yPY8NKHERq3BVICgXy5t7I96ijkhc9RM5u+T2gssNINa
   XZDBFmntcLZLydTwdHRB0dU28yMhFRptEnRvgfje/nxHZ3iQW61JnFZX/
   XfRnrR4YOVBTAsYnrHNkB08/UlFIIWVVm8cFiHT6OPAxTI/RPSvnaah8j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366925866"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="366925866"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 19:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732204942"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="732204942"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 19:28:04 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR1al-0000mJ-11;
        Wed, 02 Aug 2023 02:28:03 +0000
Date:   Wed, 2 Aug 2023 10:27:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] PCI/VGA: Fixup the firmware fb address om demanding time
Message-ID: <202308021027.rCgALJ5d-lkp@intel.com>
References: <20230801183706.702567-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801183706.702567-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.5-rc4 next-20230801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/PCI-VGA-Fixup-the-firmware-fb-address-om-demanding-time/20230802-023743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230801183706.702567-1-suijingfeng%40loongson.cn
patch subject: [PATCH] PCI/VGA: Fixup the firmware fb address om demanding time
config: arm-randconfig-r004-20230731 (https://download.01.org/0day-ci/archive/20230802/202308021027.rCgALJ5d-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308021027.rCgALJ5d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308021027.rCgALJ5d-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/vgaarb.c:133:7: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                              old_fb_start, old_fb_end,
                              ^~~~~~~~~~~~
   drivers/pci/vgaarb.c:13:69: note: expanded from macro 'vgaarb_dbg'
   #define vgaarb_dbg(dev, fmt, arg...)    dev_dbg(dev, "vgaarb: " fmt, ##arg)
                                                                   ~~~    ^~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/pci/vgaarb.c:133:21: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                              old_fb_start, old_fb_end,
                                            ^~~~~~~~~~
   drivers/pci/vgaarb.c:13:69: note: expanded from macro 'vgaarb_dbg'
   #define vgaarb_dbg(dev, fmt, arg...)    dev_dbg(dev, "vgaarb: " fmt, ##arg)
                                                                   ~~~    ^~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/pci/vgaarb.c:134:7: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                              firmware_fb.start, firmware_fb.end);
                              ^~~~~~~~~~~~~~~~~
   drivers/pci/vgaarb.c:13:69: note: expanded from macro 'vgaarb_dbg'
   #define vgaarb_dbg(dev, fmt, arg...)    dev_dbg(dev, "vgaarb: " fmt, ##arg)
                                                                   ~~~    ^~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/pci/vgaarb.c:134:26: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                              firmware_fb.start, firmware_fb.end);
                                                 ^~~~~~~~~~~~~~~
   drivers/pci/vgaarb.c:13:69: note: expanded from macro 'vgaarb_dbg'
   #define vgaarb_dbg(dev, fmt, arg...)    dev_dbg(dev, "vgaarb: " fmt, ##arg)
                                                                   ~~~    ^~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   4 warnings generated.


vim +133 drivers/pci/vgaarb.c

   104	
   105	static bool vga_arb_get_fb_range_from_tracker(resource_size_t *start,
   106						      resource_size_t *end)
   107	{
   108		struct pci_dev *pdev = firmware_fb.pdev;
   109		resource_size_t new_vram_base;
   110		resource_size_t new_fb_start;
   111		resource_size_t old_fb_start;
   112		resource_size_t old_fb_end;
   113	
   114		/*
   115		 * No firmware framebuffer support or No aperture that contains the
   116		 * firmware FB is found, in this case, the firmware_fb.pdev will be
   117		 * NULL. We will return immediately.
   118		 */
   119		if (!pdev)
   120			return false;
   121	
   122		new_vram_base = pdev->resource[firmware_fb.bar].start;
   123		new_fb_start = new_vram_base + firmware_fb.offset;
   124		old_fb_start = firmware_fb.start;
   125		old_fb_end = firmware_fb.end;
   126	
   127		if (new_fb_start != old_fb_start) {
   128			firmware_fb.start = new_fb_start;
   129			firmware_fb.end = new_fb_start + firmware_fb.size - 1;
   130			/* Firmware fb address range moved */
   131			vgaarb_dbg(&pdev->dev,
   132				   "[0x%llx, 0x%llx] -> [0x%llx, 0x%llx]\n",
 > 133				   old_fb_start, old_fb_end,
   134				   firmware_fb.start, firmware_fb.end);
   135		}
   136	
   137		*start = firmware_fb.start;
   138		*end = firmware_fb.end;
   139	
   140		return true;
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
