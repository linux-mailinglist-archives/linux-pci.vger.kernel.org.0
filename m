Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62B4792D5D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjIES0t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIES0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 14:26:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396813E
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693938379; x=1725474379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bo77MIsE7TC9LPx5x1LU0yPU5Ea/493vuZ/HOOinzEQ=;
  b=RYSWHhqnecudHmcw+0isUaXXLix7GLGe7B+I+/B+ZGOpMiK4JVPZc+VX
   nzq6gGYrLHPbrOvqDNeb43Xdb8bNJlaGhPg4tj1vesbJufXjU2VjGEDba
   y9x04533lqwxas4li8izTkfynCyR3G8fQmVtrf1URfw+ojEoAHAfP3hZM
   zRiZE1cyr5fp6O5gcqHWLtecfwkcGhY0y30Lq6JgKrHBTn/xfLUaN76N3
   SZGhGEduBvxB4QtoMc6WdFL+OwkTJHQRw6mACyA9OSQRmyPCAqIR3XzQ+
   F1yIyhhee1/zuccrSCVwa/W3Fr2ho/esBa79uf9GUOctVXYNQ9C/9mrsF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443239564"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443239564"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734725034"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="734725034"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2023 10:04:03 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdZST-0001td-2u;
        Tue, 05 Sep 2023 17:03:31 +0000
Date:   Wed, 06 Sep 2023 00:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/rcar] BUILD SUCCESS
 7af65c1120567de8624e021d798438252cbde876
Message-ID: <202309060016.f4MbIrcz-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar
branch HEAD: 7af65c1120567de8624e021d798438252cbde876  misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

elapsed time: 723m

configs tested: 174
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230905   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230905   gcc  
arc                  randconfig-r022-20230905   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20230905   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230905   gcc  
arm64                randconfig-r031-20230905   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230905   gcc  
hexagon               randconfig-001-20230905   clang
hexagon               randconfig-002-20230905   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230905   clang
i386         buildonly-randconfig-002-20230905   clang
i386         buildonly-randconfig-003-20230905   clang
i386         buildonly-randconfig-004-20230905   clang
i386         buildonly-randconfig-005-20230905   clang
i386         buildonly-randconfig-006-20230905   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230905   clang
i386                  randconfig-002-20230905   clang
i386                  randconfig-003-20230905   clang
i386                  randconfig-004-20230905   clang
i386                  randconfig-005-20230905   clang
i386                  randconfig-006-20230905   clang
i386                  randconfig-011-20230905   gcc  
i386                  randconfig-012-20230905   gcc  
i386                  randconfig-013-20230905   gcc  
i386                  randconfig-014-20230905   gcc  
i386                  randconfig-015-20230905   gcc  
i386                  randconfig-016-20230905   gcc  
i386                 randconfig-r006-20230905   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230905   gcc  
loongarch            randconfig-r014-20230905   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r015-20230905   gcc  
m68k                 randconfig-r036-20230905   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                           rs90_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230905   gcc  
nios2                randconfig-r023-20230905   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230905   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc              randconfig-r001-20230905   clang
powerpc                        warp_defconfig   gcc  
powerpc64            randconfig-r021-20230905   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230905   clang
riscv                randconfig-r005-20230905   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230905   gcc  
s390                 randconfig-r013-20230905   gcc  
s390                 randconfig-r035-20230905   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r003-20230905   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230905   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230905   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230905   clang
x86_64       buildonly-randconfig-002-20230905   clang
x86_64       buildonly-randconfig-003-20230905   clang
x86_64       buildonly-randconfig-004-20230905   clang
x86_64       buildonly-randconfig-005-20230905   clang
x86_64       buildonly-randconfig-006-20230905   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230905   gcc  
x86_64                randconfig-002-20230905   gcc  
x86_64                randconfig-003-20230905   gcc  
x86_64                randconfig-004-20230905   gcc  
x86_64                randconfig-005-20230905   gcc  
x86_64                randconfig-006-20230905   gcc  
x86_64                randconfig-011-20230905   clang
x86_64                randconfig-012-20230905   clang
x86_64                randconfig-013-20230905   clang
x86_64                randconfig-014-20230905   clang
x86_64                randconfig-015-20230905   clang
x86_64                randconfig-016-20230905   clang
x86_64                randconfig-071-20230905   clang
x86_64                randconfig-072-20230905   clang
x86_64                randconfig-073-20230905   clang
x86_64                randconfig-074-20230905   clang
x86_64                randconfig-075-20230905   clang
x86_64                randconfig-076-20230905   clang
x86_64               randconfig-r033-20230905   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r012-20230905   gcc  
xtensa               randconfig-r024-20230905   gcc  
xtensa               randconfig-r034-20230905   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
