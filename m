Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D096C8AE3
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 05:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCYEc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 00:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYEcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 00:32:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CD1A971
        for <linux-pci@vger.kernel.org>; Fri, 24 Mar 2023 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679718720; x=1711254720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+ufk2PlIsdR2+zgTvVhP3LfG+r1RNDNdKfgbc5nh7oA=;
  b=XD3nso5J66fMcJF4dkBi6/EiAmozqNpAo8ck3bbv8NXXdGffrYItHroN
   QurarQZQm/bNw6dTjtXVPOxWUhuxcpLaQY2GafITkKSgPRsMF69raSYRw
   odJp9mAiNylL63ufd0TMB4zmC+8zNbMJQGIolUsMW2xwuzdFYz4GM34AU
   sm2ohZltrppXcCpUlsU2tmwMTHspPbfH/LgLF8qXPvJThrj/fkxU1nMoq
   7FrSnTalCjbPZoHyMCu4tkbjIwalynVh7mN3jVCfQugbx8w5RMgLlBNGY
   0k2Zm8FB4Oo1P3gYkoQAI2JdhvcU/uvl2vffd0z0v1ZnuVbRH6HVdum5V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323817624"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="323817624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 21:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="676394808"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="676394808"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2023 21:31:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfvZC-000FxJ-1s;
        Sat, 25 Mar 2023 04:31:46 +0000
Date:   Sat, 25 Mar 2023 12:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/ixp4xx] BUILD SUCCESS
 6c6fa1f3f7715484a1991a38345b3a63b20914cf
Message-ID: <641e791e.Xw4Sc5dOcjEU9/eD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/ixp4xx
branch HEAD: 6c6fa1f3f7715484a1991a38345b3a63b20914cf  PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro

elapsed time: 732m

configs tested: 204
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230322   gcc  
alpha                randconfig-r016-20230322   gcc  
alpha                randconfig-r021-20230322   gcc  
alpha                randconfig-r025-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r002-20230322   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r024-20230322   gcc  
arc                  randconfig-r034-20230322   gcc  
arc                  randconfig-r036-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r003-20230322   gcc  
arm                  randconfig-r014-20230322   clang
arm                  randconfig-r014-20230323   gcc  
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r034-20230322   gcc  
arm                  randconfig-r034-20230324   gcc  
arm                  randconfig-r035-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230322   gcc  
arm64                randconfig-r013-20230322   gcc  
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
csky                 randconfig-r034-20230322   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r033-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r041-20230324   clang
hexagon              randconfig-r045-20230322   clang
hexagon              randconfig-r045-20230324   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230322   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230324   gcc  
ia64                 randconfig-r005-20230322   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r012-20230322   gcc  
ia64                 randconfig-r015-20230322   gcc  
ia64                 randconfig-r024-20230322   gcc  
ia64                 randconfig-r031-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230322   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r012-20230322   gcc  
m68k                 randconfig-r015-20230322   gcc  
microblaze           randconfig-r015-20230322   gcc  
microblaze           randconfig-r021-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230322   gcc  
mips                      loongson3_defconfig   gcc  
mips                 randconfig-r004-20230322   gcc  
mips                 randconfig-r005-20230322   gcc  
mips                 randconfig-r012-20230323   gcc  
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r031-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r004-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230322   gcc  
nios2                randconfig-r003-20230324   gcc  
nios2                randconfig-r004-20230322   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r016-20230323   gcc  
openrisc     buildonly-randconfig-r002-20230322   gcc  
openrisc             randconfig-r001-20230322   gcc  
openrisc             randconfig-r005-20230322   gcc  
openrisc             randconfig-r014-20230322   gcc  
openrisc             randconfig-r015-20230322   gcc  
openrisc             randconfig-r026-20230322   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230324   gcc  
parisc               randconfig-r004-20230322   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r013-20230323   gcc  
parisc               randconfig-r015-20230322   gcc  
parisc               randconfig-r035-20230324   gcc  
parisc               randconfig-r036-20230324   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc832x_mds_defconfig   clang
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-c003-20230322   gcc  
powerpc              randconfig-r001-20230322   clang
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r033-20230322   clang
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r036-20230322   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r004-20230322   clang
s390                 randconfig-r014-20230322   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r035-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230322   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r013-20230322   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r026-20230322   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230322   gcc  
sparc                randconfig-r011-20230322   gcc  
sparc                randconfig-r016-20230322   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r024-20230322   gcc  
sparc64              randconfig-r032-20230322   gcc  
sparc64              randconfig-r035-20230322   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa       buildonly-randconfig-r001-20230322   gcc  
xtensa       buildonly-randconfig-r006-20230322   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r001-20230322   gcc  
xtensa               randconfig-r002-20230322   gcc  
xtensa               randconfig-r012-20230322   gcc  
xtensa               randconfig-r013-20230322   gcc  
xtensa               randconfig-r014-20230322   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r031-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
