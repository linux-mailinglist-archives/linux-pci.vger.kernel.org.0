Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1642E78E609
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 07:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjHaF4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 01:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjHaF4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 01:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BE1B1
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693461387; x=1724997387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vg7RqTgVqM6Lg8+tOz0Np177DIyBv077A6/TUpdLYes=;
  b=a3aPbJwIgRJkn/61UvWNSCcIvDyPrORFJ4+Cu3oNG8q2cOtjhkoeaJUP
   D5rRmrq4cQgHwlqQNjzJr/mm+4EphdIbrvEHMprVIhNHhuGUy6Y4JG0Xe
   6ruIyWrnmdoHrh5G/BGv6rmdeDk5NAqn6g2lT4SiNDhVo7C3LKHvUdhW9
   qki2ybTn9sokDGsLvf78ys5qm8PL57GD9cmHr11Fecbf685LqOgMAxFk/
   enAlMQc4kCu35FDxqyQf0xK9HfTO7gMVz6sdQlvXuWZ3hmD+eS0h08FL2
   QU+4TOMxgCYZP3Ej76N6ay3U/yBVVCIJPkz/QdV3QlRKSiQtb1xM4bULA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360810420"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="360810420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774366206"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="774366206"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 22:56:08 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbaf1-000ArL-1G;
        Thu, 31 Aug 2023 05:56:07 +0000
Date:   Thu, 31 Aug 2023 13:55:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/rcar] BUILD SUCCESS
 33fa67818fe7e58a64663dbf3947cc0380b57a2b
Message-ID: <202308311322.XTW3TlGU-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar
branch HEAD: 33fa67818fe7e58a64663dbf3947cc0380b57a2b  misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

elapsed time: 5076m

configs tested: 177
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230828   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20230828   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20230828   gcc  
arm                        shmobile_defconfig   gcc  
arm                          sp7021_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230828   clang
hexagon               randconfig-002-20230828   clang
hexagon              randconfig-r004-20230828   clang
hexagon              randconfig-r031-20230828   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230828   gcc  
i386         buildonly-randconfig-002-20230828   gcc  
i386         buildonly-randconfig-003-20230828   gcc  
i386         buildonly-randconfig-004-20230828   gcc  
i386         buildonly-randconfig-005-20230828   gcc  
i386         buildonly-randconfig-006-20230828   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230828   gcc  
i386                  randconfig-002-20230828   gcc  
i386                  randconfig-003-20230828   gcc  
i386                  randconfig-004-20230828   gcc  
i386                  randconfig-005-20230828   gcc  
i386                  randconfig-006-20230828   gcc  
i386                  randconfig-011-20230828   clang
i386                  randconfig-012-20230828   clang
i386                  randconfig-013-20230828   clang
i386                  randconfig-014-20230828   clang
i386                  randconfig-015-20230828   clang
i386                  randconfig-016-20230828   clang
i386                 randconfig-r003-20230828   gcc  
i386                 randconfig-r024-20230828   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230828   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230828   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230828   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r035-20230828   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230828   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r021-20230828   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc              randconfig-r032-20230828   gcc  
powerpc              randconfig-r036-20230828   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc64            randconfig-r023-20230828   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230828   gcc  
riscv                randconfig-r015-20230828   clang
riscv                randconfig-r022-20230828   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230828   clang
s390                 randconfig-r026-20230828   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230828   gcc  
sparc                randconfig-r034-20230828   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230828   gcc  
sparc64              randconfig-r016-20230828   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230828   clang
um                   randconfig-r013-20230828   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230828   gcc  
x86_64       buildonly-randconfig-002-20230828   gcc  
x86_64       buildonly-randconfig-003-20230828   gcc  
x86_64       buildonly-randconfig-004-20230828   gcc  
x86_64       buildonly-randconfig-005-20230828   gcc  
x86_64       buildonly-randconfig-006-20230828   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230828   clang
x86_64                randconfig-002-20230828   clang
x86_64                randconfig-003-20230828   clang
x86_64                randconfig-004-20230828   clang
x86_64                randconfig-005-20230828   clang
x86_64                randconfig-006-20230828   clang
x86_64                randconfig-011-20230828   gcc  
x86_64                randconfig-012-20230828   gcc  
x86_64                randconfig-013-20230828   gcc  
x86_64                randconfig-014-20230828   gcc  
x86_64                randconfig-015-20230828   gcc  
x86_64                randconfig-016-20230828   gcc  
x86_64                randconfig-071-20230828   gcc  
x86_64                randconfig-072-20230828   gcc  
x86_64                randconfig-073-20230828   gcc  
x86_64                randconfig-074-20230828   gcc  
x86_64                randconfig-075-20230828   gcc  
x86_64                randconfig-076-20230828   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r005-20230828   gcc  
xtensa               randconfig-r014-20230828   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
