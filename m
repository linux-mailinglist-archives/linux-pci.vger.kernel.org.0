Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE1786EA1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjHXMBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 08:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241249AbjHXMB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 08:01:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022291993
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878482; x=1724414482;
  h=date:from:to:cc:subject:message-id;
  bh=JmTaOUK9MdL+7I476aUiGVF+yuQAYggWH+Umrj5+npE=;
  b=Mt9AF6h63Ne3zP2E0x9LGYraE4eA4lW0WUraXVeUPGV09vXxlkGiUOU/
   6CtmOglqoenJZpOOa7zJyJk/7V518CsxCYg4eHaGu1jYUZkKOW22PuU6R
   0ijDVxfwStnblesZVVIrbh2aT+1AaZVsIZOHs8ZG9LMu/k33cef8HITF4
   0+CxYjQmTJshs5os3Mntvj9yFS2F/CD+2U2fuiUF7+wg4mhMLPNtmjydH
   1qm7anPxKPArZB3lFdeNwR6GqmHn3bTYk6YRlcZLUfN5Da9Tgy0Q5nS0r
   rSm+sBLnalGWvvF00th//36IF3579g0QJayN6+qvILSXNQ93wYxOIe21z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371825096"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="371825096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910879355"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="910879355"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2023 05:01:20 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ91c-0002JL-0a;
        Thu, 24 Aug 2023 12:01:20 +0000
Date:   Thu, 24 Aug 2023 20:01:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 3f7f17a73c3779d630326bcc9d69d7fa794087c0
Message-ID: <202308242010.zGZHqwqj-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 3f7f17a73c3779d630326bcc9d69d7fa794087c0  Merge branch 'pci/misc'

elapsed time: 9580m

configs tested: 254
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230818   gcc  
alpha                randconfig-r025-20230818   gcc  
alpha                randconfig-r032-20230818   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230822   gcc  
arc                  randconfig-r002-20230822   gcc  
arc                  randconfig-r014-20230818   gcc  
arc                  randconfig-r015-20230822   gcc  
arc                  randconfig-r021-20230818   gcc  
arc                  randconfig-r022-20230818   gcc  
arc                  randconfig-r023-20230822   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r013-20230818   gcc  
arm                         s5pv210_defconfig   clang
arm                           sama7_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230818   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230818   gcc  
csky                 randconfig-r014-20230822   gcc  
csky                 randconfig-r025-20230822   gcc  
csky                 randconfig-r026-20230822   gcc  
csky                 randconfig-r031-20230818   gcc  
csky                 randconfig-r032-20230818   gcc  
hexagon               randconfig-001-20230822   clang
hexagon               randconfig-002-20230822   clang
hexagon              randconfig-r003-20230822   clang
hexagon              randconfig-r021-20230818   clang
i386                             allmodconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230822   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
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
i386                  randconfig-013-20230822   clang
i386                  randconfig-014-20230822   clang
i386                  randconfig-015-20230822   clang
i386                  randconfig-016-20230822   clang
i386                 randconfig-r006-20230822   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230822   gcc  
loongarch            randconfig-r005-20230822   gcc  
loongarch            randconfig-r015-20230818   gcc  
loongarch            randconfig-r026-20230818   gcc  
loongarch            randconfig-r026-20230822   gcc  
loongarch            randconfig-r035-20230818   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230822   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r013-20230822   gcc  
microblaze           randconfig-r015-20230818   gcc  
microblaze           randconfig-r024-20230822   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r001-20230818   clang
mips                 randconfig-r003-20230818   clang
mips                 randconfig-r012-20230822   gcc  
mips                 randconfig-r021-20230822   gcc  
mips                           rs90_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230818   gcc  
nios2                randconfig-r024-20230818   gcc  
nios2                randconfig-r024-20230822   gcc  
nios2                randconfig-r026-20230818   gcc  
nios2                randconfig-r034-20230818   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r003-20230818   gcc  
openrisc             randconfig-r013-20230818   gcc  
openrisc             randconfig-r021-20230822   gcc  
openrisc             randconfig-r033-20230818   gcc  
openrisc             randconfig-r033-20230822   gcc  
openrisc             randconfig-r035-20230818   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230818   gcc  
parisc               randconfig-r031-20230822   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                  mpc866_ads_defconfig   gcc  
powerpc              randconfig-r033-20230818   gcc  
powerpc64                           defconfig   gcc  
powerpc64            randconfig-r032-20230822   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230818   gcc  
riscv                randconfig-r022-20230818   clang
riscv                randconfig-r036-20230822   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230822   clang
s390                 randconfig-r006-20230818   gcc  
s390                 randconfig-r016-20230818   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230818   gcc  
sh                   randconfig-r003-20230822   gcc  
sh                   randconfig-r005-20230818   gcc  
sh                   randconfig-r006-20230818   gcc  
sh                   randconfig-r025-20230818   gcc  
sh                   randconfig-r033-20230818   gcc  
sh                   randconfig-r036-20230818   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230818   gcc  
sparc                randconfig-r004-20230818   gcc  
sparc                randconfig-r005-20230818   gcc  
sparc                randconfig-r011-20230818   gcc  
sparc                randconfig-r025-20230822   gcc  
sparc                randconfig-r032-20230818   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230822   gcc  
sparc64              randconfig-r014-20230818   gcc  
sparc64              randconfig-r016-20230818   gcc  
sparc64              randconfig-r035-20230822   gcc  
sparc64              randconfig-r036-20230818   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230818   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230822   gcc  
x86_64       buildonly-randconfig-002-20230822   gcc  
x86_64       buildonly-randconfig-003-20230822   gcc  
x86_64       buildonly-randconfig-004-20230822   gcc  
x86_64       buildonly-randconfig-005-20230822   gcc  
x86_64       buildonly-randconfig-006-20230822   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230822   clang
x86_64                randconfig-002-20230822   clang
x86_64                randconfig-003-20230822   clang
x86_64                randconfig-004-20230822   clang
x86_64                randconfig-005-20230822   clang
x86_64                randconfig-006-20230822   clang
x86_64                randconfig-011-20230822   gcc  
x86_64                randconfig-012-20230822   gcc  
x86_64                randconfig-013-20230822   gcc  
x86_64                randconfig-014-20230822   gcc  
x86_64                randconfig-015-20230822   gcc  
x86_64                randconfig-016-20230822   gcc  
x86_64                randconfig-071-20230822   gcc  
x86_64                randconfig-072-20230822   gcc  
x86_64                randconfig-073-20230822   gcc  
x86_64                randconfig-074-20230822   gcc  
x86_64                randconfig-075-20230822   gcc  
x86_64                randconfig-076-20230822   gcc  
x86_64               randconfig-r002-20230818   gcc  
x86_64               randconfig-r023-20230818   clang
x86_64               randconfig-r031-20230818   gcc  
x86_64               randconfig-r034-20230818   gcc  
x86_64               randconfig-r035-20230818   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r012-20230818   gcc  
xtensa               randconfig-r022-20230822   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
