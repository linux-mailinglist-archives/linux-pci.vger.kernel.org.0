Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1F7DAE9F
	for <lists+linux-pci@lfdr.de>; Sun, 29 Oct 2023 22:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjJ2VgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Oct 2023 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjJ2VgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2023 17:36:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC5B97
        for <linux-pci@vger.kernel.org>; Sun, 29 Oct 2023 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698615378; x=1730151378;
  h=date:from:to:cc:subject:message-id;
  bh=TP7dThNqQaSgaYKZGDMBSZpqK5s1Psm9Y2rslOr86AA=;
  b=aeoC2N6Noozx7E3I0NFDQM3Ux1xeTI8OzCvFJFG4bsazkckgz33VAzDz
   jP+z85jT+EvBM4rNRGF72tN2yTIozVVAhfePCpIAHfuRpJeOwVpcdjpi8
   INMQrLcRPuJQsdj35sSb0fZ2taYhmMxDRS2bWfoXtaauSRs4rbXGy3aGY
   MGZEJqDDX9SEqVRMdeOgFK+PaEN4ipZFZwzQQyNCjf8u3vED6OBgfCdax
   Bz8Qp9CmIZSWvsnTjJ9CJ+gYYVkHYBma+tB0B0ALIwMM4KxA89mFNXdCL
   SlbODVLvVRR6PuUuCEBQorg8vNLDKc/+gLS64Hf0srpxOOuf9FXlKqYu3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="368199548"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="368199548"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 14:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="1338834"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Oct 2023 14:36:04 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxDSB-000CpQ-28;
        Sun, 29 Oct 2023 21:36:15 +0000
Date:   Mon, 30 Oct 2023 05:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 50b3ef14c26b20476e67af582e788b17512023cf
Message-ID: <202310300552.oTHXvC8C-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 50b3ef14c26b20476e67af582e788b17512023cf  Merge branch 'pci/misc'

elapsed time: 1616m

configs tested: 151
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
arc                   randconfig-001-20231029   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                   randconfig-001-20231029   gcc  
arm                        spear3xx_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231029   gcc  
i386         buildonly-randconfig-002-20231029   gcc  
i386         buildonly-randconfig-003-20231029   gcc  
i386         buildonly-randconfig-004-20231029   gcc  
i386         buildonly-randconfig-005-20231029   gcc  
i386         buildonly-randconfig-006-20231029   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231029   gcc  
i386                  randconfig-002-20231029   gcc  
i386                  randconfig-003-20231029   gcc  
i386                  randconfig-004-20231029   gcc  
i386                  randconfig-005-20231029   gcc  
i386                  randconfig-006-20231029   gcc  
i386                  randconfig-011-20231029   gcc  
i386                  randconfig-012-20231029   gcc  
i386                  randconfig-013-20231029   gcc  
i386                  randconfig-014-20231029   gcc  
i386                  randconfig-015-20231029   gcc  
i386                  randconfig-016-20231029   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231029   gcc  
loongarch             randconfig-001-20231030   gcc  
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
mips                     decstation_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          allyesconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231029   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231029   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231029   gcc  
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
x86_64       buildonly-randconfig-001-20231029   gcc  
x86_64       buildonly-randconfig-002-20231029   gcc  
x86_64       buildonly-randconfig-003-20231029   gcc  
x86_64       buildonly-randconfig-004-20231029   gcc  
x86_64       buildonly-randconfig-005-20231029   gcc  
x86_64       buildonly-randconfig-006-20231029   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231029   gcc  
x86_64                randconfig-002-20231029   gcc  
x86_64                randconfig-003-20231029   gcc  
x86_64                randconfig-004-20231029   gcc  
x86_64                randconfig-005-20231029   gcc  
x86_64                randconfig-006-20231029   gcc  
x86_64                randconfig-011-20231029   gcc  
x86_64                randconfig-012-20231029   gcc  
x86_64                randconfig-013-20231029   gcc  
x86_64                randconfig-014-20231029   gcc  
x86_64                randconfig-015-20231029   gcc  
x86_64                randconfig-016-20231029   gcc  
x86_64                randconfig-071-20231029   gcc  
x86_64                randconfig-072-20231029   gcc  
x86_64                randconfig-073-20231029   gcc  
x86_64                randconfig-074-20231029   gcc  
x86_64                randconfig-075-20231029   gcc  
x86_64                randconfig-076-20231029   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
