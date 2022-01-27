Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B974649D99E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 05:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiA0E3o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 23:29:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:10940 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236029AbiA0E3n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 23:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643257783; x=1674793783;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hre1mPy8ZT7yDetqWbt6bH7VrQgWbv/CPysssEUYTno=;
  b=XsFBpT8j8bWj35aZRHlUGMfQI8TBvFH3GpUbus1jTgWL2mcflkLbQ8+p
   hxD9mQ66gAz4NrKP8gUZIxbSixyig/xrXiih9wVOhfnAufySmR5cJyYZ4
   jd6xDU/Mn9Z4m5q3PyVu5RptzStbotpAMGoU43SlOtlxsv6UxN2s9yGt0
   3uUDSUzbdKXAd9vOScIArENkz4reuoUlVwKauNUOQ7C3pP96zAdXhBvVf
   bUbjva7dgqAwsvZW3Z5vVC9Sn88CqiSS7976AkuxLUyNURm6KCdXeOGK4
   G2Qx+wYhV0HmBWdl+4+q4hZMZULcF/aXAqvsi2wJr/PteeeCDyoDH76i4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307460358"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="307460358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="628548585"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 20:29:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCwPk-000M70-Fv; Thu, 27 Jan 2022 04:29:40 +0000
Date:   Thu, 27 Jan 2022 12:28:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 d884a217c4c58541c9ce1ebfe4907ed25b2cc6a8
Message-ID: <61f21f74.ZgiI9XwFw9CCVEUK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: d884a217c4c58541c9ce1ebfe4907ed25b2cc6a8  PCI/sysfs: Find shadow ROM before static attribute initialization

elapsed time: 730m

configs tested: 187
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
m68k                             allmodconfig
powerpc                          allmodconfig
m68k                             allyesconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc              randconfig-c003-20220124
m68k                         apollo_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                         s3c6400_defconfig
m68k                           sun3_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
powerpc                       ppc64_defconfig
m68k                        stmark2_defconfig
xtensa                  nommu_kc705_defconfig
sparc                            allyesconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
sh                ecovec24-romimage_defconfig
mips                       capcella_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
m68k                          hp300_defconfig
nds32                               defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
mips                        bcm47xx_defconfig
xtensa                  audio_kc705_defconfig
mips                         cobalt_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
arm                        keystone_defconfig
mips                           ip32_defconfig
arm                         lubbock_defconfig
sh                           se7722_defconfig
m68k                          amiga_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
mips                             allmodconfig
sh                   sh7724_generic_defconfig
arc                            hsdk_defconfig
arm                            hisi_defconfig
i386                             alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
mips                 decstation_r4k_defconfig
s390                          debug_defconfig
m68k                        mvme16x_defconfig
xtensa                       common_defconfig
sparc64                          alldefconfig
sh                            migor_defconfig
openrisc                 simple_smp_defconfig
powerpc                      tqm8xx_defconfig
h8300                            alldefconfig
arm                           corgi_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220125
arc                  randconfig-r043-20220125
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220125
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
arm                  colibri_pxa300_defconfig
arm                          imote2_defconfig
mips                         tb0219_defconfig
mips                          malta_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
mips                   sb1250_swarm_defconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
powerpc                    socrates_defconfig
arm                           omap1_defconfig
powerpc                     skiroot_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
arm                          ixp4xx_defconfig
powerpc                     kilauea_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
riscv                          rv32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
