Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3791C7896F4
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHZNlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjHZNlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 09:41:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DA2114
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693057267; x=1724593267;
  h=date:from:to:cc:subject:message-id;
  bh=OmPTFM84Q3tFUaw7bjH/D7hkDlnyzEOLFrGabsuHU6Q=;
  b=D5gZsCwzGKr3gu+dZusI+SivTRKyDJHZPGVB9oHDvCnAunVzC1wMP+Yl
   Vy2KNpGSU8D4nDDwhbfjbZXuZBdK97HEvEk3CVeY/5bNcNUD0DBpdpQ33
   5Ps6h9HVe4Zx3bqte0zHAlBdQEGQWM3mOdJ4jOM2lh5SYtT4wV0oseJhf
   hUwodvjjDKw5qU7M949KS1dUFuUdZANSWTRXCqjig3E86JWKcVFGBqXua
   aalN5EJgY5BEA4S1KRXq3ExE/EUv1lH+k7hiWbm/3FhN2Bm/kf/5KigHZ
   Nge9OnpBuoIfi9XJNV+F4/K6OLG/aLEVn8CSLYetEXAqIMqtYNlm21wnK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="405869018"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="405869018"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 06:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="827862709"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="827862709"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2023 06:41:05 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZtXF-0004kM-06;
        Sat, 26 Aug 2023 13:41:05 +0000
Date:   Sat, 26 Aug 2023 21:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 9fda4d09905db9ecae17ad741924a7530aa3c96e
Message-ID: <202308262135.MGYxwyMo-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 9fda4d09905db9ecae17ad741924a7530aa3c96e  PCI: layerscape: Add power management support for ls1028a

elapsed time: 3054m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r003-20230824   gcc  
arc                  randconfig-r011-20230824   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230824   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230824   gcc  
csky                 randconfig-r035-20230824   gcc  
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230824   clang
hexagon              randconfig-r006-20230824   clang
i386         buildonly-randconfig-001-20230824   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r014-20230824   clang
i386                 randconfig-r021-20230824   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230824   gcc  
loongarch            randconfig-r033-20230824   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230824   clang
mips                 randconfig-r025-20230824   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230824   gcc  
nios2                randconfig-r022-20230824   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230824   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230824   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r004-20230824   gcc  
powerpc              randconfig-r026-20230824   clang
powerpc              randconfig-r034-20230824   gcc  
powerpc64            randconfig-r024-20230824   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230824   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230824   clang
s390                 randconfig-r002-20230824   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r005-20230824   gcc  
sh                   randconfig-r013-20230824   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r031-20230824   gcc  
sparc64              randconfig-r036-20230824   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230824   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
