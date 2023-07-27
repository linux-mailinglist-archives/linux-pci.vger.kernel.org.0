Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186076456C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 07:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjG0FYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG0FYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 01:24:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79926AE
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690435439; x=1721971439;
  h=date:from:to:cc:subject:message-id;
  bh=Qtjkj7hhk+zIs4Up04Ks7Hd+AWjaz/Sspe7MjEq0m/0=;
  b=kY9QuWTIEmLZ15uelV/HrDT3wAFfq5KebTt1SaBnX5hFLMbmMQCk2v10
   ES2qj2dJpscTtGMkiHHWK8KVX0KAtqTmxBDGvZquIlLqouRAU7GoQgMXq
   LCHqCihTz1AvDl4xwCKsWySj1XTPBqxgEW6Wg3Eq0l1M/YL75vYiLQIAX
   lNWqcbIvWxXKHLZkLieWLMTrb8q53anX2V6SE0lang5jVueFHMJs6i7lq
   4Sl4eCS7LRGFCBZfKO9HUWKMqxLaIvv+F6zfe1MTtq8gCYOFST6XTDqfm
   kdNpLvU/gE/9F77GKIYj3XQWrYnK3jFohdLOMfS1fmL4tHWsqv9CyfvCa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367082184"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367082184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792176510"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="792176510"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 22:23:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOtTU-0001xt-2p;
        Thu, 27 Jul 2023 05:23:49 +0000
Date:   Thu, 27 Jul 2023 13:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 b607aa1edc9ca2ff16ae29c48e3e4090fae8aeab
Message-ID: <202307271354.REQMBFUG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: b607aa1edc9ca2ff16ae29c48e3e4090fae8aeab  Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

elapsed time: 780m

configs tested: 134
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230726   gcc  
alpha                randconfig-r004-20230726   gcc  
alpha                randconfig-r013-20230726   gcc  
alpha                randconfig-r032-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230726   gcc  
arc                  randconfig-r043-20230726   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230726   clang
arm                  randconfig-r046-20230726   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230726   clang
arm64                randconfig-r023-20230726   clang
csky                                defconfig   gcc  
csky                 randconfig-r005-20230726   gcc  
csky                 randconfig-r021-20230726   gcc  
hexagon              randconfig-r036-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i016-20230726   clang
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-r015-20230726   clang
i386                 randconfig-r034-20230726   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230726   gcc  
loongarch            randconfig-r034-20230726   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230726   gcc  
m68k                 randconfig-r025-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230726   clang
mips                 randconfig-r022-20230726   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230726   gcc  
nios2                randconfig-r015-20230726   gcc  
nios2                randconfig-r024-20230726   gcc  
nios2                randconfig-r033-20230726   gcc  
openrisc             randconfig-r001-20230726   gcc  
openrisc             randconfig-r031-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230726   gcc  
parisc               randconfig-r006-20230726   gcc  
parisc               randconfig-r011-20230726   gcc  
parisc               randconfig-r014-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r013-20230726   clang
powerpc              randconfig-r025-20230726   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230726   clang
riscv                randconfig-r036-20230726   gcc  
riscv                randconfig-r042-20230726   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230726   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230726   gcc  
sh                   randconfig-r033-20230726   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230726   gcc  
sparc64              randconfig-r013-20230726   gcc  
sparc64              randconfig-r031-20230726   gcc  
sparc64              randconfig-r032-20230726   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r035-20230726   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230726   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230726   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230726   gcc  
xtensa               randconfig-r015-20230726   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
