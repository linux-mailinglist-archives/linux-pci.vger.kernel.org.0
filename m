Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613A73F03F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjF0BRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF0BRn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:17:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC280173E
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828661; x=1719364661;
  h=date:from:to:cc:subject:message-id;
  bh=kX7UOTJ4kyg3MeMd7XKyboIsdZXa/TEWHb3fiDDF0qA=;
  b=Yjk1iAsQf14Jn2dX65EOhNHGd9JsumxHiKPSxMlCTvCcZsXDabvSNI3O
   c/NanbIQ2ZJ1mR7vgK9cKQfCLe4Gq+2slMbcgsQVW3ncQBlhYBXQAxjTD
   t3CTijDuiZQrb8P5MC3vSdICuS6NMyPcUML6xkx9o1rPFnUmN/vG9iFc7
   cveWcvKWGk4eVpAhzAFx7KpJFeRcNTG+kV92Wt1tdFnOG+6WTEs9kuj0D
   LW/SjjyUm4GknLwLBUBQslWVW3wZVxPG0HjDUl2zO4OAJSXPwMjE72rQj
   qfaCRtePCHEvmq73hzOX7S1+DdTbdb3c3P/ot8hGoB4h95Dey7NwZi8iv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360301975"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360301975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="746027497"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="746027497"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2023 18:17:38 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxKr-000BIu-2d;
        Tue, 27 Jun 2023 01:17:37 +0000
Date:   Tue, 27 Jun 2023 09:17:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 08e3ed12ca8615b078ea19488fb45b084e5de16b
Message-ID: <202306270928.SMdpuvgx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 08e3ed12ca8615b078ea19488fb45b084e5de16b  PCI: Add failed link recovery for device reset events

elapsed time: 9134m

configs tested: 295
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230626   gcc  
alpha                randconfig-r031-20230620   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230622   gcc  
arc                  randconfig-r015-20230620   gcc  
arc                  randconfig-r026-20230620   gcc  
arc                  randconfig-r043-20230620   gcc  
arc                  randconfig-r043-20230622   gcc  
arc                  randconfig-r043-20230626   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r046-20230620   clang
arm                        shmobile_defconfig   gcc  
arm                          sp7021_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230620   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230626   gcc  
csky                 randconfig-r005-20230620   gcc  
csky                 randconfig-r006-20230620   gcc  
csky                 randconfig-r011-20230620   gcc  
csky                 randconfig-r023-20230620   gcc  
csky                 randconfig-r035-20230620   gcc  
hexagon              randconfig-r041-20230620   clang
hexagon              randconfig-r045-20230620   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230620   clang
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230620   clang
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230620   clang
i386         buildonly-randconfig-r006-20230621   gcc  
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230620   clang
i386                 randconfig-i001-20230621   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230620   clang
i386                 randconfig-i002-20230621   gcc  
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230620   clang
i386                 randconfig-i003-20230621   gcc  
i386                 randconfig-i003-20230622   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230620   clang
i386                 randconfig-i004-20230621   gcc  
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230620   clang
i386                 randconfig-i005-20230621   gcc  
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230620   clang
i386                 randconfig-i006-20230621   gcc  
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230620   gcc  
i386                 randconfig-i011-20230621   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i011-20230624   gcc  
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230620   gcc  
i386                 randconfig-i012-20230621   clang
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i012-20230624   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230620   gcc  
i386                 randconfig-i013-20230621   clang
i386                 randconfig-i013-20230622   gcc  
i386                 randconfig-i013-20230624   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230620   gcc  
i386                 randconfig-i014-20230621   clang
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i014-20230624   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230620   gcc  
i386                 randconfig-i015-20230621   clang
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i015-20230624   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230620   gcc  
i386                 randconfig-i016-20230621   clang
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-i016-20230624   gcc  
i386                 randconfig-i016-20230626   gcc  
i386                 randconfig-r004-20230620   clang
i386                 randconfig-r024-20230620   gcc  
i386                 randconfig-r026-20230621   clang
i386                 randconfig-r032-20230626   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230620   gcc  
loongarch            randconfig-r025-20230620   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r023-20230626   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230620   gcc  
microblaze           randconfig-r011-20230621   gcc  
microblaze           randconfig-r015-20230620   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r012-20230620   clang
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230621   gcc  
nios2                randconfig-r022-20230626   gcc  
openrisc             randconfig-r001-20230622   gcc  
openrisc             randconfig-r003-20230626   gcc  
openrisc             randconfig-r005-20230622   gcc  
openrisc             randconfig-r005-20230626   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r001-20230620   gcc  
parisc               randconfig-r011-20230626   gcc  
parisc               randconfig-r034-20230620   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r014-20230620   gcc  
powerpc              randconfig-r021-20230621   clang
powerpc              randconfig-r034-20230622   clang
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230620   clang
riscv                randconfig-r003-20230620   clang
riscv                randconfig-r024-20230626   gcc  
riscv                randconfig-r042-20230620   gcc  
riscv                randconfig-r042-20230622   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230620   clang
s390                 randconfig-r005-20230620   clang
s390                 randconfig-r013-20230620   gcc  
s390                 randconfig-r014-20230626   gcc  
s390                 randconfig-r035-20230626   clang
s390                 randconfig-r036-20230620   clang
s390                 randconfig-r036-20230622   clang
s390                 randconfig-r044-20230620   gcc  
s390                 randconfig-r044-20230622   gcc  
s390                 randconfig-r044-20230626   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230626   gcc  
sh                   randconfig-r012-20230620   gcc  
sh                   randconfig-r016-20230620   gcc  
sh                   randconfig-r016-20230626   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230620   gcc  
sparc                randconfig-r035-20230620   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r021-20230620   gcc  
sparc64              randconfig-r025-20230626   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230620   gcc  
um                   randconfig-r016-20230621   gcc  
um                   randconfig-r034-20230620   gcc  
um                   randconfig-r036-20230620   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230620   clang
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230620   clang
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230620   clang
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230626   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230620   gcc  
xtensa               randconfig-r026-20230626   gcc  
xtensa               randconfig-r032-20230620   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
