Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3F7D7AF0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjJZCf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 22:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 22:35:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27812F
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698287754; x=1729823754;
  h=date:from:to:cc:subject:message-id;
  bh=0vr6JaJzL0KFVf4e3JgDmbd4LNYqoHrBYnXxlNkCurU=;
  b=eOOuluPTsTkOShBw3vGBv0yKUV+zndsaYTftsHCms6GHJELWTyn51h5+
   B5ioknD2q1LcUI1HLJgVu6/UFhoZUheIUXTz7ROOBDf0VI69fdCfYtQQA
   FWeVK3+9BAkpPvc0wEzykHpFv2gNZifiLnL23oUnTCZ59hVAUZdJZhCKX
   JjlvmlO0NVWcpYfrvyTpOykjpKTh5yQA6tYX14CzquiRKCTkEkJUD39Vw
   cgOfKK4u17Y79RlZBYApNvyc4Fewqh7XUfB2k4bS6fez+tx/w9XZnaoH6
   Za8g/NMqKU/m42DPMit8xhNhjSapTzEP3xdKvQf1hnl/uxZPHv+VMg+EY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451684087"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="451684087"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="7074835"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2023 19:35:43 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvqDu-0009O7-2N;
        Thu, 26 Oct 2023 02:35:50 +0000
Date:   Thu, 26 Oct 2023 10:35:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 8e37372ad0bea4c9b4712d9943f6ae96cff9491f
Message-ID: <202310261016.HDIHP3Hd-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 8e37372ad0bea4c9b4712d9943f6ae96cff9491f  PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()

elapsed time: 1677m

configs tested: 200
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
arc                   randconfig-001-20231025   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20231026   gcc  
arm                        spear6xx_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231025   gcc  
i386         buildonly-randconfig-001-20231026   gcc  
i386         buildonly-randconfig-002-20231025   gcc  
i386         buildonly-randconfig-002-20231026   gcc  
i386         buildonly-randconfig-003-20231025   gcc  
i386         buildonly-randconfig-003-20231026   gcc  
i386         buildonly-randconfig-004-20231025   gcc  
i386         buildonly-randconfig-004-20231026   gcc  
i386         buildonly-randconfig-005-20231025   gcc  
i386         buildonly-randconfig-005-20231026   gcc  
i386         buildonly-randconfig-006-20231025   gcc  
i386         buildonly-randconfig-006-20231026   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231025   gcc  
i386                  randconfig-001-20231026   gcc  
i386                  randconfig-002-20231025   gcc  
i386                  randconfig-002-20231026   gcc  
i386                  randconfig-003-20231025   gcc  
i386                  randconfig-003-20231026   gcc  
i386                  randconfig-004-20231025   gcc  
i386                  randconfig-004-20231026   gcc  
i386                  randconfig-005-20231025   gcc  
i386                  randconfig-005-20231026   gcc  
i386                  randconfig-006-20231025   gcc  
i386                  randconfig-006-20231026   gcc  
i386                  randconfig-011-20231025   gcc  
i386                  randconfig-011-20231026   gcc  
i386                  randconfig-012-20231025   gcc  
i386                  randconfig-012-20231026   gcc  
i386                  randconfig-013-20231025   gcc  
i386                  randconfig-013-20231026   gcc  
i386                  randconfig-014-20231025   gcc  
i386                  randconfig-014-20231026   gcc  
i386                  randconfig-015-20231025   gcc  
i386                  randconfig-015-20231026   gcc  
i386                  randconfig-016-20231025   gcc  
i386                  randconfig-016-20231026   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231025   gcc  
loongarch             randconfig-001-20231026   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           jazz_defconfig   gcc  
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
parisc                generic-64bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231025   gcc  
riscv                 randconfig-001-20231026   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231025   gcc  
s390                  randconfig-001-20231026   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231025   gcc  
sparc                 randconfig-001-20231026   gcc  
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
x86_64       buildonly-randconfig-001-20231025   gcc  
x86_64       buildonly-randconfig-001-20231026   gcc  
x86_64       buildonly-randconfig-002-20231025   gcc  
x86_64       buildonly-randconfig-002-20231026   gcc  
x86_64       buildonly-randconfig-003-20231025   gcc  
x86_64       buildonly-randconfig-003-20231026   gcc  
x86_64       buildonly-randconfig-004-20231025   gcc  
x86_64       buildonly-randconfig-004-20231026   gcc  
x86_64       buildonly-randconfig-005-20231025   gcc  
x86_64       buildonly-randconfig-005-20231026   gcc  
x86_64       buildonly-randconfig-006-20231025   gcc  
x86_64       buildonly-randconfig-006-20231026   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231025   gcc  
x86_64                randconfig-001-20231026   gcc  
x86_64                randconfig-002-20231025   gcc  
x86_64                randconfig-002-20231026   gcc  
x86_64                randconfig-003-20231025   gcc  
x86_64                randconfig-003-20231026   gcc  
x86_64                randconfig-004-20231025   gcc  
x86_64                randconfig-004-20231026   gcc  
x86_64                randconfig-005-20231025   gcc  
x86_64                randconfig-005-20231026   gcc  
x86_64                randconfig-006-20231025   gcc  
x86_64                randconfig-006-20231026   gcc  
x86_64                randconfig-011-20231025   gcc  
x86_64                randconfig-012-20231025   gcc  
x86_64                randconfig-013-20231025   gcc  
x86_64                randconfig-014-20231025   gcc  
x86_64                randconfig-015-20231025   gcc  
x86_64                randconfig-016-20231025   gcc  
x86_64                randconfig-071-20231025   gcc  
x86_64                randconfig-071-20231026   gcc  
x86_64                randconfig-072-20231025   gcc  
x86_64                randconfig-072-20231026   gcc  
x86_64                randconfig-073-20231025   gcc  
x86_64                randconfig-073-20231026   gcc  
x86_64                randconfig-074-20231025   gcc  
x86_64                randconfig-074-20231026   gcc  
x86_64                randconfig-075-20231025   gcc  
x86_64                randconfig-075-20231026   gcc  
x86_64                randconfig-076-20231025   gcc  
x86_64                randconfig-076-20231026   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
