Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2573F03D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjF0BRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjF0BRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:17:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1281A173B
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828660; x=1719364660;
  h=date:from:to:cc:subject:message-id;
  bh=LZGAX7VUb9x2kU7k/rYs0ajU8Y2I8BPU4DpZNra6L9c=;
  b=N75caV6G8PlMB6CAVNbXrvtELYPUAb1QGYfdkIdzJa8KmzqZBhkkhY2K
   bO8hj+soeOOH0okrHgwIJyTYEYlvL36I9lazXnkDvqYkPb3HYk7gxt9mF
   UFdJ+62Fw6PHbek+AP4v1KcjhChYRPVaNSvTSSy/hrrLU2azAYgElF5s9
   slmJ6asXmavqxG3tTDQ3XV+X8DypMHC8+jpv7h7CED38HlXtMriqQK5LM
   dPb4VhWa+O9hY0zSckFcvASMgiwvcRqbcO4mbReGN8EAw0qXtcLVyR4Og
   TJ/GZcjfH/B04TR+peB1RcgcVI0iYRkLe9EARPHsTZ0ybiNmtpoqJF7jG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447821973"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="447821973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="693669192"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="693669192"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2023 18:17:38 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxKr-000BIZ-2H;
        Tue, 27 Jun 2023 01:17:37 +0000
Date:   Tue, 27 Jun 2023 09:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 e7e39756363ad5bd83ddeae1063193d0f13870fd
Message-ID: <202306270921.1qBM5lqG-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: e7e39756363ad5bd83ddeae1063193d0f13870fd  PCI/ASPM: Avoid link retraining race

elapsed time: 8910m

configs tested: 174
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230620   gcc  
alpha                randconfig-r003-20230620   gcc  
alpha                randconfig-r015-20230620   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r012-20230620   gcc  
arc                  randconfig-r036-20230620   gcc  
arc                  randconfig-r043-20230620   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r014-20230620   clang
arm                  randconfig-r016-20230620   clang
arm                  randconfig-r046-20230620   clang
arm                        shmobile_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230620   clang
arm64                randconfig-r035-20230620   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230620   gcc  
csky                 randconfig-r034-20230620   gcc  
hexagon              randconfig-r011-20230620   clang
hexagon              randconfig-r016-20230620   clang
hexagon              randconfig-r026-20230620   clang
hexagon              randconfig-r041-20230620   clang
hexagon              randconfig-r045-20230620   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230620   clang
i386         buildonly-randconfig-r004-20230621   gcc  
i386         buildonly-randconfig-r005-20230620   clang
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r006-20230620   clang
i386         buildonly-randconfig-r006-20230621   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230620   clang
i386                 randconfig-i002-20230620   clang
i386                 randconfig-i003-20230620   clang
i386                 randconfig-i004-20230620   clang
i386                 randconfig-i005-20230620   clang
i386                 randconfig-i006-20230620   clang
i386                 randconfig-i011-20230620   gcc  
i386                 randconfig-i012-20230620   gcc  
i386                 randconfig-i013-20230620   gcc  
i386                 randconfig-i014-20230620   gcc  
i386                 randconfig-i015-20230620   gcc  
i386                 randconfig-i016-20230620   gcc  
i386                 randconfig-r004-20230620   clang
i386                 randconfig-r022-20230620   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230620   gcc  
loongarch            randconfig-r006-20230620   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r004-20230620   gcc  
m68k                 randconfig-r022-20230620   gcc  
m68k                 randconfig-r023-20230620   gcc  
m68k                 randconfig-r024-20230620   gcc  
microblaze           randconfig-r011-20230620   gcc  
microblaze           randconfig-r014-20230620   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r015-20230620   clang
mips                 randconfig-r024-20230620   clang
mips                 randconfig-r035-20230620   gcc  
mips                          rb532_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230620   gcc  
nios2                randconfig-r006-20230620   gcc  
openrisc             randconfig-r012-20230620   gcc  
openrisc             randconfig-r031-20230620   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230620   gcc  
parisc               randconfig-r026-20230620   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r013-20230620   gcc  
powerpc              randconfig-r031-20230620   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r001-20230620   clang
riscv                randconfig-r003-20230620   clang
riscv                randconfig-r042-20230620   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230620   clang
s390                 randconfig-r005-20230620   clang
s390                 randconfig-r044-20230620   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r021-20230620   gcc  
sh                   randconfig-r034-20230620   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230620   gcc  
sparc                randconfig-r021-20230620   gcc  
sparc64              randconfig-r005-20230620   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230620   clang
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230620   clang
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230620   clang
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230620   gcc  
x86_64               randconfig-r023-20230620   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
