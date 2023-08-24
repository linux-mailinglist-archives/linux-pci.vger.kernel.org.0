Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B66786F2B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjHXMdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbjHXMdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 08:33:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539D19A6
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880421; x=1724416421;
  h=date:from:to:cc:subject:message-id;
  bh=7cIfPQugj+Pf3aPEyNkpkbLfV3DTzwI+Hsia3ZnvYN8=;
  b=DomViquGWalBMh4I2aAzj29eJEM4brxRHcxHn3WxqwSYXpctL5oPa2cg
   8OEXZ8oU4VbzRpqp4fDE4dHYBFoDOXR6jK9rdsLI1uC0NrwNUF/sGOPeb
   CcFIQhRRR3d+KaC/dSN2zmVZfgToGlmqzwX5Oc2HFvVucsU+KWYKHFdRf
   AT5ZUXtAzps9i6EjvNNfdgf13bviubSBXT/NuVO42Na+XAchNqE8d/Wki
   bxYUma8YUHpyulkoU4IeyZc+NY2rhWiDU+1oL54wgmtLi6iEJ/vzbIO6Q
   +W6I/Nz6DBV3jqTjjigtwyqD/YONbmNgr6mpFv3U55TWlpMfURbG7Zn3Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438359193"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438359193"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="737030420"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737030420"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2023 05:33:40 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ9Wt-0002UY-0Y;
        Thu, 24 Aug 2023 12:33:39 +0000
Date:   Thu, 24 Aug 2023 20:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pcie-rmw] BUILD SUCCESS
 da54556695b9ab20cc696827247ffff02254b78d
Message-ID: <202308242031.Vgizbe6R-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pcie-rmw
branch HEAD: da54556695b9ab20cc696827247ffff02254b78d  net/mlx5: Convert PCI error values to generic errnos

elapsed time: 3892m

configs tested: 164
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230822   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                             mxs_defconfig   clang
arm                           omap1_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r014-20230822   gcc  
arm                       versatile_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230822   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230822   gcc  
csky                 randconfig-r006-20230822   gcc  
hexagon              randconfig-r012-20230822   clang
hexagon              randconfig-r025-20230822   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230822   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230822   gcc  
i386                  randconfig-002-20230822   gcc  
i386                  randconfig-003-20230822   gcc  
i386                  randconfig-004-20230822   gcc  
i386                  randconfig-005-20230822   gcc  
i386                  randconfig-006-20230822   gcc  
i386                  randconfig-011-20230822   clang
i386                  randconfig-012-20230822   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230822   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r002-20230822   gcc  
m68k                 randconfig-r022-20230822   gcc  
m68k                 randconfig-r024-20230822   gcc  
m68k                 randconfig-r036-20230822   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r032-20230822   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 randconfig-r004-20230822   clang
mips                 randconfig-r005-20230822   clang
mips                 randconfig-r023-20230822   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230822   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230822   gcc  
parisc               randconfig-r035-20230822   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc              randconfig-r026-20230822   clang
powerpc64            randconfig-r013-20230822   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   gcc  
riscv                randconfig-r011-20230822   clang
riscv                randconfig-r031-20230822   gcc  
riscv                randconfig-r033-20230822   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230822   clang
s390                 randconfig-r005-20230822   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r021-20230822   gcc  
sh                          rsk7269_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230822   clang
x86_64                randconfig-002-20230822   clang
x86_64                randconfig-003-20230822   clang
x86_64                randconfig-004-20230822   clang
x86_64                randconfig-011-20230822   gcc  
x86_64                randconfig-014-20230822   gcc  
x86_64                randconfig-015-20230822   gcc  
x86_64                randconfig-016-20230822   gcc  
x86_64                randconfig-072-20230822   gcc  
x86_64                randconfig-073-20230822   gcc  
x86_64                randconfig-074-20230822   gcc  
x86_64               randconfig-r001-20230822   gcc  
x86_64               randconfig-r034-20230822   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
