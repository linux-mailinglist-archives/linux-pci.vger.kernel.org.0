Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEF34FDFB
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhCaKXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 06:23:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:60146 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhCaKXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 06:23:15 -0400
IronPort-SDR: P/V9XOAaBB2LT05aUYpduXvVjh/m3Cpnv0EPGFNrAdOPJjS4T/8YMzn2eyt0eQw5VA5gQl3V8E
 w+Xb9x0ItiLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="189740056"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="189740056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 03:23:15 -0700
IronPort-SDR: ql3z9lKOrP5xJTcheLMVmoPkAL9Iwhowp5/cCy5ldBJ+6vLPPOLKZ9kS2pvmttd8t2wXDQXLDy
 6cQ+e5uY961A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="377211545"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2021 03:23:12 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRY0G-0005px-62; Wed, 31 Mar 2021 10:23:12 +0000
Date:   Wed, 31 Mar 2021 18:22:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 f349223f076e4c2d44ccf89d19056acbda3076f5
Message-ID: <60644d55.K68h7SL0RyEKKsIJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: f349223f076e4c2d44ccf89d19056acbda3076f5  PCI/VPD: Remove pci_set_vpd_size()

elapsed time: 723m

configs tested: 147
configs skipped: 3

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
mips                           gcw0_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          rsk7203_defconfig
arm                          iop32x_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
arm                        neponset_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                         virt_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
arm                       netwinder_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8560_defconfig
arm                     am200epdkit_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
parisc                           allyesconfig
mips                         cobalt_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c6400_defconfig
powerpc                     sbc8548_defconfig
mips                  decstation_64_defconfig
sh                           se7780_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
m68k                        stmark2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    socrates_defconfig
arm                           u8500_defconfig
arm                         s5pv210_defconfig
riscv                    nommu_virt_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
arm                            mps2_defconfig
sh                     magicpanelr2_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       ebony_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
