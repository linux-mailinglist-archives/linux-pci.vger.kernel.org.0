Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086B3C1E0E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 06:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhGIEVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 00:21:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:60169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhGIEVu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 00:21:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="190021299"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="190021299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 21:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="628735314"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2021 21:19:05 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1hyj-000Efq-9g; Fri, 09 Jul 2021 04:19:05 +0000
Date:   Fri, 09 Jul 2021 12:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/pm-vaibhav] BUILD SUCCESS
 7a9ee6d14fe2fb4207101d72f7b0301b7e616294
Message-ID: <60e7ce10.2GFlAQbEYiNyB+t4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/pm-vaibhav
branch HEAD: 7a9ee6d14fe2fb4207101d72f7b0301b7e616294  XXX SPLIT DRIVERS atl1e: use generic power management

elapsed time: 727m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      malta_kvm_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
m68k                         apollo_defconfig
parisc                              defconfig
powerpc                     asp8347_defconfig
arm                           u8500_defconfig
arm                            hisi_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                              defconfig
ia64                            zx1_defconfig
m68k                          multi_defconfig
powerpc                       maple_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      chrp32_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
arm                        oxnas_v6_defconfig
arm                         at91_dt_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
arm                       multi_v4t_defconfig
m68k                        stmark2_defconfig
arm                          imote2_defconfig
arm                          pxa3xx_defconfig
sh                          urquell_defconfig
arc                    vdk_hs38_smp_defconfig
sh                        dreamcast_defconfig
mips                        nlm_xlp_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
powerpc                          allmodconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
mips                     loongson2k_defconfig
sh                           se7724_defconfig
arc                        nsim_700_defconfig
s390                             allmodconfig
arm                         vf610m4_defconfig
arc                              allyesconfig
mips                      pic32mzda_defconfig
arm                        cerfcube_defconfig
powerpc                     kmeter1_defconfig
sh                        sh7785lcr_defconfig
powerpc                     akebono_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
s390                          debug_defconfig
powerpc                    mvme5100_defconfig
sh                     magicpanelr2_defconfig
m68k                       m5475evb_defconfig
sh                               alldefconfig
nds32                             allnoconfig
mips                    maltaup_xpa_defconfig
nios2                         3c120_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v5_defconfig
sh                           se7619_defconfig
mips                        vocore2_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
powerpc                          allyesconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
powerpc                     tqm8560_defconfig
arm                           h3600_defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
arm                         socfpga_defconfig
sh                          rsk7269_defconfig
nios2                         10m50_defconfig
mips                        omega2p_defconfig
ia64                         bigsur_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
riscv                    nommu_k210_defconfig
mips                     loongson1c_defconfig
mips                            gpr_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a006-20210708
i386                 randconfig-a004-20210708
i386                 randconfig-a001-20210708
i386                 randconfig-a003-20210708
i386                 randconfig-a005-20210708
i386                 randconfig-a002-20210708
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
