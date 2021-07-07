Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C673BE1D1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 06:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGGEHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 00:07:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:31227 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhGGEHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 00:07:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206222532"
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="206222532"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 21:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="410431447"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2021 21:04:22 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m0ynO-000DMj-1x; Wed, 07 Jul 2021 04:04:22 +0000
Date:   Wed, 07 Jul 2021 12:03:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS d58b2061105956f6e69691bf0259b1dd1e9fb601
Message-ID: <60e527a1.CJ9lxozAUmZm0uWv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: d58b2061105956f6e69691bf0259b1dd1e9fb601  Merge branch 'remotes/lorenzo/pci/mobiveil'

elapsed time: 721m

configs tested: 155
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           h5000_defconfig
h8300                            alldefconfig
sh                           se7206_defconfig
m68k                       bvme6000_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc85xx_cds_defconfig
s390                       zfcpdump_defconfig
powerpc                     tqm5200_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
arm                          pxa168_defconfig
arm                         lpc32xx_defconfig
m68k                        mvme147_defconfig
openrisc                    or1ksim_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                       ebony_defconfig
riscv                            allyesconfig
mips                      bmips_stb_defconfig
powerpc                          g5_defconfig
sh                             shx3_defconfig
sh                           se7750_defconfig
arm                          moxart_defconfig
powerpc                      walnut_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
xtensa                  cadence_csp_defconfig
powerpc                   lite5200b_defconfig
m68k                          sun3x_defconfig
arm                        multi_v5_defconfig
powerpc                     stx_gp3_defconfig
powerpc                    sam440ep_defconfig
powerpc                    klondike_defconfig
sh                          sdk7786_defconfig
arm                          pcm027_defconfig
arm                         s5pv210_defconfig
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
mips                          malta_defconfig
arm                            hisi_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
sh                         ap325rxa_defconfig
arm                          iop32x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                             sh03_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
sh                            hp6xx_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
sh                           se7724_defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                   motionpro_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
sh                           se7722_defconfig
m68k                        m5407c3_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlp_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_rdb_defconfig
ia64                          tiger_defconfig
arm                            dove_defconfig
parisc                              defconfig
mips                          rb532_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a016-20210706
x86_64               randconfig-a013-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
riscv                    nommu_k210_defconfig
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
