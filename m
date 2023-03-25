Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696C6C8AD2
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 05:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCYEau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYEat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 00:30:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9DAF3F
        for <linux-pci@vger.kernel.org>; Fri, 24 Mar 2023 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679718648; x=1711254648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PVDzL7srLUI1GsxIQKdskn4AspqvuzrwtnqRhU4XXhw=;
  b=QPIX/QhNSz5Vh2e34Dd8VuuZbnZtH5YfnCAcMZqaRG824gx7WQ5p0MqT
   MlDFjV0raNDdabcf2p24uP+6mZ8HYbhKbcRtNwJpxLDpVl9jbMqIqGMjN
   1u1yz6O1k5fDvXRtZiIfWf2UfIuCVKmDrTx68ATXNT+eWjzOpSd9fB87Z
   iOyVcQFlUCGeaqrVqyl3RhJaeVT1a2A+aXUBY/bztkPxBtrLm9yVSoORu
   8AmWu8TgxCxoX/j18gBWXiDHYn1M+MWlDUU5T11nNa7ioIdYozNsAddBg
   l6URO9WLRrvYZLBOHsIcVIRrEFYxJmj2vBhp+KoGzjGv97iJOF9KYRrZX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339957917"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="339957917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 21:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="685416203"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="685416203"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2023 21:30:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfvYE-000FwV-0Y;
        Sat, 25 Mar 2023 04:30:46 +0000
Date:   Sat, 25 Mar 2023 12:30:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/mt7621] BUILD SUCCESS
 50233e105a0332ec0f3bc83180c416e6b200471e
Message-ID: <641e78f3.2K9g5J+rKGLEejMy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mt7621
branch HEAD: 50233e105a0332ec0f3bc83180c416e6b200471e  PCI: mt7621: Use dev_info() to log PCIe card detection

elapsed time: 731m

configs tested: 208
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230322   gcc  
alpha                randconfig-r025-20230322   gcc  
alpha                randconfig-r034-20230323   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r002-20230322   gcc  
arc                  randconfig-r025-20230324   gcc  
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
arm                  randconfig-r011-20230322   clang
arm                  randconfig-r014-20230322   clang
arm                  randconfig-r014-20230323   gcc  
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r034-20230324   gcc  
arm                  randconfig-r035-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230322   clang
arm64                randconfig-r005-20230322   clang
arm64                randconfig-r023-20230322   gcc  
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
csky                 randconfig-r034-20230322   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r006-20230322   clang
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
ia64                 randconfig-r015-20230322   gcc  
ia64                 randconfig-r022-20230324   gcc  
ia64                 randconfig-r024-20230322   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r036-20230323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230323   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230322   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r012-20230322   gcc  
m68k                 randconfig-r015-20230322   gcc  
m68k                 randconfig-r026-20230322   gcc  
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
mips                 randconfig-r026-20230324   clang
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r004-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230322   gcc  
nios2                randconfig-r003-20230324   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r016-20230323   gcc  
openrisc     buildonly-randconfig-r002-20230322   gcc  
openrisc             randconfig-r014-20230322   gcc  
openrisc             randconfig-r015-20230322   gcc  
openrisc             randconfig-r035-20230323   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230324   gcc  
parisc               randconfig-r004-20230322   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r013-20230323   gcc  
parisc               randconfig-r024-20230322   gcc  
parisc               randconfig-r025-20230322   gcc  
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
powerpc              randconfig-r011-20230323   clang
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r015-20230322   gcc  
powerpc              randconfig-r015-20230323   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r001-20230322   clang
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
s390                 randconfig-r032-20230323   gcc  
s390                 randconfig-r033-20230323   gcc  
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
sparc                randconfig-r003-20230322   gcc  
sparc                randconfig-r006-20230322   gcc  
sparc                randconfig-r011-20230322   gcc  
sparc                randconfig-r016-20230322   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r024-20230322   gcc  
sparc64              randconfig-r024-20230324   gcc  
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
