Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023E76E820
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHCM0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCM0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 08:26:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66393588;
        Thu,  3 Aug 2023 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691065586; x=1722601586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2F5IYI+st9aRDs3eL22xgwh/NWyfWxHGIKX3hSkU1es=;
  b=SmCRG88uMeD7OY/JymmzY+kLc35jNU5UsYIjd8lupMzVE8/BMDQkJB7z
   +oJGXKfYufYplTWesPOMIsN7e2HxzwzIZJCwUCpAw+h6fhFOlkFW1OwbO
   LqQpBAlt3Zb6e/VM78Bqg2/5ABM5mx2TmyRJmqbH9bHWV//Cu42UVEdaN
   za//qYkON4G/hEWfJ5Q1QxceStCiEl9IZ1fKjEZuCd9ms6DUjHAvYXjzO
   GxoUkG9Cyp1eTTagvf8DEbEmgP/QRbLW7OzmHebiWImX6M+tvf94g6ggt
   OBafLrluIgkEBQvQNjbrQy+nq0zhQaLYfsIr5Ycs8uooa/my2dPEPpxKf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436165444"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436165444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706515734"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706515734"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 05:26:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRXPM-00026d-1d;
        Thu, 03 Aug 2023 12:26:24 +0000
Date:   Thu, 3 Aug 2023 20:25:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] PCI/VGA: Make the vga_is_firmware_default()
 arch-independent
Message-ID: <202308032022.yiZngbbk-lkp@intel.com>
References: <20230803081758.968742-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803081758.968742-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sui,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.5-rc4 next-20230803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/PCI-VGA-Make-the-vga_is_firmware_default-arch-independent/20230803-161838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230803081758.968742-1-suijingfeng%40loongson.cn
patch subject: [PATCH] PCI/VGA: Make the vga_is_firmware_default() arch-independent
config: arm64-randconfig-r026-20230731 (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308032022.yiZngbbk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: screen_info
   >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
   >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
   >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
   >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
   >>> referenced by vgaarb.c:88 (drivers/pci/vgaarb.c:88)
   >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
