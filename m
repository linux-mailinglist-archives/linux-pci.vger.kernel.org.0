Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37204370651
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhEAIHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 May 2021 04:07:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:34425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhEAIHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 May 2021 04:07:41 -0400
IronPort-SDR: OncQhqtqrOheNtH6uf8UYLnYlTbn47oxpKpLoKQieQnO7RMQQtiCvUlZNUib3Mwmr2+H10Pk5d
 MSGkz+In9qsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="184911269"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="184911269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2021 01:06:51 -0700
IronPort-SDR: rU+aHa6ZqIdDxBGKPgPYAqySAJzRWUHlt6nrsBg6Z54eocbYJasorif/FmVFmatUdMa8X6meVX
 PS6uIDUhBGgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="426729617"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2021 01:06:50 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lckeH-0008Ua-BY; Sat, 01 May 2021 08:06:49 +0000
Date:   Sat, 01 May 2021 16:06:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 ccd61f07d28912dcd6a61ea73f5d69af7ad88efa
Message-ID: <608d0bef.zkDGz0RNjCLlPjH0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: ccd61f07d28912dcd6a61ea73f5d69af7ad88efa  x86/PCI: Remove unused alloc_pci_root_info() return value

elapsed time: 723m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
arm                  colibri_pxa270_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
microblaze                      mmu_defconfig
arm                       spear13xx_defconfig
arm                        shmobile_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     tqm8560_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
arc                              allyesconfig
arm                            hisi_defconfig
sh                           se7343_defconfig
arc                        nsimosci_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
powerpc                      ppc40x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                          g5_defconfig
s390                             alldefconfig
arm                           corgi_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                            allyesconfig
mips                         rt305x_defconfig
powerpc                      katmai_defconfig
m68k                       m5275evb_defconfig
arm                      pxa255-idp_defconfig
arm                        cerfcube_defconfig
xtensa                       common_defconfig
arm                          pxa910_defconfig
arm                          imote2_defconfig
m68k                          multi_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
arm                            mmp2_defconfig
arm                     am200epdkit_defconfig
arm                       versatile_defconfig
sh                               allmodconfig
powerpc                     pseries_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
ia64                         bigsur_defconfig
mips                        vocore2_defconfig
parisc                              defconfig
mips                          ath79_defconfig
nds32                            alldefconfig
arm                       mainstone_defconfig
powerpc                     mpc83xx_defconfig
h8300                               defconfig
sh                           se7619_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
openrisc                  or1klitex_defconfig
mips                          rb532_defconfig
mips                           gcw0_defconfig
powerpc                   lite5200b_defconfig
xtensa                    smp_lx200_defconfig
powerpc                  storcenter_defconfig
arm                          pxa168_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
h8300                    h8300h-sim_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210430
x86_64               randconfig-a004-20210430
x86_64               randconfig-a002-20210430
x86_64               randconfig-a006-20210430
x86_64               randconfig-a001-20210430
x86_64               randconfig-a005-20210430
i386                 randconfig-a004-20210430
i386                 randconfig-a001-20210430
i386                 randconfig-a003-20210430
i386                 randconfig-a002-20210430
i386                 randconfig-a005-20210430
i386                 randconfig-a006-20210430
i386                 randconfig-a013-20210430
i386                 randconfig-a011-20210430
i386                 randconfig-a016-20210430
i386                 randconfig-a015-20210430
i386                 randconfig-a012-20210430
i386                 randconfig-a014-20210430
i386                 randconfig-a013-20210501
i386                 randconfig-a015-20210501
i386                 randconfig-a016-20210501
i386                 randconfig-a014-20210501
i386                 randconfig-a011-20210501
i386                 randconfig-a012-20210501
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210430
x86_64               randconfig-a016-20210430
x86_64               randconfig-a013-20210430
x86_64               randconfig-a014-20210430
x86_64               randconfig-a012-20210430
x86_64               randconfig-a015-20210430

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
