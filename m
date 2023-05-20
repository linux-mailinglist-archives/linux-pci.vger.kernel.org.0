Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB870A50D
	for <lists+linux-pci@lfdr.de>; Sat, 20 May 2023 06:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjETEBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 May 2023 00:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjETEBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 May 2023 00:01:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D3101
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 21:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684555295; x=1716091295;
  h=date:from:to:cc:subject:message-id;
  bh=xmzyUqU4OCBpQ/htSAKtQ2R5iTPWsuejJaTwYlL1Oak=;
  b=Tad/wTaLMD3DJA8u8v/Q+F/cU1ly+qHqx1RoqyoGq6tM6GM+mFJad3z9
   Iv3+bhOchBUIgArL33x3SFi+7XCGX6RGnJCwDiA9h3OJToh3iy18suWvq
   5yIW8EgsjNkie4MfaiMQawgNLD9QYrPSx/VJOanOYxm1ZFSOJjngYfRu1
   MkGuTlKtq2RsjHN1C5yhWXULmRZJbO+TQ0RKC1n2ufvmR+QNEY/se+mvP
   rechekorm3XkPAUsSLmqJ0L0zlVVzgE0aFS1SB8k+OdR7ogrtoRq2GfRw
   keQFjS6/njjQuESBv/9yD8+VwH7JID3KJkLC+3wLQn3/1tmFhTUHW635t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="416007119"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="416007119"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 21:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="702782787"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="702782787"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2023 21:01:33 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q0Dme-000BIi-1R;
        Sat, 20 May 2023 04:01:32 +0000
Date:   Sat, 20 May 2023 12:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 f55ef626b57fd546ea1f5af17172a084ea5ec881
Message-ID: <20230520040125.oBvfc%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/pci
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: f55ef626b57fd546ea1f5af17172a084ea5ec881  PCI/ASPM: Avoid link retraining race

elapsed time: 812m

configs tested: 209
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230517   gcc  
alpha        buildonly-randconfig-r003-20230517   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230517   gcc  
alpha                randconfig-r022-20230517   gcc  
alpha                randconfig-r023-20230519   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r004-20230517   gcc  
arc                  randconfig-r005-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230517   clang
arm64                randconfig-r011-20230517   gcc  
arm64                randconfig-r012-20230517   gcc  
arm64                randconfig-r015-20230517   gcc  
arm64                randconfig-r023-20230519   gcc  
csky         buildonly-randconfig-r005-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230517   gcc  
csky                 randconfig-r024-20230517   gcc  
csky                 randconfig-r025-20230517   gcc  
hexagon              randconfig-r022-20230517   clang
hexagon              randconfig-r026-20230519   clang
hexagon              randconfig-r031-20230517   clang
hexagon              randconfig-r035-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230517   gcc  
ia64         buildonly-randconfig-r005-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r016-20230517   gcc  
ia64                 randconfig-r023-20230517   gcc  
ia64                 randconfig-r025-20230519   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230517   gcc  
loongarch            randconfig-r011-20230517   gcc  
loongarch            randconfig-r026-20230519   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230517   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r014-20230517   gcc  
m68k                 randconfig-r021-20230517   gcc  
m68k                 randconfig-r022-20230519   gcc  
m68k                 randconfig-r023-20230517   gcc  
microblaze   buildonly-randconfig-r001-20230517   gcc  
microblaze           randconfig-r003-20230517   gcc  
microblaze           randconfig-r012-20230517   gcc  
microblaze           randconfig-r021-20230519   gcc  
microblaze           randconfig-r031-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r003-20230517   gcc  
mips                     decstation_defconfig   gcc  
mips                 randconfig-r002-20230517   gcc  
mips                 randconfig-r003-20230517   gcc  
mips                 randconfig-r015-20230517   clang
mips                 randconfig-r025-20230517   clang
mips                 randconfig-r032-20230517   gcc  
nios2        buildonly-randconfig-r006-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230517   gcc  
nios2                randconfig-r021-20230519   gcc  
nios2                randconfig-r024-20230517   gcc  
openrisc     buildonly-randconfig-r004-20230517   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r026-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230517   gcc  
parisc               randconfig-r013-20230517   gcc  
parisc               randconfig-r022-20230519   gcc  
parisc               randconfig-r024-20230517   gcc  
parisc               randconfig-r024-20230519   gcc  
parisc               randconfig-r025-20230519   gcc  
parisc               randconfig-r026-20230517   gcc  
parisc               randconfig-r032-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc      buildonly-randconfig-r004-20230517   gcc  
powerpc                      katmai_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc              randconfig-r012-20230517   gcc  
powerpc              randconfig-r014-20230517   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230517   gcc  
riscv        buildonly-randconfig-r003-20230517   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230517   clang
riscv                randconfig-r002-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r023-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230517   clang
s390                 randconfig-r004-20230517   clang
s390                 randconfig-r005-20230517   clang
s390                 randconfig-r006-20230517   clang
s390                 randconfig-r016-20230517   gcc  
s390                 randconfig-r026-20230517   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r002-20230517   gcc  
sh                   randconfig-r015-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r024-20230519   gcc  
sh                   randconfig-r025-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230517   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc64      buildonly-randconfig-r005-20230517   gcc  
sparc64              randconfig-r012-20230517   gcc  
sparc64              randconfig-r016-20230517   gcc  
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
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r002-20230517   gcc  
xtensa       buildonly-randconfig-r004-20230517   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r006-20230517   gcc  
xtensa               randconfig-r021-20230517   gcc  
xtensa               randconfig-r025-20230517   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
